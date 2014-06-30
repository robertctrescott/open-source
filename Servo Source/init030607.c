
void InitHardware()
{
 	set_tris_a(0xff);			// set port a inputs
	set_tris_b(0x02);			// port b i/o direction
	set_tris_c(0x89);
	
	setup_adc(ADC_OFF);
 	setup_adc_ports(NO_ANALOGS);
	
	setup_timer_1(T1_EXTERNAL_SYNC|T1_DIV_BY_1);
	set_timer1(0);
	setup_timer_5(T5_EXTERNAL_SYNC|T5_DIV_BY_1|T5_DISABLE_SE_RESET);
	set_timer5(0);

 	setup_timer_2(T2_DIV_BY_1, 250, 1);	// 
	setup_ccp1(CCP_PWM);
	set_pwm1_duty(0);
		
	PORTA			= 0xFF;
	PORTB 			= 0x00;
	PORTC 			= 0;
	TX_ENABLE 		= 0;			// deactivate pic uart
  	TX_STATE 		= 1;			// make tx pin float tristate

	LoadEEPROM();
	if (store.format!=FMTFLAG){
		store.format 		= FMTFLAG;
		store.axis 			= 'X';
		store.mode 			= 0;
		store.status 		= 0;
		store.KProp			= KPROP;
		store.KInteg		= KINTEG;
		store.KDeriv		= KDERIV;
		store.Windup		= WINDUP;
		store.Scale			= 1;
		store.FRate			= 1;
		store.Accel			= 1;	
		SaveEEPROM();		// save for later
	}
	
	// initialize extra variables
	servo_cmd	= 0;
		
	// fire up interrupts
	enable_interrupts(GLOBAL);
	enable_interrupts(INT_TIMER2);
	enable_interrupts(INT_RDA);		// allow uart rcv interrupt
	enable_interrupts(INT_IC2QEI);
}
