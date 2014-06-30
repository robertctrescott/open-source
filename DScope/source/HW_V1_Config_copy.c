/******************** (C) COPYRIGHT 2009 e-Design Co.,Ltd. *********************
* File Name: HW_V1_config.c   Author: bure   Hardware: DS0201V1.1  Version: V1.0
*******************************************************************************/
#include "HW_V1_Config.h"
#include "function.h"

unsigned char Key_Status_Last =0;
unsigned long _GPIOA_CRL    at GPIOA_CRL;
unsigned long _GPIOA_CRH    at GPIOA_CRH;

/*******************************************************************************
* GPIO Configuration
*******************************************************************************/
void GPIO_Configure(void)
{
    IOPAEN_bit = 1;
    GPIOA_CRL = 0x88888080;     /*GPIOA Bit0-7
                  |||||||+----- Nib0  Ain   Analog input
                  ||||||+------ Nib1  NC    Pull up input
                  |||||+------- Nib2  Vbat  Analog input
                  ||||+-------- Nib3  NC    Pull up input
                  |||+--------- Nib4  KP    Pull up input
                  ||+---------- Nib5  KL    Pull up input
                  |+----------- Nib6  KU    Pull up input
                  +------------ Nib7  KR    Pull up input */
    GPIOA_CRH = 0x8884488B;   /*GPIOA Bit8-15
                  |||||||+----- Nib8  MCO   Alternate output
                  ||||||+------ Nib9  NC    Pull up input
                  |||||+------- Nib10 NC    Pull up input
                  ||||+-------- Nib11 D-    Input
                  |||+--------- Nib12 D+    Input
                  ||+---------- Nib13 TMS   Pull up input
                  |+----------- Nib14 TCK   Pull up input
                  +------------ Nib15 TDI   Pull up input*/

 #ifdef Robert
    GPIO_Analog_Input(&GPIOA_BASE,_GPIO_PINMASK_0 |
                            _GPIO_PINMASK_2);
    GPIO_Config(&GPIOA_BASE,_GPIO_PINMASK_1 |
                            _GPIO_PINMASK_3 |
                            _GPIO_PINMASK_4 |
                            _GPIO_PINMASK_5 |
                            _GPIO_PINMASK_6 |
                            _GPIO_PINMASK_7 |
                            _GPIO_PINMASK_9 |
                            _GPIO_PINMASK_10|
                            _GPIO_PINMASK_11|
                            _GPIO_PINMASK_12|
                            _GPIO_PINMASK_13|
                            _GPIO_PINMASK_14|
                            _GPIO_PINMASK_15, _GPIO_CFG_MODE_INPUT | _GPIO_CFG_PULL_UP);
    GPIO_Config(&GPIOA_BASE,_GPIO_PINMASK_8,
                            _GPIO_CFG_MODE_ALT_FUNCTION | _GPIO_CFG_OTYPE_PP | _GPIO_CFG_SPEED_50MHZ);
    GPIO_Config(&GPIOA_BASE,_GPIO_PINMASK_11|
                            _GPIO_PINMASK_12,
                            _GPIO_CFG_MODE_INPUT |_GPIO_CFG_PULL_NO);
 #endif
    GPIOA_ODR = 0x0FFFF;


/*GPIOB_CRL = 0x88888411;   GPIOB Bit0-7
                |||||||+----- Nib0  A     Low speed output
                ||||||+------ Nib1  D     Low speed output
                |||||+------- Nib2  BT1   Input
                ||||+-------- Nib3  TDO   Pull up input
                |||+--------- Nib4  TRST  Pull up input
                ||+---------- Nib5  NC    Pull up input
                |+----------- Nib6  NC    Pull up input
                +------------ Nib7  NC    Pull up input
  GPIOB_CRH = 0xBBB1B488;   GPIOB Bit8-15
                |||||||+----- Nib8  NC    Pull up input
                ||||||+------ Nib9  NC    Pull up input
                |||||+------- Nib10 Vusb  Input
                ||||+-------- Nib11 V0    Alternate output
                |||+--------- Nib12 SDCS  Low speed output
                ||+---------- Nib13 SCK   Alternate output
                |+----------- Nib14 MISO  Alternate output
                +------------ Nib15 MOSI  Alternate output*/
                
    GPIO_Config(&GPIOB_BASE,_GPIO_PINMASK_3 |
                            _GPIO_PINMASK_4 |
                            _GPIO_PINMASK_5 |
                            _GPIO_PINMASK_6 |
                            _GPIO_PINMASK_7 |
                            _GPIO_PINMASK_8 |
                            _GPIO_PINMASK_9, _GPIO_CFG_MODE_INPUT | _GPIO_CFG_PULL_UP);
    GPIO_Config(&GPIOB_BASE,_GPIO_PINMASK_11|
                            _GPIO_PINMASK_13|
                            _GPIO_PINMASK_14|
                            _GPIO_PINMASK_15,
                            _GPIO_CFG_MODE_ALT_FUNCTION | _GPIO_CFG_OTYPE_PP | _GPIO_CFG_SPEED_50MHZ);
    GPIO_Config(&GPIOB_BASE,_GPIO_PINMASK_2 |
                            _GPIO_PINMASK_10,
                            _GPIO_CFG_MODE_INPUT |_GPIO_CFG_PULL_NO);
    GPIO_Config(&GPIOB_BASE,_GPIO_PINMASK_0 |
                            _GPIO_PINMASK_1 |
                            _GPIO_PINMASK_12,
                            _GPIO_CFG_MODE_OUTPUT |_GPIO_CFG_OTYPE_PP|_GPIO_CFG_SPEED_10MHZ);

    GPIOB_ODR = 0x0FFFF;


/*GPIOC_CRL = 0x84118881;   GPIOB Bit0-7
                |||||||+----- Nib0  nCLS  Low speed output
                ||||||+------ Nib1  NC    Pull up input
                |||||+------- Nib2  NC    Pull up input
                ||||+-------- Nib3  NC    Pull up input
                |||+--------- Nib4  C     Low speed output
                ||+---------- Nib5  B     Low speed output
                |+----------- Nib6  NC    Input
                +------------ Nib7  NC    Pull up input
  GPIOC_CRH = 0x88888884;  GPIOB Bit8-15
                |||||||+----- Nib8  NC    Input
                ||||||+------ Nib9  NC    Pull up input
                |||||+------- Nib10 NC    Pull up input
                ||||+-------- Nib11 NC    Pull up input
                |||+--------- Nib12 NC    Pull up input
                ||+---------- Nib13 NC    Pull up input
                |+----------- Nib14 NC    Pull up input
                +------------ Nib15 NC    Pull up input*/
                
     GPIO_Config(&GPIOC_BASE,_GPIO_PINMASK_1 |
                            _GPIO_PINMASK_2 |
                            _GPIO_PINMASK_3 |
                            _GPIO_PINMASK_7 |
                            _GPIO_PINMASK_9 |
                            _GPIO_PINMASK_10|
                            _GPIO_PINMASK_11|
                            _GPIO_PINMASK_12|
                            _GPIO_PINMASK_13|
                            _GPIO_PINMASK_14|
                            _GPIO_PINMASK_15, _GPIO_CFG_MODE_INPUT | _GPIO_CFG_PULL_UP);
    GPIO_Config(&GPIOC_BASE,_GPIO_PINMASK_6 |
                            _GPIO_PINMASK_8,
                            _GPIO_CFG_MODE_INPUT |_GPIO_CFG_PULL_NO);
    GPIO_Config(&GPIOC_BASE,_GPIO_PINMASK_0 |
                            _GPIO_PINMASK_4 |
                            _GPIO_PINMASK_5,
                            _GPIO_CFG_MODE_OUTPUT |_GPIO_CFG_OTYPE_PP|_GPIO_CFG_SPEED_10MHZ);
                
    GPIOC_ODR = 0x0FFFF;

/*GPIOD_CRL = 0x38338838;  GPIOB Bit0-7
                |||||||+----- Nib0  NC    Pull up input
                ||||||+------ Nib1  RS    Hight speed output
                |||||+------- Nib2  NC    Pull up input
                ||||+-------- Nib3  NC    Pull up input
                |||+--------- Nib4  nRD   Hight speed output
                ||+---------- Nib5  nWR   Hight speed output
                |+----------- Nib6  NC    Pull up input
                +------------ Nib7  nCS   Hight speed output
  GPIOD_CRH = 0x888B8884;   GPIOB Bit8-15
                |||||||+----- Nib8  NC    Pull up input
                ||||||+------ Nib9  KD    Pull up input
                |||||+------- Nib10 SDDT  Pull up input
                ||||+-------- Nib11 KM    Pull up input
                |||+--------- Nib12 Fout  Alternate output
                ||+---------- Nib13 NC    Pull up input
                |+----------- Nib14 NC    Pull up input
                +------------ Nib15 NC    Pull up input*/
                
     GPIO_Config(&GPIOD_BASE,_GPIO_PINMASK_0 |
                            _GPIO_PINMASK_2 |
                            _GPIO_PINMASK_3 |
                            _GPIO_PINMASK_6 |
                            _GPIO_PINMASK_8 |
                            _GPIO_PINMASK_9 |
                            _GPIO_PINMASK_10|
                            _GPIO_PINMASK_11|
                            _GPIO_PINMASK_13|
                            _GPIO_PINMASK_14|
                            _GPIO_PINMASK_15, _GPIO_CFG_MODE_INPUT | _GPIO_CFG_PULL_UP);
    GPIO_Config(&GPIOD_BASE,_GPIO_PINMASK_12,
                            _GPIO_CFG_MODE_ALT_FUNCTION | _GPIO_CFG_OTYPE_PP | _GPIO_CFG_SPEED_50MHZ);
    GPIO_Config(&GPIOD_BASE,_GPIO_PINMASK_1 |
                            _GPIO_PINMASK_4 |
                            _GPIO_PINMASK_5 |
                            _GPIO_PINMASK_7,
                            _GPIO_CFG_MODE_OUTPUT |_GPIO_CFG_OTYPE_PP|_GPIO_CFG_SPEED_50MHZ);

    GPIOD_ODR = 0x0FF7F;

    GPIO_Config(&GPIOE_BASE,_GPIO_PINMASK_ALL,_GPIO_CFG_MODE_OUTPUT |_GPIO_CFG_OTYPE_PP|_GPIO_CFG_SPEED_50MHZ);


  GPIOE_CRL = 0x33333333;   //Bit0-7  Hight speed output£¨LCD_DB0-7 £©
  GPIOE_CRH = 0x33333333;   //Bit8-15 Hight speed output£¨LCD_DB8-15£©

AFIOEN_bit = 1;
AFIO_MAPR = 0x00001200;     /*AF remap and debug I/O configuration register Bit0-31
                ||||||++----- Reset value
                |||||+------- Bit9   TIM2_CH3_CH4 remap to PB10,PB11
                ||||+-------- Bit12  TIM4_CH1     remap to PD12
                ++++--------- Reset value */
}


/*******************************************************************************
* Key Scan & Process    Output£ºKeyBuff=Key Code
*******************************************************************************/
char KeyScan(void)
{
  char Key_Status_Now=0, KeyCode=0;

  if((~GPIOA_IDR) & 0x0010) Key_Status_Now |= 0x01; //KEY_PLAY_ON
  if((~GPIOD_IDR) & 0x0800) Key_Status_Now |= 0x02; //KEY_MENU_ON
  if((~GPIOA_IDR) & 0x0040) Key_Status_Now |= 0x04; //KEY_UP_ON
  if((~GPIOD_IDR) & 0x0200) Key_Status_Now |= 0x08; //KEY_DOWN_ON
  if((~GPIOA_IDR) & 0x0020) Key_Status_Now |= 0x10; //KEY_LEFT_ON
  if((~GPIOA_IDR) & 0x0080) Key_Status_Now |= 0x20; //KEY_RIGHT_ON

  if(Key_Status_Now &(~Key_Status_Last)){

    Key_Wait_Counter=25;        //Push on <500mS, No auto repeat

    if(Key_Status_Now & 0x01)  KeyCode=KEYCODE_PLAY; // KeyCode(Play)
    if(Key_Status_Now & 0x02)  KeyCode=KEYCODE_MANU; // KeyCode(Manu)
    if(Key_Status_Now & 0x04)  KeyCode=KEYCODE_UP;   // KeyCode(Up)
    if(Key_Status_Now & 0x08)  KeyCode=KEYCODE_DOWN; // KeyCode(Down)
    if(Key_Status_Now & 0x10)  KeyCode=KEYCODE_LEFT; // KeyCode(Left)
    if(Key_Status_Now & 0x20)  KeyCode=KEYCODE_RIGHT;// KeyCode(Right)

  } else {

    if(Key_Status_Now & Key_Status_Last){
      if((Key_Wait_Counter | Key_Repeat_Counter)==0){

        if(Key_Status_Now & 0x01)  KeyCode=KEYCODE_PLAY; // KeyCode(Play)
        if(Key_Status_Now & 0x02)  KeyCode=KEYCODE_MANU; // KeyCode(Manu)
        if(Key_Status_Now & 0x04)  KeyCode=KEYCODE_UP;   // KeyCode(Up)
        if(Key_Status_Now & 0x08)  KeyCode=KEYCODE_DOWN; // KeyCode(Down)
        if(Key_Status_Now & 0x10)  KeyCode=KEYCODE_LEFT; // KeyCode(Left)
        if(Key_Status_Now & 0x20)  KeyCode=KEYCODE_RIGHT;// KeyCode(Right)

        Key_Repeat_Counter = 3; //Auto repeat each 60mS
      }
    }else Key_Wait_Counter=25;
  }
  Key_Status_Last = Key_Status_Now;
  return KeyCode;
}

/*******************************************************************************
 Detect USB ON
*******************************************************************************/
char Test_USB_ON(void) 
{ 
  if(GPIOB_IDR &0x0400) return 1;
  else  return 0;
}

/*******************************************************************************
 Detect SD Card ON
*******************************************************************************/
char SD_Card_ON(void) 
{ 
  if(GPIOD_IDR &0x0400) return 1;
  else  return 0;
}

/******************************** END OF FILE *********************************/