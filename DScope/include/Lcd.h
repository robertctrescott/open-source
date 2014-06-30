/******************** (C) COPYRIGHT 2009 e-Design Co.,Ltd. *********************
* File Name: lcd.h      Author: bure      Hardware: DS0201V1.1     Version: V1.0
*******************************************************************************/
#ifndef __LCD_H
#define __LCD_H

//================================================================

#define WHITE                   0xFFFF        //白色：B = F800, G = 07E0, R = 001F
#define PANEL                   0xFFE0        //青色：B = F800, G = 07E0, R = 0000
#define RED                     0x001F        //红色：B = 0000, G = 0000, R = 001F
#define GRN                     0x07E0        //绿色：B = 0000, G = 07E0, R = 0000
#define YEL                     0x07FF        //黄色：B = 0000, G = 07E0, R = 001F
#define GRID                    0x738E        //灰色：B = 7000, G = 0380, R = 000E
#define CURVE                   0x0F8E        //亮绿：B = 0001, G = 0780, R = 000E 
#define MODEL                   0xC05E        //紫色：B = C000, G = 0040, R = 001E
#define LINE                    0xE79F        //白色：B = E000, G = 0780, R = 001F
//#define NOTE                    0x073E        //暗黄：B = 0000, G = 0720, R = 001F
#define BLACK                   0x0000        //黑色：B = 0000, G = 0000, R = 0000

//===================================================================

#define PRN                0
#define INV                1

//========================== LCD ==========================

void LCD_WR_REG(unsigned int Reg, unsigned int Data);
void LCD_Initial(void); 
void Point_SCR(unsigned int x0, unsigned int y0);
void Set_Pixel(unsigned int Color);
void Clear_Screen(unsigned int Color);
void Display_Frame(void);                                                
void Display_Grid(void); 

void Display_Char(unsigned int x0, unsigned int y0, unsigned int Color, unsigned char Mode, char s);
void Display_Str(unsigned int xi, unsigned int yi, unsigned int Color, unsigned char Mode, unsigned const char *s);
void Display_Logo(unsigned int Dot_x, unsigned int Dot_y);

#endif

/********************************* END OF FILE ********************************/