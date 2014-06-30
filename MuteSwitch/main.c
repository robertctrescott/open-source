/* main.c

	11/08/2011 by Robert Trescott Jr.
	(C)2011 Analogic

	History:
		11/08/11 - original work

*/

// compiler and hardware special settings
#case

#include <12F675.h>

#fuses INTRC_IO,PUT,NOWDT,BROWNOUT,CPD,PROTECT

#use delay (clock=4000000)
#include "PIC12F629.inc"

#define	true			1
#define	false			0
								// PIN	FUNCTION
								//	1 	Vcc
#BIT 	UNUSED1		= GPIO.5	// 	2	not used
#BIT 	SW_IN		= GPIO.4	// 	3	push button input to toggle between mute and unmute (active low)
#BIT 	RESET		= GPIO.3	// 	4	not used
#BIT 	MUTE_RLY	= GPIO.2	// 	5	active for mute
#BIT 	MUTE_LED	= GPIO.1	// 	6	solid on for no mute, blink 2sec off 1sec on for mute
#BIT 	UNUSED2		= GPIO.0	// 	7	not used
								//	8	GND

int1	bMute		= false;
int1	prev_sw;
int8	counter		= 0;


void initialize()
{	
	delay_ms(50);
	set_tris_a(0x18);			// set io direction
	GPIO = 0;					// keep everything low
	MUTE_RLY	= true;			// but activate the relay for test
	delay_ms(100);				// small delay
	MUTE_RLY	= false;		// now un mute	
	MUTE_LED	= true;			// and fire up led indicator
	prev_sw 	= SW_IN;		// remember switch state	
}

#zero_ram
void main()
{	
	initialize();
		
	for(;;){
		delay_ms(20);				// loop update timer

		if (bMute){					// we are in active mute mode
			MUTE_RLY = true;		// trip the mute relay
			counter+=1;				// and advance the timer counter every time through the loop
			switch (counter){
				case 1:		MUTE_LED = false; 	break;	// led off now
				case 50:	MUTE_LED = true; 	break;	// led on now after 1 sec
				case 75:	counter = 0;		break;	// wait on for .5 second then reset counter			
			}
			
		} else {
			MUTE_RLY = false;		// un_mute relay
			MUTE_LED = true;		// solid on for un-mute
			counter = 0;			// clear counter for new cycle
		}

		if (SW_IN != prev_sw){		// we have a button state change
			prev_sw = SW_IN;		// remember for later
			if (SW_IN == false){	// active low! the button is being pressed
				bMute = !bMute;		// toggle mute state flag only on press, not button release
			} 	
		}
	}
}
