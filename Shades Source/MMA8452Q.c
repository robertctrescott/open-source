/* 
	08/24/2012- port from Arduino sketch -rct 
*******************************************************************************
	Initialize the MMA8452 registers 
   	See the many application notes for more info on setting 
   	all of these registers:
   	http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=MMA8452Q
   	Feel free to modify any values, these are settings that work well for me.
*******************************************************************************/
#define SA0 1
#ifdef SA0
	#define MMA8452_ADDRESS 0x1D  // SA0 is high, 0x1C if low
#else
	#define MMA8452_ADDRESS 0x1C
#endif


// let the on board pullups do their job!
void init_i2c_device()
{
	output_float(_SCK);
	output_float(_SDA);
}

// active polling of i2c ready status
int1 i2c_device_ready()
{
	int1 ack;
	i2c_start();            				// If the write command is acknowledged,
	ack = i2c_write((MMA8452_ADDRESS<<1));  // then the device is ready.
	i2c_stop();
	return !ack;
}

/* read a single byte from address and return it as a byte */
int readRegister(int8 address)
{
	int8 data;
  
  	while (!i2c_device_ready());
  	i2c_start();
	i2c_write((MMA8452_ADDRESS<<1));		// write 0xB4
   	i2c_write(address);
   	i2c_start();
	
	i2c_write((MMA8452_ADDRESS<<1)|0x01);	// write 0xB5	
   	data=i2c_read(0);						// use nack
   	i2c_stop();
	
	return data;
}

/* Read i registers sequentially, starting at address 
   into the dest byte array */
void readRegisters(int8 address, int i, char* dest)
{
	int j;
	int8 val;
	
  	while (!i2c_device_ready());
  	i2c_start();
	i2c_write((MMA8452_ADDRESS<<1));			// write 0xB4  
	i2c_write(address);
   	i2c_start();

	i2c_write((MMA8452_ADDRESS<<1)|0x01);		// write 0xB5  
    for (j=0; j<i-1; j++){
	    val = i2c_read(1);						// use ack for multibyte up to last byte
	    dest[j] = val;
  	}
  	
	val = i2c_read(0);							// use nack for last byte read
   	i2c_stop();
	dest[j] = val;
}


/* Writes a single byte (data) into address */
void writeRegister(int8 address, int8 data)
{
  	while (!i2c_device_ready());
  	i2c_start();
	i2c_write((MMA8452_ADDRESS<<1));		// write 0xB4  
	i2c_write(address);
	i2c_write(data);
	i2c_stop();
}

/* Sets the MMA8452 to standby mode.
   It must be in standby to change most register settings */
void MMA8452Standby()
{
	int8 c = readRegister(0x2A);
	writeRegister(0x2A, c & ~(0x01));
}

/* Sets the MMA8452 to active mode.
   Needs to be in this mode to output data */
void MMA8452Active()
{
	int8 c = readRegister(0x2A);
	writeRegister(0x2A, c | 0x01);
}

void readAccelData(int16* destination)
{
	int i,j;
	int8 			rawData[6];  			// x/y/z accel register data stored here
	signed int16	dest;
	
	readRegisters(0x01, 6, &rawData[0]);  	// Read the six raw data registers into data array
		
	/* loop to calculate 12-bit ADC and g value for each axis */
	for (i=0,j=0; i<6; i+=2,j++){
		dest = rawData[i];
		dest <<= 8;
		dest|= rawData[i+1];
		dest>>=4;
		// this is a Robert fix to make number properly negative
		if (rawData[i]>0x7F) dest+=0xF000;	
		destination[j] = dest;
	}	
}


void initMMA8452(int8 fsr, int8 dataRate)
{
	MMA8452Standby();  // Must be in standby to change registers
	
	/* Set up the full scale range to 2, 4, or 8g. */
	if ((fsr==2)||(fsr==4)||(fsr==8))
		writeRegister(0x0E, fsr >> 2);  
	else
		writeRegister(0x0E, 0);
	  
	/* Setup the 3 data rate bits, from 0 to 7 */
	writeRegister(0x2A, readRegister(0x2A) & ~(0x38));
	if (dataRate <= 7)
		writeRegister(0x2A, readRegister(0x2A) | (dataRate << 3));  
	  
#ifdef 0
	/* Set up portrait/landscap registers - 4 steps:
	   1. Enable P/L
	   2. Set the back/front angle trigger points (z-lock)
	   3. Set the threshold/hysteresis angle
	   4. Set the debouce rate
	// For more info check out this app note: http://cache.freescale.com/files/sensors/doc/app_note/AN4068.pdf */
	writeRegister(0x11, 0x40);  // 1. Enable P/L
	writeRegister(0x13, 0x44);  // 2. 29deg z-lock (don't think this register is actually writable)
	writeRegister(0x14, 0x84);  // 3. 45deg thresh, 14deg hyst (don't think this register is writable either)
	writeRegister(0x12, 0x50);  // 4. debounce counter at 100ms (at 800 hz)
	
	/* Set up single and double tap - 5 steps:
	   1. Set up single and/or double tap detection on each axis individually.
	   2. Set the threshold - minimum required acceleration to cause a tap.
	   3. Set the time limit - the maximum time that a tap can be above the threshold
	   4. Set the pulse latency - the minimum required time between one pulse and the next
	   5. Set the second pulse window - maximum allowed time between end of latency and start of second pulse
	   for more info check out this app note: http://cache.freescale.com/files/sensors/doc/app_note/AN4072.pdf */
	   
	writeRegister(0x21, 0x7F);  // 1. enable single/double taps on all axes
	// writeRegister(0x21, 0x55);  // 1. single taps only on all axes
	// writeRegister(0x21, 0x6A);  // 1. double taps only on all axes
	writeRegister(0x23, 0x20);  // 2. x thresh at 2g, multiply the value by 0.0625g/LSB to get the threshold
	writeRegister(0x24, 0x20);  // 2. y thresh at 2g, multiply the value by 0.0625g/LSB to get the threshold
	writeRegister(0x25, 0x08);  // 2. z thresh at .5g, multiply the value by 0.0625g/LSB to get the threshold
	writeRegister(0x26, 0x30);  // 3. 30ms time limit at 800Hz odr, this is very dependent on data rate, see the app note
	writeRegister(0x27, 0xA0);  // 4. 200ms (at 800Hz odr) between taps min, this also depends on the data rate
	writeRegister(0x28, 0xFF);  // 5. 318ms (max value) between taps max
	
	/* Set up interrupt 1 and 2 */
	writeRegister(0x2C, 0x02);  // Active high, push-pull interrupts
	writeRegister(0x2D, 0x19);  // DRDY, P/L and tap ints enabled
	writeRegister(0x2E, 0x01);  // DRDY on INT1, P/L and taps on INT2
#endif
	
	MMA8452Active();  // Set to active to start reading
}



