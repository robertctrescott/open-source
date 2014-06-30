_GPIO_Configure:
;HW_V1_Config.c,12 :: 		void GPIO_Configure(void)
SUB	SP, SP, #4
;HW_V1_Config.c,14 :: 		IOPAEN_bit = 1;     // !!!!!!!! VERY IMPORTANT TO ACTIVATE THE APB2 PERIPHERAL CLOCK ENABLES FIRST  !!!!!!!!!!!
MOVS	R2, #1
SXTB	R2, R2
MOVW	R0, #lo_addr(IOPAEN_bit+0)
MOVT	R0, #hi_addr(IOPAEN_bit+0)
STR	R2, [R0, #0]
;HW_V1_Config.c,23 :: 		+------------ Nib7  KR    Pull up input */
MOVW	R1, #32896
MOVT	R1, #34952
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;HW_V1_Config.c,32 :: 		+------------ Nib15 TDI   Pull up input*/
MOVW	R1, #18571
MOVT	R1, #34948
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;HW_V1_Config.c,33 :: 		GPIOA_ODR = 0x0FFFF;
MOVW	R1, #65535
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;HW_V1_Config.c,35 :: 		IOPBEN_bit = 1;
MOVW	R0, #lo_addr(IOPBEN_bit+0)
MOVT	R0, #hi_addr(IOPBEN_bit+0)
STR	R2, [R0, #0]
;HW_V1_Config.c,44 :: 		+------------ Nib7  NC    Pull up input  */
MOVW	R1, #33809
MOVT	R1, #34952
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
STR	R1, [R0, #0]
;HW_V1_Config.c,53 :: 		+------------ Nib15 MOSI  Alternate output*/
MOVW	R1, #46216
MOVT	R1, #48049
MOVW	R0, #lo_addr(GPIOB_CRH+0)
MOVT	R0, #hi_addr(GPIOB_CRH+0)
STR	R1, [R0, #0]
;HW_V1_Config.c,54 :: 		GPIOB_ODR = 0x0FFFF;
MOVW	R1, #65535
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;HW_V1_Config.c,56 :: 		IOPCEN_bit = 1;
MOVW	R0, #lo_addr(IOPCEN_bit+0)
MOVT	R0, #hi_addr(IOPCEN_bit+0)
STR	R2, [R0, #0]
;HW_V1_Config.c,65 :: 		+------------ Nib7  NC    Pull up input */
MOVW	R1, #34945
MOVT	R1, #33809
MOVW	R0, #lo_addr(GPIOC_CRL+0)
MOVT	R0, #hi_addr(GPIOC_CRL+0)
STR	R1, [R0, #0]
;HW_V1_Config.c,74 :: 		+------------ Nib15 NC    Pull up input*/
MOVW	R1, #34948
MOVT	R1, #34952
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
STR	R1, [R0, #0]
;HW_V1_Config.c,75 :: 		GPIOC_ODR = 0x0FFF0;
MOVW	R1, #65520
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;HW_V1_Config.c,77 :: 		IOPDEN_bit = 1;
MOVW	R0, #lo_addr(IOPDEN_bit+0)
MOVT	R0, #hi_addr(IOPDEN_bit+0)
STR	R2, [R0, #0]
;HW_V1_Config.c,86 :: 		+------------ Nib7  nCS   Hight speed output*/
MOVW	R1, #34872
MOVT	R1, #14387
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;HW_V1_Config.c,95 :: 		+------------ Nib15 NC    Pull up input*/
MOVW	R1, #34948
MOVT	R1, #34955
MOVW	R0, #lo_addr(GPIOD_CRH+0)
MOVT	R0, #hi_addr(GPIOD_CRH+0)
STR	R1, [R0, #0]
;HW_V1_Config.c,96 :: 		GPIOD_ODR = 0x0FF7F;
MOVW	R1, #65407
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;HW_V1_Config.c,98 :: 		IOPEEN_bit = 1;
MOVW	R0, #lo_addr(IOPEEN_bit+0)
MOVT	R0, #hi_addr(IOPEEN_bit+0)
STR	R2, [R0, #0]
;HW_V1_Config.c,99 :: 		GPIOE_CRL = 0x33333333;   //Bit0-7  Hight speed output£¨LCD_DB0-7 £©
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOE_CRL+0)
MOVT	R0, #hi_addr(GPIOE_CRL+0)
STR	R1, [R0, #0]
;HW_V1_Config.c,100 :: 		GPIOE_CRH = 0x33333333;   //Bit8-15 Hight speed output£¨LCD_DB8-15£©
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
STR	R1, [R0, #0]
;HW_V1_Config.c,102 :: 		AFIOEN_bit = 1;
MOVW	R0, #lo_addr(AFIOEN_bit+0)
MOVT	R0, #hi_addr(AFIOEN_bit+0)
STR	R2, [R0, #0]
;HW_V1_Config.c,107 :: 		++++--------- Reset value */
MOVW	R1, #4608
MOVW	R0, #lo_addr(AFIO_MAPR+0)
MOVT	R0, #hi_addr(AFIO_MAPR+0)
STR	R1, [R0, #0]
;HW_V1_Config.c,108 :: 		}
L_end_GPIO_Configure:
ADD	SP, SP, #4
BX	LR
; end of _GPIO_Configure
_InitUART1:
;HW_V1_Config.c,110 :: 		void InitUART1(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;HW_V1_Config.c,113 :: 		UART1_Init_Advanced(19200,_UART_8_BIT_DATA,_UART_NOPARITY,_UART_ONE_STOPBIT,&_GPIO_MODULE_USART1_PA9_10); // simple uart
MOVW	R0, #lo_addr(__GPIO_MODULE_USART1_PA9_10+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_USART1_PA9_10+0)
PUSH	(R0)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
MOVW	R0, #19200
BL	_UART1_Init_Advanced+0
ADD	SP, SP, #4
;HW_V1_Config.c,114 :: 		NVIC_IntEnable(IVT_INT_USART1);
MOVW	R0, #53
BL	_NVIC_IntEnable+0
;HW_V1_Config.c,115 :: 		TCIE_USART1_CR1_bit = 0;        // no interrupts with xmit
MOVS	R2, #0
SXTB	R2, R2
MOVW	R0, #lo_addr(TCIE_USART1_CR1_bit+0)
MOVT	R0, #hi_addr(TCIE_USART1_CR1_bit+0)
STR	R2, [R0, #0]
;HW_V1_Config.c,116 :: 		UE_bit = 1;                     // enable USART1
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(UE_bit+0)
MOVT	R0, #hi_addr(UE_bit+0)
STR	R1, [R0, #0]
;HW_V1_Config.c,117 :: 		RE_bit = 1;                     // receiver 1 enable
MOVW	R0, #lo_addr(RE_bit+0)
MOVT	R0, #hi_addr(RE_bit+0)
STR	R1, [R0, #0]
;HW_V1_Config.c,118 :: 		RXNEIE_USART1_CR1_bit = 1;      // rx interrupts on
MOVW	R0, #lo_addr(RXNEIE_USART1_CR1_bit+0)
MOVT	R0, #hi_addr(RXNEIE_USART1_CR1_bit+0)
STR	R1, [R0, #0]
;HW_V1_Config.c,119 :: 		TXEIE_USART1_CR1_bit = 0;
MOVW	R0, #lo_addr(TXEIE_USART1_CR1_bit+0)
MOVT	R0, #hi_addr(TXEIE_USART1_CR1_bit+0)
STR	R2, [R0, #0]
;HW_V1_Config.c,120 :: 		TE_bit = 1;                     // tx 1 always enabled
MOVW	R0, #lo_addr(TE_bit+0)
MOVT	R0, #hi_addr(TE_bit+0)
STR	R1, [R0, #0]
;HW_V1_Config.c,121 :: 		}
L_end_InitUART1:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _InitUART1
_InitTimers:
;HW_V1_Config.c,126 :: 		void InitTimers(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;HW_V1_Config.c,129 :: 		RCC_APB1ENR.TIM2EN = 1;         // Enable clock gating for timer module 2
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;HW_V1_Config.c,130 :: 		TIM2_CR1.CEN = 0;               // Disable timer
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
STR	R1, [R0, #0]
;HW_V1_Config.c,131 :: 		TIM2_PSC = 0;                   // Set timer prescaler to 0
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM2_PSC+0)
MOVT	R0, #hi_addr(TIM2_PSC+0)
STR	R1, [R0, #0]
;HW_V1_Config.c,132 :: 		TIM2_ARR = 36000;               // 36Mhz clock counts 36000 times for 1ms interval
MOVW	R1, #36000
MOVW	R0, #lo_addr(TIM2_ARR+0)
MOVT	R0, #hi_addr(TIM2_ARR+0)
STR	R1, [R0, #0]
;HW_V1_Config.c,133 :: 		NVIC_IntEnable(IVT_INT_TIM2);   // Enable timer interrupt
MOVW	R0, #44
BL	_NVIC_IntEnable+0
;HW_V1_Config.c,134 :: 		TIM2_DIER.UIE = 1;              // Update interrupt enable
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
STR	R1, [R0, #0]
;HW_V1_Config.c,135 :: 		TIM2_CR1.CEN = 1;               // Enable timer
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
STR	R1, [R0, #0]
;HW_V1_Config.c,136 :: 		}
L_end_InitTimers:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _InitTimers
_KeyScan:
;HW_V1_Config.c,145 :: 		char KeyScan(void)
SUB	SP, SP, #8
;HW_V1_Config.c,147 :: 		char Key_Status_Now=0, KeyCode=0;
; Key_Status_Now start address is: 4 (R1)
MOVS	R1, #0
MOVS	R0, #0
STRB	R0, [SP, #4]
;HW_V1_Config.c,149 :: 		if((~GPIOA_IDR) & 0x0010) Key_Status_Now |= 0x01; //KEY_PLAY_ON
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
LDR	R0, [R0, #0]
MVN	R0, R0
AND	R0, R0, #16
CMP	R0, #0
IT	EQ
BEQ	L__KeyScan27
ORR	R2, R1, #1
UXTB	R2, R2
; Key_Status_Now end address is: 4 (R1)
; Key_Status_Now start address is: 8 (R2)
; Key_Status_Now end address is: 8 (R2)
UXTB	R1, R2
IT	AL
BAL	L_KeyScan0
L__KeyScan27:
L_KeyScan0:
;HW_V1_Config.c,150 :: 		if((~GPIOD_IDR) & 0x0800) Key_Status_Now |= 0x02; //KEY_MENU_ON
; Key_Status_Now start address is: 4 (R1)
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
LDR	R0, [R0, #0]
MVN	R0, R0
AND	R0, R0, #2048
CMP	R0, #0
IT	EQ
BEQ	L__KeyScan28
ORR	R2, R1, #2
UXTB	R2, R2
; Key_Status_Now end address is: 4 (R1)
; Key_Status_Now start address is: 8 (R2)
; Key_Status_Now end address is: 8 (R2)
UXTB	R1, R2
IT	AL
BAL	L_KeyScan1
L__KeyScan28:
L_KeyScan1:
;HW_V1_Config.c,151 :: 		if((~GPIOA_IDR) & 0x0040) Key_Status_Now |= 0x04; //KEY_UP_ON
; Key_Status_Now start address is: 4 (R1)
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
LDR	R0, [R0, #0]
MVN	R0, R0
AND	R0, R0, #64
CMP	R0, #0
IT	EQ
BEQ	L__KeyScan29
ORR	R2, R1, #4
UXTB	R2, R2
; Key_Status_Now end address is: 4 (R1)
; Key_Status_Now start address is: 8 (R2)
; Key_Status_Now end address is: 8 (R2)
UXTB	R1, R2
IT	AL
BAL	L_KeyScan2
L__KeyScan29:
L_KeyScan2:
;HW_V1_Config.c,152 :: 		if((~GPIOD_IDR) & 0x0200) Key_Status_Now |= 0x08; //KEY_DOWN_ON
; Key_Status_Now start address is: 4 (R1)
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
LDR	R0, [R0, #0]
MVN	R0, R0
AND	R0, R0, #512
CMP	R0, #0
IT	EQ
BEQ	L__KeyScan30
ORR	R2, R1, #8
UXTB	R2, R2
; Key_Status_Now end address is: 4 (R1)
; Key_Status_Now start address is: 8 (R2)
; Key_Status_Now end address is: 8 (R2)
IT	AL
BAL	L_KeyScan3
L__KeyScan30:
UXTB	R2, R1
L_KeyScan3:
;HW_V1_Config.c,153 :: 		if((~GPIOA_IDR) & 0x0020) Key_Status_Now |= 0x10; //KEY_LEFT_ON
; Key_Status_Now start address is: 8 (R2)
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
LDR	R0, [R0, #0]
MVN	R0, R0
AND	R0, R0, #32
CMP	R0, #0
IT	EQ
BEQ	L__KeyScan31
ORR	R1, R2, #16
UXTB	R1, R1
; Key_Status_Now end address is: 8 (R2)
; Key_Status_Now start address is: 4 (R1)
; Key_Status_Now end address is: 4 (R1)
UXTB	R2, R1
IT	AL
BAL	L_KeyScan4
L__KeyScan31:
L_KeyScan4:
;HW_V1_Config.c,154 :: 		if((~GPIOA_IDR) & 0x0080) Key_Status_Now |= 0x20; //KEY_RIGHT_ON
; Key_Status_Now start address is: 8 (R2)
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
LDR	R0, [R0, #0]
MVN	R0, R0
AND	R0, R0, #128
CMP	R0, #0
IT	EQ
BEQ	L__KeyScan32
ORR	R0, R2, #32
; Key_Status_Now end address is: 8 (R2)
; Key_Status_Now start address is: 4 (R1)
UXTB	R1, R0
; Key_Status_Now end address is: 4 (R1)
UXTB	R2, R1
IT	AL
BAL	L_KeyScan5
L__KeyScan32:
L_KeyScan5:
;HW_V1_Config.c,156 :: 		if(Key_Status_Now &(~Key_Status_Last)){
; Key_Status_Now start address is: 8 (R2)
MOVW	R0, #lo_addr(_Key_Status_Last+0)
MOVT	R0, #hi_addr(_Key_Status_Last+0)
LDRB	R0, [R0, #0]
MVN	R0, R0
UXTB	R0, R0
AND	R0, R2, R0, LSL #0
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_KeyScan6
;HW_V1_Config.c,158 :: 		Key_Wait_Counter=25;        //Push on <500mS, No auto repeat
MOVS	R1, #25
MOVW	R0, #lo_addr(_Key_Wait_Counter+0)
MOVT	R0, #hi_addr(_Key_Wait_Counter+0)
STRB	R1, [R0, #0]
;HW_V1_Config.c,160 :: 		if(Key_Status_Now & 0x01)  KeyCode=KEYCODE_PLAY; // KeyCode(Play)
AND	R0, R2, #1
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_KeyScan7
MOVS	R0, #1
STRB	R0, [SP, #4]
L_KeyScan7:
;HW_V1_Config.c,161 :: 		if(Key_Status_Now & 0x02)  KeyCode=KEYCODE_MANU; // KeyCode(Manu)
AND	R0, R2, #2
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_KeyScan8
MOVS	R0, #2
STRB	R0, [SP, #4]
L_KeyScan8:
;HW_V1_Config.c,162 :: 		if(Key_Status_Now & 0x04)  KeyCode=KEYCODE_UP;   // KeyCode(Up)
AND	R0, R2, #4
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_KeyScan9
MOVS	R0, #3
STRB	R0, [SP, #4]
L_KeyScan9:
;HW_V1_Config.c,163 :: 		if(Key_Status_Now & 0x08)  KeyCode=KEYCODE_DOWN; // KeyCode(Down)
AND	R0, R2, #8
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_KeyScan10
MOVS	R0, #4
STRB	R0, [SP, #4]
L_KeyScan10:
;HW_V1_Config.c,164 :: 		if(Key_Status_Now & 0x10)  KeyCode=KEYCODE_LEFT; // KeyCode(Left)
AND	R0, R2, #16
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_KeyScan11
MOVS	R0, #5
STRB	R0, [SP, #4]
L_KeyScan11:
;HW_V1_Config.c,165 :: 		if(Key_Status_Now & 0x20)  KeyCode=KEYCODE_RIGHT;// KeyCode(Right)
AND	R0, R2, #32
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_KeyScan12
MOVS	R0, #6
STRB	R0, [SP, #4]
L_KeyScan12:
;HW_V1_Config.c,167 :: 		} else {
IT	AL
BAL	L_KeyScan13
L_KeyScan6:
;HW_V1_Config.c,169 :: 		if(Key_Status_Now & Key_Status_Last){
MOVW	R0, #lo_addr(_Key_Status_Last+0)
MOVT	R0, #hi_addr(_Key_Status_Last+0)
LDRB	R0, [R0, #0]
AND	R0, R2, R0, LSL #0
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_KeyScan14
;HW_V1_Config.c,170 :: 		if((Key_Wait_Counter | Key_Repeat_Counter)==0){
MOVW	R0, #lo_addr(_Key_Repeat_Counter+0)
MOVT	R0, #hi_addr(_Key_Repeat_Counter+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_Key_Wait_Counter+0)
MOVT	R0, #hi_addr(_Key_Wait_Counter+0)
LDRB	R0, [R0, #0]
ORRS	R0, R1
UXTB	R0, R0
CMP	R0, #0
IT	NE
BNE	L_KeyScan15
;HW_V1_Config.c,172 :: 		if(Key_Status_Now & 0x01)  KeyCode=KEYCODE_PLAY; // KeyCode(Play)
AND	R0, R2, #1
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_KeyScan16
MOVS	R0, #1
STRB	R0, [SP, #4]
L_KeyScan16:
;HW_V1_Config.c,173 :: 		if(Key_Status_Now & 0x02)  KeyCode=KEYCODE_MANU; // KeyCode(Manu)
AND	R0, R2, #2
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_KeyScan17
MOVS	R0, #2
STRB	R0, [SP, #4]
L_KeyScan17:
;HW_V1_Config.c,174 :: 		if(Key_Status_Now & 0x04)  KeyCode=KEYCODE_UP;   // KeyCode(Up)
AND	R0, R2, #4
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_KeyScan18
MOVS	R0, #3
STRB	R0, [SP, #4]
L_KeyScan18:
;HW_V1_Config.c,175 :: 		if(Key_Status_Now & 0x08)  KeyCode=KEYCODE_DOWN; // KeyCode(Down)
AND	R0, R2, #8
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_KeyScan19
MOVS	R0, #4
STRB	R0, [SP, #4]
L_KeyScan19:
;HW_V1_Config.c,176 :: 		if(Key_Status_Now & 0x10)  KeyCode=KEYCODE_LEFT; // KeyCode(Left)
AND	R0, R2, #16
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_KeyScan20
MOVS	R0, #5
STRB	R0, [SP, #4]
L_KeyScan20:
;HW_V1_Config.c,177 :: 		if(Key_Status_Now & 0x20)  KeyCode=KEYCODE_RIGHT;// KeyCode(Right)
AND	R0, R2, #32
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_KeyScan21
MOVS	R0, #6
STRB	R0, [SP, #4]
L_KeyScan21:
;HW_V1_Config.c,179 :: 		Key_Repeat_Counter = 3; //Auto repeat each 60mS
MOVS	R1, #3
MOVW	R0, #lo_addr(_Key_Repeat_Counter+0)
MOVT	R0, #hi_addr(_Key_Repeat_Counter+0)
STRB	R1, [R0, #0]
;HW_V1_Config.c,180 :: 		}
L_KeyScan15:
;HW_V1_Config.c,181 :: 		}else Key_Wait_Counter=25;
IT	AL
BAL	L_KeyScan22
L_KeyScan14:
MOVS	R1, #25
MOVW	R0, #lo_addr(_Key_Wait_Counter+0)
MOVT	R0, #hi_addr(_Key_Wait_Counter+0)
STRB	R1, [R0, #0]
L_KeyScan22:
;HW_V1_Config.c,182 :: 		}
L_KeyScan13:
;HW_V1_Config.c,183 :: 		Key_Status_Last = Key_Status_Now;
MOVW	R0, #lo_addr(_Key_Status_Last+0)
MOVT	R0, #hi_addr(_Key_Status_Last+0)
STRB	R2, [R0, #0]
; Key_Status_Now end address is: 8 (R2)
;HW_V1_Config.c,184 :: 		return KeyCode;
LDRB	R0, [SP, #4]
;HW_V1_Config.c,185 :: 		}
L_end_KeyScan:
ADD	SP, SP, #8
BX	LR
; end of _KeyScan
_Test_USB_ON:
;HW_V1_Config.c,190 :: 		char Test_USB_ON(void)
SUB	SP, SP, #4
;HW_V1_Config.c,192 :: 		if(GPIOB_IDR &0x0400) return 1;
MOVW	R0, #lo_addr(GPIOB_IDR+0)
MOVT	R0, #hi_addr(GPIOB_IDR+0)
LDR	R0, [R0, #0]
AND	R0, R0, #1024
CMP	R0, #0
IT	EQ
BEQ	L_Test_USB_ON23
MOVS	R0, #1
IT	AL
BAL	L_end_Test_USB_ON
L_Test_USB_ON23:
;HW_V1_Config.c,193 :: 		else  return 0;
MOVS	R0, #0
;HW_V1_Config.c,194 :: 		}
L_end_Test_USB_ON:
ADD	SP, SP, #4
BX	LR
; end of _Test_USB_ON
_SD_Card_ON:
;HW_V1_Config.c,199 :: 		char SD_Card_ON(void)
SUB	SP, SP, #4
;HW_V1_Config.c,201 :: 		if(GPIOD_IDR &0x0400) return 1;
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
LDR	R0, [R0, #0]
AND	R0, R0, #1024
CMP	R0, #0
IT	EQ
BEQ	L_SD_Card_ON25
MOVS	R0, #1
IT	AL
BAL	L_end_SD_Card_ON
L_SD_Card_ON25:
;HW_V1_Config.c,202 :: 		else  return 0;
MOVS	R0, #0
;HW_V1_Config.c,203 :: 		}
L_end_SD_Card_ON:
ADD	SP, SP, #4
BX	LR
; end of _SD_Card_ON
