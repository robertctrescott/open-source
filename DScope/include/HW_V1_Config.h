/******************** (C) COPYRIGHT 2009 e-Design Co.,Ltd. *********************
* File Name: HW_V1_config.h   Author: bure   Hardware: DS0201V1.1  Version: V1.0
*******************************************************************************/
#ifndef __HWV1_CONFIG_H
#define __HWV1_CONFIG_H

#define MSD_CS_LOW()    BR12_GPIOB_BSRR_bit = 1      //Select MSD Card
#define MSD_CS_HIGH()   BS12_GPIOB_BSRR_bit = 1     //Deselect MSD Card

#define KEY_UP         (GPIO_Pin_6)  //GPIOA
#define KEY_DOWN       (GPIO_Pin_9)  //GPIOD
#define KEY_LEFT       (GPIO_Pin_5)  //GPIOA
#define KEY_RIGHT      (GPIO_Pin_7)  //GPIOA
#define KEY_PLAY       (GPIO_Pin_4)  //GPIOA
#define KEY_MENU       (GPIO_Pin_11) //GPIOD

#define LCD_DATA_OUT        GPIOE_ODR
#define LCD_DATA_INP        GPIOE_IDR
#define LCD_DATA_BUS_INP()  GPIOE_CRL = GPIOE_CRH = 0x44444444
#define LCD_DATA_BUS_OUT()  GPIOE_CRL = GPIOE_CRH = 0x33333333

#define LCD_nRST_LOW()  BR0_GPIOC_BSRR_bit = 1
#define LCD_nRST_HIGH() BS0_GPIOC_BSRR_bit = 1
#define LCD_RS_LOW()    BR1_GPIOD_BSRR_bit = 1
#define LCD_RS_HIGH()   BS1_GPIOD_BSRR_bit = 1
#define LCD_nWR_LOW()   BR5_GPIOD_BSRR_bit = 1
#define LCD_nWR_HIGH()  BS5_GPIOD_BSRR_bit = 1

#define LCD_nRD_LOW()   BR4_GPIOD_BSRR_bit = 1
#define LCD_nRD_HIGH()  BS4_GPIOD_BSRR_bit = 1


void GPIO_Configure(void);
void InitUART1(void);
void InitTimers(void);
char KeyScan(void);
char Test_USB_ON(void);
char SD_Card_ON(void);

#endif 
/****************************** END OF FILE ***********************************/