/* radio.c

	09/11/2011 by Robert Trescott Jr.
	(C)2011 Analogic

	History:
		09/17/11 - original work

*/

void Write1()
{
	SCK		= false;
	SCK		= false;
	output_high(_SDA);
	delay_us(1);
	SCK		= true;
	SCK		= true;
}

void Write0()
{
	SCK		= false;
	SCK		= false;
	output_low(_SDA);
	delay_us(1);
	SCK		= true;
	SCK		= true;
}

void WriteCMD(int16 CMD)
{
	int8 n = 16;

	output_low(_SCK);
	RF_EN	= false;

	while (n--){
		if (CMD&0x8000)
			Write1();
		else
			Write0();
		CMD<<=1;
	}
	SCK		= false;
	RF_EN	= true;
}

void Init_RF12()
{
	RF_EN	= true;
	output_high(_SDA);
	output_low(_SCK);

	WriteCMD(0x80D8);	//enable register,433MHz,12.5pF
	WriteCMD(0x8208);	//Turn on crystal,!PA
	WriteCMD(0xA640);	//
	WriteCMD(0xC647);	//
	WriteCMD(0XCC77);	//
	WriteCMD(0x94A0);	//VDI,FAST,134kHz,0dBm,-103dBm
	WriteCMD(0xC2AC);
	WriteCMD(0xCA80);
	WriteCMD(0xCA83);	//FIFO8,SYNC,
	WriteCMD(0xC49B);
	WriteCMD(0x9850);	//!mp,9810=30kHz,MAX OUT
	WriteCMD(0xE000);	//NOT USE
	WriteCMD(0xC80E);	//NOT USE
	WriteCMD(0xC000);	//1.0MHz,2.2V
}

void WriteFSKbyte(int8 DATA)
{
	int8 	RGIT = 0;
	int16 	temp = 0xB800;
	
	output_float(_SDO);
	output_low(_SCK);

	temp|= DATA;

Loop:	SCK = false;

	RF_EN	= false;
	output_low(_SDA);
	SCK		= true;
	RGIT 	= (SDO==true); //Polling SDO
	SCK		= false;
	output_high(_SDA);
	RF_EN	= true;

	if (RGIT==0){
		goto Loop;
	} else {
		RGIT=false;
		WriteCMD(temp);
	}
}

// preamble -> FORMATTED -> unit id -> dest id -> data -> csum -> close...
// copied from transmitter code
void rf_xmit_packet(int8 data)
{
	int8 i;
	int8 outbytes[8];
	int16 crc;
		
	outbytes[0] = START_ID;
	outbytes[1] = TX_ID;
	outbytes[2] = UNIT_ID;
	outbytes[3] = RX_ID;
	outbytes[4] = dest_id;
	outbytes[5] = data;
	crc = _CRC16_(outbytes, 6);
	outbytes[6] = make8(crc,0);
	outbytes[7] = make8(crc,1);
	
	WriteCMD(0x8228); 		// OPEN PA
	delay_us(4);
	WriteCMD(0x8238);
	delay_us(1);
	WriteFSKbyte(0xAA);		// PREAMBLE
	WriteFSKbyte(0xAA);
	WriteFSKbyte(0xAA);
	WriteFSKbyte(0x2D);		// SYNCHRO PATTERN 0x2DD4
	WriteFSKbyte(0xD4);
	
	for (i=0; i<8; i++)
		WriteFSKbyte(outbytes[i]);

	WriteFSKbyte(0xAA);
	WriteFSKbyte(0xAA);
	WriteFSKbyte(0xAA);
	WriteCMD(0x8208); 		// CLOSE PA	
}



int8 RF12_RDFIFO()
{
	int8 	i,Result;

	output_low(_SCK);
	output_low(_SDA);
	RF_EN	= false;

	for (i=0; i<16; i++) { //skip status bits
		SCK		= true;
		SCK		= true;
		SCK		= false;
	}

	Result	= 0;

	for (i=0; i<8; i++) { //read fifo data byte
		Result<<=1;

		if (SDO){
			Result|=1;
		}

		SCK		= true;
		SCK		= true;
		SCK		= false;
	}

	RF_EN		= true;
	return(Result);
}

void Init_RF12RX()
{
	RF_EN	= true;
	output_high(_SDA);
	output_low(_SCK);

	WriteCMD(0x80D8);		//enable register,433MHz,12.5pF
	WriteCMD(0x82D8);		//enable receive,!PA
	WriteCMD(0xA640);		//
	WriteCMD(0xC647);		//
	WriteCMD(0x94A0);		//VDI,FAST,134kHz,0dBm,-103dBm
	WriteCMD(0xC2AC);
	WriteCMD(0XCC77);		//
	WriteCMD(0xCA80);
	WriteCMD(0xCA83);		//FIFO8,SYNC,
	WriteCMD(0xC49B);
	WriteCMD(0x9850);		//!mp,9810=30kHz,MAX OUT
	WriteCMD(0xE000);		//NOT USE
	WriteCMD(0xC800);		//NOT USE
	WriteCMD(0xC000);		//1.0MHz,2.2V
	
	WriteCMD(0xCA80);
	WriteCMD(0xCA83); 					// reset FIFO and read to receive next Byte
	RF12_RDFIFO();
}
