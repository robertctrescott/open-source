/*******************************************************************************
 File Name : hw_config.h              Author  : MCD Application Team & bure
*******************************************************************************/

#ifndef __HW_CONFIG_H
#define __HW_CONFIG_H

#define ApplicationAddress 0x08004000

#define GPIOA_CRL   (*((vu32 *)(GPIOA_BASE+0x00)))
#define GPIOB_CRL   (*((vu32 *)(GPIOB_BASE+0x00)))
#define GPIOC_CRL   (*((vu32 *)(GPIOC_BASE+0x00)))
#define GPIOD_CRL   (*((vu32 *)(GPIOD_BASE+0x00)))
#define GPIOE_CRL   (*((vu32 *)(GPIOE_BASE+0x00)))

#define GPIOA_CRH   (*((vu32 *)(GPIOA_BASE+0x04)))
#define GPIOB_CRH   (*((vu32 *)(GPIOB_BASE+0x04)))
#define GPIOC_CRH   (*((vu32 *)(GPIOC_BASE+0x04)))
#define GPIOD_CRH   (*((vu32 *)(GPIOD_BASE+0x04)))
#define GPIOE_CRH   (*((vu32 *)(GPIOE_BASE+0x04)))

#define GPIOA_ODR   (*((vu32 *)(GPIOA_BASE+0x0C)))
#define GPIOB_ODR   (*((vu32 *)(GPIOB_BASE+0x0C)))
#define GPIOC_ODR   (*((vu32 *)(GPIOC_BASE+0x0C)))
#define GPIOD_ODR   (*((vu32 *)(GPIOD_BASE+0x0C)))
#define GPIOE_ODR   (*((vu32 *)(GPIOE_BASE+0x0C)))

#define GPIOA_IDR   (*((vu32 *)(GPIOA_BASE+0x08)))
#define GPIOB_IDR   (*((vu32 *)(GPIOB_BASE+0x08)))
#define GPIOC_IDR   (*((vu32 *)(GPIOC_BASE+0x08)))
#define GPIOD_IDR   (*((vu32 *)(GPIOD_BASE+0x08)))
#define GPIOE_IDR   (*((vu32 *)(GPIOE_BASE+0x08)))

#define GPIOA_BSRR  (*((vu32 *)(GPIOA_BASE+0x10)))
#define GPIOB_BSRR  (*((vu32 *)(GPIOB_BASE+0x10)))
#define GPIOC_BSRR  (*((vu32 *)(GPIOC_BASE+0x10)))
#define GPIOD_BSRR  (*((vu32 *)(GPIOD_BASE+0x10)))
#define GPIOE_BSRR  (*((vu32 *)(GPIOE_BASE+0x10)))

#define GPIOA_BRR   (*((vu32 *)(GPIOA_BASE+0x14)))
#define GPIOB_BRR   (*((vu32 *)(GPIOB_BASE+0x14)))
#define GPIOC_BRR   (*((vu32 *)(GPIOC_BASE+0x14)))
#define GPIOD_BRR   (*((vu32 *)(GPIOD_BASE+0x14)))
#define GPIOE_BRR   (*((vu32 *)(GPIOE_BASE+0x14)))

#define LDC_DATA_OUT        GPIOE_ODR
#define LDC_DATA_INP        GPIOE_IDR
#define LCD_DATA_BUS_INP()  GPIOE_CRL = GPIOC_CRH = 0x44444444
#define LCD_DATA_BUS_OUT()  GPIOE_CRL = GPIOC_CRH = 0x33333333

#define LCD_nRST_LOW()  GPIOC_BRR  = GPIO_Pin_0
#define LCD_nRST_HIGH() GPIOC_BSRR = GPIO_Pin_0
#define LCD_RS_LOW()    GPIOD_BRR  = GPIO_Pin_1
#define LCD_RS_HIGH()   GPIOD_BSRR = GPIO_Pin_1
#define LCD_nWR_LOW()   GPIOD_BRR  = GPIO_Pin_5
#define LCD_nWR_HIGH()  GPIOD_BSRR = GPIO_Pin_5
#define LCD_nWR_ACT()   GPIOD_BSRR = GPIOD_BRR  = GPIO_Pin_5
#define LCD_nRD_LOW()   GPIOD_BRR  = GPIO_Pin_4
#define LCD_nRD_HIGH()  GPIOD_BSRR = GPIO_Pin_4
#define LCD_nRD_ACT()   GPIOD_BSRR = GPIOB_BRR  = GPIO_Pin_4

void GPIO_Config(void);
void LCD_WR_REG(unsigned short Reg, unsigned short Data); 
void Delay_ms(unsigned short mS); 
void LCD_Initial(void);
void Point_SCR(unsigned short x0, unsigned short y0); 
void Set_Pixel(unsigned short Color); 
void Clear_Screen(unsigned short Color);                                                
void Display_Str(unsigned short x0, unsigned short y0, unsigned short Color, unsigned char Mode, unsigned const char *s);
void Display_Logo(unsigned short Dot_x, unsigned short Dot_y);
u8  DFU_Button_Read(void);


#endif  

/********************************* END OF FILE ********************************/