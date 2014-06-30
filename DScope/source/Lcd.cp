#line 1 "Z:/Robs Folder/DScope/source/Lcd.c"
#line 1 "z:/robs folder/dscope/include/lcd.h"
#line 28 "z:/robs folder/dscope/include/lcd.h"
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
#line 8 "Z:/Robs Folder/DScope/source/Lcd.c"
unsigned const int Char_Dot[760] =
{
 0x0000,0x0000,0x3E00,0x3C00,0x0000,0x3E00,0x3C00,0x0000,
 0x0480,0x0480,0x3FF0,0x0480,0x0480,0x3FF0,0x0480,0x0480,
 0x0000,0x0000,0x0000,0xE000,0x1000,0x0800,0x0800,0x0800,
 0x0C30,0x0C60,0x00C0,0x0180,0x0300,0x0630,0x0C30,0x0000,
 0x0800,0x0800,0x1000,0xE000,0x0000,0x0000,0x0000,0x0000,
 0x0000,0x0000,0x0000,0x3E00,0x3C00,0x0000,0x0000,0x0000,
 0x0000,0x0000,0x0FC0,0x1FE0,0x3030,0x2010,0x0000,0x0000,
 0x0000,0x0000,0x2010,0x3030,0x1FE0,0x0FC0,0x0000,0x0000,
 0x0000,0x1240,0x0A80,0x0700,0x3FE0,0x0700,0x0A80,0x1240,
 0x0000,0x0100,0x0100,0x07C0,0x07C0,0x0100,0x0100,0x0000,
 0x0000,0x0000,0x0000,0x0034,0x0038,0x0000,0x0000,0x0000,
 0x0000,0x0100,0x0100,0x0100,0x0100,0x0100,0x0100,0x0000,
 0x0000,0x0000,0x0000,0x0030,0x0030,0x0000,0x0000,0x0000,
 0x0030,0x0060,0x00C0,0x0180,0x0300,0x0600,0x0C00,0x0000,
 0x1FE0,0x3FF0,0x2090,0x2310,0x2410,0x3FF0,0x1FE0,0x0000,
 0x0000,0x0810,0x1810,0x3FF0,0x3FF0,0x0010,0x0010,0x0000,
 0x1070,0x30F0,0x2190,0x2310,0x2610,0x3830,0x1830,0x0000,
 0x1020,0x3030,0x2210,0x2210,0x2210,0x3FF0,0x1DE0,0x0000,
 0x0300,0x0700,0x0D00,0x1910,0x3FF0,0x3FF0,0x0110,0x0000,
 0x3E20,0x3E30,0x2210,0x2210,0x2310,0x23F0,0x21E0,0x0000,
 0x0FE0,0x1FF0,0x3210,0x2210,0x2210,0x03F0,0x01E0,0x0000,
 0x3000,0x3000,0x20F0,0x21F0,0x2300,0x3E00,0x3C00,0x0000,
 0x1DE0,0x3FF0,0x2210,0x2210,0x2210,0x3FF0,0x1DE0,0x0000,
 0x1C00,0x3E10,0x2210,0x2210,0x2230,0x3FE0,0x1FC0,0x0000,
 0x0000,0x0000,0x0000,0x0C60,0x0C60,0x0000,0x0000,0x0000,
 0x0000,0x0000,0x0000,0x0334,0x0338,0x0000,0x0000,0x0000,
 0x0000,0x0100,0x0380,0x06C0,0x0C60,0x1830,0x1010,0x0000,
 0x0240,0x0240,0x0240,0x0240,0x0240,0x0240,0x0240,0x0000,
 0x0000,0x1010,0x1830,0x0C60,0x06C0,0x0380,0x0100,0x0000,
 0x1800,0x3800,0x2000,0x23B0,0x27B0,0x3C00,0x1800,0x0000,
 0x0FC0,0x1020,0x2790,0x2490,0x27D0,0x1050,0x0F80,0x0000,
 0x07F0,0x0FF0,0x1900,0x3100,0x1900,0x0FF0,0x07F0,0x0000,
 0x2010,0x3FF0,0x3FF0,0x2210,0x2210,0x3FF0,0x1DE0,0x0000,
 0x0FC0,0x1FE0,0x3030,0x2010,0x2010,0x3030,0x1860,0x0000,
 0x2010,0x3FF0,0x3FF0,0x2010,0x3030,0x1FE0,0x0FC0,0x0000,
 0x2010,0x3FF0,0x3FF0,0x2210,0x2710,0x3030,0x3870,0x0000,
 0x2010,0x3FF0,0x3FF0,0x2210,0x2700,0x3000,0x3800,0x0000,
 0x0FC0,0x1FE0,0x3030,0x2110,0x2110,0x31E0,0x19F0,0x0000,
 0x3FF0,0x3FF0,0x0200,0x0200,0x0200,0x3FF0,0x3FF0,0x0000,
 0x0000,0x0000,0x2010,0x3FF0,0x3FF0,0x2010,0x0000,0x0000,
 0x00E0,0x00F0,0x0010,0x2010,0x3FF0,0x3FE0,0x2000,0x0000,
 0x2010,0x3FF0,0x3FF0,0x0300,0x0F00,0x3CF0,0x3070,0x0000,
 0x2010,0x3FF0,0x3FF0,0x2010,0x0010,0x0030,0x0030,0x0000,
 0x3FF0,0x3FF0,0x1C00,0x0E00,0x1C00,0x3FF0,0x3FF0,0x0000,
 0x3FF0,0x3FF0,0x1C00,0x0E00,0x0700,0x3FF0,0x3FF0,0x0000,
 0x0FC0,0x1FE0,0x3030,0x2010,0x3030,0x1FE0,0x0FC0,0x0000,
 0x2010,0x3FF0,0x3FF0,0x2210,0x2200,0x3E00,0x1C00,0x0000,
 0x1FE0,0x3FF0,0x2010,0x2070,0x2030,0x3FF8,0x1FE8,0x0000,
 0x2010,0x3FF0,0x3FF0,0x2200,0x2300,0x3FF0,0x1CF0,0x0000,
 0x1860,0x3C70,0x2610,0x2210,0x2310,0x39F0,0x18E0,0x0000,
 0x0000,0x3800,0x3010,0x3FF0,0x3FF0,0x3010,0x3800,0x0000,
 0x3FE0,0x3FF0,0x0010,0x0010,0x0010,0x3FF0,0x3FE0,0x0000,
 0x3F80,0x3FC0,0x0060,0x0030,0x0060,0x3FC0,0x3F80,0x0000,
 0x3FC0,0x3FF0,0x0070,0x01C0,0x0070,0x3FF0,0x3FC0,0x0000,
 0x3030,0x3CF0,0x0FC0,0x0300,0x0FC0,0x3CF0,0x3030,0x0000,
 0x0000,0x3C00,0x3E10,0x03F0,0x03F0,0x3E10,0x3C00,0x0000,
 0x3870,0x30F0,0x2190,0x2310,0x2610,0x3C30,0x3870,0x0000,
 0x3FF8,0x3FF8,0x2008,0x2008,0x2008,0x0000,0x0000,0x0000,
 0x0000,0x3800,0x1E00,0x0780,0x01E0,0x0078,0x001C,0x0000,
 0x0000,0x0000,0x0000,0x2008,0x2008,0x2008,0x3FF8,0x3FF8,
 0x0000,0x0C00,0x1800,0x3000,0x1800,0x0C00,0x0000,0x0000,
 0x000C,0x000C,0x000C,0x000C,0x000C,0x000C,0x000C,0x000C,
 0x0000,0x0000,0x3000,0x3800,0x1800,0x0000,0x0000,0x0000,
 0x00E0,0x05F0,0x0510,0x0510,0x07E0,0x03F0,0x0010,0x0000,
 0x2010,0x3FF0,0x3FE0,0x0210,0x0210,0x03F0,0x01E0,0x0000,
 0x03E0,0x07F0,0x0410,0x0410,0x0410,0x0630,0x0220,0x0000,
 0x01E0,0x03F0,0x0610,0x2410,0x3FF0,0x3FF0,0x0010,0x0000,
 0x03E0,0x07F0,0x0510,0x0510,0x0510,0x0730,0x0320,0x0000,
 0x0000,0x0210,0x1FF0,0x3FF0,0x2210,0x3000,0x1800,0x0000,
 0x03C8,0x07EC,0x0424,0x0424,0x03FC,0x07F8,0x0400,0x0000,
 0x2010,0x3FF0,0x3FF0,0x0220,0x0400,0x07F0,0x03F0,0x0000,
 0x0000,0x0000,0x0410,0x37F0,0x37F0,0x0010,0x0000,0x0000,
 0x0000,0x0018,0x001C,0x0404,0x37FC,0x37F8,0x0400,0x0000,
 0x2010,0x3FF0,0x3FF0,0x2180,0x03C0,0x0670,0x0430,0x0000,
 0x0000,0x0000,0x2010,0x3FF0,0x3FF0,0x0010,0x0000,0x0000,
 0x07F0,0x07F0,0x0600,0x03F0,0x0600,0x07F0,0x07F0,0x0000,
 0x0400,0x07F0,0x03F0,0x0400,0x0400,0x07F0,0x03F0,0x0000,
 0x03E0,0x07F0,0x0410,0x0410,0x0410,0x07F0,0x03E0,0x0000,
 0x0404,0x07FC,0x03FC,0x0444,0x0440,0x07C0,0x0380,0x0000,
 0x0380,0x07C0,0x0440,0x0444,0x07FC,0x03FC,0x0404,0x0000,
 0x0410,0x07F0,0x03F0,0x0610,0x0400,0x0600,0x0300,0x0000,
 0x0000,0x0220,0x0730,0x0590,0x0490,0x06F0,0x0260,0x0000,
 0x0400,0x0400,0x1FE0,0x3FF0,0x0410,0x0430,0x0020,0x0000,
 0x07E0,0x07F0,0x0010,0x0010,0x07E0,0x07F0,0x0010,0x0000,
 0x0000,0x07C0,0x07E0,0x0030,0x0030,0x07E0,0x07C0,0x0000,
 0x07E0,0x07F0,0x0030,0x00E0,0x0030,0x07F0,0x07E0,0x0000,
 0x0410,0x0630,0x03E0,0x01C0,0x03E0,0x0630,0x0410,0x0000,
 0x0780,0x07C4,0x0044,0x0044,0x0044,0x07F8,0x07F0,0x0000,
 0x0630,0x0670,0x04D0,0x0590,0x0710,0x0630,0x0430,0x0000,
 0x0780,0x0480,0x3CF0,0x2010,0x2FD0,0x2FD0,0x2FD0,0x2FD0,
 0x2FD0,0x2FD0,0x2FD0,0x2FD0,0x2FD0,0x2FD0,0x2FD0,0x2FD0,
 0x2FD0,0x2FD0,0x2FD0,0x2FD0,0x2FD0,0x2010,0x3FF0,0x0000,
 0x0780,0x0480,0x3CF0,0x2010,0x2010,0x2010,0x2010,0x2010
};

unsigned const long Logo_Dot[512] ={

0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,
0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,

0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,
0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,

};
#line 118 "Z:/Robs Folder/DScope/source/Lcd.c"
void LCD_WR_REG(unsigned int Reg, unsigned int Data)
{
  GPIOE_ODR =Reg;
  BR1_GPIOD_BSRR_bit = 1 ;
  BR5_GPIOD_BSRR_bit = 1 ;
  BS5_GPIOD_BSRR_bit = 1 ;
  BS1_GPIOD_BSRR_bit = 1 ;
  GPIOE_ODR =Data;
  BR5_GPIOD_BSRR_bit = 1 ;
  BS5_GPIOD_BSRR_bit = 1 ;
}
#line 133 "Z:/Robs Folder/DScope/source/Lcd.c"
void LCD_Initial(void)
{

  GPIOE_CRL = GPIOE_CRH = 0x33333333 ;
  BS5_GPIOD_BSRR_bit = 1 ;
  BS4_GPIOD_BSRR_bit = 1 ;
  BS1_GPIOD_BSRR_bit = 1 ;
  BS0_GPIOC_BSRR_bit = 1 ;
 Delay_ms(1);
  BR0_GPIOC_BSRR_bit = 1 ;
 Delay_ms(1);
  BS0_GPIOC_BSRR_bit = 1 ;
 Delay_ms(5);

 LCD_WR_REG(0x00FF, 0x0001);
 LCD_WR_REG(0x00F3, 0x0008);
  GPIOE_ODR =0x00F3;
  BR1_GPIOD_BSRR_bit = 1 ;
  BR5_GPIOD_BSRR_bit = 1 ;
  BS5_GPIOD_BSRR_bit = 1 ;

  BS1_GPIOD_BSRR_bit = 1 ;

 LCD_WR_REG(0x0001, 0x0100);
 LCD_WR_REG(0x0002, 0x0700);
 LCD_WR_REG(0x0003, 0x0030);
 LCD_WR_REG(0x0008, 0x0302);
 LCD_WR_REG(0x0009, 0x0000);
 LCD_WR_REG(0x000A, 0x0000);

 LCD_WR_REG(0x0010, 0x0790);
 LCD_WR_REG(0x0011, 0x0005);
 LCD_WR_REG(0x0012, 0x0000);
 LCD_WR_REG(0x0013, 0x0000);
 Delay_ms(100);
 LCD_WR_REG(0x0010, 0x12B0);
 Delay_ms(50);
 LCD_WR_REG(0x0011, 0x0007);
 Delay_ms(50);
 LCD_WR_REG(0x0012, 0x008C);
 LCD_WR_REG(0x0013, 0x1700);
 LCD_WR_REG(0x0029, 0x001A);
 Delay_ms(50);

 LCD_WR_REG(0x0030, 0x0000);
 LCD_WR_REG(0x0031, 0x0507);
 LCD_WR_REG(0x0032, 0x0003);
 LCD_WR_REG(0x0035, 0x0200);
 LCD_WR_REG(0x0036, 0x0106);
 LCD_WR_REG(0x0037, 0x0000);
 LCD_WR_REG(0x0038, 0x0507);
 LCD_WR_REG(0x0039, 0x0104);
 LCD_WR_REG(0x003C, 0x0200);
 LCD_WR_REG(0x003D, 0x0005);

 LCD_WR_REG(0x0050, 0x0000);
 LCD_WR_REG(0x0051, 0x00EF);
 LCD_WR_REG(0x0052, 0x0000);
 LCD_WR_REG(0x0053, 0x013F);

 LCD_WR_REG(0x0060, 0xA700);
 LCD_WR_REG(0x0061, 0x0001);
 LCD_WR_REG(0x0090, 0x0033);
 LCD_WR_REG(0x0007, 0x0133);
 Delay_ms(50);
}
#line 203 "Z:/Robs Folder/DScope/source/Lcd.c"
void Point_SCR(unsigned int x0, unsigned int y0)
{
 LCD_WR_REG(0x0020,y0);
 LCD_WR_REG(0x0021,x0);
  GPIOE_ODR =0x0022;
  BR1_GPIOD_BSRR_bit = 1 ;
  BR5_GPIOD_BSRR_bit = 1 ;
  BS5_GPIOD_BSRR_bit = 1 ;
  BR5_GPIOD_BSRR_bit = 1 ;
  BS5_GPIOD_BSRR_bit = 1 ;
  BS1_GPIOD_BSRR_bit = 1 ;
}
#line 218 "Z:/Robs Folder/DScope/source/Lcd.c"
void Set_Pixel(unsigned int Color)
{
  GPIOE_ODR =Color;
  BR5_GPIOD_BSRR_bit = 1 ;
  BS5_GPIOD_BSRR_bit = 1 ;
}
#line 228 "Z:/Robs Folder/DScope/source/Lcd.c"
void Clear_Screen(unsigned int Color)
{
 unsigned long i;
 Point_SCR(0, 0);
 for(i=0; i<240*320; ++i)
 Set_Pixel(Color);
}
#line 238 "Z:/Robs Folder/DScope/source/Lcd.c"
void Display_Frame(void)
{
 unsigned int i,j;
 for(i=0; i<320; ++i) {
 Point_SCR(i,0);
 for(j=0; j< 19 -1; ++j) Set_Pixel( 0xFFE0 );
 }
 for(i=0; i<320; ++i) {
 Point_SCR(i, ( 200  + 19 ) +3);
 for(j= ( 200  + 19 ) +3; j<240; ++j) Set_Pixel( 0xFFE0 );
 }
}
#line 253 "Z:/Robs Folder/DScope/source/Lcd.c"
void Display_Grid(void)
{
 unsigned int i,j;
 for(j= 19 ; j<= ( 200  + 19 ) ; j+=25) for(i= 1 ; i< ( 300  + 1 ) +1; ++i){
 Point_SCR(i,j);
 Set_Pixel( 0x738E );
 }
 for(i= 1 ;i<= ( 300  + 1 ) ; i+=25){
 Point_SCR(i, 19 );
 for(j= 19 ; j<= ( 200  + 19 ) ; ++j) Set_Pixel( 0x738E );
 }
 for(i= 1 +5; i< ( 300  + 1 ) ; i+=5){
 Point_SCR(i, 19 +1);
 Set_Pixel( 0x738E );
 Point_SCR(i, ( 200  + 19 ) -1);
 Set_Pixel( 0x738E );
 Point_SCR(i,(( 19 + ( 200  + 19 ) )/2+1));
 Set_Pixel( 0x738E );
 Point_SCR(i,(( 19 + ( 200  + 19 ) )/2-1));
 Set_Pixel( 0x738E );
 }
 for(j= 19 +5; j< ( 200  + 19 ) ; j+=5){
 Point_SCR( 1 +1,j);
 Set_Pixel( 0x738E );
 Point_SCR( ( 300  + 1 ) -1,j);
 Set_Pixel( 0x738E );
 Point_SCR((( 1 + ( 300  + 1 ) )/2+1),j);
 Set_Pixel( 0x738E );
 Point_SCR((( 1 + ( 300  + 1 ) )/2-1),j);
 Set_Pixel( 0x738E );
 }
}
#line 290 "Z:/Robs Folder/DScope/source/Lcd.c"
void Display_Char(unsigned int x0, unsigned int y0, unsigned int Color, unsigned char Mode, char s)
{
 signed int i, j, b;

 Point_SCR(x0, y0);
 for (j=0; j<14;++j){
 if(Mode==0) Set_Pixel( 0x0000 );
 if(Mode==1) Set_Pixel(Color);
 }

 x0++;
 if (s!=0) {
 unsigned const int *scanline=Char_Dot+((s-0x22)*8);
 for(i=0;i<8;++i){
 Point_SCR(x0+i, y0);
 if((s==0x20)||(s==0x21)) b=0x0000;
 else b=scanline[i];
 if((s==0x21)&&(i==4)) break;
 for(j=0;j<14;++j){
 if(b&4) {
 if(Mode==0) Set_Pixel(Color);
 if(Mode==1) Set_Pixel( 0x0000 );
 if(Mode==2) Set_Pixel(Color);
 if(Mode==3) Set_Pixel( 0x0000 );
 } else {
 if(Mode==0) Set_Pixel( 0x0000 );
 if(Mode==1) Set_Pixel(Color);
 if(Mode==2) Set_Pixel( 0x0000 );
 if(Mode==3) Set_Pixel(Color);
 }
 b>>=1;
 }
 }
 if(s==0x21) x0 +=4;
 else x0 += 8;
 }
}
#line 331 "Z:/Robs Folder/DScope/source/Lcd.c"
void Display_Str(unsigned int x0, unsigned int y0, unsigned int Color, unsigned char Mode, unsigned const char *s)
{
 signed int i, j, b;
 Point_SCR(x0, y0);
 for (j=0; j<14;++j){
 if(Mode==0) Set_Pixel( 0x0000 );
 if(Mode==1) Set_Pixel(Color);
 }
 x0++;
 while (*s!=0) {
 unsigned const int *scanline=Char_Dot+((*s-0x22)*8);
 for(i=0;i<8;++i){
 Point_SCR(x0+i, y0);
 if((*s==0x20)||(*s==0x21)) b=0x0000;
 else b=scanline[i];
 if((*s==0x21)&&(i==4)) break;
 for(j=0;j<14;++j){
 if(b&4) {
 if(Mode==0) Set_Pixel(Color);
 if(Mode==1) Set_Pixel( 0x0000 );
 if(Mode==2) Set_Pixel(Color);
 if(Mode==3) Set_Pixel( 0x0000 );
 } else {
 if(Mode==0) Set_Pixel( 0x0000 );
 if(Mode==1) Set_Pixel(Color);
 if(Mode==2) Set_Pixel( 0x0000 );
 if(Mode==3) Set_Pixel(Color);
 }
 b>>=1;
 }
 }
 if(*s==0x21) x0 +=4;
 else x0 += 8;
 ++s;
 }
}
#line 370 "Z:/Robs Folder/DScope/source/Lcd.c"
void Display_Logo(unsigned int Dot_x, unsigned int Dot_y)
{
 unsigned int i, j, k, Color; long b;
 for (i=0; i<256;++i)
 {
 Point_SCR(Dot_x+i, Dot_y);
 for (j=0; j<2;++j)
 {
 b=Logo_Dot[(i*2)+j];
 for (k=0;k<32;++k)
 {
 if(b&0x80000000)
 {
 Color=0x07E0;
 }
 else Color=0;
 Set_Pixel(Color);
 b <<=1;
 }
 }
 }

 for(i=3; i<317; ++i)
 {
 Point_SCR(i, 3);
 Set_Pixel(0xFFFF);
 Point_SCR(i, 236);
 Set_Pixel(0xFFFF);
 }

 Point_SCR(0, 0);
 for(j=0; j<240; ++j) Set_Pixel(0xFFFF);
 Point_SCR(3, 3);
 for(j=3; j<237; ++j) Set_Pixel(0xFFFF);
 Point_SCR(316, 3);
 for(j=3; j<237; ++j) Set_Pixel(0xFFFF);
 Point_SCR(319, 0);
 for(j=0; j<240; ++j) Set_Pixel(0xFFFF);

}
