/* main.c

	01/31/08 by Robert Trescott Jr.
	(C)2008 Sage Metering Inc

	Microchip MPLAB ICD2 Emulation

	History:
		01/31/08 - ORIGINAL WORK for PCB01220801 - rct

*/

// compiler and hardware special settings
// *** Microchip stores "little-endian" ex. $4F52 = 0x52 0x4F in memory ***
// *** DO NOT USE ICD2 THROUGH USB HUB! **********

#case
#define ICD2

#include <16F690.h>
//#device *=16

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

#define RS485_TX		PIN_B7
#define RS485_RX		PIN_B5

#define RX_MAX			32

#BIT LED				= PORTC.7
#BIT TX_OUT				= PORTB.7
#BIT RS485_EN			= PORTB.6
#BIT RX_IN				= PORTB.5

// macro definitions
#define DIFF(l,h)		((h<l) ? (l-h) : (h-l))
#define MAX(a,b)		((a>b) ? a : b)
#define MIN(a,b)		((a<b) ? a : b)
#define hibyte(x)		(make8(x,1)) 
#define lobyte(x)		(make8(x,0))
#define ABS(x)			((x<0) ? -x : x)

#use rs232(baud=19200,parity=E,xmit=RS485_TX,rcv=RS485_RX)

typedef struct {				// bytes   $ADDR	   REG#
	char	format;				//	1		0			0
	char	unit_id;			//	1		1	
	char	mode2 	: 5;		//	1		2	
	char	tech_id	: 3;		//	1		3	
	
	char	bRun	: 1;			
	char	bTotal 	: 1;			
	char	bEEProm	: 1;			
	char	bReset	: 1;			
	char	padd	: 1;			
	char	bLeadEn : 1;		// lead comp enable flag			
	char	bDAClo	: 1;			
	char	bDAChi	: 1;			
} s_store;

// globals follow
const char version[7] = "v1.000";
char	rx_tx[RX_MAX];
s_store	store;


// main routines follow
#include "modbus_crc.c"
#include "packets.c"



void InitHardware()
{
	delay_ms(100);
	
	setup_adc(ADC_OFF);
 	TRISB		= 0x20;			// set port B I/O
 	TRISC		= 0x00;			// set port C I/O
 	NOT_RABPU	= 0x00;			// allow pull-ups
	PORTB		= 0x00;			// set io port initial levels

	// fire up interrupts
	enable_interrupts(GLOBAL);	// allow all other interrupts
}

void main()
{				
	InitHardware();
	
	for (;;){
		LED = true;
		delay_ms(500);
		LED = false;
		delay_ms(500);
	}
}
