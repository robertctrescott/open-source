/* packets.c

	02/04/06 - handle standard MODBUS 4,6 & 16 Func Codes - rct
	03/14/07 - modified code to handle 16bit registers in BigEndian format
				Reg addresses 0000-00FF =  8 bit reads and writes			(0-255)
				Reg addresses 0100-01FF = 16 bit reads and writes			(256-511)
				Reg addresses 0200-02FF = 32 bit reads and writes			(512-767)
				Reg addresses 0300-03FF = 32 bit PIC float reads and writes	(768-1023)

		 MODBUS PACKET CONSTRUCTION
	
	0x04 READ MULTIPLE INPUT REGISTERS
---------------------------------------------------------
-QUERY-				|	-RESPONSE-
ID - SLAVE ADDRESS	|	ID
04 - FUNC CODE		|	04
RH - REG ADDR HI*	|	BC - # OF DATA BYTES TO FOLLOW
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
RH - REG ADDR HI*	|	RH - REG ADDR HI*
RL - REG ADDR LO	|	RL - REG ADDR LO
00 - # OF REGS HI	|	00 - # REGS HI
CT - # OF REGS LO	|	CT - # REGS LO
BC - BYTES COUNT	|	CH - CRC MSB		\
DATA0				|	CL - CRC LSB		/	-  see "modbus_crc.c"
DATA1				|
DATAn				|
CH - CRC MSB		|
CL - CRC LSB		|


	0x06 WRITE SINGLE REGISTER (16 BIT ONLY)
---------------------------------------------------------
-QUERY-				|	-RESPONSE-
ID - SLAVE ADDRESS	|	ID - SLAVE ADDRESS
06 - FUNC CODE		|	06 - 0x06 FUNC CODE
RH - REG ADDR HI*	|	RH - REG ADDR HI*
RL - REG ADDR LO	|	RL - REG ADDR LO
DH - DATA HI BYTE	|	DH - DATA HIGH BYTE
DL - DATA LO BYTE	|	DL - DATA LOW BYTE
CH - CRC MSB		|	CH - CRC MSB		\
CL - CRC LSB		|	CL - CRC LSB		/	-  see "modbus_crc.c"
				

**************** NOTE **********************
REGS/REGISTERS ARE REG ADDRESSES IN MEMORY
THAT ARE ACCESSED AS N BIT REGISTERS
CT IS HOW MANY N BIT REGS THAT WILL BE SENT
REG ADDRESSES (IN REG ADDR HI) DETERMINE N BIT WIDTH (see 3/14/07 desc above)
ALL REGS RESIDE 00-FF THEY ARE SIMPLY ACCESSED AS DIFFERENT WIDTHS
--------------------------------------------

*/

// tristate the tx pin when not using 485 driver chip
void RS485_EN(int x)
{
	if (x){
		TX_ENABLE = 1;				// activate tx uart
		TX_STATE = 0;				// make tx an output pin
	} else {
		TX_ENABLE = 0;				// wait for 1 char time
		TX_STATE = 1;				// make tx pin float tristate		
	}
}

// this is a response to a register read or acknowledge
// called by HandleRXData()
void XmitRegistersPacket(void)
{
	int16	crc,offset;
	int8	x,count,width;
		
	switch (rx_tx[1]){		// read function code
		case 0x06:			// response to: Preset Single Register
		case 0x10:			// response to: Preset Multiple Regs
			crc = _CRC16_(rx_tx,6);
			rx_tx[6] = make8(crc,0);
			rx_tx[7] = make8(crc,1);
			count = 8;
			break;
		
		case 0x04:			// response to: Read Input Regs
			vars.format = PORTB; // get port B bits into register
			// determine register address offset
			offset = make16(0,rx_tx[3]);
			
			// determine addressing width for bytes swapping
			if (rx_tx[2] == 0) width = 1;
			else if (rx_tx[2] <= 1) width = 2;
			else width = 4;
			
			// extract actual byte count
			count = (rx_tx[5]*width)&0x7F;	
			
			// move count to this byte for response packet
			rx_tx[2] = count;	
			
			// load up buffer with count register bytes	
			for (x=0; x<count; x+=width){
				switch (width){
					case 1:	// no byte swapping required here
						rx_tx[x+3] = *((char*)&vars+offset+x);
						break;
					case 2: // byte swap for big endian correction
						rx_tx[x+3] = *((char*)&vars+offset+x+1);
						rx_tx[x+4] = *((char*)&vars+offset+x);
						break;
					case 4:	// byte swapping here					
						rx_tx[x+3] = *((char*)&vars+offset+x+3);
						rx_tx[x+4] = *((char*)&vars+offset+x+2);
						rx_tx[x+5] = *((char*)&vars+offset+x+1);
						rx_tx[x+6] = *((char*)&vars+offset+x);
						break;
				}	
			}
			
			// calculate the crc on the whole packet
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

void Write1RegisterPacket()
{
	int16 	offset;
						
	// determine register offset address
	offset = make16(0,rx_tx[3]);
			
	// write received data into registers now
	*((char*)&vars+offset) 		= rx_tx[5];
	*((char*)&vars+offset+1) 	= rx_tx[4];
	
	// send response packet
	XmitRegistersPacket();	
}

void WriteRegistersPacket()
{
	int16 	offset;
	int8  	x, width, count;
						
	// determine register offset address
	offset = make16(0,rx_tx[3]);
			
	// determine addressing width for bytes swapping
	if (rx_tx[2] == 0) width = 1;
	else if (rx_tx[2] <= 1) width = 2;
	else width = 4;

	// extract actual byte count
	count = (rx_tx[5]*width)&0x7F;	

	for (x=0; x<count; x+=width){
		// write received data into registers now
		switch (width){
			case 1:	// no byte swapping here
				*((char*)&vars+offset+x) 	= rx_tx[x+7];
				break;
			case 2:	// byte swap for big endian input correction
				*((char*)&vars+offset+x) 	= rx_tx[x+8];
				*((char*)&vars+offset+x+1) 	= rx_tx[x+7];
				break;
			case 4:	// byte swapping here
				*((char*)&vars+offset+x) 	= rx_tx[x+10];
				*((char*)&vars+offset+x+1) 	= rx_tx[x+9];
				*((char*)&vars+offset+x+2) 	= rx_tx[x+8];
				*((char*)&vars+offset+x+3) 	= rx_tx[x+7];
				break;	
		}
	}
	
	// send response packet
	XmitRegistersPacket();
}


// called by fast async main() function
void HandleRXData(void)
{
	int16 	crc,cal;
	int8	count;
		
	if (rx_count>6 && rx_timer>1){
		count = rx_count;
		CREN = FALSE;
		RCIE = false;
		if (rx_tx[0] == 0 || rx_tx[0] == vars.src_id){
			crc = make16(rx_tx[count-1],rx_tx[count-2]);
			cal = _CRC16_(rx_tx, count-2);
		
			if (crc == cal){		// crc check out as good
				switch (rx_tx[1]){
					case 0x06:
						Write1RegisterPacket();
						break;
					case 0x10:
						WriteRegistersPacket();
						break;
					case 0x04:
						if (rx_tx[0] == vars.src_id)	// only reply id same address
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
	
	if (rx_count < RX_MAX) 
		rx_count++;
		
	rx_timer=0;
}
