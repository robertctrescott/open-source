#nolist

//-----	Register	Files------------------------------------------------------

#BYTE	INDF        = 0x0000
#BYTE	TMR0		= 0x0001
#BYTE	PCL			= 0x0002
#BYTE	STATUS		= 0x0003
#BYTE	FSR			= 0x0004
#BYTE	GPIO		= 0x0005
#BYTE	PCLATH		= 0x000A
#BYTE	INTCON		= 0x000B
#BYTE	PIR1		= 0x000C
#BYTE	TMR1L		= 0x000E
#BYTE	TMR1H		= 0x000F
#BYTE	T1CON		= 0x0010
#BYTE	CMCON		= 0x0019
#BYTE	ADRESH		= 0x001E
#BYTE	ADCON0		= 0x001F
#BYTE	OPTION_REG	= 0x0081
#BYTE	TRISIO		= 0x0085
#BYTE	PIE1		= 0x008C
#BYTE	PCON		= 0x008E
#BYTE	OSCCAL		= 0x0090
#BYTE	WPU			= 0x0095	
#BYTE	IOC			= 0x0096	
#BYTE	IOCB		= 0x0096	

#BYTE	VRCON		= 0x0099	
#BYTE	EEDATA		= 0x009A	
#BYTE	EEDAT		= 0x009A	
#BYTE	EEADR		= 0x009B	
#BYTE	EECON1		= 0x009C	
#BYTE	EECON2		= 0x009D	
#BYTE	ADRESL		= 0x009E	
#BYTE	ANSEL		= 0x009F	


//-----	STATUS	Bits	--------------------------------------------------------

#BIT	IRP			= STATUS.7	
#BIT	RP1			= STATUS.6	
#BIT	RP0			= STATUS.5	
#BIT	NOT_TO		= STATUS.4	
#BIT	NOT_PD		= STATUS.3	
#BIT	Z			= STATUS.2	
#BIT	DC			= STATUS.1	
#BIT	C			= STATUS.0	

//-----	GPIO	Bits	--------------------------------------------------------

#BIT	GP5			= GPIO.5	
#BIT	GPIO5		= GPIO.5	
#BIT	GP4			= GPIO.4	
#BIT	GPIO4		= GPIO.4	
#BIT	GP3			= GPIO.3	
#BIT	GPIO3		= GPIO.3	
#BIT	GP2			= GPIO.2	
#BIT	GPIO2		= GPIO.2	
#BIT	GP1			= GPIO.1	
#BIT	GPIO1		= GPIO.1	
#BIT	GP0			= GPIO.0	
#BIT	GPIO0		= GPIO.0

#BIT	TS0			= TRISIO.0
#BIT	TS1			= TRISIO.1
#BIT	TS2			= TRISIO.2
#BIT	TS3			= TRISIO.3
#BIT	TS4			= TRISIO.4
#BIT	TS5			= TRISIO.5

//-----	INTCON	Bits	--------------------------------------------------------

#BIT	GIE			= INTCON.7	
#BIT	PEIE		= INTCON.6	
#BIT	T0IE		= INTCON.5	
#BIT	INTE		= INTCON.4	
#BIT	GPIE		= INTCON.3	
#BIT	T0IF		= INTCON.2	
#BIT	INTF		= INTCON.1	
#BIT	GPIF		= INTCON.0	

//-----	PIR1	Bits	----------------------------------------------------------

#BIT	EEIF		= PIR1.7	
#BIT	ADIF		= PIR1.6	
#BIT	CMIF		= PIR1.3	
#BIT	T1IF		= PIR1.0	
#BIT	TMR1IF		= PIR1.0	

//-----	T1CON	Bits	---------------------------------------------------------

#BIT	TMR1GE		= T1CON.6	
#BIT	T1CKPS1		= T1CON.5	
#BIT	T1CKPS0		= T1CON.4	
#BIT	T1OSCEN		= T1CON.3	
#BIT	NOT_T1SYNC	= T1CON.2	
#BIT	TMR1CS		= T1CON.1	
#BIT	TMR1ON		= T1CON.0	

//-----	COMCON	Bits	--------------------------------------------------------

#BIT	COUT		= CMCON.6	
#BIT	CINV		= CMCON.4	
#BIT	CIS			= CMCON.3	
#BIT	CM2			= CMCON.2	
#BIT	CM1			= CMCON.1	
#BIT	CM0			= CMCON.0	

//-----	ADCON0	Bits	--------------------------------------------------------

#BIT	ADFM		= ADCON0.7	
#BIT	VCFG		= ADCON0.6	
#BIT	CHS1		= ADCON0.3	
#BIT	CHS0		= ADCON0.2	
#BIT	GO			= ADCON0.1	
#BIT	NOT_DONE	= ADCON0.1	
#BIT	GO_DONE		= ADCON0.1	
#BIT	ADON		= ADCON0.0	

//-----	OPTION	Bits	--------------------------------------------------------

#BIT	NOT_GPPU	= OPTION_REG.7	
#BIT	INTEDG		= OPTION_REG.6	
#BIT	T0CS		= OPTION_REG.5	
#BIT	T0SE		= OPTION_REG.4	
#BIT	PSA			= OPTION_REG.3	
#BIT	PS2			= OPTION_REG.2	
#BIT	PS1			= OPTION_REG.1	
#BIT	PS0			= OPTION_REG.0	

//-----	PIE1	Bits	----------------------------------------------------------

#BIT	EEIE		= PIE1.7	
#BIT	ADIE		= PIE1.6	
#BIT	CMIE		= PIE1.3	
#BIT	T1IE		= PIE1.0	
#BIT	TMR1IE		= PIE1.0	

//-----	PCON	Bits	----------------------------------------------------------

#BIT	NOT_POR		= PCON.1	
#BIT	NOT_BOD		= PCON.0	

//-----	OSCCAL	Bits	--------------------------------------------------------

#BIT	CAL5		= OSCCAL.7	
#BIT	CAL4		= OSCCAL.6	
#BIT	CAL3		= OSCCAL.5	
#BIT	CAL2		= OSCCAL.4	
#BIT	CAL1		= OSCCAL.3	
#BIT	CAL0		= OSCCAL.2	

//-----	IOCB	Bits	--------------------------------------------------------

#BIT	IOCB5		= IOCB.5	
#BIT	IOCB4		= IOCB.4	
#BIT	IOCB3		= IOCB.3	
#BIT	IOCB2		= IOCB.2	
#BIT	IOCB1		= IOCB.1	
#BIT	IOCB0		= IOCB.0	

//-----	IOC	Bits	--------------------------------------------------------

#BIT	IOC5		= IOC.5	
#BIT	IOC4		= IOC.4	
#BIT	IOC3		= IOC.3	
#BIT	IOC2		= IOC.2	
#BIT	IOC1		= IOC.1	
#BIT	IOC0		= IOC.0	

//-----	VRCON	Bits	---------------------------------------------------------

#BIT	VREN		= VRCON.7	
#BIT	VRR			= VRCON.5
#BIT	VR3			= VRCON.3
#BIT	VR2			= VRCON.2
#BIT	VR1			= VRCON.1
#BIT	VR0			= VRCON.0

//-----	EECON1	-------------------------------------------------------------

#BIT	WRERR		= EECON1.3
#BIT	WREN		= EECON1.2
#BIT	WR			= EECON1.1
#BIT	RD			= EECON1.0

//-----	ANSEL	--------------------------------------------------------------

#BIT	ADCS2		= ANSEL.6
#BIT	ADCS1		= ANSEL.5
#BIT	ADCS0		= ANSEL.4
#BIT	ANS3		= ANSEL.3
#BIT	ANS2		= ANSEL.2
#BIT	ANS1		= ANSEL.1
#BIT	ANS0		= ANSEL.0

#list	
