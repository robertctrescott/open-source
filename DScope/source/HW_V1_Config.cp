#line 1 "Z:/Robs Folder/DScope/source/HW_V1_Config.c"
#line 1 "z:/robs folder/dscope/include/hw_v1_config.h"
#line 33 "z:/robs folder/dscope/include/hw_v1_config.h"
void GPIO_Configure(void);
void InitUART1(void);
void InitTimers(void);
char KeyScan(void);
char Test_USB_ON(void);
char SD_Card_ON(void);
#line 1 "z:/robs folder/dscope/include/function.h"
#line 23 "z:/robs folder/dscope/include/function.h"
extern unsigned int Delay_Counter, X_Counter;
extern unsigned char Counter_20mS, Key_Repeat_Counter, Key_Wait_Counter;
extern unsigned char Cursor_Counter,Erase_Note, Frame, Stop, Type, Sync;

extern unsigned long vb_Sum, Battery;
extern unsigned int temp, Lcd_X, Lcd_Y;

extern unsigned char Update[22];
extern unsigned char SectorBuff[512];
extern long Frequency, Cycle, Duty;
#line 7 "Z:/Robs Folder/DScope/source/HW_V1_Config.c"
unsigned char Key_Status_Last =0;
#line 12 "Z:/Robs Folder/DScope/source/HW_V1_Config.c"
void GPIO_Configure(void)
{
 IOPAEN_bit = 1;
#line 23 "Z:/Robs Folder/DScope/source/HW_V1_Config.c"
 GPIOA_CRL = 0x88888080;
#line 32 "Z:/Robs Folder/DScope/source/HW_V1_Config.c"
 GPIOA_CRH = 0x8884488B;
 GPIOA_ODR = 0x0FFFF;

 IOPBEN_bit = 1;
#line 44 "Z:/Robs Folder/DScope/source/HW_V1_Config.c"
 GPIOB_CRL = 0x88888411;
#line 53 "Z:/Robs Folder/DScope/source/HW_V1_Config.c"
 GPIOB_CRH = 0xBBB1B488;
 GPIOB_ODR = 0x0FFFF;

 IOPCEN_bit = 1;
#line 65 "Z:/Robs Folder/DScope/source/HW_V1_Config.c"
 GPIOC_CRL = 0x84118881;
#line 74 "Z:/Robs Folder/DScope/source/HW_V1_Config.c"
 GPIOC_CRH = 0x88888884;
 GPIOC_ODR = 0x0FFF0;

 IOPDEN_bit = 1;
#line 86 "Z:/Robs Folder/DScope/source/HW_V1_Config.c"
 GPIOD_CRL = 0x38338838;
#line 95 "Z:/Robs Folder/DScope/source/HW_V1_Config.c"
 GPIOD_CRH = 0x888B8884;
 GPIOD_ODR = 0x0FF7F;

 IOPEEN_bit = 1;
 GPIOE_CRL = 0x33333333;
 GPIOE_CRH = 0x33333333;

 AFIOEN_bit = 1;
#line 107 "Z:/Robs Folder/DScope/source/HW_V1_Config.c"
 AFIO_MAPR = 0x00001200;
}

void InitUART1(void)
{

 UART1_Init_Advanced(19200,_UART_8_BIT_DATA,_UART_NOPARITY,_UART_ONE_STOPBIT,&_GPIO_MODULE_USART1_PA9_10);
 NVIC_IntEnable(IVT_INT_USART1);
 TCIE_USART1_CR1_bit = 0;
 UE_bit = 1;
 RE_bit = 1;
 RXNEIE_USART1_CR1_bit = 1;
 TXEIE_USART1_CR1_bit = 0;
 TE_bit = 1;
}
#line 126 "Z:/Robs Folder/DScope/source/HW_V1_Config.c"
void InitTimers(void)
{

 RCC_APB1ENR.TIM2EN = 1;
 TIM2_CR1.CEN = 0;
 TIM2_PSC = 0;
 TIM2_ARR = 36000;
 NVIC_IntEnable(IVT_INT_TIM2);
 TIM2_DIER.UIE = 1;
 TIM2_CR1.CEN = 1;
}
#line 145 "Z:/Robs Folder/DScope/source/HW_V1_Config.c"
char KeyScan(void)
{
 char Key_Status_Now=0, KeyCode=0;

 if((~GPIOA_IDR) & 0x0010) Key_Status_Now |= 0x01;
 if((~GPIOD_IDR) & 0x0800) Key_Status_Now |= 0x02;
 if((~GPIOA_IDR) & 0x0040) Key_Status_Now |= 0x04;
 if((~GPIOD_IDR) & 0x0200) Key_Status_Now |= 0x08;
 if((~GPIOA_IDR) & 0x0020) Key_Status_Now |= 0x10;
 if((~GPIOA_IDR) & 0x0080) Key_Status_Now |= 0x20;

 if(Key_Status_Now &(~Key_Status_Last)){

 Key_Wait_Counter=25;

 if(Key_Status_Now & 0x01) KeyCode= 1 ;
 if(Key_Status_Now & 0x02) KeyCode= 2 ;
 if(Key_Status_Now & 0x04) KeyCode= 3 ;
 if(Key_Status_Now & 0x08) KeyCode= 4 ;
 if(Key_Status_Now & 0x10) KeyCode= 5 ;
 if(Key_Status_Now & 0x20) KeyCode= 6 ;

 } else {

 if(Key_Status_Now & Key_Status_Last){
 if((Key_Wait_Counter | Key_Repeat_Counter)==0){

 if(Key_Status_Now & 0x01) KeyCode= 1 ;
 if(Key_Status_Now & 0x02) KeyCode= 2 ;
 if(Key_Status_Now & 0x04) KeyCode= 3 ;
 if(Key_Status_Now & 0x08) KeyCode= 4 ;
 if(Key_Status_Now & 0x10) KeyCode= 5 ;
 if(Key_Status_Now & 0x20) KeyCode= 6 ;

 Key_Repeat_Counter = 3;
 }
 }else Key_Wait_Counter=25;
 }
 Key_Status_Last = Key_Status_Now;
 return KeyCode;
}
#line 190 "Z:/Robs Folder/DScope/source/HW_V1_Config.c"
char Test_USB_ON(void)
{
 if(GPIOB_IDR &0x0400) return 1;
 else return 0;
}
#line 199 "Z:/Robs Folder/DScope/source/HW_V1_Config.c"
char SD_Card_ON(void)
{
 if(GPIOD_IDR &0x0400) return 1;
 else return 0;
}
