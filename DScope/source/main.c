//
// main.c       orig author: bure   Hardware: DS0201V1.1   Version: Ver 1.0
// Terminal Emulator conversion
// 03/13/2013 - rev 1.0 - original code for mikroC Pro for ARM STM32F103VBT6 -rct
//


#include "Lcd.h"
#include "HW_V1_Config.h"
#include "function.h"

#define MAX_IN_BUFFER   128
#define MAX_X_POS       315
#define MAX_Y_POS       238
#define STEP_X_POS      9
#define STEP_Y_POS      14
#define CHARS_X         (MAX_X_POS/STEP_X_POS)
#define CHARS_Y         (MAX_Y_POS/STEP_Y_POS)

#define MAX_KEY_IN_CHARS    8
#define MAX_KEY_IN_TABLE    12



static unsigned int in_ptr;
static unsigned int out_ptr;
static char in_buffer[MAX_IN_BUFFER];
static int  x_pos = 1;
static int  y_pos = MAX_Y_POS-STEP_Y_POS;

static char cur_key_press;
unsigned char Key_Wait_Counter;
unsigned char Key_Repeat_Counter;

bit     b1ms;
bit     b20ms;
bit     bPrompt;

char val_tab[MAX_KEY_IN_TABLE] = {' ','0','1','2','3','4','5','6','7','8','9','.'};
unsigned short in_value[MAX_KEY_IN_CHARS] = {0,0,0,0,0,0,0,0};   // each of these elements can be 0x00-0x0E
unsigned short in_value_index = 0;  //   --------^

void String2Send(void)
{
    short x;
    char cByte;

    for (x=0; x<MAX_KEY_IN_CHARS; x++){
        cByte = val_tab[in_value[x]];
        if (cByte != ' '){
            while (!TXE_USART1_SR_bit);                 // sit here and wait until tx is ready
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
    char    ch;
    ch = in_buffer[out_ptr++];
    if (out_ptr >= MAX_IN_BUFFER) out_ptr = 0;
    return ch;
}

void ClearNextTextLine(int y_cur_pos, unsigned int Color)
{
    unsigned int i,j;
    
    if (y_cur_pos-STEP_Y_POS >= 0){                                         // make sure we only use positive values
        for(i=0; i<320; ++i) {                                              // 320 pixels = full horizontal scan line
            Point_SCR(i,y_cur_pos-STEP_Y_POS);                              // set screen addresses
            for(j=y_cur_pos-STEP_Y_POS; j<y_cur_pos; ++j)                   // rows are 1 character tall = 14
                Set_Pixel(Color);                                           // make the pixels black
        }
    }
}

void Handle_UART_Input()
{
    char ch;
    
    if (isAvailable()){
        bPrompt = 0;                                            // cancel prompt signal
        ch = getChar();
        switch (ch){
            case 0x1B:                                          // ESC signals screen clear
                x_pos = 1;
                y_pos =  MAX_Y_POS-STEP_Y_POS;                  // go back to top
                Clear_Screen(BLACK);
                break;
            case '\r': x_pos = 1; break;                        // <CR> just go back to line start
            case '\n':                                          // <LF> line feed
                ClearNextTextLine(y_pos, BLACK);                // make sure the next line is empty
                y_pos-=STEP_Y_POS;                              // move to next text row (y is reversed!)
                if (y_pos < 0){                                 // if we are at the Y bottom
                    y_pos =  MAX_Y_POS-STEP_Y_POS;              // go back to top
                }
                break;
            default:
                Display_Char(x_pos, y_pos, WHITE,PRN, ch);      // show the current displayable character
                x_pos+=STEP_X_POS;                              // move to next character position
                if (x_pos >= MAX_X_POS){                        // if we hit last column then wrap
                    x_pos = 1;                                  // move x to starting column
                    ClearNextTextLine(y_pos, BLACK);            // make sure the next line is empty
                    y_pos-=STEP_Y_POS;                          // move to next text row (y is reversed!)
                    if (y_pos < 0){                             // if we are at the Y bottom
                        y_pos =  MAX_Y_POS-STEP_Y_POS;          // go back to top
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
        case KEYCODE_VOID:                              // no keys are pressed
            if (bPrompt){                               // but a good place to handle prompt feature
                if (++prompt_count==10){
                    Display_Char(x_pos, y_pos, WHITE,PRN, '_');     // show '_'
                } else if (prompt_count==20){
                    prompt_count = 0;
                    Display_Char(x_pos, y_pos, WHITE,PRN, val_tab[in_value[in_value_index]]);   // now show char
                }
            }
            break;
        
        case KEYCODE_PLAY:                              // this is the A button
            x_pos = 1;
            y_pos =  MAX_Y_POS-STEP_Y_POS;              // go back to top
            Clear_Screen(BLACK);
            break;
        
        case KEYCODE_MANU:
            String2Send();
            ClearNextTextLine(y_pos+STEP_Y_POS, BLACK);            // make sure the next line is empty
            bPrompt = 0;
            for (in_value_index=0; in_value_index<MAX_KEY_IN_CHARS; in_value_index++)
                in_value[in_value_index] = 0;
            in_value_index = 0;
            break;    // this is the OK button
        
        case KEYCODE_UP:
            bPrompt = 1;
            if (in_value[in_value_index]<MAX_KEY_IN_TABLE-1) in_value[in_value_index]++;
            else in_value[in_value_index] = 0;
            Display_Char(x_pos, y_pos, WHITE,PRN, val_tab[in_value[in_value_index]]);
            break;
        
        case KEYCODE_DOWN:
            bPrompt = 1;
            if (in_value[in_value_index]>0) in_value[in_value_index]--;
            else in_value[in_value_index] = MAX_KEY_IN_TABLE-1;
            Display_Char(x_pos, y_pos, WHITE,PRN, val_tab[in_value[in_value_index]]);
            break;

        case KEYCODE_LEFT:
            bPrompt = 1;
            if (in_value_index>0){
                if (in_value[in_value_index] == 0){
                    Display_Char(x_pos, y_pos, WHITE,PRN, ' ');
                } else {
                    Display_Char(x_pos, y_pos, WHITE,PRN, val_tab[in_value[in_value_index]]);
                }
                in_value_index--;
                x_pos-=STEP_X_POS;
                Display_Char(x_pos, y_pos, WHITE,PRN, val_tab[in_value[in_value_index]]);
            }
            break;

        case KEYCODE_RIGHT:
            bPrompt = 1;
            if (in_value[in_value_index] == 0) in_value[in_value_index] = 1;
            if (in_value_index<MAX_KEY_IN_CHARS){
                Display_Char(x_pos, y_pos, WHITE,PRN, val_tab[in_value[in_value_index]]);
                in_value_index++;
                x_pos+=STEP_X_POS;
                Display_Char(x_pos, y_pos, WHITE,PRN, val_tab[in_value[in_value_index]]);
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
    Clear_Screen(BLACK);
    Display_Str(2, 2, WHITE,PRN, "Terminal rev 1.0");
    Delay_ms(2000);
    Clear_Screen(BLACK);
    
    while (1){
        Handle_UART_Input();
        if (b20ms){
            b20ms = 0;
            HandleKeyPress();
        }
    }
}




// kick off timer2 every 1mS
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
    if (TXE_USART1_SR_bit == 1 && TXEIE_USART1_CR1_bit == 1){     // make sure the high speed modem is ready to transmit
        USART1_SR = 0;
        USART1_DR = 0;
    } else if (RXNE_USART1_SR_bit == 1 && RXNEIE_USART1_CR1_bit == 1){
        in_buffer[in_ptr++] = (char)((unsigned int)(USART1_DR & (unsigned int)0x00ff));
        if (in_ptr>=MAX_IN_BUFFER) in_ptr = 0;
    }
}