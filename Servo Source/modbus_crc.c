// modbus_crc.c

#define CRC_16	0xA001

// call this function on each byte in the packet
// be sure to clear crc to 0xFFFF before starting new packet
void update_crc(int16& crc, char ch)
{
	int			i;
	short		j;
	for (i=0; i<8; ch>>=1, i++){
		j = (ch^crc)&1;
		crc>>=1;
		if (j) crc^=CRC_16;
	}
} 

// this function works over a whole array of chars
int16 _CRC16_(char* array, int len)
{	
	int16	test_crc = 0xFFFF;
	
	while (len--){
		update_crc(test_crc,*array++);
	}

	return test_crc;		
}



