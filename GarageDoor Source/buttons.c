// buttons.c

void HandleUIButtons()
{
	static int prev_button;
	int button = BUTTON_NONE;
	
	if (SW_MODE == 0) button = BUTTON_MODE;
	if (SW_SET == 0) button++;

	if (button != prev_button){
		prev_button = button;
		LED_M1 = LED_M2 = 0;
		switch (button){
			case BUTTON_NONE: break;
			case BUTTON_SET: cur_cmd = CMD_OPEN; break;
			case BUTTON_MODE:cur_cmd = CMD_CLOSE; break;
		}

	}
}


void HandleUILeds()
{
//	LED_M1 = ;			see HandleRfTraffic()
//	LED_M2 = ;
	LED_B1 = (cur_cmd == CMD_OPEN);
	LED_B2 = (cur_cmd == CMD_DONE);
	LED_B4 = (cur_cmd == CMD_CLOSE);
	LED_B8 = 0;	
}
