// servo.c

// moves long into mantissa and int into exponent
u_fix LongInt2Fix(signed int32 mant,int exp)
{
	u_fix f;
	f.ul = (mant<<8)+exp;
	if (mant<0) f.b[3]|=0x80;	// keep sign proper
	else f.b[3]&=0x7F;
	return f;
}

// moves mantissa into 32 bit signed long number
signed int32 Fix2LongInt(u_fix f)
{
	u_fix r;
	r.sl = f.sl>>8;
	if (f.b[3]&0x80) r.b[3]=0xff;
	return r.sl;	
}

// 32 bit to 16 bit limit truncate rightmost value
void LimitI16(u_fix &val)
{
	u_fix r;
	
	r.b[2] = val.b[3];
	r.b[1] = val.b[2];
	r.b[0] = val.b[1];
	
	if (r.b[2] & 0x80){
		r.b[3] = 0xFF;
		if ((r.i[1] != 0xFFFF) || !(r.b[1] & 0x80)){
			r.ul = 0xFFFF8000;
		}
	} else {
		r.b[3] = 0x00;
		if ((r.i[1] != 0x0000) || (r.b[1] & 0x80)){
			r.ul = 0x00007FFF;
		}
	}
	val.ul = r.ul;
}

// 32 bit to 24 bit limit strip leftmost value
void LimitI24(u_fix &val)
{
	u_fix r;

	r.ul = val.ul;

	if (r.b[3] & 0x80){
		if ((r.b[3] < 0xFF) || !(r.b[2] & 0x80)){
			r.ul = 0xFF800000;
		}
	} else {
		if (r.b[3] || (r.b[2] > 0x7F)){
			r.ul = 0x007FFFFF;
		}
	}
	val.ul = r.ul;
}

#define PWM_MAX		1000
#define PWM_MIN		0

void UpdatePWM()
{		
	if (!STATUS.pid_lock || STATUS.error) ypwm = PWM_MIN;
	else {
		STATUS.saturated = false;
		if (ypwm & 0x8000){				/* first determine proper direction */
			if (ypwm == 0x8000){
				ypwm = PWM_MIN;
				STATUS.saturated = true;
			} else
				ypwm = -ypwm;
			REV_DIR;
		} else
			FWD_DIR;
			
		if (ypwm >= PWM_MAX){
			ypwm = PWM_MAX;
			STATUS.saturated = true;
		}	
	}
	set_pwm1_duty(ypwm);
}


// look at step and direction data inputs at timers 1&5 to generate new position 
void CalculateExtCount()
{
	int16 t1count;
	int16 t5count;
	
	if (!STATUS.pid_lock || STATUS.error) return;

	t1count = prev_t1count;
	t5count = prev_t5count;
	prev_t1count = get_timer1();
	prev_t5count = get_timer5();

	servo_cmd+= (signed long)((prev_t1count-t1count)-(prev_t5count-t5count));
}

// read motor quadrature encoder and determine position
void UpdatePosition()
{
	long	count;
	count = prev_count;
	prev_count = POSCNT;	
	mposition.sl+= (signed long)LongInt2Fix((count-prev_count),0);
	act_pos = Fix2LongInt(mposition);
}

void UpdatePID()
{	
	static int			deriv;
	static long			sat_count;
	signed int32		ext_count;
	
	if (!STATUS.pid_lock || STATUS.error) return;
	ext_count = (signed int32) LongInt2Fix(servo_cmd,0);
	// error = commanded position - measured position	
	u0 = (signed long)Fix2LongInt((ext_count+cmd_pos.sl) - mposition.sl);
		
	if (!STATUS.saturated){
		integral += u0; 	// add integral value if not saturated
		sat_count = 0;
	} else sat_count++;		// keep track of how long we've been saturated

	if (sat_count == vars.windup) STATUS.error = true;
	
	ypid.sl = (signed int32) vars.kp * u0;		// calc in the kp
	ypid.sl+= (signed int32) vars.ki * integral;	// calc in the ki	
	ypid.sl+= (signed int32) vars.kd * (u0 - u1);	// calc in the kd
	
	// pin to 24 bit limits
	LimitI24(ypid);

	// extend derivitive sample time
	if (++deriv > 2){
		deriv = 0;
		u1 = u0;
	}
		
	// use only 16 bit result from 24 bit calculation
	ypid.b[0] = ypid.b[1];
	ypid.b[1] = ypid.b[2];
	ypwm = ypid.i[0];	
}

void StartGoMove()
{
	if (STATUS.move_in_prog) return;	// get out if already in move
	
	if (STATUS.abs_flag){
		phase1dist = LongInt2Fix((pos_com-Fix2LongInt(mposition.sl)),0);
		fposition = pos_com;

	} else {
		phase1dist.sl = LongInt2Fix(pos_com,0);
		fposition = Fix2LongInt(mposition.sl) + pos_com;
	}

	velact.sl = 0;

	if (phase1dist.sl < 0){
		FLAGS.neg_move = true;
		phase1dist.sl = -phase1dist.sl;
	} else FLAGS.neg_move = false;

	phase1dist.sl = (phase1dist.sl/2);
	flatcount = 0;
	FLAGS.phase = false;
	STATUS.move_in_prog = true;
	mode = e_pos_mode;		
}

void ResetServo()
{
	set_timer1(0);
	set_timer5(0);
	prev_t1count 	= 0;
	prev_t5count 	= 0;
	servo_cmd		= 0;

	POSCNT			= 0;
	prev_count		= 0;
	velact.ul		= 0;
	mposition.ul	= 0;
	cmd_pos.ul		= 0;
	mode 			= e_hold_mode;
	
	STATUS.halt_index 	= false;
	STATUS.error 		= false;
	STATUS.move_in_prog = false;
}

void LockServo()
{
	set_timer1(0);
	set_timer5(0);
	prev_t1count 		= 0;
	prev_t5count 		= 0;
	servo_cmd			= 0;

	cmd_pos				= mposition;
	STATUS.pid_lock 	= true;
	STATUS.halt_index 	= false;
	STATUS.error 		= false;
	STATUS.move_in_prog = false;
	ypwm				= 0;
	mode 				= e_hold_mode;
}

void UpdateTrajectory()
{			
	STATUS.index = INDEX_PIN;

	if (STATUS.index && STATUS.halt_index || STATUS.error){
		velact = 0;
		return;
	}

	switch (mode){
	case e_velo_mode:
		if (!(!STATUS.halt_index && STATUS.saturated)){			 

			if ((long)Fix2LongInt(velact.ul) < vars.velcom){		// is the velocity lower than target 
				velact.sl += vars.accel;
				
				if ((long)Fix2LongInt(velact.ul) > vars.velcom)
					velact = LongInt2Fix(vars.velcom,0);
					
			} else if ((long)Fix2LongInt(velact.ul) > vars.velcom){
				velact.sl -= vars.accel;
				
				if ((long)Fix2LongInt(velact.ul) < vars.velcom)
					velact = LongInt2Fix(vars.velcom,0);
			}	
			
			cmd_pos.sl += Fix2LongInt(velact.ul);
		}
		break;

	case e_pos_mode:
		if (!(!STATUS.halt_index && STATUS.saturated)){			 

			if (!FLAGS.phase){							// process the first half of the profile 
				
				if ((long)Fix2LongInt(velact.ul) < vars.vlim)		// we need to accelerate to start move
					velact.sl += vars.accel;		// keep adding accel value to actual velocity
				else
					flatcount++;				// keep track of visits through this function
														// after accel has peaked
				phase1dist.sl -= Fix2LongInt(velact.ul); 

				if (FLAGS.neg_move)
					cmd_pos.sl -= Fix2LongInt(velact.ul);	// keep moving position
				else
					cmd_pos.sl += Fix2LongInt(velact.ul);	// keep moving position forward
				
				if (phase1dist.sl < 0)
					FLAGS.phase = true; 	// if phase distance is neg, then we are finished with first half of profile
	
			} else {
												// this is the second half of the profile
				if (flatcount > 0){
					flatcount--;
				
				} else if ((long)Fix2LongInt(velact.ul)>0 ){
					velact.sl -= vars.accel;
				
				} else {
					cmd_pos = LongInt2Fix(fposition,0);
					STATUS.move_in_prog = false;
					mode = e_hold_mode;
				}

				if (FLAGS.neg_move)							// keep moving position
					cmd_pos.sl -= Fix2LongInt(velact.ul);
				else
					cmd_pos.sl += Fix2LongInt(velact.ul);
			}
		}
		break;
	
	case e_save_eeprom_mode:
		mode = e_hold_mode;
		SaveEEPROM();
		break;
		
	case e_pos_go_mode:
		StartGoMove();
		break;
		
	case e_servo_reset_mode:
		ResetServo();
		break;
	
	case e_servo_lock_mode:
		LockServo();
		break;
	
	case e_servo_unlock_mode:
		STATUS.pid_lock 	= false;
		mode 				= e_hold_mode;
		break;
	}
}

void HandleErrorTask()
{
	static int pulse;
	static int filter;
	static int step_en;

	
	if (!STEP_ENABLE){
		if (filter>100){
			step_en = false;
		} else {
			filter++;
			step_en = true;
		}

	} else {
		filter = 0;
		step_en = true;
	}


	if (bEnable != step_en){
		if (!step_en){		// if our step enable pin is deactivated
			STATUS.pid_lock	= false;

		} else {			// step enable is active now
			if (STATUS.error){
				ResetServo();
			}
			LockServo();
		}
		bEnable = step_en;
	} else {
		if (STATUS.error){
			STATUS.pid_lock	= false;
		}
	}





	if (STATUS.pid_lock){		// keep track of pid errors
		TX_STATE = 1;			// tristate error pin if no errors
		PID_ERROR = 1;			// keep logic high (pullup high) and
		pulse = 0;				// clear counter for max pulse width
	} else {
		if (pulse > 100){		// we have an error, is the pulse done
			TX_STATE = 1;		// if we finished the pulse, reset for later
			PID_ERROR = 1;		
		} else {
			pulse++;			// keep counting until max pulse count 
			TX_STATE = 0;		// while holding error pin as an output
			PID_ERROR = 0;		// with an error logic level low
		}
	}
}

			
