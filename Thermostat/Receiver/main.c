/* main.c

	09/11/2011 by Robert Trescott Jr.
	(C)2011 Analogic

	History:
		09/11/11 - original work
		11/18/11 - modified to add an extra channel on port GP1

*/

// compiler and hardware special settings
#case

#include <12F675.h>

#fuses INTRC_IO,PUT,NOWDT,BROWNOUT,CPD,PROTECT

#use delay (clock=4000000)
#include "PIC12F629.inc"

#define	true			1
#define	false			0

#define MAX_CHANS		3
#define PREAMBLE		0xE5


// "little-endian" ex. 0xA8 0x31 0x52 0x4F in memory = int32 4F5231A8
typedef union {		
	struct {
		int8 byte;
	};
	struct {
		int8 pre		: 5;	// bit 0
		int8 ch3		: 1;
		int8 ch2		: 1;
		int8 ch1		: 1;	// bit 7
	};
} u_IN;


static int16	chan[MAX_CHANS];
static u_IN 	in;

#use rs232(baud=1200, xmit=PIN_A1,rcv=PIN_A0)


void initialize()
{	
	delay_ms(50);
	set_tris_a(0xC9);		// set io direction including GP1 as an output
//	set_tris_a(0xCB);		// set io direction
	GPIO = 0;				// keep relays low
}

#zero_ram
void main()
{	
	initialize();
		
	for(;;){
		if (kbhit()){
			in.byte = getc();
			if ((in.byte & 0x1F) == 0x05){
				if (in.ch1 && !in.ch2){
					GPIO4 = in.ch1;
					GPIO5 = in.ch2;
					GPIO2 = in.ch3;
				} else if (!in.ch1 && in.ch2){
					GPIO4 = in.ch1;
					GPIO5 = in.ch2;
					GPIO2 = in.ch3;
				} else if (in.ch1 && in.ch2){
					GPIO4 = false;
					GPIO5 = false;
					GPIO1 = true;
					GPIO2 = in.ch3;
				} else {
					GPIO4 = in.ch1;
					GPIO5 = in.ch2;
					GPIO2 = in.ch3;
					GPIO1 = false;
				}
			}
		} else {
			delay_us(500);
		}
	}
}

