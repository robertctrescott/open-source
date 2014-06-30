
void InitDefaults()
{
	store.format 		= FORMATED;
	store.unit_id 		= 0x32;
}


void InitHardware()
{
	int8 pb;
	
	delay_ms(20);
		
	setup_adc(ADC_OFF);
	setup_adc_ports(NO_ANALOGS);

	set_tris_a(0xFC);	
	set_tris_b(0xF0);	
	set_tris_c(0xA0);	
	
	PORTA = 0;
	PORTB = 0xE0;
	PORTC = 0xF8;
	RBPU = 0;
	RF_RES	= true;
	delay_ms(100);
	pb = PORTB;				// end mismatch condition
	RBIF = 0;				// clear port b change interrupt flag	
	
	setup_timer_1(T1_DISABLED);
//	setup_timer_2(T2_DIV_BY_4, 249, 5);			// heater pwm @5Khz & generate interrupt every 1ms
	setup_timer_2(T2_DIV_BY_4, 196, 10);			// heater pwm @5Khz & generate interrupt every 1ms
		
	LoadEEPROM();
	if (store.format!=FORMATED){
		InitDefaults();
		SaveEEPROM();		// save for later
		delay_ms(100);
	}
			
	enable_interrupts(INT_TIMER2);
	enable_interrupts(INT_RB);
	enable_interrupts(GLOBAL);

	// startup with a light flash
	LED_M1 = LED_M2 = LED_B1 = LED_B2 = LED_B4 = LED_B8 = 1;
	delay_ms(350);
	LED_M1 = LED_M2 = LED_B1 = LED_B2 = LED_B4 = LED_B8 = 0;
	delay_ms(750);
	
	cur_cmd = CMD_DONE;	
}
