// packets.c

//	revised - 02/04/06 - handle standard MODBUS 4 & 16 Func Codes - rct

/*		 MODBUS PACKET CONSTRUCTION
	
	0x04 READ MULTIPLE INPUT REGISTERS
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


**************** NOTE **********************
REGS/REGISTERS ARE BYTE LOCATIONS IN MEMORY
--------------------------------------------

*/

void XmitRegistersPacket(char* rx_tx)
{
	int16	crc;
	int8	x,count;
		
	switch (rx_tx[1]){		// read function code
		case 0x10:			// Preset Multiple Regs
			count = 7 + rx_tx[6]; 
			crc = _CRC16_(rx_tx,count);
			rx_tx[count] 	= make8(crc,0);
			rx_tx[count+1] 	= make8(crc,1);
			count += 2;
			break;	
	}
	
	RS485_EN = true;
	
	for (x=0; x<count; x++){
#ifdef SIMULATE_IO
		printf("%02X ",rx_tx[x]);
#else
		putchar(rx_tx[x]);	// xfer all output bytes at one time
#endif	
	}
	
	delay_us(1300);
	RS485_EN = false;
}

