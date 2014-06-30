/* main.c

	05/02/09 by Robert Trescott Jr.
	(C)2009 Analogic

	Microchip MPLAB ICD2 Emulation

	History:
		05/18/09 - ORIGINAL WORK for PICDEM 2 PLUS PCB - rct

*/

// compiler and hardware special settings
// *** Microchip stores "little-endian" ex. $4F52 = 0x52 0x4F in memory ***
// *** DO NOT USE ICD2 THROUGH A USB HUB! **********

#case
#define ICD2

#include <18F452.h>
#device *=16
#device ADC=10

#ifdef ICD2
#fuses HS,NOWDT,NOPROTECT,NOBROWNOUT,PUT,NOCPD,NOCPB,NOLVP,DEBUG
#else
#fuses HS,NOWDT,PROTECT,BROWNOUT,PUT,NODEBUG,NOLVP,NOCPD,CPB
#endif
#use delay(clock=20000000)

#include "PIC18F452.inc"		// standard ccs io defs

#define	VERSION		   "1.00"
#export (hex,file="MDI2_1_00.hex")


#define false			0
#define true			1
#define byte			int
#define boolean			short int
#define RS232_TX		PIN_C6
#define RS232_RX		PIN_C7
#define NOTEON			0x90
#define NOTEOFF			0x80
#define SYSEXON			0xF0
#define SYSEXOFF		0xF7
#define REALTIME		0xF8
#define PROGCHNG		0xC0
#define CHANPRSR		0xDF
#define MIDICHAN		PORTC



#define RX_BUFFER_SIZE 	64

#BIT LITE0            	= PORTB.0
#BIT LITE1            	= PORTB.1
#BIT LITE2            	= PORTB.2
#BIT LITE3            	= PORTB.3



#use rs232(baud=31250,xmit=RS232_TX,rcv=RS232_RX)

static int1 mvalid;
static int1 rxempty;
static int1 byteflag;
static int1 insysex;
static int8 mstatus;
static int8 mkey;
static int8 mvel;
static int8 mval;
static int8	mchan;
static int16 mword;

static int8 in_ptr;
static int8 out_ptr;
static int8 in_buffer[RX_BUFFER_SIZE];



void InitHardware()
{
	rxempty = true;
	mstatus = 0;
	mkey	= 0xFF;
	mvel 	= 0xFF;
	mword 	= 0xFFFF;
	mvalid	= false;
	mchan 	= MIDICHAN & 0x0F;

	enable_interrupts(GLOBAL);
	enable_interrupts(INT_TIMER2);
	enable_interrupts(INT_RDA);		// allow uart rcv interrupt
}


void RxMIDI()
{
	if (rxempty){
		mword 	= 0xFFFF;			// make midi word invalid
	} else {
		mword = in_buffer[out_ptr];
		out_ptr++;
		if (out_ptr >= RX_BUFFER_SIZE) out_ptr = 0;
		rxempty = (in_ptr == out_ptr);
	}
}

void HandleMIDI()
{
	mvalid = false;
	RxMIDI();

	if (mword < REALTIME){					// data must be valid and not realtime status
		if (mword == SYSEXOFF){				// sysex message has ended so recognize it and
			insysex = false;				// cancel its flag
			mstatus = 0;					// we also want to clear running status buffer
		} else {
	
			if (mword == SYSEXON || insysex){	// we are either in sysex or getting into it so
				insysex = true;				// flag sysex mode
				mstatus = 0;				// and make sure status buffer is cleared
			} else {
		
				if (mword >= NOTEOFF){		// this must be a status byte
					mstatus = mword;		// so remember it and
					byteflag = false;		// clear thirdbyte flag
				} else {					// we must be a data byte

					if (byteflag){			// are we at the third byte yet
						byteflag = false;	// if so then reset flag and
						mvel = mword;		// record thirdbyte as velocity
						mvalid = true;		// and let system know we are valid
					} else {				// we are not third byte yet

						if (mstatus){
							if (mstatus >= PROGCHNG && mstatus <= CHANPRSR){
								mval = mword;		// save this value but not as third byte
								mvalid = true;		// and let system know we are valid
							} else {
								byteflag = true;	// we now have data bytes that req 3 bytes	
								mkey = mword;		// save key value
			
							}
						}
					}
				}
			}
		}
	}
}




void main()
{	
	InitHardware();
	
	for (;;){										// forever loop
		HandleMIDI();								// parse MIDI stream
		if (mvalid){								// handle if valid
			if ((mstatus&0x0F) == mchan){			// also must be our channel
				switch (mstatus&0xF0){				// only respond to NOTEON/OFF status
					case NOTEOFF: break;
					case NOTEON: break;
					default: break;
				}
			}
		}
	}
}



#INT_TIMER2
void timer2_isr()
{	

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
		rxempty = false;		// we now have something in the rxbuffer
		
		in_buffer[in_ptr] = in;	// read to clear interrupt status flag
		in_ptr++;
		if (in_ptr >= RX_BUFFER_SIZE)
			in_ptr=0;	
	}	
}
