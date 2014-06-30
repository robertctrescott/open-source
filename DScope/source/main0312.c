
// File Name: main.c       orig author: bure   Hardware: DS0201V1.1   Version: Ver 1.0


#include "Lcd.h"
#include "HW_V1_Config.h"

#define MAX_IN_BUFFER   48
#define MAX_X_POS       315
#define MAX_Y_POS       238
#define STEP_X_POS      9
#define STEP_Y_POS      14
#define CHARS_X         (MAX_X_POS/STEP_X_POS)
#define CHARS_Y         (MAX_Y_POS/STEP_Y_POS)





static int in_ptr;
static int out_ptr;
static char in_buffer[MAX_IN_BUFFER];
static int  x_pos;
static int  y_pos = MAX_Y_POS-STEP_Y_POS;

static char chars_buffer[CHARS_X*CHARS_Y];
static int chars_buffer_count;


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

void HandleInput()
{
    char ch;
    if (isAvailable()){
        ch = getChar();
        chars_buffer[chars_buffer_count++] = ch;    // buffer is used to replay screen data for scroll
        if (chars_buffer_count >= (CHARS_X*CHARS_Y)) chars_buffer_count = 0;
        switch (ch){
            case '\r': x_pos = 0; ; break;
            case '\n':
                y_pos-=STEP_Y_POS;
                if (y_pos < 0){
                    y_pos =  MAX_Y_POS-STEP_Y_POS;
                    Clear_Screen(BLACK);
                }
                break;
            default:
                Display_Char(x_pos, y_pos, WHITE,PRN, ch);
                x_pos+=STEP_X_POS;
                if (x_pos >= MAX_X_POS){
                    x_pos = 0;
                    y_pos-=STEP_Y_POS;
                    if (y_pos < 0){
                        y_pos =  MAX_Y_POS-STEP_Y_POS;
                        Clear_Screen(BLACK);
                    }
                }
                break;

        }
    }
}


void main(void)
{
    Delay_ms(200);
    GPIO_Configure();


    // setup USART1
    UART1_Init_Advanced(19200,_UART_8_BIT_DATA,_UART_NOPARITY,_UART_ONE_STOPBIT,&_GPIO_MODULE_USART1_PA9_10); // simple uart
    NVIC_IntEnable(IVT_INT_USART1);
    TCIE_USART1_CR1_bit = 0;        // no interrupts with xmit
    UE_bit = 1;                     // enable USART1
    RE_bit = 1;                     // receiver 1 enable
    RXNEIE_USART1_CR1_bit = 1;      // rx interrupts on
    TXEIE_USART1_CR1_bit = 0;
    TE_bit = 1;                     // tx 1 always enabled

    LCD_Initial();
    Clear_Screen(BLACK);
    Display_Str(2, 2, WHITE,PRN, "Terminal rev 1.0");
    Delay_ms(2000);
    Clear_Screen(BLACK);
    
    while (1){
        HandleInput();
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