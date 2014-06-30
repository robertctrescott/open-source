#line 1 "Z:/Robs Folder/DScope/source/main.c"
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
#line 25 "Z:/Robs Folder/DScope/source/main.c"
static unsigned int in_ptr;
static unsigned int out_ptr;
static char in_buffer[ 128 ];
static int x_pos = 1;
static int y_pos =  238 - 14 ;

static char cur_key_press;
unsigned char Key_Wait_Counter;
unsigned char Key_Repeat_Counter;

bit b1ms;
bit b20ms;
bit bPrompt;

char val_tab[ 12 ] = {' ','0','1','2','3','4','5','6','7','8','9','.'};
unsigned short in_value[ 8 ] = {0,0,0,0,0,0,0,0};
unsigned short in_value_index = 0;

void String2Send(void)
{
 short x;
 char cByte;

 for (x=0; x< 8 ; x++){
 cByte = val_tab[in_value[x]];
 if (cByte != ' '){
 while (!TXE_USART1_SR_bit);
 USART1_DR = (unsigned int) cByte & 0x00ff;
 Delay_ms(1);
 }
 }
 cByte = '\r';
 USART1_DR = (unsigned int) cByte & 0x00ff;
}

char isAvailable()
{
 return (in_ptr != out_ptr);
}

char getChar()
{
 char ch;
 ch = in_buffer[out_ptr++];
 if (out_ptr >=  128 ) out_ptr = 0;
 return ch;
}

void ClearNextTextLine(int y_cur_pos, unsigned int Color)
{
 unsigned int i,j;

 if (y_cur_pos- 14  >= 0){
 for(i=0; i<320; ++i) {
 Point_SCR(i,y_cur_pos- 14 );
 for(j=y_cur_pos- 14 ; j<y_cur_pos; ++j)
 Set_Pixel(Color);
 }
 }
}

void Handle_UART_Input()
{
 char ch;

 if (isAvailable()){
 bPrompt = 0;
 ch = getChar();
 switch (ch){
 case 0x1B:
 x_pos = 1;
 y_pos =  238 - 14 ;
 Clear_Screen( 0x0000 );
 break;
 case '\r': x_pos = 1; break;
 case '\n':
 ClearNextTextLine(y_pos,  0x0000 );
 y_pos-= 14 ;
 if (y_pos < 0){
 y_pos =  238 - 14 ;
 }
 break;
 default:
 Display_Char(x_pos, y_pos,  0xFFFF , 0 , ch);
 x_pos+= 9 ;
 if (x_pos >=  315 ){
 x_pos = 1;
 ClearNextTextLine(y_pos,  0x0000 );
 y_pos-= 14 ;
 if (y_pos < 0){
 y_pos =  238 - 14 ;
 }
 }
 break;
 }
 }
}

void HandleKeyPress(void)
{
 static int prompt_count;

 cur_key_press = KeyScan();
 switch (cur_key_press){
 case  0 :
 if (bPrompt){
 if (++prompt_count==10){
 Display_Char(x_pos, y_pos,  0xFFFF , 0 , '_');
 } else if (prompt_count==20){
 prompt_count = 0;
 Display_Char(x_pos, y_pos,  0xFFFF , 0 , val_tab[in_value[in_value_index]]);
 }
 }
 break;

 case  1 :
 x_pos = 1;
 y_pos =  238 - 14 ;
 Clear_Screen( 0x0000 );
 break;

 case  2 :
 String2Send();
 ClearNextTextLine(y_pos+ 14 ,  0x0000 );
 bPrompt = 0;
 for (in_value_index=0; in_value_index< 8 ; in_value_index++)
 in_value[in_value_index] = 0;
 in_value_index = 0;
 break;

 case  3 :
 bPrompt = 1;
 if (in_value[in_value_index]< 12 -1) in_value[in_value_index]++;
 else in_value[in_value_index] = 0;
 Display_Char(x_pos, y_pos,  0xFFFF , 0 , val_tab[in_value[in_value_index]]);
 break;

 case  4 :
 bPrompt = 1;
 if (in_value[in_value_index]>0) in_value[in_value_index]--;
 else in_value[in_value_index] =  12 -1;
 Display_Char(x_pos, y_pos,  0xFFFF , 0 , val_tab[in_value[in_value_index]]);
 break;

 case  5 :
 bPrompt = 1;
 if (in_value_index>0){
 if (in_value[in_value_index] == 0){
 Display_Char(x_pos, y_pos,  0xFFFF , 0 , ' ');
 } else {
 Display_Char(x_pos, y_pos,  0xFFFF , 0 , val_tab[in_value[in_value_index]]);
 }
 in_value_index--;
 x_pos-= 9 ;
 Display_Char(x_pos, y_pos,  0xFFFF , 0 , val_tab[in_value[in_value_index]]);
 }
 break;

 case  6 :
 bPrompt = 1;
 if (in_value[in_value_index] == 0) in_value[in_value_index] = 1;
 if (in_value_index< 8 ){
 Display_Char(x_pos, y_pos,  0xFFFF , 0 , val_tab[in_value[in_value_index]]);
 in_value_index++;
 x_pos+= 9 ;
 Display_Char(x_pos, y_pos,  0xFFFF , 0 , val_tab[in_value[in_value_index]]);
 }
 break;
 }
}



void main(void)
{
 int i;

 Delay_ms(200);
 GPIO_Configure();
 InitUART1();
 InitTimers();
 LCD_Initial();
 Clear_Screen( 0x0000 );
 Display_Str(2, 2,  0xFFFF , 0 , "Terminal rev 1.0");
 Delay_ms(2000);
 Clear_Screen( 0x0000 );

 while (1){
 Handle_UART_Input();
 if (b20ms){
 b20ms = 0;
 HandleKeyPress();
 }
 }
}





void Timer2_interrupt() iv IVT_INT_TIM2
{
 static short count20;

 TIM2_SR.UIF = 0;
 b1ms = 1;

 if (count20<20) count20++;
 else {
 count20 = 0;
 b20ms = 1;
 }
}

void Usart1_ISR() iv IVT_INT_USART1 ics ICS_AUTO
{
 if (TXE_USART1_SR_bit == 1 && TXEIE_USART1_CR1_bit == 1){
 USART1_SR = 0;
 USART1_DR = 0;
 } else if (RXNE_USART1_SR_bit == 1 && RXNEIE_USART1_CR1_bit == 1){
 in_buffer[in_ptr++] = (char)((unsigned int)(USART1_DR & (unsigned int)0x00ff));
 if (in_ptr>= 128 ) in_ptr = 0;
 }
}
