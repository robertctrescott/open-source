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
	EECON2 = 0xaa;
	
	WR     = true;
	while (WR){};
	WREN   = false;
	
	GIE    = flag;
}

int read_int_eeprom(int address)
{
	EEADR = address;
	EEPGD = false;
	CFGS  = false;
	RD    = true;
	return (EEDATA);
}

void SaveEEPROM(void)
{
	int x;
	
	for (x=0; x<sizeof(s_vars); x++){		// write all sensor eeprom data
		write_int_eeprom(x,*((char*)&vars+x));
	}
}

void LoadEEPROM()
{
	long	index;
	memset(&vars,0x00,sizeof(s_vars));	// first clear everything
	for (index=0; index<sizeof(s_vars); index++)	// then read from eeprom
		*((char*)&vars+index) = read_int_eeprom(index);	
	
}


// floating.c
// floating point conversion routines for CCSC PIC compiler
//

float Pic2PC(float f)
{
	float	r;
	char	sign, lsb;
	// pic floating point is big endian
	sign = (((*((char*)&f+1))& 0x80));			// save sign bit status
	lsb  = (((*((char*)&f  ))& 0x01)) ? 0x80:0;	// save lsb bit status
	// note that pc is little endian
	*((char*)&r+3) = ((*((char*)&f  ))>>1)|sign;
	*((char*)&r+2) = ((*((char*)&f+1)) & 0x7f)|lsb;
	*((char*)&r+1) = ( *((char*)&f+2));
	*((char*)&r  ) = ( *((char*)&f+3));
	return r;
}

float PC2Pic(float f)
{
	float	r;
	char	sign, lsb;
	// note that pc is little endian
	sign = (((*((char*)&f+3))& 0x80));			// save sign bit status
	lsb  = (((*((char*)&f+2))& 0x80)) ? 0x01:0; // save lsb bit status
	// pic floating point is big endian
	*((char*)&r  ) = ((*((char*)&f+3))<<1)|lsb;
	*((char*)&r+1) = ((*((char*)&f+2))& 0x7f)|sign;
	*((char*)&r+2) = ( *((char*)&f+1));
	*((char*)&r+3) = ( *((char*)&f  ));
	return r;
}
