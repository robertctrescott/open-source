// packets.c

//	revised - 02/04/06 - handle standard MODBUS 4 & 16 Func Codes - rct

/*		 MODBUS PACKET CONSTRUCTION
	
	0x04 READ MULTIPLE INPUT REGISTERS
	0x03 READ MULTIPLE HOLDING REGISTERS added 05/20/08
---------------------------------------------------------
-QUERY-				|	-RESPONSE-
ID - SLAVE ADDRESS	|	ID
04 - FUNC CODE		|	04
RH - REG ADDR HI	|	BC - # OF DATA BYTES TO FOLLOW
RL - REG ADDR LO	|	DATA0
00 - # OF REGS HI	|	DATA1
CT - # OF REGS LO	|	DATAn	
CH - CRC MSB		|	CH		\
CL - CRC LSB		|	CL		/	-  see "modbus_crc.c"


	0x10 WRITE MULTIPLE REGISTERS
---------------------------------------------------------
-QUERY-				|	-RESPONSE-
ID - SLAVE ADDRESS	|	ID - SLAVE ADDRESS
10 - FUNC CODE		|	10 - 0x10 FUNC CODE
RH - REG ADDR HI	|	RH - REG ADDR HI
RL - REG ADDR LO	|	RL - REG ADDR LO
00 - # OF REGS HI	|	00 - # REGS HI
CT - # OF REGS LO	|	CT - # REGS LO
BC - BYTES COUNT	|	CH - CRC MSB		\
DATA0				|	CL - CRC LSB		/	-  see "modbus_crc.c"
DATA1				|
DATAn				|
CH - CRC MSB		|
CL - CRC LSB		|

	0x06 PRESET SINGLE REGISTER added 05/20/08
---------------------------------------------------------
-QUERY-				|	-RESPONSE-(ECHO)
ID - SLAVE ADDRESS	|	ID - SLAVE ADDRESS
06 - FUNC CODE		|	06 - 0x06 FUNC CODE
RH - REG ADDR HI	|	RH - REG ADDR HI
RL - REG ADDR LO	|	RL - REG ADDR LO
DATA0				|	DATA0			\
DATA1				|	DATA1			/	-  see "modbus_crc.c"
CH - CRC MSB		|	CH - CRC MSB
CL - CRC LSB		|	CL - CRC LSB


**************** NOTE **********************
REGS/REGISTERS ARE BYTE LOCATIONS IN MEMORY
--------------------------------------------

*/

// tristate the tx pin when not using 485 driver chip
void RS485_EN(int x)
{
	if (x){
		TX_ENABLE = 1;				// activate tx uart
		TX_STATE = 0;				// make tx an output pin
	} else {
		TX_STATE = 1;				// make tx pin float tristate		
		TX_ENABLE = 0;				// wait for 1 char time
	}
}

// we are doing standard Microchip byte xfers including floats
int ProcessMicrochipBytes(int16 offset)
{
	int8	x,count;
							
	count = rx_tx[5]&0x7F;		// extract actual byte count
	rx_tx[2] = count;			// move count to this byte

	// load up buffer with count register bytes	
	for (x=0; x<count; x++){
		rx_tx[x+3] = *((char*)&vars+offset+x);	
	}

	return count;
}


// registers from 0x0200 to 0x02FF are all processed as 2 byte registers w/IEEE function
// all registers are still addressed on 2 byte boundrys but the modbus count byte is 2X
int Process2ByteIEEE(int16 offset)
{
	int8	x,count;
	u_BFP	val1, val2;
							
	offset = (offset-0x200)*2;		// find absolute byte address				
	count = (rx_tx[5]&0x7F)*2;		// capture actual byte count for crc calculation	
	
	for (x=0; x<count; x+=4){	
		val1.Byte[0] = *((char*)&vars+offset+x  );
		val1.Byte[1] = *((char*)&vars+offset+x+1);
		val1.Byte[2] = *((char*)&vars+offset+x+2);
		val1.Byte[3] = *((char*)&vars+offset+x+3);
		
		val2.FP = Pic2PC(val1.FP);
		
		rx_tx[x+3] = val2.Byte[1];	// swap bytes for endian correction
		rx_tx[x+4] = val2.Byte[0];
		rx_tx[x+5] = val2.Byte[3];
		rx_tx[x+6] = val2.Byte[2];
	}
	rx_tx[2] = count;				// move calc'd byte count to this response byte	

	return count;
}

// registers from 0x0100 to 0x01FF are all processed as 2 byte registers (NOT IEEE!)
// all registers are 16 bits wide and called by register not byte addressed
int Process2ByteRegs(int16 offset)
{
	int8	x,count;
							
	offset = (offset-0x100)*2;		// find absolute byte address				
	count = (rx_tx[5]&0x7F)*2;		// capture actual byte count for crc calculation	
	
	for (x=0; x<count; x+=2){	
		rx_tx[x+4]	= *((char*)&vars+offset+x  );	// swap bytes for endian correction
		rx_tx[x+3]	= *((char*)&vars+offset+x+1);
	}
	rx_tx[2] = count;				// move calc'd byte count to this response byte	

	return count;
}


// this is a response to a register read or acknowledge
// called by HandleRXData()
void XmitRegistersPacket(void)
{
	int16	crc,offset;
	int8	x,count;
		
	switch (rx_tx[1]){		// read function code
		case 0x06:			// response to: Preset Single Register
		case 0x10:			// response to: Preset Multiple Regs
			crc = _CRC16_(rx_tx,6);
			rx_tx[6] = make8(crc,0);
			rx_tx[7] = make8(crc,1);
			count = 8;
			break;
		
		case 0x03:			// response to: Read Holding Regs
		case 0x04:			// response to: Read Input Regs
			// determine register address offset
			offset = make16(rx_tx[2],rx_tx[3]);
			if (offset>=0x0200){
				count = Process2ByteIEEE(offset);
			} else if (offset>=0x0100){
				count = Process2ByteRegs(offset);
			} else {
				count = ProcessMicrochipBytes(offset);
			}

			crc = _CRC16_(rx_tx,count+3);
			rx_tx[count+3] = make8(crc,0);
			rx_tx[count+4] = make8(crc,1);
			count+=5;
			break;	
	}
	
	
	RS485_EN(true);
	delay_us(10);
	// xfer all output bytes at one time
	for (x=0; x<count; x++){
		putchar(rx_tx[x]);	
	}
	
	while (!TRMT){}
	delay_us(10);
	RS485_EN(false);
}


void Write2ByteIEEE(int16 offset, int8 count)
{	
	int8  	x;
	u_BFP	val1, val2;
	
	offset = (offset-0x200)*2;		// find absolute byte address				
	for (x=0; x<count; x+=4){		// IEEE is always sent as 4 bytes
		// convert rx data to floating entity (swap bytes for endian correction)
		val1.Byte[3] = rx_tx[x+9];
		val1.Byte[2] = rx_tx[x+10];
		val1.Byte[1] = rx_tx[x+7];
		val1.Byte[0] = rx_tx[x+8];
		// IEEE float to Microchip float conversion
		val2.FP = PC2Pic(val1.FP);
		// save converted float to memory 
		*((char*)&vars+offset+x  ) = val2.Byte[0];	
		*((char*)&vars+offset+x+1) = val2.Byte[1];	
		*((char*)&vars+offset+x+2) = val2.Byte[2];	
		*((char*)&vars+offset+x+3) = val2.Byte[3];	
	}
}

void Write2ByteRegs(int16 offset, int8 count)
{
	int8  	x;
	offset = (offset-0x100)*2;		// find absolute byte address				
	for (x=0; x<count; x+=2){		// always sent as 2 byte regs
		*((char*)&vars+offset+x  ) = rx_tx[x+8];	
		*((char*)&vars+offset+x+1) = rx_tx[x+7];	
	}
}

// we are doing standard Microchip byte xfers including floats						
void WriteMicrochipBytes(int16 offset, int8 count)
{
	int8  	x;
	for (x=0; x<count; x++){
		// write received data into registers now					
		*((char*)&vars+offset+x) = rx_tx[x+7];
	}
}

// added 05/20/08
void Preset2ByteReg(int16 offset)
{
	offset&=0x00FF;		// strip high reg address
	offset*=2;			// find absolute byte address
				
	*((char*)&vars+offset  ) = rx_tx[5];	
	*((char*)&vars+offset+1) = rx_tx[4];	
}

// called by fast async main() function
void HandleRXData(void)
{
	int16 	crc,cal;
	int16 	offset;
	int8	count;
		
	if (rx_count>6 && rx_timer>1){
		count = rx_count;
		CREN = FALSE;
		RCIE = false;
		if (rx_tx[0] == 0 || rx_tx[0] == vars.src_id){
			crc = make16(rx_tx[count-1],rx_tx[count-2]);
			cal = _CRC16_(rx_tx, count-2);
			offset = make16(rx_tx[2],rx_tx[3]);
		
			if (crc == cal){		// crc check out as good
				switch (rx_tx[1]){
					case 0x06:
						Preset2ByteReg(offset);
						rx_tx[0] = vars.src_id; // reply with proper unit address
						XmitRegistersPacket();
						break;
					case 0x10:
						bDirty = true;		// allow save to eeprom 
						// determine register offset address
						if (offset>=0x200){
							Write2ByteIEEE(offset,rx_tx[6]);
							offset-=0x200;
						} else if (offset>=0x100){
							Write2ByteRegs(offset,rx_tx[6]);		// use byte counter
							offset-=0x100;
						} else {
							WriteMicrochipBytes(offset,rx_tx[6]);						
						}
						// allow this case to fall through to next
					case 0x04: case 0x03:
							rx_tx[0] = vars.src_id; // reply with proper unit address
							XmitRegistersPacket();
						break;				
				} 
			} else {
				ERR_EN = true;		// crc was in error so indicate bad data
			}
		} else {
			ERR_EN = true;	
		}
		rx_timer = 0;
		CREN = TRUE;
		RCIE = true;
		rx_count = 0;
	}
}

#INT_RDA
void rx_isr()
{	
	if (RCSTA & 0x06){				// if we have an error, clear error flags
		CREN = FALSE;				// reset comm error
		CREN = TRUE;				// toggle error and enable comm
	}

	rx_tx[rx_count] = RCREG;		// save in input buffer
	
	if (rx_count < RX_MAX-1) 
		rx_count++;
		
	rx_timer=0;
}
