#line 1 "Z:/Robs Folder/DScope/source/usb_pwr.c"
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
#line 1 "z:/robs folder/dscope/usblib/inc/usb_lib.h"
#line 1 "z:/robs folder/dscope/usblib/inc/usb_type.h"
#line 1 "z:/robs folder/dscope/include/usb_conf.h"
#line 1 "z:/robs folder/dscope/usblib/inc/usb_regs.h"
#line 22 "z:/robs folder/dscope/usblib/inc/usb_regs.h"
typedef enum _EP_DBUF_DIR
{

 EP_DBUF_ERR,
 EP_DBUF_OUT,
 EP_DBUF_IN
}EP_DBUF_DIR;


enum EP_BUF_NUM
{
 EP_NOBUF,
 EP_BUF0,
 EP_BUF1
};
#line 554 "z:/robs folder/dscope/usblib/inc/usb_regs.h"
extern volatile u16 wIstr;


void SetCNTR(u16 );
void SetISTR(u16 );
void SetDADDR(u16 );
void SetBTABLE(u16 );
void SetBTABLE(u16 );
u16 GetCNTR(void);
u16 GetISTR(void);
u16 GetFNR(void);
u16 GetDADDR(void);
u16 GetBTABLE(void);
void SetENDPOINT(u8 , u16 );
u16 GetENDPOINT(u8 );
void SetEPType(u8 , u16 );
u16 GetEPType(u8 );
void SetEPTxStatus(u8 , u16 );
void SetEPRxStatus(u8 , u16 );
void SetDouBleBuffEPStall(u8 , u8 bDir);
u16 GetEPTxStatus(u8 );
u16 GetEPRxStatus(u8 );
void SetEPTxValid(u8 );
void SetEPRxValid(u8 );
u16 GetTxStallStatus(u8 );
u16 GetRxStallStatus(u8 );
void SetEP_KIND(u8 );
void ClearEP_KIND(u8 );
void Set_Status_Out(u8 );
void Clear_Status_Out(u8 );
void SetEPDoubleBuff(u8 );
void ClearEPDoubleBuff(u8 );
void ClearEP_CTR_RX(u8 );
void ClearEP_CTR_TX(u8 );
void ToggleDTOG_RX(u8 );
void ToggleDTOG_TX(u8 );
void ClearDTOG_RX(u8 );
void ClearDTOG_TX(u8 );
void SetEPAddress(u8 , u8 );
u8 GetEPAddress(u8 );
void SetEPTxAddr(u8 , u16 );
void SetEPRxAddr(u8 , u16 );
u16 GetEPTxAddr(u8 );
u16 GetEPRxAddr(u8 );
void SetEPCountRxReg(u32 * , u16 );
void SetEPTxCount(u8 , u16 );
void SetEPRxCount(u8 , u16 );
u16 GetEPTxCount(u8 );
u16 GetEPRxCount(u8 );
void SetEPDblBuf0Addr(u8 , u16 );
void SetEPDblBuf1Addr(u8 , u16 );
void SetEPDblBuffAddr(u8 , u16 , u16 );
u16 GetEPDblBuf0Addr(u8 );
u16 GetEPDblBuf1Addr(u8 );
void SetEPDblBuffCount(u8 , u8 , u16 );
void SetEPDblBuf0Count(u8 , u8 , u16 );
void SetEPDblBuf1Count(u8 , u8 , u16 );
u16 GetEPDblBuf0Count(u8 );
u16 GetEPDblBuf1Count(u8 );
EP_DBUF_DIR GetEPDblBufDir(u8 );
void FreeUserBuffer(u8 bEpNum , u8 bDir);
u16 ToWord(u8, u8);
u16 ByteSwap(u16);
#line 1 "z:/robs folder/dscope/usblib/inc/usb_def.h"
#line 22 "z:/robs folder/dscope/usblib/inc/usb_def.h"
typedef enum _RECIPIENT_TYPE
{
 DEVICE_RECIPIENT,
 INTERFACE_RECIPIENT,
 ENDPOINT_RECIPIENT,
 OTHER_RECIPIENT
} RECIPIENT_TYPE;


typedef enum _STANDARD_REQUESTS
{
 GET_STATUS = 0,
 CLEAR_FEATURE,
 RESERVED1,
 SET_FEATURE,
 RESERVED2,
 SET_ADDRESS,
 GET_DESCRIPTOR,
 SET_DESCRIPTOR,
 GET_CONFIGURATION,
 SET_CONFIGURATION,
 GET_INTERFACE,
 SET_INTERFACE,
 TOTAL_sREQUEST,
 SYNCH_FRAME = 12
} STANDARD_REQUESTS;


typedef enum _DESCRIPTOR_TYPE
{
 DEVICE_DESCRIPTOR = 1,
 CONFIG_DESCRIPTOR,
 STRING_DESCRIPTOR,
 INTERFACE_DESCRIPTOR,
 ENDPOINT_DESCRIPTOR
} DESCRIPTOR_TYPE;


typedef enum _FEATURE_SELECTOR
{
 ENDPOINT_STALL,
 DEVICE_REMOTE_WAKEUP
} FEATURE_SELECTOR;
#line 1 "z:/robs folder/dscope/usblib/inc/usb_core.h"
#line 22 "z:/robs folder/dscope/usblib/inc/usb_core.h"
typedef enum _CONTROL_STATE
{
 WAIT_SETUP,
 SETTING_UP,
 IN_DATA,
 OUT_DATA,
 LAST_IN_DATA,
 LAST_OUT_DATA,
 WAIT_STATUS_IN,
 WAIT_STATUS_OUT,
 STALLED,
 PAUSE
} CONTROL_STATE;

typedef struct OneDescriptor
{
 u8 *Descriptor;
 u16 Descriptor_Size;
}
ONE_DESCRIPTOR, *PONE_DESCRIPTOR;
#line 45 "z:/robs folder/dscope/usblib/inc/usb_core.h"
typedef enum _RESULT
{
 USB_SUCCESS = 0,
 USB_ERROR,
 USB_UNSUPPORT,
#line 51 "z:/robs folder/dscope/usblib/inc/usb_core.h"
 USB_NOT_READY
} RESULT;



typedef struct _ENDPOINT_INFO
{
#line 80 "z:/robs folder/dscope/usblib/inc/usb_core.h"
 u16 Usb_wLength;
 u16 Usb_wOffset;
 u16 PacketSize;
 u8 *(*CopyData)(u16 Length);
}
ENDPOINT_INFO;



typedef struct _DEVICE
{
 u8 Total_Endpoint;
 u8 Total_Configuration;
}
DEVICE;

typedef union
{
 u16 w;
 struct BW
 {
 u8 bb1;
 u8 bb0;
 }
 bw;
} u16_u8;

typedef struct _DEVICE_INFO
{
 u8 USBbmRequestType;
 u8 USBbRequest;
 u16_u8 USBwValues;
 u16_u8 USBwIndexs;
 u16_u8 USBwLengths;

 u8 ControlState;
 u8 Current_Feature;
 u8 Current_Configuration;
 u8 Current_Interface;
#line 120 "z:/robs folder/dscope/usblib/inc/usb_core.h"
 u8 Current_AlternateSetting;

 ENDPOINT_INFO Ctrl_Info;
}
DEVICE_INFO;

typedef struct _DEVICE_PROP
{
 void (*Init)(void);
 void (*Reset)(void);


 void (*Process_Status_IN)(void);
 void (*Process_Status_OUT)(void);
#line 151 "z:/robs folder/dscope/usblib/inc/usb_core.h"
 RESULT (*Class_Data_Setup)(u8 RequestNo);
#line 162 "z:/robs folder/dscope/usblib/inc/usb_core.h"
 RESULT (*Class_NoData_Setup)(u8 RequestNo);
#line 172 "z:/robs folder/dscope/usblib/inc/usb_core.h"
 RESULT (*Class_Get_Interface_Setting)(u8 Interface, u8 AlternateSetting);

 u8* (*GetDeviceDescriptor)(u16 Length);
 u8* (*GetConfigDescriptor)(u16 Length);
 u8* (*GetStringDescriptor)(u16 Length);

 u8* RxEP_buffer;
 u8 MaxPacketSize;

}
DEVICE_PROP;

typedef struct _USER_STANDARD_REQUESTS
{
 void (*User_GetConfiguration)(void);
 void (*User_SetConfiguration)(void);
 void (*User_GetInterface)(void);
 void (*User_SetInterface)(void);
 void (*User_GetStatus)(void);
 void (*User_ClearFeature)(void);
 void (*User_SetEndPointFeature)(void);
 void (*User_SetDeviceFeature)(void);
 void (*User_SetDeviceAddress)(void);
}
USER_STANDARD_REQUESTS;
#line 216 "z:/robs folder/dscope/usblib/inc/usb_core.h"
u8 Setup0_Process(void);
u8 Post0_Process(void);
u8 Out0_Process(void);
u8 In0_Process(void);

RESULT Standard_SetEndPointFeature(void);
RESULT Standard_SetDeviceFeature(void);

u8 *Standard_GetConfiguration(u16 Length);
RESULT Standard_SetConfiguration(void);
u8 *Standard_GetInterface(u16 Length);
RESULT Standard_SetInterface(void);
u8 *Standard_GetDescriptorData(u16 Length, PONE_DESCRIPTOR pDesc);

u8 *Standard_GetStatus(u16 Length);
RESULT Standard_ClearFeature(void);
void SetDeviceAddress(u8);
void NOP_Process(void);

extern DEVICE_PROP Device_Property;
extern USER_STANDARD_REQUESTS User_Standard_Requests;
extern DEVICE Device_Table;
extern DEVICE_INFO Device_Info;


extern u16 SaveRState;
extern u16 SaveTState;
#line 1 "z:/robs folder/dscope/usblib/inc/usb_init.h"
#line 25 "z:/robs folder/dscope/usblib/inc/usb_init.h"
void USB_Init(void);



extern u8 EPindex;




extern DEVICE_INFO* pInformation;


extern DEVICE_PROP* pProperty;




extern USER_STANDARD_REQUESTS *pUser_Standard_Requests;

extern u16 SaveState ;
extern u16 wInterrupt_Mask;
#line 1 "z:/robs folder/dscope/usblib/inc/usb_mem.h"
#line 25 "z:/robs folder/dscope/usblib/inc/usb_mem.h"
void UserToPMABufferCopy(u8 *pbUsrBuf, u16 wPMABufAddr, u16 wNBytes);
void PMAToUserBufferCopy(u8 *pbUsrBuf, u16 wPMABufAddr, u16 wNBytes);
#line 1 "z:/robs folder/dscope/usblib/inc/usb_int.h"
#line 26 "z:/robs folder/dscope/usblib/inc/usb_int.h"
void CTR_LP(void);
void CTR_HP(void);
#line 1 "z:/robs folder/dscope/include/usb_conf.h"
#line 1 "z:/robs folder/dscope/include/usb_pwr.h"
#line 10 "z:/robs folder/dscope/include/usb_pwr.h"
typedef enum _RESUME_STATE
{
 RESUME_EXTERNAL,
 RESUME_INTERNAL,
 RESUME_LATER,
 RESUME_WAIT,
 RESUME_START,
 RESUME_ON,
 RESUME_OFF,
 RESUME_ESOF
} RESUME_STATE;

typedef enum _DEVICE_STATE
{
 UNCONNECTED,
 ATTACHED,
 POWERED,
 DEFAULT,
 ADDRESSED,
 CONFIGURED
} DEVICE_STATE;

void Suspend(void);
void Resume_Init(void);
void Resume(RESUME_STATE eResumeSetVal);

extern vu8 bDeviceState;
extern volatile char fSuspendEnabled;
#line 1 "z:/robs folder/dscope/include/hw_v1_config.h"
#line 1 "z:/robs folder/dscope/usblib/inc/usb_type.h"
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
#line 22 "Z:/Robs Folder/DScope/source/usb_pwr.c"
volatile u8 bDeviceState = UNCONNECTED;
volatile char fSuspendEnabled =  1 ;

struct
{
 volatile RESUME_STATE eState;
 volatile u8 bESOFcnt;
}
ResumeS;
#line 39 "Z:/Robs Folder/DScope/source/usb_pwr.c"
void Suspend(void)
{
 u16 wCNTR;




 wCNTR =  ((u16) * ((volatile unsigned *)( (0x40005C00L)  + 0x40)) ) ;
 wCNTR |=  (0x0008) ;
  (* ((volatile unsigned *)( (0x40005C00L)  + 0x40))  = (u16)wCNTR) ;







 wCNTR =  ((u16) * ((volatile unsigned *)( (0x40005C00L)  + 0x40)) ) ;
 wCNTR |=  (0x0004) ;
  (* ((volatile unsigned *)( (0x40005C00L)  + 0x40))  = (u16)wCNTR) ;





}
#line 73 "Z:/Robs Folder/DScope/source/usb_pwr.c"
void Resume_Init(void)
{
 u16 wCNTR;





 wCNTR =  ((u16) * ((volatile unsigned *)( (0x40005C00L)  + 0x40)) ) ;
 wCNTR &= (~ (0x0004) );
  (* ((volatile unsigned *)( (0x40005C00L)  + 0x40))  = (u16)wCNTR) ;






  (* ((volatile unsigned *)( (0x40005C00L)  + 0x40))  = (u16) ( (0x8000)  | (0x0400) ) ) ;




}
#line 109 "Z:/Robs Folder/DScope/source/usb_pwr.c"
void Resume(RESUME_STATE eResumeSetVal)
{
 u16 wCNTR;

 if (eResumeSetVal != RESUME_ESOF)
 ResumeS.eState = eResumeSetVal;

 switch (ResumeS.eState)
 {
 case RESUME_EXTERNAL:
 Resume_Init();
 ResumeS.eState = RESUME_OFF;
 break;
 case RESUME_INTERNAL:
 Resume_Init();
 ResumeS.eState = RESUME_START;
 break;
 case RESUME_LATER:
 ResumeS.bESOFcnt = 2;
 ResumeS.eState = RESUME_WAIT;
 break;
 case RESUME_WAIT:
 ResumeS.bESOFcnt--;
 if (ResumeS.bESOFcnt == 0)
 ResumeS.eState = RESUME_START;
 break;
 case RESUME_START:
 wCNTR =  ((u16) * ((volatile unsigned *)( (0x40005C00L)  + 0x40)) ) ;
 wCNTR |=  (0x0010) ;
  (* ((volatile unsigned *)( (0x40005C00L)  + 0x40))  = (u16)wCNTR) ;
 ResumeS.eState = RESUME_ON;
 ResumeS.bESOFcnt = 10;
 break;
 case RESUME_ON:
 ResumeS.bESOFcnt--;
 if (ResumeS.bESOFcnt == 0)
 {
 wCNTR =  ((u16) * ((volatile unsigned *)( (0x40005C00L)  + 0x40)) ) ;
 wCNTR &= (~ (0x0010) );
  (* ((volatile unsigned *)( (0x40005C00L)  + 0x40))  = (u16)wCNTR) ;
 ResumeS.eState = RESUME_OFF;
 }
 break;
 case RESUME_OFF:
 case RESUME_ESOF:
 default:
 ResumeS.eState = RESUME_OFF;
 break;
 }
}
