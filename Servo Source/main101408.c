/* main.c

	02/25/07 by Robert Trescott Jr.
	(C)2007 Acquitronics INC

	Microchip MPLAB ICD2 Emulation

	History:
		02/25/07 - ORIGINAL WORK -rct
		03/06/07 - changed to prev code developed 11/12/04 -rct
					but kept the new code that is used with the PIC18F2431
		03/13/07 - Converted comms to Modbus

*/

// compiler and hardware special settings
// *** Microchip stores "little-endian" ex. $4F52 = 0x52 0x4F in memory ***
#case

//#define ICD2

#include <18F2431.h>
#device *=16
#include "18F2431.inc"

#ifdef ICD2
#fuses HS,NOWDT,NOPROTECT,NOBROWNOUT,PUT,DEBUG,NOLVP
#else
#fuses HS,NOWDT,PROTECT,BROWNOUT,PUT,NODEBUG,NOLVP
#endif
#use delay(clock=20000000)
#id CHECKSUM

#define false			0
#define true			1
#define boolean			short int

#define RS485_TX		PIN_C6
#define RS485_RX		PIN_C7

#BIT 	SYNC			= PORTB.5
#BIT	ERR_EN			= PORTB.5
#BIT	INDEX_BIT		= PORTA.2
#BIT	M_DIR			= PORTC.5
#BIT	STEP_ENABLE		= PORTB.4

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

#define INT_MAX		32767
#define FORMATED	0x50

#define FWD_DIR			(M_DIR = false)
#define REV_DIR			(M_DIR = true)
#define STEP_DIR		(M_DIR)
#define INDEX_PIN		(INDEX_BIT)

#define MSD 0
#define LSD 1
#define MSB 0
#define LSB 3

#define STATUS			vars.status.s
#define FLAGS			vars.flags.f
#define	RX_MAX			128

#define ABS(x)			(((x)<0)?(-x):(x))

enum {
	e_hold_mode		= 0,
	e_step_dir_mode,
	e_step_mode,
	e_velo_dir_mode,
	e_velo_mode,
	e_start_pos_mode,
	e_pos_mode,
	e_pos_go_mode,
	e_servo_reset_mode,
	e_servo_lock_mode,
	e_servo_unlock_mode,
	e_save_eeprom_mode
};

/* structures and unions follow */

typedef struct {
	char error			: 1;	// LSB
	char saturated		: 1;
	char index			: 1;
	char halt_index		: 1;
	char move_in_prog	: 1;
	char dstep			: 1;
	char pid_lock		: 1;
	char abs_flag		: 1;	// MSB
} s_stat;

typedef union {
	s_stat	s;
	char	byte;
} u_stat;

typedef struct {
	char phase			: 1;	// LSB
	char neg_move		: 1;
	char d5				: 1;
	char d4				: 1;
	char d3				: 1;
	char step_motor		: 1;
	char menu			: 1;
	char ascii			: 1;	// MSB
} s_flags;

typedef union {
	s_flags	f;
	char	byte;
} u_flags;

typedef union {
	int32			ul;		// b[0]		ui[0]
	signed int32	sl;		// b[1]		ui[1]
	long			ui[2];	// b[2]
	signed long		i[2];	// b[3]
	char			b[4];
} u_fix;

typedef union {
	struct {
		int8 Byte[4];
	};
	struct {
		float FP;
	};
} u_BFP;


// EEPROM Data Structure
typedef struct {					//		byte addr	Reg16
	char			format;			//		0			256
	char			src_id;			//		1
	u_stat			status;			//		2			258
	u_flags			flags;			//		3
	
	signed long		kp,				//		4-5			260
					ki,				//		6-7			262
					kd,				//		8-9			264
					velcom,			//		10-11		266
					vlim,			//		12-13		268
					windup;			//		14-15		270
	unsigned long 	accel;			//		16-17		272
} s_vars;

/* main.c globals follow */
s_vars 			vars;				//		00-17

signed long		mode = e_hold_mode;	//		18-19		274

signed int32 	pos_com,			//		20-23		276
				act_pos;			//		24-27		280
									//------END-------
u_fix			cmd_pos,
				mposition,
				velact,
				ypid,
				phase1dist;

signed long		ypwm			= 0,
				u1				= 0,
				integral		= 0;

signed long		u0;
									
long 			prev_count 		= 0;

signed int32	fposition		= 0,
				flatcount		= 0,
				servo_cmd		= 0L;
				
int16			prev_t1count 	= 0;
int16			prev_t5count 	= 0;
int				servo_update 	= 0;
	
char			rx_timer 		= 0;
char			rx_count 		= 0;
char			rx_tx[RX_MAX];

short int		bServo			= false;
short int		bEnable			= false;
short int		bDirty			= false;

#use rs232(baud=19200,parity=E,xmit=RS485_TX,rcv=RS485_RX)


void Encoder(char state)
{
	if (state){						// if state is true then we are activating quadrature
//		set_tris_a(0xfb);			// disable index pin by making it an output
		DFLTCON 		= 0x3C;
		QEICON 			= 0x88;		// 2X clocks
//		QEICON 			= 0x98;		// 4X clocks
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
#include "init.c"
#include "servo.c"
#include "modbus_crc.c"
#include "packets.c"

#zero_ram
void main()
{			
	InitHardware();
	Encoder(true);
	
	ResetServo();
	delay_ms(200);

	bEnable = !STEP_ENABLE;
		
	// run these asynch tasks
	for (;;){
		if (bServo){
			SYNC = true;
			UpdatePosition();
			UpdateTrajectory();
			CalculateExtCount();
			UpdatePID();
			UpdatePWM();
			HandleErrorTask();
			bServo = false;
		} else {		
			HandleRXData();
			
			if (SYNC){
				if (bDirty && !bEnable){
					bDirty = false;
					SaveEEPROM();
				}
				SYNC = false;	
			}


		}
	}
}

#INT_TIMER2
void servoisr()
{
	if (servo_update++ > 18){
		servo_update = 0;
		bServo = true;
		rx_timer++;
	}	
}
