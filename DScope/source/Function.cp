#line 1 "Z:/Robs Folder/DScope/source/Function.c"
#line 1 "z:/robs folder/dscope/include/function.h"
#line 50 "z:/robs folder/dscope/include/function.h"
extern char Test[2];
extern unsigned short Scan_Buffer[0x1000];
extern unsigned char View_Buffer[300], Ref_Buffer[304];
extern unsigned char Signal_Buffer[300], Key_Buffer;
extern unsigned const char Item_V[20][11], Item_T[22][12];
extern unsigned const int V_Scale[20], T_Scale[22], Fout_ARR[16];
extern unsigned const char V_Unit[4][3], T_Unit[4][3];
extern unsigned const short Scan_PSC[22], Scan_ARR[22];

extern unsigned short Delay_Counter, X_Counter;
extern unsigned char Counter_20mS, Key_Repeat_Counter, Key_Wait_Counter;
extern unsigned char Cursor_Counter,Erase_Note, Frame, Stop, Type, Sync;

extern unsigned int vb_Sum, Battery;
extern unsigned short temp, Lcd_X, Lcd_Y;

extern unsigned char Update[22];
extern unsigned char SectorBuff[512];
extern unsigned char FileNum[4];

extern unsigned short Item_Index[20];
extern unsigned short _vt, _v0, _v1, _v2, _t0, _t1, _t2;
extern unsigned char Hide_vs, Hide_vt, Hide_v0, Hide_v1, Hide_v2;
extern unsigned char Hide_t1, Hide_t2, Hide_Ref, Item;
extern int Frequency, Cycle, Duty;

void Delayms(unsigned short mS);
void Scan_Wave(void);
void Update_Item(void);
void Sync_Trig(void);
void Signal_Process(void);
void Erase_Draw(void);
void Measure_Wave(void);
void Battery_Detect(void);
void Test_Display(int Var);
#line 1 "z:/robs folder/dscope/include/lcd.h"
#line 28 "z:/robs folder/dscope/include/lcd.h"
void LCD_WR_REG(unsigned short Reg, unsigned short Data);
void LCD_Initial(void);
void Point_SCR(unsigned short x0, unsigned short y0);
void Set_Pixel(unsigned short Color);
void Clear_Screen(unsigned short Color);
void Display_Frame(void);
void Display_Grid(void);


void Display_Str(unsigned short xi, unsigned short yi, unsigned short Color, unsigned char Mode, unsigned const char *s);
void Display_Logo(unsigned short Dot_x, unsigned short Dot_y);
void Erase_Wave(unsigned short Color);
void Erase_SEG(unsigned short i, unsigned short y1, unsigned short y2);
void Draw_SEG(unsigned short i, unsigned short y1, unsigned short y2, unsigned short Color);
void Draw_View_Area(void);
void Erase_View_Area(void);

void Erase_Vn(unsigned short v);
void Erase_Vi(unsigned short v);
void Erase_Ti(unsigned short t);
void Draw_v0(void);
void Draw_vt(void);
void Draw_vi(unsigned short vi);
void Draw_ti(unsigned short ti);
void Erase_Dot_v0(void);
void Erase_Dot_vt(void);
void Erase_Dot_vi(unsigned short vi);
void Erase_Dot_ti(unsigned short ti);
void Draw_Dot_v0(void);
void Draw_Dot_vt(void);
void Draw_Dot_vi(unsigned short vi);
void Draw_Dot_ti(unsigned short ti);
#line 1 "z:/robs folder/dscope/include/calculate.h"
#line 7 "z:/robs folder/dscope/include/calculate.h"
typedef struct _T_i32str_res I32STR_RES;

struct _T_i32str_res {
 char decPos;
 char len;
 char str[13];
};

void Int32String_sign(I32STR_RES *r, int n, int e);
void Int32String(I32STR_RES *r, int n, int e);
void Char_to_Str(unsigned char *p, unsigned char n);
void Char_to_Hex(unsigned char *p, unsigned char n);
#line 1 "z:/robs folder/dscope/library/inc/stm32f10x_lib.h"
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
#line 1 "z:/robs folder/dscope/library/inc/stm32f10x_adc.h"
#line 1 "z:/robs folder/dscope/library/inc/stm32f10x_map.h"
#line 26 "z:/robs folder/dscope/library/inc/stm32f10x_adc.h"
typedef struct
{
 u32 ADC_Mode;
 FunctionalState ADC_ScanConvMode;
 FunctionalState ADC_ContinuousConvMode;
 u32 ADC_ExternalTrigConv;
 u32 ADC_DataAlign;
 u8 ADC_NbrOfChannel;
}ADC_InitTypeDef;
#line 226 "z:/robs folder/dscope/library/inc/stm32f10x_adc.h"
void ADC_DeInit(ADC_TypeDef* ADCx);
void ADC_Init(ADC_TypeDef* ADCx, ADC_InitTypeDef* ADC_InitStruct);
void ADC_StructInit(ADC_InitTypeDef* ADC_InitStruct);
void ADC_Cmd(ADC_TypeDef* ADCx, FunctionalState NewState);
void ADC_DMACmd(ADC_TypeDef* ADCx, FunctionalState NewState);
void ADC_ITConfig(ADC_TypeDef* ADCx, u16 ADC_IT, FunctionalState NewState);
void ADC_ResetCalibration(ADC_TypeDef* ADCx);
FlagStatus ADC_GetResetCalibrationStatus(ADC_TypeDef* ADCx);
void ADC_StartCalibration(ADC_TypeDef* ADCx);
FlagStatus ADC_GetCalibrationStatus(ADC_TypeDef* ADCx);
void ADC_SoftwareStartConvCmd(ADC_TypeDef* ADCx, FunctionalState NewState);
FlagStatus ADC_GetSoftwareStartConvStatus(ADC_TypeDef* ADCx);
void ADC_DiscModeChannelCountConfig(ADC_TypeDef* ADCx, u8 Number);
void ADC_DiscModeCmd(ADC_TypeDef* ADCx, FunctionalState NewState);
void ADC_RegularChannelConfig(ADC_TypeDef* ADCx, u8 ADC_Channel, u8 Rank, u8 ADC_SampleTime);
void ADC_ExternalTrigConvCmd(ADC_TypeDef* ADCx, FunctionalState NewState);
u16 ADC_GetConversionValue(ADC_TypeDef* ADCx);
u32 ADC_GetDualModeConversionValue(void);
void ADC_AutoInjectedConvCmd(ADC_TypeDef* ADCx, FunctionalState NewState);
void ADC_InjectedDiscModeCmd(ADC_TypeDef* ADCx, FunctionalState NewState);
void ADC_ExternalTrigInjectedConvConfig(ADC_TypeDef* ADCx, u32 ADC_ExternalTrigInjecConv);
void ADC_ExternalTrigInjectedConvCmd(ADC_TypeDef* ADCx, FunctionalState NewState);
void ADC_SoftwareStartInjectedConvCmd(ADC_TypeDef* ADCx, FunctionalState NewState);
FlagStatus ADC_GetSoftwareStartInjectedConvCmdStatus(ADC_TypeDef* ADCx);
void ADC_InjectedChannelConfig(ADC_TypeDef* ADCx, u8 ADC_Channel, u8 Rank, u8 ADC_SampleTime);
void ADC_InjectedSequencerLengthConfig(ADC_TypeDef* ADCx, u8 Length);
void ADC_SetInjectedOffset(ADC_TypeDef* ADCx, u8 ADC_InjectedChannel, u16 Offset);
u16 ADC_GetInjectedConversionValue(ADC_TypeDef* ADCx, u8 ADC_InjectedChannel);
void ADC_AnalogWatchdogCmd(ADC_TypeDef* ADCx, u32 ADC_AnalogWatchdog);
void ADC_AnalogWatchdogThresholdsConfig(ADC_TypeDef* ADCx, u16 HighThreshold, u16 LowThreshold);
void ADC_AnalogWatchdogSingleChannelConfig(ADC_TypeDef* ADCx, u8 ADC_Channel);
void ADC_TempSensorVrefintCmd(FunctionalState NewState);
FlagStatus ADC_GetFlagStatus(ADC_TypeDef* ADCx, u8 ADC_FLAG);
void ADC_ClearFlag(ADC_TypeDef* ADCx, u8 ADC_FLAG);
ITStatus ADC_GetITStatus(ADC_TypeDef* ADCx, u16 ADC_IT);
void ADC_ClearITPendingBit(ADC_TypeDef* ADCx, u16 ADC_IT);
#line 1 "z:/robs folder/dscope/library/inc/stm32f10x_dma.h"
#line 1 "z:/robs folder/dscope/library/inc/stm32f10x_map.h"
#line 26 "z:/robs folder/dscope/library/inc/stm32f10x_dma.h"
typedef struct
{
 u32 DMA_PeripheralBaseAddr;
 u32 DMA_MemoryBaseAddr;
 u32 DMA_DIR;
 u32 DMA_BufferSize;
 u32 DMA_PeripheralInc;
 u32 DMA_MemoryInc;
 u32 DMA_PeripheralDataSize;
 u32 DMA_MemoryDataSize;
 u32 DMA_Mode;
 u32 DMA_Priority;
 u32 DMA_M2M;
}DMA_InitTypeDef;
#line 207 "z:/robs folder/dscope/library/inc/stm32f10x_dma.h"
void DMA_DeInit(DMA_Channel_TypeDef* DMA_Channelx);
void DMA_Init(DMA_Channel_TypeDef* DMA_Channelx, DMA_InitTypeDef* DMA_InitStruct);
void DMA_StructInit(DMA_InitTypeDef* DMA_InitStruct);
void DMA_Cmd(DMA_Channel_TypeDef* DMA_Channelx, FunctionalState NewState);
void DMA_ITConfig(DMA_Channel_TypeDef* DMA_Channelx, u32 DMA_IT, FunctionalState NewState);
u16 DMA_GetCurrDataCounter(DMA_Channel_TypeDef* DMA_Channelx);
FlagStatus DMA_GetFlagStatus(u32 DMA_FLAG);
void DMA_ClearFlag(u32 DMA_FLAG);
ITStatus DMA_GetITStatus(u32 DMA_IT);
void DMA_ClearITPendingBit(u32 DMA_IT);
#line 1 "z:/robs folder/dscope/library/inc/stm32f10x_flash.h"
#line 1 "z:/robs folder/dscope/library/inc/stm32f10x_map.h"
#line 144 "z:/robs folder/dscope/library/inc/stm32f10x_flash.h"
void FLASH_SetLatency(u32 FLASH_Latency);
void FLASH_HalfCycleAccessCmd(u32 FLASH_HalfCycleAccess);
void FLASH_PrefetchBufferCmd(u32 FLASH_PrefetchBuffer);
#line 1 "z:/robs folder/dscope/library/inc/stm32f10x_gpio.h"
#line 1 "z:/robs folder/dscope/library/inc/stm32f10x_map.h"
#line 26 "z:/robs folder/dscope/library/inc/stm32f10x_gpio.h"
typedef enum
{
 GPIO_Speed_10MHz = 1,
 GPIO_Speed_2MHz,
 GPIO_Speed_50MHz
}GPIOSpeed_TypeDef;
#line 37 "z:/robs folder/dscope/library/inc/stm32f10x_gpio.h"
typedef enum
{ GPIO_Mode_AIN = 0x0,
 GPIO_Mode_IN_FLOATING = 0x04,
 GPIO_Mode_IPD = 0x28,
 GPIO_Mode_IPU = 0x48,
 GPIO_Mode_Out_OD = 0x14,
 GPIO_Mode_Out_PP = 0x10,
 GPIO_Mode_AF_OD = 0x1C,
 GPIO_Mode_AF_PP = 0x18
}GPIOMode_TypeDef;
#line 54 "z:/robs folder/dscope/library/inc/stm32f10x_gpio.h"
typedef struct
{
 u16 GPIO_Pin;
 GPIOSpeed_TypeDef GPIO_Speed;
 GPIOMode_TypeDef GPIO_Mode;
}GPIO_InitTypeDef;


typedef enum
{ Bit_RESET = 0,
 Bit_SET
}BitAction;
#line 190 "z:/robs folder/dscope/library/inc/stm32f10x_gpio.h"
void GPIO_DeInit(GPIO_TypeDef* GPIOx);
void GPIO_AFIODeInit(void);
void GPIO_Init(GPIO_TypeDef* GPIOx, GPIO_InitTypeDef* GPIO_InitStruct);
void GPIO_StructInit(GPIO_InitTypeDef* GPIO_InitStruct);
u8 GPIO_ReadInputDataBit(GPIO_TypeDef* GPIOx, u16 GPIO_Pin);
u16 GPIO_ReadInputData(GPIO_TypeDef* GPIOx);
u8 GPIO_ReadOutputDataBit(GPIO_TypeDef* GPIOx, u16 GPIO_Pin);
u16 GPIO_ReadOutputData(GPIO_TypeDef* GPIOx);
void GPIO_SetBits(GPIO_TypeDef* GPIOx, u16 GPIO_Pin);
void GPIO_ResetBits(GPIO_TypeDef* GPIOx, u16 GPIO_Pin);
void GPIO_WriteBit(GPIO_TypeDef* GPIOx, u16 GPIO_Pin, BitAction BitVal);
void GPIO_Write(GPIO_TypeDef* GPIOx, u16 PortVal);
void GPIO_PinLockConfig(GPIO_TypeDef* GPIOx, u16 GPIO_Pin);
void GPIO_EventOutputConfig(u8 GPIO_PortSource, u8 GPIO_PinSource);
void GPIO_EventOutputCmd(FunctionalState NewState);
void GPIO_PinRemapConfig(u32 GPIO_Remap, FunctionalState NewState);
void GPIO_EXTILineConfig(u8 GPIO_PortSource, u8 GPIO_PinSource);
#line 1 "z:/robs folder/dscope/library/inc/stm32f10x_nvic.h"
#line 1 "z:/robs folder/dscope/library/inc/stm32f10x_map.h"
#line 26 "z:/robs folder/dscope/library/inc/stm32f10x_nvic.h"
typedef struct
{
 u8 NVIC_IRQChannel;
 u8 NVIC_IRQChannelPreemptionPriority;
 u8 NVIC_IRQChannelSubPriority;
 FunctionalState NVIC_IRQChannelCmd;
} NVIC_InitTypeDef;
#line 217 "z:/robs folder/dscope/library/inc/stm32f10x_nvic.h"
void NVIC_DeInit(void);
void NVIC_SCBDeInit(void);
void NVIC_PriorityGroupConfig(u32 NVIC_PriorityGroup);
void NVIC_Init(NVIC_InitTypeDef* NVIC_InitStruct);
void NVIC_StructInit(NVIC_InitTypeDef* NVIC_InitStruct);
void NVIC_SETPRIMASK(void);
void NVIC_RESETPRIMASK(void);
void NVIC_SETFAULTMASK(void);
void NVIC_RESETFAULTMASK(void);
void NVIC_BASEPRICONFIG(u32 NewPriority);
u32 NVIC_GetBASEPRI(void);
u16 NVIC_GetCurrentPendingIRQChannel(void);
ITStatus NVIC_GetIRQChannelPendingBitStatus(u8 NVIC_IRQChannel);
void NVIC_SetIRQChannelPendingBit(u8 NVIC_IRQChannel);
void NVIC_ClearIRQChannelPendingBit(u8 NVIC_IRQChannel);
u16 NVIC_GetCurrentActiveHandler(void);
ITStatus NVIC_GetIRQChannelActiveBitStatus(u8 NVIC_IRQChannel);
u32 NVIC_GetCPUID(void);
void NVIC_SetVectorTable(u32 NVIC_VectTab, u32 Offset);
void NVIC_GenerateSystemReset(void);
void NVIC_GenerateCoreReset(void);
void NVIC_SystemLPConfig(u8 LowPowerMode, FunctionalState NewState);
void NVIC_SystemHandlerConfig(u32 SystemHandler, FunctionalState NewState);
void NVIC_SystemHandlerPriorityConfig(u32 SystemHandler, u8 SystemHandlerPreemptionPriority,
 u8 SystemHandlerSubPriority);
ITStatus NVIC_GetSystemHandlerPendingBitStatus(u32 SystemHandler);
void NVIC_SetSystemHandlerPendingBit(u32 SystemHandler);
void NVIC_ClearSystemHandlerPendingBit(u32 SystemHandler);
ITStatus NVIC_GetSystemHandlerActiveBitStatus(u32 SystemHandler);
u32 NVIC_GetFaultHandlerSources(u32 SystemHandler);
u32 NVIC_GetFaultAddress(u32 SystemHandler);
#line 1 "z:/robs folder/dscope/library/inc/stm32f10x_rcc.h"
#line 1 "z:/robs folder/dscope/library/inc/stm32f10x_map.h"
#line 25 "z:/robs folder/dscope/library/inc/stm32f10x_rcc.h"
typedef struct
{
 u32 SYSCLK_Frequency;
 u32 HCLK_Frequency;
 u32 PCLK1_Frequency;
 u32 PCLK2_Frequency;
 u32 ADCCLK_Frequency;
}RCC_ClocksTypeDef;
#line 238 "z:/robs folder/dscope/library/inc/stm32f10x_rcc.h"
void RCC_DeInit(void);
void RCC_HSEConfig(u32 RCC_HSE);
ErrorStatus RCC_WaitForHSEStartUp(void);
void RCC_AdjustHSICalibrationValue(u8 HSICalibrationValue);
void RCC_HSICmd(FunctionalState NewState);
void RCC_PLLConfig(u32 RCC_PLLSource, u32 RCC_PLLMul);
void RCC_PLLCmd(FunctionalState NewState);
void RCC_SYSCLKConfig(u32 RCC_SYSCLKSource);
u8 RCC_GetSYSCLKSource(void);
void RCC_HCLKConfig(u32 RCC_HCLK);
void RCC_PCLK1Config(u32 RCC_PCLK1);
void RCC_PCLK2Config(u32 RCC_PCLK2);
void RCC_ITConfig(u8 RCC_IT, FunctionalState NewState);
void RCC_USBCLKConfig(u32 RCC_USBCLKSource);
void RCC_ADCCLKConfig(u32 RCC_ADCCLK);
void RCC_LSEConfig(u32 RCC_LSE);
void RCC_LSICmd(FunctionalState NewState);
void RCC_RTCCLKConfig(u32 RCC_RTCCLKSource);
void RCC_RTCCLKCmd(FunctionalState NewState);
void RCC_GetClocksFreq(RCC_ClocksTypeDef* RCC_Clocks);
void RCC_AHBPeriphClockCmd(u32 RCC_AHBPeriph, FunctionalState NewState);
void RCC_APB2PeriphClockCmd(u32 RCC_APB2Periph, FunctionalState NewState);
void RCC_APB1PeriphClockCmd(u32 RCC_APB1Periph, FunctionalState NewState);
void RCC_APB2PeriphResetCmd(u32 RCC_APB2Periph, FunctionalState NewState);
void RCC_APB1PeriphResetCmd(u32 RCC_APB1Periph, FunctionalState NewState);
void RCC_BackupResetCmd(FunctionalState NewState);
void RCC_ClockSecuritySystemCmd(FunctionalState NewState);
void RCC_MCOConfig(u8 RCC_MCO);
FlagStatus RCC_GetFlagStatus(u8 RCC_FLAG);
void RCC_ClearFlag(void);
ITStatus RCC_GetITStatus(u8 RCC_IT);
void RCC_ClearITPendingBit(u8 RCC_IT);
#line 1 "z:/robs folder/dscope/library/inc/stm32f10x_spi.h"
#line 1 "z:/robs folder/dscope/library/inc/stm32f10x_map.h"
#line 26 "z:/robs folder/dscope/library/inc/stm32f10x_spi.h"
typedef struct
{
 u16 SPI_Direction;
 u16 SPI_Mode;
 u16 SPI_DataSize;
 u16 SPI_CPOL;
 u16 SPI_CPHA;
 u16 SPI_NSS;
 u16 SPI_BaudRatePrescaler;
 u16 SPI_FirstBit;
 u16 SPI_CRCPolynomial;
}SPI_InitTypeDef;
#line 175 "z:/robs folder/dscope/library/inc/stm32f10x_spi.h"
void SPI_DeInit(SPI_TypeDef* SPIx);
void SPI_Init(SPI_TypeDef* SPIx, SPI_InitTypeDef* SPI_InitStruct);
void SPI_StructInit(SPI_InitTypeDef* SPI_InitStruct);
void SPI_Cmd(SPI_TypeDef* SPIx, FunctionalState NewState);
void SPI_ITConfig(SPI_TypeDef* SPIx, u8 SPI_IT, FunctionalState NewState);
void SPI_DMACmd(SPI_TypeDef* SPIx, u16 SPI_DMAReq, FunctionalState NewState);
void SPI_SendData(SPI_TypeDef* SPIx, u16 Data);
u16 SPI_ReceiveData(SPI_TypeDef* SPIx);
void SPI_NSSInternalSoftwareConfig(SPI_TypeDef* SPIx, u16 SPI_NSSInternalSoft);
void SPI_SSOutputCmd(SPI_TypeDef* SPIx, FunctionalState NewState);
void SPI_DataSizeConfig(SPI_TypeDef* SPIx, u16 SPI_DataSize);
void SPI_TransmitCRC(SPI_TypeDef* SPIx);
void SPI_CalculateCRC(SPI_TypeDef* SPIx, FunctionalState NewState);
u16 SPI_GetCRC(SPI_TypeDef* SPIx, u8 SPI_CRC);
u16 SPI_GetCRCPolynomial(SPI_TypeDef* SPIx);
void SPI_BiDirectionalLineConfig(SPI_TypeDef* SPIx, u16 SPI_Direction);
FlagStatus SPI_GetFlagStatus(SPI_TypeDef* SPIx, u16 SPI_FLAG);
void SPI_ClearFlag(SPI_TypeDef* SPIx, u16 SPI_FLAG);
ITStatus SPI_GetITStatus(SPI_TypeDef* SPIx, u8 SPI_IT);
void SPI_ClearITPendingBit(SPI_TypeDef* SPIx, u8 SPI_IT);
#line 1 "z:/robs folder/dscope/library/inc/stm32f10x_systick.h"
#line 1 "z:/robs folder/dscope/library/inc/stm32f10x_map.h"
#line 55 "z:/robs folder/dscope/library/inc/stm32f10x_systick.h"
void SysTick_CLKSourceConfig(u32 SysTick_CLKSource);
void SysTick_SetReload(u32 Reload);
void SysTick_CounterCmd(u32 SysTick_Counter);
void SysTick_ITConfig(FunctionalState NewState);
u32 SysTick_GetCounter(void);
FlagStatus SysTick_GetFlagStatus(u8 SysTick_FLAG);
#line 1 "z:/robs folder/dscope/library/inc/stm32f10x_tim1.h"
#line 1 "z:/robs folder/dscope/library/inc/stm32f10x_map.h"
#line 27 "z:/robs folder/dscope/library/inc/stm32f10x_tim1.h"
typedef struct
{
 u16 TIM1_Prescaler;
 u16 TIM1_CounterMode;
 u16 TIM1_Period;
 u16 TIM1_ClockDivision;
 u8 TIM1_RepetitionCounter;
} TIM1_TimeBaseInitTypeDef;


typedef struct
{
 u16 TIM1_OCMode;
 u16 TIM1_OutputState;
 u16 TIM1_OutputNState;
 u16 TIM1_Pulse;
 u16 TIM1_OCPolarity;
 u16 TIM1_OCNPolarity;
 u16 TIM1_OCIdleState;
 u16 TIM1_OCNIdleState;
} TIM1_OCInitTypeDef;


typedef struct
{
 u16 TIM1_Channel;
 u16 TIM1_ICPolarity;
 u16 TIM1_ICSelection;
 u16 TIM1_ICPrescaler;
 u8 TIM1_ICFilter;
} TIM1_ICInitTypeDef;


typedef struct
{
 u16 TIM1_OSSRState;
 u16 TIM1_OSSIState;
 u16 TIM1_LOCKLevel;
 u16 TIM1_DeadTime;
 u16 TIM1_Break;
 u16 TIM1_BreakPolarity;
 u16 TIM1_AutomaticOutput;
} TIM1_BDTRInitTypeDef;
#line 559 "z:/robs folder/dscope/library/inc/stm32f10x_tim1.h"
void TIM1_DeInit(void);
void TIM1_TimeBaseInit(TIM1_TimeBaseInitTypeDef* TIM1_TimeBaseInitStruct);
void TIM1_OC1Init(TIM1_OCInitTypeDef* TIM1_OCInitStruct);
void TIM1_OC2Init(TIM1_OCInitTypeDef* TIM1_OCInitStruct);
void TIM1_OC3Init(TIM1_OCInitTypeDef* TIM1_OCInitStruct);
void TIM1_OC4Init(TIM1_OCInitTypeDef* TIM1_OCInitStruct);
void TIM1_BDTRConfig(TIM1_BDTRInitTypeDef *TIM1_BDTRInitStruct);
void TIM1_ICInit(TIM1_ICInitTypeDef* TIM1_ICInitStruct);
void TIM1_PWMIConfig(TIM1_ICInitTypeDef* TIM1_ICInitStruct);
void TIM1_TimeBaseStructInit(TIM1_TimeBaseInitTypeDef* TIM1_TimeBaseInitStruct);
void TIM1_OCStructInit(TIM1_OCInitTypeDef* TIM1_OCInitStruct);
void TIM1_ICStructInit(TIM1_ICInitTypeDef* TIM1_ICInitStruct);
void TIM1_BDTRStructInit(TIM1_BDTRInitTypeDef* TIM1_BDTRInitStruct);
void TIM1_Cmd(FunctionalState NewState);
void TIM1_CtrlPWMOutputs(FunctionalState Newstate);
void TIM1_ITConfig(u16 TIM1_IT, FunctionalState NewState);
void TIM1_DMAConfig(u16 TIM1_DMABase, u16 TIM1_DMABurstLength);
void TIM1_DMACmd(u16 TIM1_DMASource, FunctionalState Newstate);
void TIM1_InternalClockConfig(void);
void TIM1_ETRClockMode1Config(u16 TIM1_ExtTRGPrescaler, u16 TIM1_ExtTRGPolarity,
 u16 ExtTRGFilter);
void TIM1_ETRClockMode2Config(u16 TIM1_ExtTRGPrescaler, u16 TIM1_ExtTRGPolarity,
 u16 ExtTRGFilter);
void TIM1_ETRConfig(u16 TIM1_ExtTRGPrescaler, u16 TIM1_ExtTRGPolarity,
 u16 ExtTRGFilter);
void TIM1_ITRxExternalClockConfig(u16 TIM1_InputTriggerSource);
void TIM1_TIxExternalClockConfig(u16 TIM1_TIxExternalCLKSource, u16 TIM1_ICPolarity,
 u8 ICFilter);
void TIM1_SelectInputTrigger(u16 TIM1_InputTriggerSource);
void TIM1_UpdateDisableConfig(FunctionalState Newstate);
void TIM1_UpdateRequestConfig(u8 TIM1_UpdateSource);
void TIM1_SelectHallSensor(FunctionalState Newstate);
void TIM1_SelectOnePulseMode(u16 TIM1_OPMode);
void TIM1_SelectOutputTrigger(u16 TIM1_TRGOSource);
void TIM1_SelectSlaveMode(u16 TIM1_SlaveMode);
void TIM1_SelectMasterSlaveMode(u16 TIM1_MasterSlaveMode);
void TIM1_EncoderInterfaceConfig(u16 TIM1_EncoderMode, u16 TIM1_IC1Polarity,
 u16 TIM1_IC2Polarity);
void TIM1_PrescalerConfig(u16 Prescaler, u16 TIM1_PSCReloadMode);
void TIM1_CounterModeConfig(u16 TIM1_CounterMode);
void TIM1_ForcedOC1Config(u16 TIM1_ForcedAction);
void TIM1_ForcedOC2Config(u16 TIM1_ForcedAction);
void TIM1_ForcedOC3Config(u16 TIM1_ForcedAction);
void TIM1_ForcedOC4Config(u16 TIM1_ForcedAction);
void TIM1_ARRPreloadConfig(FunctionalState Newstate);
void TIM1_SelectCOM(FunctionalState Newstate);
void TIM1_SelectCCDMA(FunctionalState Newstate);
void TIM1_CCPreloadControl(FunctionalState Newstate);
void TIM1_OC1PreloadConfig(u16 TIM1_OCPreload);
void TIM1_OC2PreloadConfig(u16 TIM1_OCPreload);
void TIM1_OC3PreloadConfig(u16 TIM1_OCPreload);
void TIM1_OC4PreloadConfig(u16 TIM1_OCPreload);
void TIM1_OC1FastConfig(u16 TIM1_OCFast);
void TIM1_OC2FastConfig(u16 TIM1_OCFast);
void TIM1_OC3FastConfig(u16 TIM1_OCFast);
void TIM1_OC4FastConfig(u16 TIM1_OCFast);
void TIM1_ClearOC1Ref(u16 TIM1_OCClear);
void TIM1_ClearOC2Ref(u16 TIM1_OCClear);
void TIM1_ClearOC3Ref(u16 TIM1_OCClear);
void TIM1_ClearOC4Ref(u16 TIM1_OCClear);
void TIM1_GenerateEvent(u16 TIM1_EventSource);
void TIM1_OC1PolarityConfig(u16 TIM1_OCPolarity);
void TIM1_OC1NPolarityConfig(u16 TIM1_OCNPolarity);
void TIM1_OC2PolarityConfig(u16 TIM1_OCPolarity);
void TIM1_OC2NPolarityConfig(u16 TIM1_OCNPolarity);
void TIM1_OC3PolarityConfig(u16 TIM1_OCPolarity);
void TIM1_OC3NPolarityConfig(u16 TIM1_OCNPolarity);
void TIM1_OC4PolarityConfig(u16 TIM1_OCPolarity);
void TIM1_CCxCmd(u16 TIM1_Channel, FunctionalState Newstate);
void TIM1_CCxNCmd(u16 TIM1_Channel, FunctionalState Newstate);
void TIM1_SelectOCxM(u16 TIM1_Channel, u16 TIM1_OCMode);
void TIM1_SetCounter(u16 Counter);
void TIM1_SetAutoreload(u16 Autoreload);
void TIM1_SetCompare1(u16 Compare1);
void TIM1_SetCompare2(u16 Compare2);
void TIM1_SetCompare3(u16 Compare3);
void TIM1_SetCompare4(u16 Compare4);
void TIM1_SetIC1Prescaler(u16 TIM1_IC1Prescaler);
void TIM1_SetIC2Prescaler(u16 TIM1_IC2Prescaler);
void TIM1_SetIC3Prescaler(u16 TIM1_IC3Prescaler);
void TIM1_SetIC4Prescaler(u16 TIM1_IC4Prescaler);
void TIM1_SetClockDivision(u16 TIM1_CKD);
u16 TIM1_GetCapture1(void);
u16 TIM1_GetCapture2(void);
u16 TIM1_GetCapture3(void);
u16 TIM1_GetCapture4(void);
u16 TIM1_GetCounter(void);
u16 TIM1_GetPrescaler(void);
FlagStatus TIM1_GetFlagStatus(u16 TIM1_FLAG);
void TIM1_ClearFlag(u16 TIM1_Flag);
ITStatus TIM1_GetITStatus(u16 TIM1_IT);
void TIM1_ClearITPendingBit(u16 TIM1_IT);
#line 1 "z:/robs folder/dscope/library/inc/stm32f10x_tim.h"
#line 1 "z:/robs folder/dscope/library/inc/stm32f10x_map.h"
#line 27 "z:/robs folder/dscope/library/inc/stm32f10x_tim.h"
typedef struct
{
 u16 TIM_Period;
 u16 TIM_Prescaler;
 u16 TIM_ClockDivision;
 u16 TIM_CounterMode;
} TIM_TimeBaseInitTypeDef;


typedef struct
{
 u16 TIM_OCMode;
 u16 TIM_Channel;
 u16 TIM_Pulse;
 u16 TIM_OCPolarity;
} TIM_OCInitTypeDef;


typedef struct
{
 u16 TIM_ICMode;
 u16 TIM_Channel;
 u16 TIM_ICPolarity;
 u16 TIM_ICSelection;
 u16 TIM_ICPrescaler;
 u8 TIM_ICFilter;
} TIM_ICInitTypeDef;
#line 443 "z:/robs folder/dscope/library/inc/stm32f10x_tim.h"
void TIM_DeInit(TIM_TypeDef* TIMx);
void TIM_TimeBaseInit(TIM_TypeDef* TIMx, TIM_TimeBaseInitTypeDef* TIM_TimeBaseInitStruct);
void TIM_OCInit(TIM_TypeDef* TIMx, TIM_OCInitTypeDef* TIM_OCInitStruct);
void TIM_ICInit(TIM_TypeDef* TIMx, TIM_ICInitTypeDef* TIM_ICInitStruct);
void TIM_TimeBaseStructInit(TIM_TimeBaseInitTypeDef* TIM_TimeBaseInitStruct);
void TIM_OCStructInit(TIM_OCInitTypeDef* TIM_OCInitStruct);
void TIM_ICStructInit(TIM_ICInitTypeDef* TIM_ICInitStruct);
void TIM_Cmd(TIM_TypeDef* TIMx, FunctionalState NewState);
void TIM_ITConfig(TIM_TypeDef* TIMx, u16 TIM_IT, FunctionalState NewState);
void TIM_DMAConfig(TIM_TypeDef* TIMx, u16 TIM_DMABase, u16 TIM_DMABurstLength);
void TIM_DMACmd(TIM_TypeDef* TIMx, u16 TIM_DMASource, FunctionalState Newstate);
void TIM_InternalClockConfig(TIM_TypeDef* TIMx);
void TIM_ITRxExternalClockConfig(TIM_TypeDef* TIMx, u16 TIM_InputTriggerSource);
void TIM_TIxExternalClockConfig(TIM_TypeDef* TIMx, u16 TIM_TIxExternalCLKSource,
 u16 TIM_ICPolarity, u8 ICFilter);
void TIM_ETRClockMode1Config(TIM_TypeDef* TIMx, u16 TIM_ExtTRGPrescaler, u16 TIM_ExtTRGPolarity,
 u8 ExtTRGFilter);
void TIM_ETRClockMode2Config(TIM_TypeDef* TIMx, u16 TIM_ExtTRGPrescaler, u16 TIM_ExtTRGPolarity,
 u8 ExtTRGFilter);
void TIM_ETRConfig(TIM_TypeDef* TIMx, u16 TIM_ExtTRGPrescaler, u16 TIM_ExtTRGPolarity,
 u8 ExtTRGFilter);
void TIM_SelectInputTrigger(TIM_TypeDef* TIMx, u16 TIM_InputTriggerSource);
void TIM_PrescalerConfig(TIM_TypeDef* TIMx, u16 Prescaler, u16 TIM_PSCReloadMode);
void TIM_CounterModeConfig(TIM_TypeDef* TIMx, u16 TIM_CounterMode);
void TIM_ForcedOC1Config(TIM_TypeDef* TIMx, u16 TIM_ForcedAction);
void TIM_ForcedOC2Config(TIM_TypeDef* TIMx, u16 TIM_ForcedAction);
void TIM_ForcedOC3Config(TIM_TypeDef* TIMx, u16 TIM_ForcedAction);
void TIM_ForcedOC4Config(TIM_TypeDef* TIMx, u16 TIM_ForcedAction);
void TIM_ARRPreloadConfig(TIM_TypeDef* TIMx, FunctionalState Newstate);
void TIM_SelectCCDMA(TIM_TypeDef* TIMx, FunctionalState Newstate);
void TIM_OC1PreloadConfig(TIM_TypeDef* TIMx, u16 TIM_OCPreload);
void TIM_OC2PreloadConfig(TIM_TypeDef* TIMx, u16 TIM_OCPreload);
void TIM_OC3PreloadConfig(TIM_TypeDef* TIMx, u16 TIM_OCPreload);
void TIM_OC4PreloadConfig(TIM_TypeDef* TIMx, u16 TIM_OCPreload);
void TIM_OC1FastConfig(TIM_TypeDef* TIMx, u16 TIM_OCFast);
void TIM_OC2FastConfig(TIM_TypeDef* TIMx, u16 TIM_OCFast);
void TIM_OC3FastConfig(TIM_TypeDef* TIMx, u16 TIM_OCFast);
void TIM_OC4FastConfig(TIM_TypeDef* TIMx, u16 TIM_OCFast);
void TIM_ClearOC1Ref(TIM_TypeDef* TIMx, u16 TIM_OCClear);
void TIM_ClearOC2Ref(TIM_TypeDef* TIMx, u16 TIM_OCClear);
void TIM_ClearOC3Ref(TIM_TypeDef* TIMx, u16 TIM_OCClear);
void TIM_ClearOC4Ref(TIM_TypeDef* TIMx, u16 TIM_OCClear);
void TIM_UpdateDisableConfig(TIM_TypeDef* TIMx, FunctionalState Newstate);
void TIM_EncoderInterfaceConfig(TIM_TypeDef* TIMx, u16 TIM_EncoderMode,
 u16 TIM_IC1Polarity, u16 TIM_IC2Polarity);
void TIM_GenerateEvent(TIM_TypeDef* TIMx, u16 TIM_EventSource);
void TIM_OC1PolarityConfig(TIM_TypeDef* TIMx, u16 TIM_OCPolarity);
void TIM_OC2PolarityConfig(TIM_TypeDef* TIMx, u16 TIM_OCPolarity);
void TIM_OC3PolarityConfig(TIM_TypeDef* TIMx, u16 TIM_OCPolarity);
void TIM_OC4PolarityConfig(TIM_TypeDef* TIMx, u16 TIM_OCPolarity);
void TIM_UpdateRequestConfig(TIM_TypeDef* TIMx, u16 TIM_UpdateSource);
void TIM_SelectHallSensor(TIM_TypeDef* TIMx, FunctionalState Newstate);
void TIM_SelectOnePulseMode(TIM_TypeDef* TIMx, u16 TIM_OPMode);
void TIM_SelectOutputTrigger(TIM_TypeDef* TIMx, u16 TIM_TRGOSource);
void TIM_SelectSlaveMode(TIM_TypeDef* TIMx, u16 TIM_SlaveMode);
void TIM_SelectMasterSlaveMode(TIM_TypeDef* TIMx, u16 TIM_MasterSlaveMode);
void TIM_SetCounter(TIM_TypeDef* TIMx, u16 Counter);
void TIM_SetAutoreload(TIM_TypeDef* TIMx, u16 Autoreload);
void TIM_SetCompare1(TIM_TypeDef* TIMx, u16 Compare1);
void TIM_SetCompare2(TIM_TypeDef* TIMx, u16 Compare2);
void TIM_SetCompare3(TIM_TypeDef* TIMx, u16 Compare3);
void TIM_SetCompare4(TIM_TypeDef* TIMx, u16 Compare4);
void TIM_SetIC1Prescaler(TIM_TypeDef* TIMx, u16 TIM_IC1Prescaler);
void TIM_SetIC2Prescaler(TIM_TypeDef* TIMx, u16 TIM_IC2Prescaler);
void TIM_SetIC3Prescaler(TIM_TypeDef* TIMx, u16 TIM_IC3Prescaler);
void TIM_SetIC4Prescaler(TIM_TypeDef* TIMx, u16 TIM_IC4Prescaler);
void TIM_SetClockDivision(TIM_TypeDef* TIMx, u16 TIM_CKD);
u16 TIM_GetCapture1(TIM_TypeDef* TIMx);
u16 TIM_GetCapture2(TIM_TypeDef* TIMx);
u16 TIM_GetCapture3(TIM_TypeDef* TIMx);
u16 TIM_GetCapture4(TIM_TypeDef* TIMx);
u16 TIM_GetCounter(TIM_TypeDef* TIMx);
u16 TIM_GetPrescaler(TIM_TypeDef* TIMx);
FlagStatus TIM_GetFlagStatus(TIM_TypeDef* TIMx, u16 TIM_FLAG);
void TIM_ClearFlag(TIM_TypeDef* TIMx, u16 TIM_FLAG);
ITStatus TIM_GetITStatus(TIM_TypeDef* TIMx, u16 TIM_IT);
void TIM_ClearITPendingBit(TIM_TypeDef* TIMx, u16 TIM_IT);
#line 1 "z:/robs folder/dscope/library/inc/stm32f10x_usart.h"
#line 1 "z:/robs folder/dscope/library/inc/stm32f10x_map.h"
#line 26 "z:/robs folder/dscope/library/inc/stm32f10x_usart.h"
typedef struct
{
 u32 USART_BaudRate;
 u16 USART_WordLength;
 u16 USART_StopBits;
 u16 USART_Parity;
 u16 USART_HardwareFlowControl;
 u16 USART_Mode;
 u16 USART_Clock;
 u16 USART_CPOL;
 u16 USART_CPHA;
 u16 USART_LastBit;
} USART_InitTypeDef;
#line 188 "z:/robs folder/dscope/library/inc/stm32f10x_usart.h"
void USART_DeInit(USART_TypeDef* USARTx);
void USART_Init(USART_TypeDef* USARTx, USART_InitTypeDef* USART_InitStruct);
void USART_StructInit(USART_InitTypeDef* USART_InitStruct);
void USART_Cmd(USART_TypeDef* USARTx, FunctionalState NewState);
void USART_ITConfig(USART_TypeDef* USARTx, u16 USART_IT, FunctionalState NewState);
void USART_DMACmd(USART_TypeDef* USARTx, u16 USART_DMAReq, FunctionalState NewState);
void USART_SetAddress(USART_TypeDef* USARTx, u8 USART_Address);
void USART_WakeUpConfig(USART_TypeDef* USARTx, u16 USART_WakeUp);
void USART_ReceiverWakeUpCmd(USART_TypeDef* USARTx, FunctionalState NewState);
void USART_LINBreakDetectLengthConfig(USART_TypeDef* USARTx, u16 USART_LINBreakDetectLength);
void USART_LINCmd(USART_TypeDef* USARTx, FunctionalState NewState);
void USART_SendData(USART_TypeDef* USARTx, u16 Data);
u16 USART_ReceiveData(USART_TypeDef* USARTx);
void USART_SendBreak(USART_TypeDef* USARTx);
void USART_SetGuardTime(USART_TypeDef* USARTx, u8 USART_GuardTime);
void USART_SetPrescaler(USART_TypeDef* USARTx, u8 USART_Prescaler);
void USART_SmartCardCmd(USART_TypeDef* USARTx, FunctionalState NewState);
void USART_SmartCardNACKCmd(USART_TypeDef* USARTx, FunctionalState NewState);
void USART_HalfDuplexCmd(USART_TypeDef* USARTx, FunctionalState NewState);
void USART_IrDAConfig(USART_TypeDef* USARTx, u16 USART_IrDAMode);
void USART_IrDACmd(USART_TypeDef* USARTx, FunctionalState NewState);
FlagStatus USART_GetFlagStatus(USART_TypeDef* USARTx, u16 USART_FLAG);
void USART_ClearFlag(USART_TypeDef* USARTx, u16 USART_FLAG);
ITStatus USART_GetITStatus(USART_TypeDef* USARTx, u16 USART_IT);
void USART_ClearITPendingBit(USART_TypeDef* USARTx, u16 USART_IT);
#line 104 "z:/robs folder/dscope/library/inc/stm32f10x_lib.h"
void debug(void);
#line 1 "z:/robs folder/dscope/include/hw_v1_config.h"
#line 1 "z:/robs folder/dscope/usblib/inc/usb_type.h"
#line 1 "z:/robs folder/dscope/include/usb_conf.h"
#line 152 "z:/robs folder/dscope/include/hw_v1_config.h"
void Set_System(void);
void NVIC_Configuration(void);
void GPIO_Configure(void);
void Get_Medium_Characteristics(void);
void SPI_Config(void);

void DMA_Configuration(void);
void ADC_Configuration(void);
void Timer_Configuration(void);
char KeyScan(void);
void MSD_WriteByte(u8 byte);
unsigned char MSD_ReadByte(void);

void Battery_Detect(void);
void Set_Range(char Range);
void Set_Base(char Base);
void ADC_Start(void);
void Set_Y_Pos(unsigned short Y0);
char Test_USB_ON(void);
char SD_Card_ON(void);
#line 13 "Z:/Robs Folder/DScope/source/Function.c"
unsigned const char Item_V[20][11] =

{"10mV/Div","20mV/Div","50mV/Div","0.1V/Div","0.2V/Div","0.5V/Div"," 1V/Div "," 2V/Div "," 5V/Div "," 10V/Div",

 "0.2V/Div","0.5V/Div"," 1V/Div "," 2V/Div "," 5V/Div "," 10V/Div"," 20V/Div"," 50V/Div","100V/Div"," -GND-  "};

unsigned const int V_Scale[20] =

{400, 800, 2000, 4000, 8000, 20000, 40000, 80000, 200000, 400000,

 8000, 20000, 40000, 80000, 200000, 400000, 800000, 2000000, 4000000, 0 };

unsigned short Km[20]=

{2956, 1478, 591, 296, 1114, 446, 223, 1157, 463, 231, 1452, 581, 290, 1082, 433, 216, 1048, 419, 210, 231};



unsigned const char Item_T[22][12] =

{" 1uS/Div "," 2uS/Div "," 5uS/Div "," 10uS/Div"," 20uS/Div"," 50uS/Div","100uS/Div","200uS/Div","500uS/Div"," 1mS/Div "," 2mS/Div ",

 " 5mS/Div "," 10mS/Div"," 20mS/Div"," 50mS/Div"," 0.1S/Div"," 0.2S/Div"," 0.5S/Div","  1S/Div ","  2S/Div ","  5S/Div "," 10S/Div "};

unsigned const int T_Scale[22] =

{ 1167, 1167, 1167, 1167, 1167, 2000, 4000, 8000, 20000, 40000, 80000,

 200000, 400000, 800000, 2000000, 4000000, 8000000, 20000000, 40000000, 80000000, 200000000, 400000000};

unsigned const short Scan_PSC[22] =

{11, 11, 11, 11, 11, 15, 15, 15, 15, 15, 15,

511, 511, 511, 511, 511, 511, 255, 511, 1023, 511, 511, };

unsigned const short Scan_ARR[22] =

{ 6, 6, 6, 6, 6, 8 , 17, 35, 89, 179, 359,

1124, 1124, 1124, 1124, 1124, 1124, 5624, 5624, 5624, 28124, 28124, };

unsigned const short Ks[22] =

{ 29860,14930,5972,2986,1493,1024,1024,1024,1024,1024,1024,1024,1024,1024,1024,1024,1024,1024,1024,1024,1024,1024};



unsigned const char Item_F[16][7] =

{" 1MHz ","500KHz","200KHz","100KHz"," 50KHz"," 20KHz"," 10KHz"," 5KHZ "," 2KHz "," 1KHz "," 500Hz"," 200Hz"," 100Hz"," 50Hz "," 20 Hz"," 10Hz "};

unsigned const int Fout_PSC[16] =

{ 0, 0, 0, 0, 0, 0, 0, 0, 4-1, 4-1, 16-1, 16-1, 64-1, 64-1, 128-1, 128-1};

unsigned const int Fout_ARR[16] =

{ 72-1, 144-1, 360-1, 720-1, 1440-1, 3600-1, 7200-1, 14400-1, 9000-1, 18000-1, 9000-1, 22500-1, 11250-1, 22500-1, 28125-1, 56250-1};



unsigned short Scan_Buffer[0x1000];
unsigned char Signal_Buffer[300];
unsigned char View_Buffer[300];
unsigned char Ref_Buffer [304] =
 {100,116,130,144,157,167,175,181,185,185,184,179,173,164,153,141,128,114,100,86, 73, 60, 49, 40, 33, 27, 24, 24, 25, 29,
 35, 43, 52, 63, 75, 87, 100,112,124,135,145,153,160,164,167,167,166,163,157,150,142,133,122,111,100,89, 79, 70, 61, 54,
 48, 44, 42, 42, 43, 46, 50, 57, 64, 72, 81, 90, 100,109,118,126,133,139,144,147,149,149,148,146,142,137,130,124,116,108,
 100,93, 85, 79, 73, 68, 64, 61, 60, 60, 61, 63, 66, 70, 75, 81, 87, 93, 100,106,112,117,122,125,128,130,131,131,131,129,
 126,123,119,115,110,105,100,96, 91, 88, 84, 81, 79, 78, 77, 78, 78, 80, 82, 84, 87, 90, 93, 97, 100,103,106,108,110,112,
 113,114,114,113,113,112,110,109,107,105,104,102,100,99, 97, 96, 96, 95, 95, 95, 95, 96, 96, 97, 97, 98, 99, 99, 100,100,
 100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,
 100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,115,129,141,151,160,165,169,170,169,167,162,156,148,139,130,
 120,110,100,91, 82, 75, 68, 63, 59, 57, 56, 56, 58, 61, 64, 69, 75, 81, 87, 94, 100,106,112,117,121,125,127,129,130,130,
 128,127,124,121,117,113,109,104,100,96, 92, 88, 85, 83, 81, 80, 79, 79, 80, 81, 83, 85, 88, 91, 94, 97, 100,103,106,108,
 108,108,6,8};


unsigned short Item_Index[20]={0, 6, 8, 0, 0, 4, 8, 0, 0, 1, 1, 9, 0, 0, 4096, 0, 0, 0, 0, 0};
unsigned short _vt=140, _v0=69, _v1=199, _v2=40, _t0=150, _t1=68, _t2=233;
unsigned char Hide_vs=1, Hide_vt=0, Hide_v0=1, Hide_v1=0, Hide_v2=0;
unsigned char Hide_t1=0, Hide_t2=0, Hide_Ref=0, Item=4;

int Frequency, Cycle, Duty;

unsigned char Update[22] ={1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0};
unsigned const char V_Unit[4][3]={"uV","mV","V ","kV"};
unsigned const char T_Unit[4][3]={"nS","uS","mS","S "};
unsigned const char F_Unit[4][4]={"Hz","Hz","KC","MC"};
unsigned const char Battery_Status[5][4]={"~`'","~`}","~|}","{|}","USB"};
unsigned const short Battery_Color [5] ={ 0x001F ,  0x07FF ,  0x07E0 ,  0x07E0 ,  0x07E0  };
unsigned const char MODE_Unit[4][5]={"AUTO","NORM","SIGN","NONE"};
unsigned const char TEST_Unit[3][8]={" FREQN "," CYCLE ","  DUTY "};
unsigned char FileNum[4]="000";

unsigned short Delay_Counter=0, X_Counter=0, First_Edge, Last_Edge;
unsigned short temp=0;
unsigned char Counter_20mS=0, Key_Repeat_Counter=0, Key_Wait_Counter=0, Cursor_Counter=0, Type;
unsigned char Key_Buffer=0, Toggle=0, Sync=0, Erase_Note=0, Frame=0, Stop=0;
unsigned int vb_Sum=3600*64, Battery;


I32STR_RES Num;
#line 122 "Z:/Robs Folder/DScope/source/Function.c"
void Delayms(u16 mS)
{ Delay_Counter=mS; while(Delay_Counter) {}; }
#line 128 "Z:/Robs Folder/DScope/source/Function.c"
void Sync_Trig(void)
{
 int Vs;
 for(_t0=150; _t0<(0x1000- 300 );++_t0){
 if(_t0>=(0x1000- (*((vu32 *)(0x40020000+0x0C))) )) break;
 Vs=120+(Km[Item_Index[ 1 ]]*(2048-Scan_Buffer[_t0]))/4096;
 if(Item_Index[ 7 ]==0) {
 if(Vs<(_vt-Item_Index[ 6 ])&&(Sync==0)) Sync=1;
 if(Vs>(_vt+Item_Index[ 6 ])&&(Sync==1)) Sync=2;
 } else {
 if(Vs>(_vt+Item_Index[ 6 ])&&(Sync==0)) Sync=1;
 if(Vs<(_vt-Item_Index[ 6 ])&&(Sync==1)) Sync=2;
 }
 if(Sync==2) break;
 }
 X_Counter=0;
 if(_t0>=(0x1000- 300 )) Sync=3;

}
#line 151 "Z:/Robs Folder/DScope/source/Function.c"
void Signal_Process(void)
{
 int i, p, q; int Vs, Vr;
 if(Sync==3) _t0=150;
 p=_t0+Item_Index[ 14 ]-4096;
 for(i=X_Counter; i<( 300 ); ++i){
 Sync=5;
 q=p+(i*1024)/Ks[Item_Index[ 2 ]];
 if(q<0) {
 q=0;
 Item_Index[ 14 ]++;
 }
 if(q>=0x1000) {
 q=0x1000-1;
 Item_Index[ 14 ]--;
 }
 if(q>=(0x1000- (*((vu32 *)(0x40020000+0x0C))) )) break;
 X_Counter=i+1;
 Vr=Km[Item_Index[ 1 ]]*(Scan_Buffer[q+1]-Scan_Buffer[q])/4096;
 Vs=(Km[Item_Index[ 1 ]]*(2048-Scan_Buffer[q]))/4096+120
 -(((i*1024)%Ks[Item_Index[ 2 ]])*Vr)/Ks[Item_Index[ 2 ]];
 if(Vs> ( 200  + 19 ) ) Vs= ( 200  + 19 ) ;
 else if(Vs< 19 ) Vs= 19 ;
 Signal_Buffer[i]=Vs;
 Sync=4;
 }
 if( (*((vu32 *)(0x40020000+0x0C))) ==0) {
 Measure_Wave();
 if(Item_Index[ 15 ]== 0 ) ADC_Start();
 }
}
#line 186 "Z:/Robs Folder/DScope/source/Function.c"
void Erase_Draw(void)
{
unsigned short i;
unsigned char y1, y2, y3, y4,y5, y6;

 y1=View_Buffer[0];
 y3=Signal_Buffer[0];
 y5=Ref_Buffer[0];

 for(i=0; i<X_Counter; ++i){
 y2=View_Buffer[i];
 Erase_SEG(i,y1,y2);
 y1 = y2;
 y4=Signal_Buffer[i];
 Draw_SEG(i,y3,y4, 0x0F8E );
 y3 = y4;
 View_Buffer[i]=y4;
 y6=Ref_Buffer[i];
 if(Hide_Ref==0) Draw_SEG(i,y5,y6, 0xC05E );
 y5 = y6;
 }

 if(X_Counter>= 300 -1) {
 Stop=1;
 X_Counter=0;
 Battery_Detect();
 if((((Frame+2)* 300 )+_t0+Item_Index[14])<0x1000) Frame++;
 else {
 Frame=0;
 Sync=0;
 }
 Delay_Counter=100;
 if(Item_Index[0]!=4) Sync=0;
 else Erase_Wave( 0x0F8E );
 } else {
 Sync=2;
 Stop=0;
 }
}
#line 229 "Z:/Robs Folder/DScope/source/Function.c"
void Scan_Wave(void)
{


 if(Item_Index[ 0 ]==0) {
 Frame=0;
 if(Item_Index[ 15 ]== 0 ){
 Stop=0;
 if((Sync==0)||(Sync==1)) Sync_Trig();
 } else {
 Sync=2;
 X_Counter=0;
 }
 if((Sync==2)||(Sync==3)) Signal_Process();
 if((Sync>3)&&(Delay_Counter==0)) Erase_Draw();
 }


 if(Item_Index[ 0 ]==1){
 Frame=0;
 if(Item_Index[ 15 ]== 0 ){
 Stop=0;
 if((Sync==0)||(Sync==1)) Sync_Trig();
 } else {
 Sync=2;
 X_Counter=0;
 }
 if(Sync==3) Erase_Wave( 0x0F8E );
 if(Sync==2) Signal_Process();
 if((Sync>3)&&(Delay_Counter==0)) Erase_Draw();
 }

 if(Item_Index[ 0 ]==2){
 Frame=0;
 if(Item_Index[ 15 ]== 0 ){
 Stop=0;
 if((Sync==0)||(Sync==1)) Sync_Trig();
 } else {
 Sync=2;
 X_Counter=0;
 }
 if(Sync==3) Erase_Wave( 0x0F8E );
 if(Sync==2) Signal_Process();
 if((Sync>3)&&(Delay_Counter==0)) Erase_Draw();
 Item_Index[ 15 ]= 1 ;
 Update[ 15 ]=1;
 }

 if(Item_Index[ 0 ]==3){
 Frame=0; X_Counter=0;
 if(Item_Index[ 15 ]== 0 ){
 Sync=3; Stop=0;
 } else {
 Sync=2;
 }
 if((Sync==2)||(Sync==3)) Signal_Process();

 if((Sync>3)&&(Delay_Counter==0)) Erase_Draw();
 }
}
#line 292 "Z:/Robs Folder/DScope/source/Function.c"
void Measure_Wave(void)
{
 unsigned short i=0, Edge=0, Trig=0;
 unsigned int Threshold1, Threshold2, Threshold3;
 int Vm;
 First_Edge=0;
 Last_Edge=0;
 Threshold1=2048-((_vt-Item_Index[ 6 ]-120)*4096)
 /Km[Item_Index[ 1 ]];
 Threshold2=2048-((_vt+Item_Index[ 6 ]-120)*4096)
 /Km[Item_Index[ 1 ]];
 Threshold3=2048-((_vt-120)*4096)/Km[Item_Index[ 1 ]];
 for(i=0;i<0x1000;++i){
 if((Scan_Buffer[i]>Threshold1)&&(Trig==0)) Trig=1;
 if((Scan_Buffer[i]<Threshold2)&&(Trig==1)) {
 Trig=0;
 if(First_Edge==0) {
 First_Edge=i;
 Last_Edge=i;
 Edge=0;
 } else {
 Last_Edge=i;
 Edge++;
 }
 }
 }
 if(Edge!=0){
 Vm = 0;
 for(i=First_Edge; i<Last_Edge; ++i){
 if(Scan_Buffer[i]<Threshold3) Vm++;
 }
 if(Type== 0 ) {
 Frequency = (Edge*(1000000000/T_Scale[Item_Index[ 2 ]])/(Last_Edge-First_Edge))*1000;
 Cycle = ((Last_Edge-First_Edge)*T_Scale[Item_Index[ 2 ]])/Edge;
 Duty = 100000*Vm/(Last_Edge-First_Edge);
 }
 } else {
 Frequency = 0;
 Cycle = 0;
 Duty = 0;
 }
}
#line 337 "Z:/Robs Folder/DScope/source/Function.c"
void Update_Item(void)
{
 unsigned short Tmp;

 if( Update[ 0 ]!=0){
 Update[ 0 ]=Type;
 Display_Str(3,224, 0x07E0 ,Type,MODE_Unit[Item_Index[ 0 ]]);
 }

 if( Update[ 1 ]!=0){
 Update[ 1 ]=Type;
 Display_Str(40,224, 0x07FF ,Type,Item_V[Item_Index[ 1 ]]);
 Update[ 19 ]=1;
 Update[ 18 ]=1;
 Set_Range(Item_Index[ 1 ]);
 Set_Y_Pos(_v0);
 }

 if( Update[ 2 ]!=0){
 Update[ 2 ]=Type;
 Display_Str(109,224, 0x07FF ,Type,Item_T[Item_Index[ 2 ]]);
 Display_Str(109,224, 0x07FF ,Type,Item_T[Item_Index[ 2 ]]);
 Set_Base(Item_Index[ 2 ]);
 Update[ 16 ]=1;
 }

 if( Update[ 3 ]!=0){
 Update[ 3 ]=Type;
 Display_Str(186,224, 0xC05E ,Type,"Y.POS");
 Draw_Dot_v0();
 if(Hide_v0) Erase_Vn(_v0);
 else Draw_v0();
 Set_Y_Pos(_v0);
 Update[ 20 ]=1;
 }

 if( Update[ 4 ]!=0){
 Update[ 4 ]=Type;
 if(Type==0) Display_Str(231,224, 0xFFFF , 0 ,TEST_Unit[Item_Index[ 4 ]]);
 else {
 switch (Item_Index[4]){
 case 0:
 if(Frequency==0)
 Display_Str(231,224, 0xFFFF , 1 ,TEST_Unit[Item_Index[ 4 ]]);
 else {
 Int32String(&Num, Frequency, 4);
 Display_Str(231,224, 0xFFFF ,Type,(unsigned const char *)Num.str);
 Display_Str(231+40,224, 0xFFFF ,Type,F_Unit[Num.decPos]);
 }
 break;
 case 1:
 if(Cycle==0)
 Display_Str(231,224, 0xFFFF , 1 ,TEST_Unit[Item_Index[ 4 ]]);
 else {
 Int32String(&Num, Cycle, 4);
 Display_Str(231,224, 0xFFFF ,Type,(unsigned const char *)Num.str);
 Display_Str(231+40,224, 0xFFFF ,Type,T_Unit[Num.decPos]);
 }
 break;
 case 2:
 if(Duty==0)
 Display_Str(231,224, 0xFFFF , 1 ,TEST_Unit[Item_Index[ 4 ]]);
 else {
 Int32String(&Num, Duty, 4);
 Display_Str(231,224, 0xFFFF ,Type,(unsigned const char *)Num.str);
 Display_Str(231+40,224, 0xFFFF ,Type,"% ");
 }
 break;
 }
 }
 }

 if( Update[ 5 ]!=0){
 Update[ 5 ]=Type;
 if(Test_USB_ON())
 Display_Str(292,224,Battery_Color[4], 0 ,Battery_Status[4]);
 else
 Display_Str(292,224,Battery_Color[Item_Index[5]], 0 ,
 Battery_Status[Item_Index[ 5 ]]);
 }

 if( Update[ 6 ]!=0){
 Update[ 6 ]=Type;
 Display_Str(303, 195,  0x07FF ,Type, "TR");
 if(Item== 6 ){
 Display_Str(88,2, 0xFFFF ,Type,"Trig!Sensitive");
 temp=_vt;
 for(_vt=temp-2; _vt>(temp-Item_Index[6]); _vt=_vt-2) Draw_vt();
 for(_vt=(temp+2); _vt<(temp+Item_Index[6]); _vt=_vt+2) Draw_vt();
 _vt=temp;
 }
 }

 if( Update[ 7 ]!=0){
 Update[ 7 ]=Type;
 if(Item_Index[ 7 ]== 0 ) Display_Str(303, 175,  0x07FF ,Type, "^S");
 else Display_Str(303, 175,  0x07FF ,Type, "_S");
 if(Item== 7 ){
 if(Item_Index[ 7 ]==0) Display_Str(88,2, 0xFFFF ,Type,"!Trig.Slope=!^!");
 else Display_Str(88,2, 0xFFFF ,Type,"!Trig.Slope=!_!");
 }
 }

 if( Update[ 8 ]!=0){
 Update[ 8 ]=Type;
 if(Item_Index[ 8 ]==0) Display_Str(303, 155,  0x07FF ,Type, "*1");
 else Display_Str(303, 155,  0x07FF ,Type, "10");
 if(Item== 8 ){
 if(Item_Index[ 8 ]==0) Display_Str(88,2, 0xFFFF ,Type,"!INP.Scale!=*1!");
 else Display_Str(88,2, 0xFFFF ,Type,"!INP.Scale=*10");
 }
 Update[ 1 ]=1;
 }
 if( Update[ 9 ]!=0){
 Update[ 9 ]=Type;
 Display_Str(303, 135,  0x07FF ,Type, "FS");
 if(Item== 9 ){
 Char_to_Str(FileNum,Item_Index[ 9 ]);
 Display_Str(88,2, 0xFFFF ,Type,"!Save File");
 Display_Str(164,2, 0xFFFF ,Type,FileNum);
 Display_Str(188,2, 0xFFFF ,Type," ");
 }
 }
 if( Update[ 10 ]!=0){
 Update[ 10 ]=Type;
 Display_Str(303, 115,  0x07FF , Type,"FL");
 if(Item== 10 ){
 Char_to_Str(FileNum,Item_Index[ 10 ]);
 Display_Str(88,2, 0xFFFF ,Type,"!Load File");
 Display_Str(164,2, 0xFFFF ,Type,FileNum);
 Display_Str(188,2, 0xFFFF ,Type," ");
 }
 }

 if( Update[ 11 ]!=0){
 Update[ 11 ]=Type;
  (*((vu32 *)( ( ((u32)0x40000000)  + 0x0800) +0x28)))  = Fout_PSC[Item_Index[ 11 ]];
  (*((vu32 *)( ( ((u32)0x40000000)  + 0x0800) +0x2C)))  = Fout_ARR[Item_Index[ 11 ]];
  (*((vu32 *)( ( ((u32)0x40000000)  + 0x0800) +0x34)))  = (Fout_ARR[Item_Index[ 11 ]]+1)/2;
 Display_Str(303, 95,  0x07FF ,Type, "Fo");
 if(Item==11){
 Display_Str(88,2, 0xFFFF ,Type," Fout!=");
 Display_Str(140,2, 0xFFFF ,Type,Item_F[Item_Index[ 11 ]]);
 Display_Str(188,2, 0xFFFF ,Type," ");
 }
 }

 if( Update[ 12 ]!=0){
 Update[ 12 ]=Type;
 Display_Str(303, 75,  0x07FF ,Type, "T2");
 if(Item== 12 ){
 Display_Str(88,2, 0xFFFF ,Type,"!Time Cursor2 ");
 if(Hide_t1==0) Draw_ti(_t1);
 Draw_Dot_ti(_t1);
 }
 }

 if( Update[ 13 ]!=0){
 Update[ 13 ]=Type;
 Display_Str(303, 55,  0x07FF ,Type, "T1");
 if(Item== 13 ){
 Display_Str(88,2, 0xFFFF ,Type,"!Time Cursor1 ");
 if(Hide_t1==0) Draw_ti(_t1);
 Draw_Dot_ti(_t1);
 }
 }

 if( Update[ 14 ]!=0){
 Update[ 14 ]=Type;
 Display_Str(303, 35,  0x07FF ,Type, "T0");
 if(Item== 14 ){
 Display_Str(88,2, 0xFFFF ,Type,"!X.POS Adjust ");
 }
 }

 if( Update[ 15 ]!=0){
 Update[ 15 ]=0;
 if(Item_Index[ 15 ]==0) Display_Str(284,2, 0x07E0 , 0 ,"!RUN!");
 else Display_Str(284,2, 0x001F , 0 ,"HOLD");
 }

 if( Update[ 16 ]!=0){
 Update[ 16 ]=0;
 Int32String_sign(&Num, (_t2-_t1)*T_Scale[Item_Index[ 2 ]], 3);
 Display_Str(199,2, 0x07FF , 0 ,"[T=");
 Display_Str(224,2, 0x07FF , 0 ,(unsigned const char *)Num.str);
 Display_Str(224+Num.len*8,2, 0x07FF , 0 ," ");
 Display_Str(224+40,2, 0x07FF , 0 ,T_Unit[Num.decPos]);
 }

 if( Update[ 17 ]!=0){
 Update[ 17 ]=Type;
 if(Item!= 17 ) Tmp= 0 ;
 else Tmp=Type;
 if((Item<6)||(Item>14)){
 Int32String_sign(&Num, (_v1-_v2)*V_Scale[Item_Index[ 1 ]], 3);
 Display_Str(88,2,  0xFFFF , 0 ,"V1");
 Display_Str(105,2, 0xFFFF , 0 ,"-");
 Display_Str(114,2, 0xFFFF ,Tmp,"V2");
 Display_Str(131,2, 0xFFFF , 0 ,"=");
 Display_Str(139,2, 0xFFFF , 0 ,(unsigned const char *)Num.str);
 Display_Str(139+40,2, 0xFFFF , 0 ,V_Unit[Num.decPos]);
 }
 }

 if( Update[ 18 ]!=0){
 Update[ 18 ]=Type;
 if(Item!= 18 ) Tmp= 0 ;
 else Tmp=Type;
 if((Item<6)||(Item>14)){
 Int32String_sign(&Num, (_v1-_v2)*V_Scale[Item_Index[ 1 ]], 3);
 Display_Str(88,2, 0xFFFF ,Tmp,"V1");
 Display_Str(105,2, 0xFFFF , 0 ,"-");
 Display_Str(139,2, 0xFFFF , 0 ,(unsigned const char *)Num.str);
 Display_Str(139+40,2, 0xFFFF , 0 ,V_Unit[Num.decPos]);
 }
 }

 if( Update[ 19 ]!=0){
 Update[ 19 ]=Type;
 Update[ 20 ]=1;
 if(Item!= 19 ) Tmp= 0 ;
 else Tmp=Type;
 Int32String_sign(&Num, (_vt-_v0)*V_Scale[Item_Index[ 1 ]], 3);
 Display_Str(3,2, 0x07FF ,Tmp,"Vt");
 Display_Str(20,2, 0x07FF , 0 ,"=");
 Display_Str(28,2, 0x07FF , 0 ,(unsigned const char *)Num.str);
 Display_Str(28+40,2, 0x07FF , 0 ,V_Unit[Num.decPos]);
 }

 if(Hide_vs){
 temp=_vt;
 for(_vt=temp-2; _vt>=(temp-Item_Index[ 6 ]); _vt=_vt-2) Erase_Vn(_vt);
 for(_vt=(temp+2); _vt<=(temp+Item_Index[ 6 ]); _vt=_vt+2) Erase_Vn(_vt);
 _vt=temp;
 Hide_vs=0;
 }

 if(Update[ 20 ]){
 Update[ 20 ]=0;
 if(Hide_t1) Erase_Ti(_t1);
 else Draw_ti(_t1);
 if(Hide_t2) Erase_Ti(_t2);
 else Draw_ti(_t2);
 if(Hide_v1) Erase_Vi(_v1);
 else Draw_vi(_v1);
 if(Hide_v2) Erase_Vi(_v2);
 else Draw_vi(_v2);
 if(Hide_vt) Erase_Vn(_vt);
 else Draw_vt();
 Draw_Dot_vt();
 Draw_Dot_vi(_v1);
 Draw_Dot_vi(_v2);
 Draw_Dot_ti(_t1);
 Draw_Dot_ti(_t2);
 }
}
void Test_Display(int Var)
{
 Int32String_sign(&Num, Var, 4);
 Display_Str(28,60, 0x07FF , 0 ,(unsigned const char *)Num.str);
}
