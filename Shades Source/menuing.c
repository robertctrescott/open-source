#define CMD_RD				1
#define CMD_WR				0
#define MAX_BUFFER			16
#define MAX_MENU_WIDTH		14
#define MAX_MENU_ITEMS  	26
#define MAX_PROMPT_WIDTH 	10
#define MENU_ENTRY_OFFSET 	10
#define REAL_TIME_MENU		2
#define MENU_IMMEDIATE		33

void DispatchFunction(int item, short cmd, char* theData)
{
	if (cmd == CMD_RD){			// we are reading the values from the item list			
		switch (item) {

			default : sprintf(theData,"...");
		}
	} else {
		menu_item = 0;					// default return of global menu_item
		if (theData[0]){
			switch (item){				// we are writing or calling another function
	
				case 34: menu_item = REAL_TIME_MENU;		// setting global menu_item value
					printf(  "\n\r     T-Test,    spc-menu's\r\n\n");
					break;
				case 50: InitDefaults();	// fall through and save to EEPROM
				case 35: SaveEEPROM(); break;
			}
		}
	}	
}


void DisplayMenuItem(char item)
{
	char i;
	char data[MAX_BUFFER];
	
	for (i=0;i<MAX_MENU_WIDTH;i++)
		putc(items[item][i]);
			
	DispatchFunction(item+MENU_ENTRY_OFFSET, CMD_RD, data);
	printf("  -> %s ",data);
}

void DisplayMenuPrompt(char item)
{
	char i;
	
	for (i=0;i<MAX_PROMPT_WIDTH;i++)
		putc(prompts[item][i]);
	
	printf(" => ");
}

void DisplayMenu(void)
{
	int l;
	
	printf("\r\n\n   *** Robs Shades %s ***\r\n",VERSION);

	for(l=0;l<MAX_MENU_ITEMS;l++){
		printf(" %d) ",MENU_ENTRY_OFFSET+l);
		DisplayMenuItem(l);
		delay_ms(5);
		printf("\r\n");
	}

	printf("\r\n     Enter # >");	
}



void HandleRS232Menu(void)
{
	static char inbuf[MAX_BUFFER];
	static char pos = 0;
	char	c;
	
	if (menu_item == REAL_TIME_MENU) return; // process in another routine
	
	if (!rx_available()) return;	//test if any chars waiting
	
	c = _low_level_get();			// we have a character in the uart
	
	if (c==8){			// is it a backspace
		if (pos>0){
			pos--;		// if so, back it out
			putc(c);
			putc(' ');
			putc(c);
		}
	} else if ((c>=' ')&&(c<='~')){
		if (pos<MAX_BUFFER-1){
			inbuf[pos++]=c;	// if char in range and not too big, save it
			putc(c);		// echo out the uart
		}
	}
	
	if (c!=13) return;	// we need an enter to finish up
	
	inbuf[pos]=0;		// null terminate string
	pos = 0;			// clear pos for next string
	
	if (menu_item < REAL_TIME_MENU){
		menu_item = atoi(inbuf);
		if (menu_item > MENU_IMMEDIATE)
			DispatchFunction(menu_item, CMD_WR, inbuf);
		
		else if (menu_item >= MENU_ENTRY_OFFSET){
			printf("\r\n     ");
			DisplayMenuItem(menu_item-MENU_ENTRY_OFFSET);
			DisplayMenuPrompt(menu_item-MENU_ENTRY_OFFSET);
		} else menu_item = 0;
	} else {
		DispatchFunction(menu_item, CMD_WR, inbuf);
	}
}
