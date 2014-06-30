/* main.c

	05/02/09 by Robert Trescott Jr.
	(C)2009 Analogic

	Microchip MPLAB ICD2 Emulation

	History:
		05/02/09 - ORIGINAL WORK for PICDEM 2 PLUS PCB - rct
		05/25/09 - Port to 18F252 PCB09051401 - rct
		08/24/12 - Accelerometer test code
		12/14/12 - rev 1.02 added RF receiver for remote control

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
#fuses INTRC_IO,NOWDT,NOPROTECT,NOBROWNOUT,PUT,NOCPD,NOCPB,NOLVP,DEBUG
#else
#fuses INTRC_IO,NOWDT,PROTECT,BROWNOUT,PUT,NODEBUG,NOLVP,NOCPD,CPB
//#fuses HS,NOWDT,PROTECT,BROWNOUT,PUT,NODEBUG,NOLVP,NOCPD,CPB
#endif
#use delay(clock=32000000)

#include "18F4520.inc"		// standard ccs io defs

#define	VERSION		    "1.02"
#export (hex,file="SHADES1_02.hex")

#define START_ID		0x12		
#define TX_ID			0x10
#define	SRC_ID			0x10
#define RX_ID			0x30
#define UNIT_ID			0x11

#define false			0
#define true			1
#define byte			int
#define boolean			short int

#define BUTTON_NONE			0
#define	BUTTON_SET			1
#define BUTTON_MODE			2
#define BUTTON_BOTH			3

#define CMD_DONE			0
#define CMD_OPEN			1
#define CMD_CLOSE			2
#define CMD_OFF			0x31
#define	CMD_ON			0x32


#define SERVO_VAL_STOP		0
#define SERVO_VAL_OPEN		1
#define SERVO_VAL_CLOSE		2

#define _SDO  			PIN_C5
#define _SDA  			PIN_C4
#define _SCK  			PIN_C3
#define ADC_DATA_MAX	16
#define RF_MAX			10
#define RF_LEN			8

// accelerometer values
const int 				SCALE = 2;
const int16 			MAX_CLOSED	= 980;		// Y axis value only
const int16 			MAX_OPENED	= 600;		// Y axis value only

#BIT	RCIF			= PIR1.5
#BIT	RBPU			= INTCON2.7
#BIT	RBIF			= INTCON.0

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

#use i2c(master, scl=PIN_C3, sda=PIN_C4)

signed int32	adc_raw[ADC_DATA_MAX];
static signed int32	adc_smooth;

signed int16 	accelCount[3];  // Stores the 12-bit signed value
static int1 	b50ms;
static int1		bRX_ready;
static int		servo_val;
static int		cur_cmd;
static int8		dest_id;

static int8 	RF_RXBUF[RF_MAX];
static int8		in_ptr;


#include "buttons.c"
#include "MMA8452Q.c"
#include "modbus_crc.c"
#include "radio.c"

signed int32 calc_smooth_val(signed int32 in_val, signed int32* raw, int array_size)
{
	int				i;
	signed int32 	f;
	
	for (i=array_size-1, f=0; i>0; i--){
		raw[i] = raw[i-1];
		f+= ((raw[i])/array_size);		
	}
	
	raw[0] = in_val;
	f+= (in_val/array_size);
	
	return (f);
}
       
// called every 50ms
void HandleEvents()
{			
	switch (cur_cmd){
		case CMD_OPEN:
			readAccelData(accelCount);  		// Read the x/y/z adc values
			accelCount[1] = 0-accelCount[1];	// we only care about Y axis, keep it positive!
			adc_smooth = calc_smooth_val((signed int32)accelCount[1], &adc_raw, ADC_DATA_MAX);
			if (adc_smooth>MAX_OPENED){		// larger values are more closed!
				servo_val = SERVO_VAL_OPEN;
				SERVO_PWR = true;
			} else {
				cur_cmd = CMD_DONE; 
			}
			break;			
		
		case CMD_CLOSE:
			readAccelData(accelCount);  		// Read the x/y/z adc values
			accelCount[1] = 0-accelCount[1];	// we only care about Y axis, keep it positive!
			adc_smooth = calc_smooth_val((signed int32)accelCount[1], &adc_raw, ADC_DATA_MAX);
			if (adc_smooth<MAX_CLOSED){
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
}

#define IN_START_ID		0
#define IN_TX_ID		1
#define IN_SRC_ID		2
#define IN_RX_ID		3
#define IN_UNIT_ID		4
#define IN_DATA			5
#define IN_CRC_LSB		6
#define IN_CRC_MSB		7

void HandleRfTraffic()
{
	int8 i,lsb,msb;
	int16 crc;
	int8 in_bytes[RF_MAX];
	
	if (bRX_ready){				
		for (i=0; i<RF_LEN; i++)			// copy rf to input so we can operate and still rx
			in_bytes[i] = RF_RXBUF[i];
			
		WriteCMD(0xCA80);
		WriteCMD(0xCA83); 					// reset FIFO and read to receive next Byte
		RF12_RDFIFO();
		bRX_ready = FALSE;					// allow packets again
		
		// now process the last packet using transferred input rx data
		crc = _CRC16_(in_bytes, RF_LEN-2);
		lsb = make8(crc,0);					// crc lsb
		msb = make8(crc,1);					// crc msb

		if (in_bytes[IN_TX_ID] 	 == TX_ID &&
			in_bytes[IN_SRC_ID]  == SRC_ID &&
			in_bytes[IN_RX_ID]   == RX_ID &&
			in_bytes[IN_UNIT_ID] == UNIT_ID &&
			in_bytes[IN_CRC_LSB] == lsb &&
			in_bytes[IN_CRC_MSB] == msb ){	// we have all good data
				
			switch (in_bytes[IN_DATA]){
				case CMD_OFF:
					LED_M1=0;
					LED_M2=1;
					cur_cmd = CMD_CLOSE;
					break;
				case CMD_ON:
					LED_M1=1;
					LED_M2=0;
					cur_cmd = CMD_OPEN;
					break;
				default:
					LED_M1=0;
					LED_M2=0;
					break;
			}
			
		}	
		
		for (i=0; i<RF_LEN; i++)			// copy rf to input so we can operate and still rx
			in_bytes[i] = RF_RXBUF[i] = 0;	// clear out previous data (just in case)		
	}
}	

void InitHardware()
{
	int8 pb;
	
	delay_ms(20);
		
	setup_adc(ADC_OFF);
	setup_adc_ports(NO_ANALOGS);

	set_tris_a(0xFC);	
	set_tris_b(0xE0);	
	set_tris_c(0xA0);	
	
	PORTA = 0;
	PORTB = 0xE0;
	PORTC = 0xF8;
	RBPU = 0;
	RF_RES	= true;
	delay_ms(100);
	pb = PORTB;				// end mismatch condition
	RBIF = 0;				// clear port b change interrupt flag	
	
	setup_timer_1(T1_DISABLED);
//	setup_timer_2(T2_DIV_BY_4, 249, 5);			// heater pwm @5Khz & generate interrupt every 1ms
	setup_timer_2(T2_DIV_BY_4, 196, 10);			// heater pwm @5Khz & generate interrupt every 1ms
					
	enable_interrupts(INT_TIMER2);
	enable_interrupts(INT_RB);
	enable_interrupts(GLOBAL);

	// startup with a light flash
	LED_M1 = LED_M2 = LED_B1 = LED_B2 = LED_B4 = LED_B8 = 1;
	delay_ms(350);
	LED_M1 = LED_M2 = LED_B1 = LED_B2 = LED_B4 = LED_B8 = 0;
	delay_ms(750);
	
	cur_cmd = CMD_DONE;
	servo_val = SERVO_VAL_STOP;
	SERVO_PWR = false;
	
}


void main()
{
	int8 c;
		
	setup_oscillator(OSC_32MHZ);
	InitHardware();
	init_i2c_device();
	Init_RF12RX();
		
  	c = readRegister(0x0D);  			// Read WHO_AM_I register
	if (c == 0x2A){		 				// WHO_AM_I should always be 0x2A  
		initMMA8452(SCALE, 0);  		// init the accelerometer if communication is OK
	}
	
	// preload all the smoothing registers to filter accelerometer inputs
	for (c=0; c<ADC_DATA_MAX; c++){
		readAccelData(accelCount);  		// Read the x/y/z adc values
		accelCount[1] = 0-accelCount[1];	// we only care about Y axis, keep it positive!
		adc_smooth = calc_smooth_val((signed int32)accelCount[1], &adc_raw, ADC_DATA_MAX);
	}
	
	for (;;){
		if (b50ms){
			b50ms = false;
			HandleEvents();
			HandleUILeds();
			HandleUIButtons();
		}
		
		HandleRfTraffic();
		
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
		servo_counter = 0;
		servo_frame = 0;
	}	
}

#INT_RB
void portb_isr()
{
	int8	pb;
	int8	rx;
	
	if (!RF_IRQ && !bRX_ready){		// we have an RF interrupt and packet still not complete 
		rx = RF12_RDFIFO();			// load byte with rf fifo
		if (rx == START_ID) in_ptr = 0;
		else in_ptr++;
		if (in_ptr > RF_LEN){
			bRX_ready = TRUE;		// signal that we are ready to decode packet
			in_ptr = RF_MAX;
		} else {
			RF_RXBUF[in_ptr] = rx;
		}
	}

	pb = PORTB;				// end mismatch condition
	RBIF = 0;				// clear port b change interrupt flag	
	
}	
