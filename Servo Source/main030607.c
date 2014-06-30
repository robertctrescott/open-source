/* main.c

	02/25/07 by Robert Trescott Jr.
	(C)2007 Acquitronics INC

	Microchip MPLAB ICD2 Emulation

	History:
		02/25/07 - ORIGINAL WORK -rct

*/

// compiler and hardware special settings
// *** Microchip stores "little-endian" ex. $4F52 = 0x52 0x4F in memory ***
#case

//#define ICD2

#include <18F2431.h>
#device *=16
#include "18F2431.inc"
#include <stdlib.h>

#ifdef ICD2
#fuses HS,NOWDT,NOPROTECT,NOBROWNOUT,PUT,DEBUG,NOLVP
#else
#fuses HS,NOWDT,PROTECT,BROWNOUT,PUT,NODEBUG,NOLVP
#endif
#use delay(clock=20000000)
#id CHECKSUM

#define false			0
#define true			1
#define byte			int
#define boolean			short int

#define RS485_TX		PIN_C6
#define RS485_RX		PIN_C7

#define RX_MAX			32
#define RX_BUFFER_SIZE 	16
#define MAX_BUFFER		16

#define FMTFLAG			0x9A
#define	KPROP			8
#define KINTEG			0
#define KDERIV			6
#define WINDUP			60000

#BIT	INDEX_BIT		= PORTA.2
#BIT	MOT_DIR_BIT		= PORTC.5
#BIT	TEST_BIT		= PORTB.5
#BIT	INP_DIR_BIT		= PORTB.1

#BIT	TX_STATE		= TRISC.6
#BIT	TX_ENABLE		= TXSTA.5

#BIT	BRGH			= TXSTA.2
#BIT	POR				= RCON.1
#BIT	RINT			= RCON.4
#BIT	RCIF			= PIR1.5
#BIT	RCIE			= PIE1.5
#BIT	TRMT			= TXSTA.1
#BIT	CREN			= RCSTA.4
#BIT	TIMER0			= T0CON.7
#BIT	UP_DN			= QEICON.5

union PIC_LONG {
	int32			ul;
	int16			ui[2];
	signed int16 	i[2];
	char			b[4];	
};

typedef struct {
	char	format;
	char	axis;
	char	mode;
	char	status;
	
	signed int16	KProp;
	signed int16	KInteg;
	signed int16	KDeriv;
	signed int32	FRate;
	signed int32	Accel;
	signed int32	Windup;
	signed int32	Scale;
} s_store;
	
s_store			store;

signed int32	servo_cmd		= 0L;
signed int32	servo_go		= 0L;
signed int32	servo_trim		= 0L;
signed int16	servo_count		= 0;

signed int16 	u1 				= 0;
int16			prev_posct		= 0;
signed int32	integral 		= 0;
int16			prev_t1count 	= 0;
int16			prev_t5count 	= 0;

int				rx_count		= 0;
char			rx_buffer[RX_MAX];
char			in_buffer[RX_BUFFER_SIZE];
char			in_ptr 			= 0;
char			out_ptr 		= 0;

union PIC_LONG	servo_pos;

short int		bServo;
short int		saturated 		= 0;
short int		bInMotion		= 0;
short int		bPhase1			= 0;

#define DIFF(l,h)		((h<l) ? (l-h) : (h-l))
#define	SENSOR_MAX		sizeof(s_store)


#use rs232(baud=19200,parity=N,xmit=RS485_TX,rcv=RS485_RX)

void MOT_DIR(short x)
{
	MOT_DIR_BIT = x;
}

void Encoder(char state)
{
	if (state){						// if state is true then we are activating quadrature
//		set_tris_a(0xfb);			// disable index pin by making it an output
		DFLTCON 		= 0x3C;
		QEICON 			= 0x88;
		POSCNT			= 0;
		MAXCNT			= 0xFFFF;
	} else {
		set_tris_a(0xff);			// make all port a pins inputs
		DFLTCON 		= 0x00;		// shut off filters
		QEICON 			= 0x9C;		// disable quad counter		
	}	
}


// main routines follow
#include "device.c"
#include "rs232.c"
#include "init.c"


signed int32 makesigned32(int16 in)
{
	union PIC_LONG	x;
	
	x.i[0] = in;
	
	if (x.b[1] & 0x80){
		if ((x.i[1]!=0xffff) || !(x.b[1] & 0x80)){
			x.ui[1] = 0xffff;
			x.ui[0] = 0x8000;
		} else;	
	} else {
		x.b[3] = 0x00;
		if ((x.i[1]!=0x0000) || (x.b[1] & 0x80)){
			x.ui[1] = 0x0000;
			x.ui[0] = 0x7fff;
		} else;	
	}
	return x.ul;
}

signed int32 int2fix(int16 in)
{
	union PIC_LONG	x;
	x.i[0] = in;
	
	if (x.b[1] & 0x80) x.ui[1]=0xffff;

	x.b[3] = x.b[2];
	x.b[2] = x.b[1];
	x.b[1] = x.b[0];
	x.b[0] = 0x00;	
	return x.ul;
}

int16 fix2int(signed int32 in)
{
	return in>>8;	
}

#define MAX_PWM		(1000)

void MotorPWM(signed int16 pwm)
{
	saturated = false;

	if (pwm > MAX_PWM){
		saturated = true;
		pwm = MAX_PWM;
	} else if (pwm< -MAX_PWM){
		saturated = true;
		pwm = -MAX_PWM;
	}
				
	if (pwm < 0){
		MOT_DIR(false);
		pwm = -pwm;
	} else {
		 MOT_DIR(true);
	}
	
	set_pwm1_duty((int16)pwm);		
}

// look at step and direction data inputs at timers 1&5 to generate new position 
void CalculateCommand()
{
	int16	t1count;
	int16	t5count;
	
	t1count = get_timer1();
	t5count = get_timer5();
	servo_cmd+= ((t1count-prev_t1count)-(t5count-prev_t5count));
	prev_t1count = t1count;
	prev_t5count = t5count;		








}



void HandleServoTask()
{	
	int16			curr_posct;
	signed int16	u0,integ,deriv;
	union PIC_LONG	ypid;
	
	// calculate position
	curr_posct = POSCNT;
	servo_count+= (curr_posct-prev_posct);
	servo_pos.i[0] = curr_posct;
	prev_posct = curr_posct;	
							
	CalculateCommand();
	// PI Motor controller
	
	u0 = (servo_cmd-servo_count);

	if (!saturated) integral+=u0;
	if (integral>store.Windup) integral = store.Windup;
	else if (integral < -store.Windup) integral = -store.Windup;
	
	integ = fix2int(integral*store.KInteg);
	deriv = fix2int((u0-u1)*store.KDeriv);
			
	ypid.ul = (u0*store.KProp)+integ+deriv;
	
	// LIMIT YPID to 24 bit result
	if (ypid.b[3] & 0x80){
		if ((ypid.b[3]<0xff)||!(ypid.b[2] & 0x80)){
			ypid.ui[1] = 0xff80;
			ypid.ui[0] = 0x0000;
		} else;
	} else {
		if (ypid.b[3] || (ypid.b[2]>0x7f)){
			ypid.ui[1] = 0x007f;
			ypid.ui[0] = 0xffff;
		} else;
	}

	u1 = u0;
	
	MotorPWM(ypid.i[0]);
}


#zero_ram
void main()
{			
	delay_ms(50);
	InitHardware();
	Encoder(true);
	servo_pos.ul = 0;
	
	for (;;){					// loop forever
		if (bServo){			
			TEST_BIT = true;
			HandleServoTask();
			TEST_BIT = false;
			bServo = false;
		} else {
			HandleCommPort();	
		}
	}
}

#INT_TIMER2
void servoisr()
{
	static int	servo_update = 0;
	
	if (servo_update++ > 18){
		servo_update = 0;
		bServo = true;
	}
}

#INT_RDA
void rx_isr()
{
	char in;
		
	if (RCIF){					// we may have a valid char in uart					
		if (RCSTA & 0x06){		// if we have an error, clear error flags
			CREN = FALSE;
			CREN = TRUE;
		}
		
		in = RCREG;
		
		in_buffer[in_ptr++] = in;	// read to clear interrupt status flag
		if (in_ptr >= RX_BUFFER_SIZE)
			in_ptr=0;	
	}	
}

#INT_IC2QEI
void qei_isr()
{	
	if (UP_DN) servo_pos.i[1]++;
	else servo_pos.i[1]--;	
}
