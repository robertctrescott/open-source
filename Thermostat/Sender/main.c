/* main.c

	09/11/2011 by Robert Trescott Jr.
	(C)2011 Analogic

	History:
		09/11/11 - original work

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
		int8 pre		: 5;
		int8 ch3		: 1;
		int8 ch2		: 1;
		int8 ch1		: 1;
	};
} u_OUT;


static int16	chan[MAX_CHANS];
static u_OUT 	out;

#use rs232(baud=1200, xmit=PIN_A0,rcv=PIN_A3)


void initialize()
{	
	delay_ms(50);
	set_tris_a(0xFE);		// set io direction
}


#zero_ram
void main()
{	
	int16	count;

	initialize();
		
	for(;;){
		// look at incoming signal and filter ac over .5 seconds
		// we should see a some logic level change over that time
		// record count value in each register, then test again and again
		for (count=0; count<4000; count++){
			if (!GPIO4) chan[0]++;	
			if (!GPIO5) chan[1]++;	
			if (!GPIO2) chan[2]++;
			delay_us(100);
		}
		
		// if register has some counts in it, then we must be active
		out.ch1 = (chan[0]>100);
		out.ch2 = (chan[1]>100);
		out.ch3 = (chan[2]>100);

		// send preamble and channel status
		out.pre = PREAMBLE;
		putchar(out.byte);

		// clear the counter registers for next test
		chan[0] = chan[1] = chan[2] = 0;
	}
}
