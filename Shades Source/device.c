// device.c

// device handlers assume that all devices are left in a known good
// disabled state

void write_int_eeprom(int address, int data)
{	
	int1 	flag;
	
	flag   = GIE;
	GIE    = false;

	EEADR  = address;
	EEDATA = data;
	EEPGD  = false;
	CFGS   = false;
	WREN   = true;
	
	EECON2 = 0x55;
	EECON2 = 0xAA;
	
	WR	= true;		// EE_WRITE is defined in *.inc file
	while (WR){};
	WREN   		= false;
	
	GIE    		= flag;
}

int read_int_eeprom(int address)
{
	EEADR 		= address;
	EEPGD 		= false;
	CFGS  		= false;
	RD   		= true;
	return (EEDATA);
}

void SaveEEPROM(void)
{
	int x;
	
	for (x=0; x<sizeof(s_store); x++){		// write all sensor eeprom data
		write_int_eeprom(x,*((char*)&store+x));
	}
}

void LoadEEPROM()
{
	long	index;
	memset(&store,0x00,sizeof(s_store));	// first clear everything
	for (index=0; index<sizeof(s_store); index++)	// then read from eeprom
		*((char*)&store+index) = read_int_eeprom(index);	
	
}

#ifdef 0
int16 Load_95071_ADC(int chan)
{
	int		bits;
	signed int16	padc = 0;

	TEMP_CS = true;

	output_float(_SDA);			// make SDA an input data pin
	output_low(_SCK);			// set clock line to drive output

	if (!chan)
		TEMP_CS = false;

	
	for (bits=0; bits<16; bits++){		// stuff the bits into the memory structure
		SCK = true;	
		shift_left(&padc,4,SDA);
		SCK = false;
	}

	TEMP_CS = true;

	return padc;
}
#endif