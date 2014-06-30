/******************** (C) COPYRIGHT 2009 e-Design Co.,Ltd. *********************
* File Name: Funtion.h   Author: bure   Hardware:  DS0201V1.1   Version: Ver 1.0
*******************************************************************************/
#ifndef __Funtion_h
#define __Funtion_h

#define KEYCODE_VOID    0
#define KEYCODE_PLAY    1
#define KEYCODE_MANU    2
#define KEYCODE_UP      3
#define KEYCODE_DOWN    4
#define KEYCODE_LEFT    5
#define KEYCODE_RIGHT   6

#define X_SIZE    300
#define Y_SIZE    200
#define MIN_X     1
#define MIN_Y     19
#define MAX_X     (X_SIZE + MIN_X)
#define MAX_Y     (Y_SIZE + MIN_Y)


extern unsigned int Delay_Counter, X_Counter;
extern unsigned char  Counter_20mS, Key_Repeat_Counter, Key_Wait_Counter; 
extern unsigned char  Cursor_Counter,Erase_Note, Frame, Stop, Type, Sync;

extern unsigned long   vb_Sum, Battery;
extern unsigned int temp, Lcd_X, Lcd_Y;

extern unsigned char  Update[22];
extern unsigned char  SectorBuff[512];
extern          long  Frequency, Cycle, Duty;//, Vram, Vavg, Vpp, DCV;


#endif
/******************************** END OF FILE *********************************/