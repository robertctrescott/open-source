/* main.c

	10/04/09 by Robert Trescott Jr.
	(C)2009 Analogic

	Microchip MPLAB ICD2 Emulation

	History:
		01/31/08 - ORIGINAL WORK for PCB01220801 - rct

*/

// compiler and hardware special settings
// *** Microchip stores "little-endian" ex. $4F52 = 0x52 0x4F in memory ***
// *** DO NOT USE ICD2 THROUGH USB HUB! **********
// *** PIC16F690 REQUIRES ICD2 HEADER BOARD! *****

#case
//#define ICD2

#include <16F690.h>
#device *=16

#ifdef ICD2
#fuses HS,NOWDT,NOPROTECT,NOPUT,NOBROWNOUT,NOCPD,MCLR,NOIESO,NOFCMEN
#else
#fuses HS,NOWDT,PROTECT,PUT,NOBROWNOUT,CPD,MCLR
#endif

#use delay(clock=20000000)

#include "PIC16F690.inc"

#define false			0
#define true			1
#define byte			int
#define boolean			short int

#define	LONG_DELAY		15
#define DOOR_OPEN		0
#define CYCLES			5

#BIT FUEL_DOOR			= PORTB.6
#BIT IGNITION			= PORTB.5
#BIT ALARM_OUT			= PORTB.4


char portb;
static int mins 		= 0;


// main routines follow
void InitHardware()
{
	delay_ms(500);
	
	setup_adc(ADC_OFF);
 	TRISA		= 0xFF;			// set port A I/O
 	TRISB		= 0xEF;			// set port B I/O
 	TRISC		= 0xFF;			// set port C I/O
	PORTB		= 0x00;			// set io port initial levels
	IOCB		= 0x60;			// interrupt on change of ignition and fuel door sense
	portb		= PORTB;
	RABIF		= false;

	// fire up interrupts
	enable_interrupts(INT_RB5);
	enable_interrupts(INT_RB6);
	enable_interrupts(GLOBAL);	// allow all other interrupts
}

void wait1minute()
{
	int	secs;
	for (secs=0; secs<60; secs++){
		delay_ms(1000);
	}
}

void doAlarm()
{
	int count = CYCLES;
	
	while (count && !IGNITION){
		ALARM_OUT = true;
		delay_ms(500);
		ALARM_OUT = false;
		delay_ms(300);
		ALARM_OUT = true;
		delay_ms(500);
		ALARM_OUT = false;
		delay_ms(300);
		ALARM_OUT = true;
		delay_ms(1000);
		ALARM_OUT = false;
		delay_ms(300);
		count--;
	}
}

/* Operation:
	Activating Ignition resets timer to LONG DELAY period.
	After timeout, alarm will test fuel door for 1 second, if still opened alarm will sound.
	Ignition will cancel alarm in progress and reset to LONG DELAY.
	Alarm will repeat for CYCLES count and then quiet. After 1 minute if fuel door is still open,
		alarm will sound again. If door is closed it will sleep, but alarm immediatley if reopened 


*/


void main()
{				
	InitHardware();

	for (;;){
		if ((FUEL_DOOR==DOOR_OPEN) && (mins==0)){		// we got an alarm condition
			delay_ms(1000);								// debounce for 1 second
			if (FUEL_DOOR==DOOR_OPEN){					// are we still opened
				doAlarm();								// make noise for a while
				if (FUEL_DOOR==DOOR_OPEN)				// after a while
					mins=1;								// reset timer to 1 minute alarm period 
				else sleep();							// but sleep and be quite if door is closed
			}

		} else if (IGNITION){		// keep the timer a full delay while ignition is on
			mins = LONG_DELAY;

		} else if (!IGNITION){		// we are going to start timers and count down to arm the fuel door
			if (mins>0){
				wait1minute();
				mins-=1;
			}
			else sleep();			// after timeout then sleep (the door is armed and will alarm if opened)
		}
	}
}

#INT_RB
void ignition_isr()
{
	portb = PORTB;		// wake up sleeping processor on change in ignition or fuel door
	RABIF = false;
}