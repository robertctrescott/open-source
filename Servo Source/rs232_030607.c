
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


//------------------------------------------------------------------

void SaveNumData()
{
	int32	val;
	
	val = atoi32(&rx_buffer[3]);
	switch (rx_buffer[1]){
		case 'P': store.KProp = val; 	break;	
		case 'I': store.KInteg = val; 	break;	
		case 'D': store.KDeriv = val; 	break;	
		case 'W': store.Windup = val; 	break;	
		case 'S': store.Scale = val; 	break;
		case 'F': store.FRate = val;	break;
		case 'A': store.Accel = val;	break;
		case 'G': servo_go = val;		break;			
	}
	SaveEEPROM();
}

void SendCommData(char id)
{
	TX_ENABLE = 1;				// activate tx uart
	TX_STATE = 0;				// make tx an output pin
	delay_us(10);
	
	switch (id){
		case '@': printf("%Ld ",servo_pos.ul); 	break;
		case 'P': printf("%Ld ",store.KProp); 	break;	
		case 'I': printf("%Ld ",store.KInteg); 	break;	
		case 'D': printf("%Ld ",store.KDeriv); 	break;	
		case 'W': printf("%Ld ",store.Windup); 	break;	
		case 'S': printf("%Ld ",store.Scale); 	break;	
		case 'F': printf("%Ld ",store.FRate); 	break;	
		case 'A': printf("%Ld ",store.Accel); 	break;	
		case '!': printf("%d ", store.status); 	break;
	}	

	while (!TRMT){}
	delay_us(10);
	TX_ENABLE = 0;				// wait for 1 char time
	TX_STATE = 1;				// make tx pin float tristate
}


void HandleCommPort()
{
	char	c;
		
	if (!rx_available()) return;	// test if any chars waiting
	
	c = _low_level_get();			// we have a character in the uart
	
	if (rx_count == 0){
		if (c=='$' || c==store.axis){
			rx_buffer[rx_count] = c;
			rx_count = 1;
		}
	} else { 
		if (rx_count==1){
			if (rx_buffer[0] == '$'){
				store.axis = c;
				rx_count = 0;
				SaveEEPROM();	
			} else {
				if (c=='@' || c=='!'){
					rx_count = 0;
					SendCommData(c);
				} else {	
					rx_buffer[rx_count] = c;
					rx_count = 2;
				}
			}
		} else if (rx_count==2) {
			if (c=='@'){
				rx_count = 0;
				SendCommData(rx_buffer[1]);
			} else if (c=='=') {
				rx_buffer[rx_count] = c;
				rx_count = 3;
			} else {
				rx_count = 0;
			}
		} else if (rx_count>=3){
			if ((c>=' ')&&(c<='~')){
				if (rx_count<MAX_BUFFER-1){
					rx_buffer[rx_count++]=c;	// if char in range and not too big, save it
				}
			}
			if (c=='\r'){					// did we press enter or return?
				rx_buffer[rx_count++]=0;	// null terminate for number conversion
				SaveNumData();
				rx_count = 0;
			}
		}
	}
}
