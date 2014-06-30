
char rx_available(void)
{
	return (in_ptr != out_ptr);			// a test only if data is there
}

char _low_level_get(void)
{
	char	c = 0;
	if (in_ptr != out_ptr){
		c = in_buffer[out_ptr];
		out_ptr+=1;
		if (out_ptr == RX_BUFFER_SIZE) out_ptr=0;
	}
	return c;
}


