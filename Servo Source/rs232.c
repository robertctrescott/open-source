
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

void Print(int x)
{
	if (x){
		TX_ENABLE = 1;				// activate tx uart
		TX_STATE = 0;				// make tx an output pin
		delay_us(10);				// wait for 1 bit time
	} else {
		while (!TRMT){}
		delay_us(10);
		TX_ENABLE = 0;				// wait for 1 char time
		TX_STATE = 1;				// make tx pin float tristate		
	}
}

void PrintHelpScreen()
{
	if (FLAGS.menu){
		printf("\n\n\n\n\r  Analogic Servo Menu rev1.1\n\n\r");
		
		printf(" Ex. XG1024 <ENTER>       Move X to 1024\r\n");
		printf(" Ex. YV2048 <ENTER>       Set Y Vel to 2048\r\n");
		printf(" Ex. ZL0    <ENTER>       unlock Z AXIS\r\n");
		printf(" Ex. XL1    <ENTER>       lock X AXIS\r\n");
		printf(" Ex. X@     <ENTER>       display X status\r\n\n");
		printf(" Xc   - Set Axis Char      = %c \r\n",vars.src_id);
		printf(" Vxxx - Velocity Mode      = %ld\r\n",vars.velcom);
		printf(" Fxxx - Position Speed     = %ld\r\n",vars.vlim);
		printf(" Gxxx - Go to Position     = %ld\r\n",vars.pos_com);
		printf(" Pnnn - Proportional Gain  = %ld\r\n",vars.kp);
		printf(" Innn - Integral Gain      = %ld\r\n",vars.ki);
		printf(" Dnnn - Deriv Gain         = %ld\r\n",vars.kd);
		printf(" Annn - Accel Entry        = %lu\r\n",vars.accel);
		printf(" Rxxx - Reset Position     = %ld\r\n",mposition.i[1]);
		printf(" Wnnn - Windup Error       = %ld\r\n",vars.windup);
		printf("    L - Lock Servo PID       %c\r\n",(STATUS.pid_lock)?'Y':'N');
		printf("    B - Absolute Position    %c\r\n",(STATUS.abs_flag)?'Y':'N');
		printf("    H - Index Halt           %c\r\n",(STATUS.halt_index)?'Y':'N');
		printf("    E - Echo Menus           %c\r\n",(FLAGS.menu)?'Y':'N');
		printf("    Q - Initialize Servo   \r\n");
		printf("    S - Save to EEPROM     \r\n");
		printf("    # - Show Menu       \r\n\n ");
	}
}

void ProcessCommand(char inpbuf[])
{
	int count;
	count = strlen(inpbuf);
	
	Print(true);
	
	switch (inpbuf[0]){
		case 'P': case 'p':  if (count > 1) vars.kp = atol(&inpbuf[1]);		break;
		case 'I': case 'i':  if (count > 1) vars.ki = atol(&inpbuf[1]);		break;
		case 'D': case 'd':  if (count > 1) vars.kd = atol(&inpbuf[1]);		break;
		case 'A': case 'a':  if (count > 1) vars.accel =atol(&inpbuf[1]);	break;
		case 'W': case 'w':  if (count > 1)	vars.windup=atol(&inpbuf[1]);	break;
			
		case 'Q': case 'q':  InitializeVars(); // fall through next reset command
		case 'R': case 'r':
			if (count > 1){
				vars.cmd_pos.sl = mposition.sl = (atoi32(&inpbuf[1]));
			} else {
				vars.cmd_pos.sl = mposition.sl;
			}				

			set_timer1(0);
			set_timer5(0);
			prev_t1count 	= 0;
			prev_t5count 	= 0;
			servo_cmd		= 0;

			POSCNT			= 0;
			prev_count		= 0;
			velact.ul		= 0;
			mode 			= e_menu_mode;
			
			STATUS.halt_index = false;
			STATUS.error 	= false;
			STATUS.move_in_prog = false;
			break;
								
		case 'V': case 'v':
			mode = e_velo_mode;
			if (count > 1) vars.velcom = atol(&inpbuf[1]);
			break;

		case 'F': case 'f':
			if (count > 1) vars.vlim = atol(&inpbuf[1]);
			break;
	
		case 'G': case 'g':
			if (count > 1)  vars.pos_com = atoi32(&inpbuf[1]);
				StartGoMove();
			break;

		case 'L': case 'l':  		// lock pid = 1, unlock = 0
			if (count > 1 && atoi(&inpbuf[1])==1){					
				vars.cmd_pos = mposition;
				STATUS.pid_lock = true;
			} else {
				STATUS.pid_lock = false;
			}
			break;

		case 'E': case 'e':  		// echo data = 1, no echo = 0
			if (count > 1 && atoi(&inpbuf[1])==1){					
				FLAGS.menu = true;
			} else {
				FLAGS.menu = false;
			}
			break;

		case 'B': case 'b':			// set state of abs flag
			STATUS.abs_flag = (count > 1 && atoi(&inpbuf[1])==1);
			break;
				
		case 'H': case 'h':			// set state of halt index flag
			STATUS.halt_index = (count > 1 && atoi(&inpbuf[1])==1);
			break;
			
		case 'S': case 's':	// save all data to eeprom
			SaveEEPROM();
			break;

		case 'X': case 'x':	// set axis id character
			vars.src_id = inpbuf[1];
			break;
		
		case '@': 
			printf("%c>%02X;%08ld\r\n",vars.src_id,vars.status.byte,mposition.sl);
			break;
		
		case '#':
			FLAGS.menu = true;
			FLAGS.ascii = true;
			PrintHelpScreen();
			break;
	}
	Print(false);
}

#define MAX_LINEIN	32

void HandleComms()
{
	static char buffer[MAX_LINEIN] = {0};
	static int	pos	 = 0;
	char		in;

	if (rx_available()){
		in = _low_level_get();
		
		if (FLAGS.menu){
			Print(true);
			putchar(in);
			Print(false);
		}

		if (in != '\n'){		// ignore any linefeeds in data
			buffer[pos] = in;
			pos++;
			if (pos >= MAX_LINEIN-1) pos = 0;
			
			if (in == '\r'){
				buffer[pos] = 0;	// zero terminate string after CR
			
				if (buffer[0] == UNISON || buffer[0] == vars.src_id){
					ProcessCommand(buffer+1);	// process immediate line of data if this axis is selected
				}
				
				for (pos=0; pos<MAX_LINEIN; pos++) buffer[pos]=0;	// clear entire buffer
				pos = 0;	// reset position for next line
			}
		}
	}
}
