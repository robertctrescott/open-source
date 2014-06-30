#nolist

// ----- Register Files------------------------------------------------------

#BYTE	INDF         = 0x0000
#BYTE	TMR0         = 0x0001
#BYTE	PCL          = 0x0002
#BYTE	STATUS       = 0x0003
#BYTE	FSR          = 0x0004
#BYTE	PORTA        = 0x0005
#BYTE	PORTB        = 0x0006
#BYTE	PORTC        = 0x0007

#BYTE	PCLATH       = 0x000A
#BYTE	INTCON       = 0x000B
#BYTE	PIR1         = 0x000C
#BYTE	PIR2         = 0x000D
#BYTE	TMR1L        = 0x000E		
#BYTE	TMR1H        = 0x000F		
#BYTE	T1CON        = 0x0010		
#BYTE	TMR2         = 0x0011
#BYTE	T2CON        = 0x0012
#BYTE	SSPBUF       = 0x0013
#BYTE	SSPCON       = 0x0014
#BYTE	CCPR1L       = 0x0015
#BYTE	CCPR1H       = 0x0016
#BYTE	CCP1CON      = 0x0017
#BYTE	RCSTA        = 0x0018
#BYTE	TXREG        = 0x0019		
#BYTE	RCREG        = 0x001A

#BYTE	PWM1CON      = 0x001C
#BYTE	ECCPAS       = 0x001D
#BYTE	ADRESH       = 0x001E		
#BYTE	ADCON0       = 0x001F		


#BYTE	OPTION_REG   = 0x0081

#BYTE	TRISA        = 0x0085
#BYTE	TRISB        = 0x0086
#BYTE	TRISC        = 0x0087

#BYTE	PIE1         = 0x008C
#BYTE	PIE2         = 0x008D
#BYTE	PCON         = 0x008E
#BYTE	OSCCON       = 0x008F
#BYTE	OSCTUNE	     = 0x0090

#BYTE	PR2          = 0x0092
#BYTE	SSPADD       = 0x0093
#BYTE	MSK          = 0x0093
#BYTE	SSPMSK       = 0x0093
#BYTE	SSPSTAT      = 0x0094
#BYTE	WPU          = 0x0095
#BYTE	WPUA         = 0x0095
#BYTE	IOC          = 0x0096
#BYTE	IOCA         = 0x0096
#BYTE	WDTCON       = 0x0097
#BYTE	TXSTA        = 0x0098
#BYTE	SPBRG        = 0x0099
#BYTE	SPBRGH       = 0x009A	
#BYTE	BAUDCTL      = 0x009B


#BYTE	ADRESL       = 0x009E		
#BYTE	ADCON1       = 0x009F


#BYTE	EEDAT        = 0x010C
#BYTE	EEDATA       = 0x010C
#BYTE	EEADR        = 0x010D
#BYTE	EEDATH       = 0x010E
#BYTE	EEADRH       = 0x010F


#BYTE	WPUB         = 0x0115
#BYTE	IOCB         = 0x0116

#BYTE	VRCON        = 0x0118
#BYTE	CM1CON0      = 0x0119
#BYTE	CM2CON0      = 0x011A
#BYTE	CM2CON1      = 0x011B

#BYTE	ANSEL        = 0x011E
#BYTE	ANSELH       = 0x011F

#BYTE	EECON1       = 0x018C
#BYTE	EECON2       = 0x018D


#BYTE	PSTRCON      = 0x019D
#BYTE	SRCON        = 0x019E



//---- BANK 0 REGISTER DEFINITIONS ----------------------------------------
//---- STATUS Bits --------------------------------------------------------

#BIT	IRP          = STATUS.7
#BIT	RP1          = STATUS.6
#BIT	RP0          = STATUS.5
#BIT	NOT_TO       = STATUS.4
#BIT	NOT_PD       = STATUS.3
#BIT	Z            = STATUS.2
#BIT	DC           = STATUS.1
#BIT	C            = STATUS.0

//---- INTCON Bits --------------------------------------------------------

#BIT	GIE          = INTCON.7
#BIT	PEIE         = INTCON.6
#BIT	T0IE         = INTCON.5
#BIT	INTE         = INTCON.4
#BIT	RABIE        = INTCON.3
#BIT	T0IF         = INTCON.2
#BIT	INTF         = INTCON.1
#BIT	RABIF        = INTCON.0

//---- PIR1 Bits ----------------------------------------------------------

#BIT	ADIF         = PIR1.6
#BIT	RCIF         = PIR1.5
#BIT	TXIF         = PIR1.4
#BIT	SSPIF        = PIR1.3
#BIT	CCP1IF       = PIR1.2
#BIT	T2IF         = PIR1.1
#BIT	TMR2IF       = PIR1.1
#BIT	T1IF         = PIR1.0
#BIT	TMR1IF       = PIR1.0

//---- PIR2 Bits ----------------------------------------------------------

#BIT	OSFIF        = PIR2.7
#BIT	C2IF         = PIR2.6
#BIT	C1IF         = PIR2.5
#BIT	EEIF         = PIR2.4

//---- T1CON Bits ---------------------------------------------------------

#BIT	T1GINV       = T1CON.7
#BIT	TMR1GE       = T1CON.6
#BIT	T1CKPS1      = T1CON.5
#BIT	T1CKPS0      = T1CON.4
#BIT	T1OSCEN      = T1CON.3
#BIT	NOT_T1SYNC   = T1CON.2
#BIT	TMR1CS       = T1CON.1
#BIT	TMR1ON       = T1CON.0

//---- T2CON Bits ---------------------------------------------------------

#BIT	TOUTPS3      = T2CON.6
#BIT	TOUTPS2      = T2CON.5
#BIT	TOUTPS1      = T2CON.4
#BIT	TOUTPS0      = T2CON.3
#BIT	TMR2ON       = T2CON.2
#BIT	T2CKPS1      = T2CON.1
#BIT	T2CKPS0      = T2CON.0

//---- SSPCON Bits -------------------------------------------------------

#BIT	WCOL         = SSPCON.7
#BIT	SSPOV        = SSPCON.6
#BIT	SSPEN        = SSPCON.5
#BIT	CKP          = SSPCON.4
#BIT	SSPM3        = SSPCON.3
#BIT	SSPM2        = SSPCON.2
#BIT	SSPM1        = SSPCON.1
#BIT	SSPM0        = SSPCON.0

//---- CCP1CON Bits -------------------------------------------------------

#BIT	P1M1         = CCP1CON.7
#BIT	P1M0         = CCP1CON.6
#BIT	DC1B1        = CCP1CON.5
#BIT	DC1B0        = CCP1CON.4
#BIT	CCP1M3       = CCP1CON.3
#BIT	CCP1M2       = CCP1CON.2
#BIT	CCP1M1       = CCP1CON.1
#BIT	CCP1M0       = CCP1CON.0

//---- RCSTA Bits ---------------------------------------------------------

#BIT	SPEN         = RCSTA.7
#BIT	RX9          = RCSTA.6
#BIT	SREN         = RCSTA.5
#BIT	CREN         = RCSTA.4
#BIT	ADDEN        = RCSTA.3
#BIT	FERR         = RCSTA.2
#BIT	OERR         = RCSTA.1
#BIT	RX9D         = RCSTA.0

//---- PWM1CON Bits -------------------------------------------------------

#BIT	PRSEN        = PWM1CON.7
#BIT	PDC6         = PWM1CON.6
#BIT	PDC5         = PWM1CON.5
#BIT	PDC4         = PWM1CON.4
#BIT	PDC3         = PWM1CON.3
#BIT	PDC2         = PWM1CON.2
#BIT	PDC1         = PWM1CON.1
#BIT	PDC0         = PWM1CON.0

//---- ECCPAS Bits --------------------------------------------------------

#BIT	ECCPASE      = ECCPAS.7
#BIT	ECCPAS2      = ECCPAS.6
#BIT	ECCPAS1      = ECCPAS.5
#BIT	ECCPAS0      = ECCPAS.4
#BIT	PSSAC1       = ECCPAS.3
#BIT	PSSAC0       = ECCPAS.2
#BIT	PSSBD1       = ECCPAS.1
#BIT	PSSBD0       = ECCPAS.0

//---- ADCON0 Bits --------------------------------------------------------

#BIT	ADFM         = ADCON0.7
#BIT	VCFG         = ADCON0.6
#BIT	CHS3         = ADCON0.5
#BIT	CHS2         = ADCON0.4
#BIT	CHS1         = ADCON0.3
#BIT	CHS0         = ADCON0.2
#BIT	GO           = ADCON0.1
#BIT	NOT_DONE     = ADCON0.1
#BIT	GO_DONE      = ADCON0.1
#BIT	ADON         = ADCON0.0

//---- BANK 1 REGISTER DEFINITIONS ----------------------------------------
//---- OPTION_REG Bits --------------------------------------------------------

#BIT	NOT_RABPU    = OPTION_REG.7
#BIT	INTEDG       = OPTION_REG.6
#BIT	T0CS         = OPTION_REG.5
#BIT	T0SE         = OPTION_REG.4
#BIT	PSA          = OPTION_REG.3
#BIT	PS2          = OPTION_REG.2
#BIT	PS1          = OPTION_REG.1
#BIT	PS0          = OPTION_REG.0

//---- TRISA Bits --------------------------------------------------------

#BIT	TRISA5       = TRISA.5
#BIT	TRISA4       = TRISA.4
#BIT	TRISA3       = TRISA.3
#BIT	TRISA2       = TRISA.2
#BIT	TRISA1       = TRISA.1
#BIT	TRISA0       = TRISA.0

//---- TRISB Bits --------------------------------------------------------

#BIT	TRISB7       = TRISB.7
#BIT	TRISB6       = TRISB.6
#BIT	TRISB5       = TRISB.5
#BIT	TRISB4       = TRISB.4

//---- TRISC Bits --------------------------------------------------------

#BIT	TRISC7       = TRISC.7
#BIT	TRISC6       = TRISC.6
#BIT	TRISC5       = TRISC.5
#BIT	TRISC4       = TRISC.4
#BIT	TRISC3       = TRISC.3
#BIT	TRISC2       = TRISC.2
#BIT	TRISC1       = TRISC.1
#BIT	TRISC0       = TRISC.0

//---- PIE1 Bits ----------------------------------------------------------

#BIT	ADIE         = PIE1.6
#BIT	RCIE         = PIE1.5
#BIT	TXIE         = PIE1.4
#BIT	SSPIE        = PIE1.3
#BIT	CCP1IE       = PIE1.2
#BIT	T2IE         = PIE1.1
#BIT	TMR2IE       = PIE1.1
#BIT	T1IE         = PIE1.0
#BIT	TMR1IE       = PIE1.0

//---- PIE2 Bits ----------------------------------------------------------

#BIT	OSFIE        = PIE2.7
#BIT	C2IE         = PIE2.6
#BIT	C1IE         = PIE2.5
#BIT	EEIE         = PIE2.4

//---- PCON Bits ----------------------------------------------------------

#BIT	ULPWUE       = PCON.5
#BIT	SBOREN       = PCON.4
#BIT	NOT_POR      = PCON.1
#BIT	NOT_BOR      = PCON.0

//---- OSCCON Bits --------------------------------------------------------

#BIT	IRCF2        = OSCCON.6
#BIT	IRCF1        = OSCCON.5
#BIT	IRCF0        = OSCCON.4
#BIT	OSTS         = OSCCON.3
#BIT	HTS          = OSCCON.2
#BIT	LTS          = OSCCON.1
#BIT	SCS          = OSCCON.0

//---- OSCTUNE Bits -------------------------------------------------------

#BIT	TUN4         = OSCTUNE.4
#BIT	TUN3         = OSCTUNE.3
#BIT	TUN2         = OSCTUNE.2
#BIT	TUN1         = OSCTUNE.1
#BIT	TUN0         = OSCTUNE.0

//---- SSPSTAT Bits --------------------------------------------------------

#BIT	SMP          = SSPSTAT.7
#BIT	CKE          = SSPSTAT.6
//#BIT	D            = SSPSTAT.5
#BIT	I2C_DATA     = SSPSTAT.5
#BIT	NOT_A        = SSPSTAT.5
#BIT	NOT_ADDRESS  = SSPSTAT.5
#BIT	D_A          = SSPSTAT.5
#BIT	DATA_ADDRESS = SSPSTAT.5
//#BIT	P            = SSPSTAT.4
#BIT	I2C_STOP     = SSPSTAT.4
//#BIT	S            = SSPSTAT.3
#BIT	I2C_START    = SSPSTAT.3
//#BIT	R            = SSPSTAT.2
#BIT	I2C_READ     = SSPSTAT.2
#BIT	NOT_W        = SSPSTAT.2
#BIT	NOT_WRITE    = SSPSTAT.2
#BIT	R_W          = SSPSTAT.2
#BIT	READ_WRITE   = SSPSTAT.2
#BIT	UA           = SSPSTAT.1
#BIT	BF           = SSPSTAT.0

//---- WPUA --------------------------------------------------------------

#BIT	WPUA5        = WPUA.5
#BIT	WPUA4        = WPUA.4

#BIT	WPUA2        = WPUA.2
#BIT	WPUA1        = WPUA.1
#BIT	WPUA0        = WPUA.0

//---- IOC --------------------------------------------------------------

#BIT	IOC5         = IOC.5
#BIT	IOC4         = IOC.4
#BIT	IOC3         = IOC.3
#BIT	IOC2         = IOC.2
#BIT	IOC1         = IOC.1
#BIT	IOC0         = IOC.0

//---- IOCA --------------------------------------------------------------

#BIT	IOCA5        = IOCA.5
#BIT	IOCA4        = IOCA.4
#BIT	IOCA3        = IOCA.3
#BIT	IOCA2        = IOCA.2
#BIT	IOCA1        = IOCA.1
#BIT	IOCA0        = IOCA.0

//---- WDTCON Bits --------------------------------------------------------

#BIT	WDTPS3       = WDTCON.4
#BIT	WDTPS2       = WDTCON.3
#BIT	WDTPS1       = WDTCON.2
#BIT	WDTPS0       = WDTCON.1
#BIT	SWDTEN       = WDTCON.0

//---- TXSTA Bits -------------------------------------------------------

#BIT	CSRC         = TXSTA.7
#BIT	TX9          = TXSTA.6
#BIT	TXEN         = TXSTA.5
#BIT	SYNC         = TXSTA.4
#BIT	SENB         = TXSTA.3
#BIT	BRGH         = TXSTA.2
#BIT	TRMT         = TXSTA.1
#BIT	TX9D         = TXSTA.0

//---- SPBRG Bits -------------------------------------------------------

#BIT	BRG7         = SPBRG.7
#BIT	BRG6         = SPBRG.6
#BIT	BRG5         = SPBRG.5
#BIT	BRG4         = SPBRG.4
#BIT	BRG3         = SPBRG.3
#BIT	BRG2         = SPBRG.2
#BIT	BRG1         = SPBRG.1
#BIT	BRG0         = SPBRG.0

//---- SPBRGH Bits -------------------------------------------------------

#BIT	BRG15        = SPBRGH.7
#BIT	BRG14        = SPBRGH.6
#BIT	BRG13        = SPBRGH.5
#BIT	BRG12        = SPBRGH.4
#BIT	BRG11        = SPBRGH.3
#BIT	BRG10        = SPBRGH.2
#BIT	BRG9         = SPBRGH.1
#BIT	BRG8         = SPBRGH.0

//---- BAUDCTL Bits -------------------------------------------------------

#BIT	ABDOVF       = BAUDCTL.7
#BIT	RCIDL        = BAUDCTL.6

#BIT	SCKP         = BAUDCTL.4
#BIT	BRG16        = BAUDCTL.3

#BIT	WUE          = BAUDCTL.1
#BIT	ABDEN        = BAUDCTL.0

//---- ADCON1 -------------------------------------------------------------

#BIT	ADCS2        = ADCON1.6
#BIT	ADCS1        = ADCON1.5
#BIT	ADCS0        = ADCON1.4

//---- BANK 2 REGISTER DEFINITIONS ----------------------------------------
//---- WPUB Bits ----------------------------------------------------------

#BIT	WPUB7        = WPUB.7
#BIT	WPUB6        = WPUB.6
#BIT	WPUB5        = WPUB.5
#BIT	WPUB4        = WPUB.4

//---- IOCB --------------------------------------------------------------

#BIT	IOCB7        = IOCB.7
#BIT	IOCB6        = IOCB.6
#BIT	IOCB5        = IOCB.5
#BIT	IOCB4        = IOCB.4

//---- VRCON Bits ---------------------------------------------------------

#BIT	C1VREN       = VRCON.7
#BIT	C2VREN       = VRCON.6
#BIT	VRR          = VRCON.5
#BIT	VP6EN        = VRCON.4
#BIT	VR3          = VRCON.3
#BIT	VR2          = VRCON.2
#BIT	VR1          = VRCON.1
#BIT	VR0          = VRCON.0

//---- CM1CON0 Bits -------------------------------------------------------

#BIT	C1ON         = CM1CON0.7
//#BIT	C1OUT        = CM1CON0.6
#BIT	C1OE         = CM1CON0.5
#BIT	C1POL        = CM1CON0.4

#BIT	C1R          = CM1CON0.2
#BIT	C1CH1        = CM1CON0.1
#BIT	C1CH0        = CM1CON0.0

//---- CM2CON0 Bits -------------------------------------------------------

#BIT	C2ON         = CM2CON0.7
//#BIT	C2OUT        = CM2CON0.6
#BIT	C2OE         = CM2CON0.5
#BIT	C2POL        = CM2CON0.4

#BIT	C2R          = CM2CON0.2
#BIT	C2CH1        = CM2CON0.1
#BIT	C2CH0        = CM2CON0.0

//---- CM2CON1 Bits -------------------------------------------------------

#BIT	MC1OUT       = CM2CON1.7
#BIT	MC2OUT       = CM2CON1.6
#BIT	T1GSS        = CM2CON1.1
#BIT	C2SYNC       = CM2CON1.0

//---- ANSELH -------------------------------------------------------------

#BIT	ANS11        = ANSELH.3
#BIT	ANS10        = ANSELH.2
#BIT	ANS9         = ANSELH.1
#BIT	ANS8         = ANSELH.0

//---- ANSEL --------------------------------------------------------------

#BIT	ANS7         = ANSEL.7
#BIT	ANS6         = ANSEL.6
#BIT	ANS5         = ANSEL.5
#BIT	ANS4         = ANSEL.4
#BIT	ANS3         = ANSEL.3
#BIT	ANS2         = ANSEL.2
#BIT	ANS1         = ANSEL.1
#BIT	ANS0         = ANSEL.0

//---- BANK 3 REGISTER DEFINITIONS ----------------------------------------
//---- EECON1 -------------------------------------------------------------

#BIT	EEPGD        = EECON1.7
#BIT	WRERR        = EECON1.3
#BIT	WREN         = EECON1.2
#BIT	WR           = EECON1.1
#BIT	RD           = EECON1.0

//---- PSTRCON -------------------------------------------------------------

#BIT	STRSYNC       = PSTRCON.4
#BIT	STRD          = PSTRCON.3
#BIT	STRC          = PSTRCON.2
#BIT	STRB          = PSTRCON.1
#BIT	STRA          = PSTRCON.0

//---- SRCON ---------------------------------------------------------------

#BIT	SR1           = SRCON.7
#BIT	SR0           = SRCON.6
#BIT	C1SEN         = SRCON.5
#BIT	C2REN         = SRCON.4
#BIT	PULSS         = SRCON.3
#BIT	PULSR         = SRCON.2

#list
