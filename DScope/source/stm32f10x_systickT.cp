#line 1 "Z:/Robs Folder/DScope/source/stm32f10x_systickT.c"
#line 1 "z:/robs folder/dscope/library/inc/stm32f10x_systick.h"
#line 1 "z:/robs folder/dscope/library/inc/stm32f10x_map.h"
#line 1 "z:/robs folder/dscope/include/stm32f10x_conf.h"
#line 1 "z:/robs folder/dscope/library/inc/stm32f10x_type.h"
#line 23 "z:/robs folder/dscope/library/inc/stm32f10x_type.h"
typedef signed long s32;
typedef signed short s16;
typedef signed char s8;

typedef signed long const sc32;
typedef signed short const sc16;
typedef signed char const sc8;

typedef volatile signed long vs32;
typedef volatile signed short vs16;
typedef volatile signed char vs8;

typedef volatile signed long const vsc32;
typedef volatile signed short const vsc16;
typedef volatile signed char const vsc8;

typedef unsigned long u32;
typedef unsigned short u16;
typedef unsigned char u8;

typedef unsigned long const uc32;
typedef unsigned short const uc16;
typedef unsigned char const uc8;

typedef volatile unsigned long vu32;
typedef volatile unsigned short vu16;
typedef volatile unsigned char vu8;

typedef volatile unsigned long const vuc32;
typedef volatile unsigned short const vuc16;
typedef volatile unsigned char const vuc8;



typedef enum {RESET = 0, SET = !RESET} FlagStatus, ITStatus;

typedef enum {DISABLE = 0, ENABLE = !DISABLE} FunctionalState;


typedef enum {ERROR = 0, SUCCESS = !ERROR} ErrorStatus;
#line 1 "z:/robs folder/dscope/library/inc/stm32f10x_type.h"
#line 1 "z:/robs folder/dscope/library/inc/cortexm3_macro.h"
#line 1 "z:/robs folder/dscope/library/inc/stm32f10x_type.h"
#line 27 "z:/robs folder/dscope/library/inc/cortexm3_macro.h"
void __WFI(void);
void __WFE(void);
void __SEV(void);
void __ISB(void);
void __DSB(void);
void __DMB(void);
void __SVC(void);
u32 __MRS_CONTROL(void);
void __MSR_CONTROL(u32 Control);
u32 __MRS_PSP(void);
void __MSR_PSP(u32 TopOfProcessStack);
u32 __MRS_MSP(void);
void __MSR_MSP(u32 TopOfMainStack);
void __SETPRIMASK(void);
void __RESETPRIMASK(void);
void __SETFAULTMASK(void);
void __RESETFAULTMASK(void);
void __BASEPRICONFIG(u32 NewPriority);
u32 __GetBASEPRI(void);
u16 __REV_HalfWord(u16 Data);
u32 __REV_Word(u32 Data);
#line 36 "z:/robs folder/dscope/library/inc/stm32f10x_map.h"
typedef struct
{
 vu32 SR;
 vu32 CR1;
 vu32 CR2;
 vu32 SMPR1;
 vu32 SMPR2;
 vu32 JOFR1;
 vu32 JOFR2;
 vu32 JOFR3;
 vu32 JOFR4;
 vu32 HTR;
 vu32 LTR;
 vu32 SQR1;
 vu32 SQR2;
 vu32 SQR3;
 vu32 JSQR;
 vu32 JDR1;
 vu32 JDR2;
 vu32 JDR3;
 vu32 JDR4;
 vu32 DR;
} ADC_TypeDef;


typedef struct
{
 u32 RESERVED0;
 vu16 DR1;
 u16 RESERVED1;
 vu16 DR2;
 u16 RESERVED2;
 vu16 DR3;
 u16 RESERVED3;
 vu16 DR4;
 u16 RESERVED4;
 vu16 DR5;
 u16 RESERVED5;
 vu16 DR6;
 u16 RESERVED6;
 vu16 DR7;
 u16 RESERVED7;
 vu16 DR8;
 u16 RESERVED8;
 vu16 DR9;
 u16 RESERVED9;
 vu16 DR10;
 u16 RESERVED10;
 vu16 RTCCR;
 u16 RESERVED11;
 vu16 CR;
 u16 RESERVED12;
 vu16 CSR;
 u16 RESERVED13;
} BKP_TypeDef;


typedef struct
{
 vu32 TIR;
 vu32 TDTR;
 vu32 TDLR;
 vu32 TDHR;
} CAN_TxMailBox_TypeDef;

typedef struct
{
 vu32 RIR;
 vu32 RDTR;
 vu32 RDLR;
 vu32 RDHR;
} CAN_FIFOMailBox_TypeDef;

typedef struct
{
 vu32 FR0;
 vu32 FR1;
} CAN_FilterRegister_TypeDef;

typedef struct
{
 vu32 MCR;
 vu32 MSR;
 vu32 TSR;
 vu32 RF0R;
 vu32 RF1R;
 vu32 IER;
 vu32 ESR;
 vu32 BTR;
 u32 RESERVED0[88];
 CAN_TxMailBox_TypeDef sTxMailBox[3];
 CAN_FIFOMailBox_TypeDef sFIFOMailBox[2];
 u32 RESERVED1[12];
 vu32 FMR;
 vu32 FM0R;
 u32 RESERVED2[1];
 vu32 FS0R;
 u32 RESERVED3[1];
 vu32 FFA0R;
 u32 RESERVED4[1];
 vu32 FA0R;
 u32 RESERVED5[8];
 CAN_FilterRegister_TypeDef sFilterRegister[14];
} CAN_TypeDef;


typedef struct
{
 vu32 CCR;
 vu32 CNDTR;
 vu32 CPAR;
 vu32 CMAR;
} DMA_Channel_TypeDef;

typedef struct
{
 vu32 ISR;
 vu32 IFCR;
} DMA_TypeDef;


typedef struct
{
 vu32 IMR;
 vu32 EMR;
 vu32 RTSR;
 vu32 FTSR;
 vu32 SWIER;
 vu32 PR;
} EXTI_TypeDef;


typedef struct
{
 vu32 ACR;
 vu32 KEYR;
 vu32 OPTKEYR;
 vu32 SR;
 vu32 CR;
 vu32 AR;
 vu32 RESERVED;
 vu32 OBR;
 vu32 WRPR;
} FLASH_TypeDef;

typedef struct
{
 vu16 RDP;
 vu16 USER;
 vu16 Data0;
 vu16 Data1;
 vu16 WRP0;
 vu16 WRP1;
 vu16 WRP2;
 vu16 WRP3;
} OB_TypeDef;


typedef struct
{
 vu32 CRL;
 vu32 CRH;
 vu32 IDR;
 vu32 ODR;
 vu32 BSRR;
 vu32 BRR;
 vu32 LCKR;
} GPIO_TypeDef;

typedef struct
{
 vu32 EVCR;
 vu32 MAPR;
 vu32 EXTICR[4];
} AFIO_TypeDef;


typedef struct
{
 vu16 CR1;
 u16 RESERVED0;
 vu16 CR2;
 u16 RESERVED1;
 vu16 OAR1;
 u16 RESERVED2;
 vu16 OAR2;
 u16 RESERVED3;
 vu16 DR;
 u16 RESERVED4;
 vu16 SR1;
 u16 RESERVED5;
 vu16 SR2;
 u16 RESERVED6;
 vu16 CCR;
 u16 RESERVED7;
 vu16 TRISE;
 u16 RESERVED8;
} I2C_TypeDef;


typedef struct
{
 vu32 KR;
 vu32 PR;
 vu32 RLR;
 vu32 SR;
} IWDG_TypeDef;


typedef struct
{
 vu32 ISER[2];
 u32 RESERVED0[30];
 vu32 ICER[2];
 u32 RSERVED1[30];
 vu32 ISPR[2];
 u32 RESERVED2[30];
 vu32 ICPR[2];
 u32 RESERVED3[30];
 vu32 IABR[2];
 u32 RESERVED4[62];
 vu32 IPR[11];
} NVIC_TypeDef;

typedef struct
{
 vu32 CPUID;
 vu32 ICSR;
 vu32 VTOR;
 vu32 AIRCR;
 vu32 SCR;
 vu32 CCR;
 vu32 SHPR[3];
 vu32 SHCSR;
 vu32 CFSR;
 vu32 HFSR;
 vu32 DFSR;
 vu32 MMFAR;
 vu32 BFAR;
 vu32 AFSR;
} SCB_TypeDef;


typedef struct
{
 vu32 CR;
 vu32 CSR;
} PWR_TypeDef;


typedef struct
{
 vu32 CR;
 vu32 CFGR;
 vu32 CIR;
 vu32 APB2RSTR;
 vu32 APB1RSTR;
 vu32 AHBENR;
 vu32 APB2ENR;
 vu32 APB1ENR;
 vu32 BDCR;
 vu32 CSR;
} RCC_TypeDef;


typedef struct
{
 vu16 CRH;
 u16 RESERVED0;
 vu16 CRL;
 u16 RESERVED1;
 vu16 PRLH;
 u16 RESERVED2;
 vu16 PRLL;
 u16 RESERVED3;
 vu16 DIVH;
 u16 RESERVED4;
 vu16 DIVL;
 u16 RESERVED5;
 vu16 CNTH;
 u16 RESERVED6;
 vu16 CNTL;
 u16 RESERVED7;
 vu16 ALRH;
 u16 RESERVED8;
 vu16 ALRL;
 u16 RESERVED9;
} RTC_TypeDef;


typedef struct
{
 vu16 CR1;
 u16 RESERVED0;
 vu16 CR2;
 u16 RESERVED1;
 vu16 SR;
 u16 RESERVED2;
 vu16 DR;
 u16 RESERVED3;
 vu16 CRCPR;
 u16 RESERVED4;
 vu16 RXCRCR;
 u16 RESERVED5;
 vu16 TXCRCR;
 u16 RESERVED6;
} SPI_TypeDef;


typedef struct
{
 vu32 CTRL;
 vu32 LOAD;
 vu32 VAL;
 vu32 CALIB;
} SysTick_TypeDef;


typedef struct
{
 vu16 CR1;
 u16 RESERVED0;
 vu16 CR2;
 u16 RESERVED1;
 vu16 SMCR;
 u16 RESERVED2;
 vu16 DIER;
 u16 RESERVED3;
 vu16 SR;
 u16 RESERVED4;
 vu16 EGR;
 u16 RESERVED5;
 vu16 CCMR1;
 u16 RESERVED6;
 vu16 CCMR2;
 u16 RESERVED7;
 vu16 CCER;
 u16 RESERVED8;
 vu16 CNT;
 u16 RESERVED9;
 vu16 PSC;
 u16 RESERVED10;
 vu16 ARR;
 u16 RESERVED11;
 vu16 RCR;
 u16 RESERVED12;
 vu16 CCR1;
 u16 RESERVED13;
 vu16 CCR2;
 u16 RESERVED14;
 vu16 CCR3;
 u16 RESERVED15;
 vu16 CCR4;
 u16 RESERVED16;
 vu16 BDTR;
 u16 RESERVED17;
 vu16 DCR;
 u16 RESERVED18;
 vu16 DMAR;
 u16 RESERVED19;
} TIM1_TypeDef;


typedef struct
{
 vu16 CR1;
 u16 RESERVED0;
 vu16 CR2;
 u16 RESERVED1;
 vu16 SMCR;
 u16 RESERVED2;
 vu16 DIER;
 u16 RESERVED3;
 vu16 SR;
 u16 RESERVED4;
 vu16 EGR;
 u16 RESERVED5;
 vu16 CCMR1;
 u16 RESERVED6;
 vu16 CCMR2;
 u16 RESERVED7;
 vu16 CCER;
 u16 RESERVED8;
 vu16 CNT;
 u16 RESERVED9;
 vu16 PSC;
 u16 RESERVED10;
 vu16 ARR;
 u16 RESERVED11[3];
 vu16 CCR1;
 u16 RESERVED12;
 vu16 CCR2;
 u16 RESERVED13;
 vu16 CCR3;
 u16 RESERVED14;
 vu16 CCR4;
 u16 RESERVED15[3];
 vu16 DCR;
 u16 RESERVED16;
 vu16 DMAR;
 u16 RESERVED17;
} TIM_TypeDef;


typedef struct
{
 vu16 SR;
 u16 RESERVED0;
 vu16 DR;
 u16 RESERVED1;
 vu16 BRR;
 u16 RESERVED2;
 vu16 CR1;
 u16 RESERVED3;
 vu16 CR2;
 u16 RESERVED4;
 vu16 CR3;
 u16 RESERVED5;
 vu16 GTPR;
 u16 RESERVED6;
} USART_TypeDef;


typedef struct
{
 vu32 CR;
 vu32 CFR;
 vu32 SR;
} WWDG_TypeDef;
#line 55 "z:/robs folder/dscope/library/inc/stm32f10x_systick.h"
void SysTick_CLKSourceConfig(u32 SysTick_CLKSource);
void SysTick_SetReload(u32 Reload);
void SysTick_CounterCmd(u32 SysTick_Counter);
void SysTick_ITConfig(FunctionalState NewState);
u32 SysTick_GetCounter(void);
FlagStatus SysTick_GetFlagStatus(u8 SysTick_FLAG);
#line 1 "z:/robs folder/dscope/include/hw_config.h"
#line 62 "z:/robs folder/dscope/include/hw_config.h"
void Set_System(void);
void Enter_LowPowerMode(void);
void Leave_LowPowerMode(void);
void USB_Cable_Config (FunctionalState NewState);
void USB_Interrupts_Config(void);

void GPIO_Config(void);
void LCD_WR_REG(unsigned short Reg, unsigned short Data);
void Delay_ms(unsigned short mS);
void LCD_Initial(void);
void Point_SCR(unsigned short x0, unsigned short y0);
void Set_Pixel(unsigned short Color);
void Clear_Screen(unsigned short Color);
void Display_Str(unsigned short x0, unsigned short y0, unsigned short Color, unsigned char Mode, unsigned const char *s);
void Display_Logo(unsigned short Dot_x, unsigned short Dot_y);
u8 DFU_Button_Read(void);

void Reset_Device(void);
void Internal_FLASH_PageErase(u32 Sectors);
void Internal_FLASH_WordWrite(u32 Address, u32 Data);
void Internal_FLASH_WritePrConfig(u32 Xsectors, FunctionalState NewState);
u32 Internal_FLASH_SectorMask(u32 Address);

void SMI_FLASH_Init(void);
void SMI_FLASH_SectorErase(u32 Address);
void SMI_FLASH_WordWrite(u32 Address, u32 Data);
void SMI_FLASH_PageWrite(u32 Address, u32* wBuffer);
#line 44 "Z:/Robs Folder/DScope/source/stm32f10x_systickT.c"
void SysTick_CLKSourceConfig(u32 SysTick_CLKSource)
{



 if (SysTick_CLKSource ==  ((u32)0x00000004) )
 {
  ((SysTick_TypeDef *) ( ((u32)0xE000E000)  + 0x0010) ) ->CTRL |=  ((u32)0x00000004) ;
 }
 else
 {
  ((SysTick_TypeDef *) ( ((u32)0xE000E000)  + 0x0010) ) ->CTRL &=  ((u32)0xFFFFFFFB) ;
 }
}
#line 67 "Z:/Robs Folder/DScope/source/stm32f10x_systickT.c"
void SysTick_SetReload(u32 Reload)
{



  ((SysTick_TypeDef *) ( ((u32)0xE000E000)  + 0x0010) ) ->LOAD = Reload;
}
#line 86 "Z:/Robs Folder/DScope/source/stm32f10x_systickT.c"
void SysTick_CounterCmd(u32 SysTick_Counter)
{



 if (SysTick_Counter ==  ((u32)0x00000001) )
 {
  ((SysTick_TypeDef *) ( ((u32)0xE000E000)  + 0x0010) ) ->CTRL |=  ((u32)0x00000001) ;
 }
 else if (SysTick_Counter ==  ((u32)0xFFFFFFFE) )
 {
  ((SysTick_TypeDef *) ( ((u32)0xE000E000)  + 0x0010) ) ->CTRL &=  ((u32)0xFFFFFFFE) ;
 }
 else
 {
  ((SysTick_TypeDef *) ( ((u32)0xE000E000)  + 0x0010) ) ->VAL =  ((u32)0x00000000) ;
 }
}
#line 113 "Z:/Robs Folder/DScope/source/stm32f10x_systickT.c"
void SysTick_ITConfig(FunctionalState NewState)
{



 if (NewState != DISABLE)
 {
  ((SysTick_TypeDef *) ( ((u32)0xE000E000)  + 0x0010) ) ->CTRL |=  ((u32)0x00000002) ;
 }
 else
 {
  ((SysTick_TypeDef *) ( ((u32)0xE000E000)  + 0x0010) ) ->CTRL &=  ((u32)0xFFFFFFFD) ;
 }
}
#line 135 "Z:/Robs Folder/DScope/source/stm32f10x_systickT.c"
u32 SysTick_GetCounter(void)
{
 return( ((SysTick_TypeDef *) ( ((u32)0xE000E000)  + 0x0010) ) ->VAL);
}
#line 151 "Z:/Robs Folder/DScope/source/stm32f10x_systickT.c"
FlagStatus SysTick_GetFlagStatus(u8 SysTick_FLAG)
{
 u32 statusreg = 0, tmp = 0 ;
 FlagStatus bitstatus = RESET;





 tmp = SysTick_FLAG >> 3;

 if (tmp == 2)
 {
 statusreg =  ((SysTick_TypeDef *) ( ((u32)0xE000E000)  + 0x0010) ) ->CTRL;
 }
 else
 {
 statusreg =  ((SysTick_TypeDef *) ( ((u32)0xE000E000)  + 0x0010) ) ->CALIB;
 }

 if ((statusreg & ((u32)1 << SysTick_FLAG)) != (u32)RESET)
 {
 bitstatus = SET;
 }
 else
 {
 bitstatus = RESET;
 }
 return bitstatus;
}
