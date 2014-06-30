/* main.c

	05/02/09 by Robert Trescott Jr.
	(C)2009 Analogic

	Microchip MPLAB ICD2 Emulation

	History:
		05/02/09 - ORIGINAL WORK for PICDEM 2 PLUS PCB - rct
		05/25/09 - Port to 18F252 PCB09051401 - rct
		08/24/12 - Accelerometer test code

*/

// compiler and hardware special settings
// *** Microchip stores "little-endian" ex. $4F52 = 0x52 0x4F in memory ***
// *** DO NOT USE ICD2 THROUGH A USB HUB! **********


#case
//#define ICD2

#include <18F2520.h>
#device *=16
#device ADC=10

#ifdef ICD2
#fuses HS,NOWDT,NOPROTECT,NOBROWNOUT,PUT,NOCPD,NOCPB,NOLVP,DEBUG
#else
#fuses INTRC,NOWDT,PROTECT,BROWNOUT,PUT,NODEBUG,NOLVP,NOCPD,CPB
#endif
#use delay(clock=32000000)

#include "18F4520.inc"		// standard ccs io defs
#include <stdlib.h>

#define	VERSION		  "1.00"
#export (hex,file="SHADES1_00.hex")


#define false			0
#define true			1
#define byte			int
#define boolean			short int
#define RS232_TX		PIN_C6
#define RS232_RX		PIN_C7

#define FORMATED		0x51		
#define ADC_REF			0
#define	ONE_SEC			(20)					// assuming 50ms updates!!!!!

#define BUTTON_NONE			0
#define	BUTTON_SET			1
#define BUTTON_MODE			2
#define BUTTON_BOTH			3

#define CMD_DONE			0
#define CMD_OPEN			1
#define CMD_CLOSE			2

#define SERVO_VAL_STOP		0
#define SERVO_VAL_OPEN		1
#define SERVO_VAL_CLOSE		2

#define SLIP_END		0xc0
#define SLIP_ESC		0xdb
#define SLIP_FLAG_END	0xdc
#define SLIP_FLAG_ESC	0xdd
#define RF_RX_MAX		3

#define RX_BUFFER_SIZE 	16
#define MAX_HISTORY		6

#define _SDO  			PIN_C5
#define _SDA  			PIN_C4
#define _SCK  			PIN_C3

// accelerometer values
const int 				SCALE = 2;
const int16 			MAX_CLOSED	= 980;		// Y axis value only
const int16 			MAX_OPENED	= 600;		// Y axis value only
//const int16 			MAX_CLOSED	= 900;		// Y axis value only
//const int16 			MAX_OPENED	= 700;		// Y axis value only

#BIT	RCIF			= PIR1.5
#BIT	RBPU			= INTCON2.7

#BIT LED_M1		    	= PORTA.0
#BIT LED_M2          	= PORTA.1
#BIT LED_B1           	= PORTB.0
#BIT LED_B2           	= PORTB.1
#BIT LED_B4           	= PORTB.2
#BIT LED_B8           	= PORTB.3
#BIT SERVO_CS			= PORTB.4
#BIT RF_IRQ				= PORTB.5
#BIT SW_SET				= PORTB.6
#BIT SW_MODE			= PORTB.7
#BIT RF_EN				= PORTC.0
#BIT RF_RES				= PORTC.1
#BIT SERVO_PWR			= PORTC.2
#BIT SCK				= PORTC.3
#BIT SDA				= PORTC.4
#BIT SDO				= PORTC.5
#BIT TXO				= PORTC.6
#BIT RXI				= PORTC.7

#use rs232(baud=19200,xmit=RS232_TX,rcv=RS232_RX)
#use i2c(master, scl=PIN_C3, sda=PIN_C4, FORCE_HW)

typedef struct {
	int8  format;
	int8  unit_id;
} s_store;

typedef struct {
	char	cmd;
	char	dat;
	char	csum;
} s_packet;

s_store 	store;
s_packet	pTx;

char	disp_mode = ' ';
signed int16 	accelCount[3];  // Stores the 12-bit signed value
//float 	accelG[3];  // Stores the real accel value in g's

static int1 b50ms;
static int1 b1ms;
static int	servo_val;
static int	cur_cmd;

int1	TEMP_CS;
char	in_buffer[RX_BUFFER_SIZE];
char	in_ptr 		= 0;
char	out_ptr 	= 0;
int		menu_item 	= 0;


#include "number.h"
#include "device.c"
#include "init.c"
#include "rs232.c"
#include "menus.h"
#include "menuing.c"
#include "buttons.c"
#include "radio.c"
#include "MMA8452Q.c"
       
void HandleRealTimeCommands()
{
	if (menu_item == 0){
		menu_item = 1;
		DisplayMenu();
	}

	if (menu_item == REAL_TIME_MENU && rx_available()){
		disp_mode = _low_level_get();
		switch (disp_mode){
			case 'T': break;
			case ' ': menu_item = 0;	break;
		}
	}
}

void HandleRealTimeDisplay()
{
	static int rate;
	static int disp_rate = ONE_SEC;

	if (menu_item == REAL_TIME_MENU){
		if (rate++ > disp_rate){
			rate = 0;
	
			switch (disp_mode){
				case 'T':
					disp_mode = ' ';
					break;	
				
				default:
					disp_mode = ' ';
					break;
			}
		} 
	}
}

// called every 50ms
void HandleEvents()
{			
	switch (cur_cmd){
		case CMD_OPEN:
			readAccelData(accelCount);  		// Read the x/y/z adc values
			accelCount[1] = 0-accelCount[1];	// we only care about Y axis, keep it positive!
			if (accelCount[1]>MAX_OPENED){		// larger values are more closed!
				servo_val = SERVO_VAL_OPEN;
				SERVO_PWR = true;
			} else {
				cur_cmd = CMD_DONE; 
			}
			break;			
		
		case CMD_CLOSE:
			readAccelData(accelCount);  		// Read the x/y/z adc values
			accelCount[1] = 0-accelCount[1];	// we only care about Y axis, keep it positive!
			if (accelCount[1]<MAX_CLOSED){
				servo_val = SERVO_VAL_CLOSE;
				SERVO_PWR = true;
			} else {
				cur_cmd = CMD_DONE; 
			}
			break;			
		
		case CMD_DONE:
			servo_val = SERVO_VAL_STOP;
			SERVO_PWR = false;
			break;		
	}	
	
//	readAccelData(accelCount);  // Read the x/y/z adc values
//	accelCount[1] = 0-accelCount[1];	// we only care about Y axis, keep it positive!
	
//	printf("x=%Ld y=%Ld z=%Ld  \r\n",accelCount[0], accelCount[1], accelCount[2]);
	    /* Now we'll calculate the accleration value into actual g's */
//    for (i=0; i<3; i++){
//		accelG[i] = (float) accelCount[i]/((1<<12)/(2*SCALE));  // get actual g value, this depends on scale being set
//    }		
    /* print out values */
//    printf("x=%f y=%f z=%f \r\n",accelG[0],accelG[1],accelG[2]);	
}


void main()
{
	int8 c;
		
	setup_oscillator(OSC_32MHZ);
	InitHardware();
	Init_RF12();
	init_i2c_device();
	pTx.cmd = 0x12;
	pTx.dat = 0x34;
	
  	c = readRegister(0x0D);  			// Read WHO_AM_I register
	if (c == 0x2A){		 				// WHO_AM_I should always be 0x2A  
		initMMA8452(SCALE, 0);  		// init the accelerometer if communication is OK
		printf("MMA8452Q is online...\r\n");
	} else {
		printf("Could not connect to MMA8452Q: 0x%X",c);
	}
	
	for (;;){
		if (b50ms){
			b50ms = false;
			HandleRealTimeDisplay();
			HandleEvents();
			HandleUILeds();
			HandleUIButtons();
		}

		if (b1ms){
			b1ms = false;
			HandleRealTimeCommands();
			HandleRS232Menu();
		}
	}
}

#INT_TIMER2
void timer2_isr()
{	
	static int8 count;
	static int8 servo_frame;
	static int8 servo_counter;
	
	if (count++ > 49){
		count = 0; 
		
		b50ms = true;
	}
	
	if (servo_counter<servo_val){
		servo_counter++;
		SERVO_CS = true;	
	} else {
		SERVO_CS = false;
	}	

	if (servo_frame++ > 19){
		servo_counter=0;
		servo_frame = 0;
	}
	
	b1ms = true;
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
