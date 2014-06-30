// init.c

void InitializeVars()
{
	vars.kp				= 3000;
	vars.ki				= 40;
	vars.kd				= 6000;

	vars.windup			= 500;
	
	vars.velcom			= 1000;
	vars.vlim			= 1000;
	vars.accel			= 1000;
	
	vars.src_id			= 1;		// 0=All, 1=X, 2=Y, 3=Z
	vars.format			= FORMATED;	
	
	vars.status.byte	= 0;
	STATUS.abs_flag		= true;
	STATUS.pid_lock		= true;
	STATUS.halt_index	= true;
	
	vars.flags.byte		= 0;
	FLAGS.ascii			= true;
	FLAGS.menu			= true;
}

void InitHardware()
{
	delay_ms(50);

 	set_tris_a(0xFF);			// set port a inputs
	set_tris_b(0xDF);			// port b i/o direction
	set_tris_c(0x89);
	
	setup_adc(ADC_OFF);
 	setup_adc_ports(NO_ANALOGS);
 	
	// Up/Dn Counters for Step/Direction inputs
	setup_timer_1(T1_EXTERNAL_SYNC|T1_DIV_BY_1);
	set_timer1(0);
	setup_timer_5(T5_EXTERNAL_SYNC|T5_DIV_BY_1|T5_DISABLE_SE_RESET);
	set_timer5(0);
	
	// PWM for Servo
 	setup_timer_2(T2_DIV_BY_1, 250, 1);	// 
	setup_ccp1(CCP_PWM);
	set_pwm1_duty(0);
		
	PORTA			= 0xFF;
	PORTB 			= 0xFF;
	PORTC 			= 0x40;
	TX_ENABLE 		= 0;			// deactivate pic uart
 	TX_STATE 		= 1;			// make tx pin tristate

	LoadEEPROM();
	if (vars.format!=FORMATED){
		InitializeVars();
		SaveEEPROM();		// save for later
		delay_ms(100);
	}
	
	// read hex switch for device slave ID
	port_b_pullups(true);
	vars.src_id = (PORTB&0x0F);
 	port_b_pullups(false);

	// initialize extra variables
//	RCIE = true;
//	CREN = false;
//	CREN = true;
		
	ypid.ul			= 0;
	velact.ul		= 0; 		
	phase1dist.ul	= 0;
	pos_com			= 0;

	// fire up interrupts
	enable_interrupts(GLOBAL);
	enable_interrupts(INT_TIMER2);
//	enable_interrupts(INT_RDA);		// allow uart rcv interrupt
//	PORT_EN = 0;
//	RS485_EN(0);
}
