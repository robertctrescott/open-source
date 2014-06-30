_String2Send:
;main.c,43 :: 		void String2Send(void)
SUB	SP, SP, #4
;main.c,48 :: 		for (x=0; x<MAX_KEY_IN_CHARS; x++){
; x start address is: 12 (R3)
MOVS	R3, #0
SXTB	R3, R3
; x end address is: 12 (R3)
L_String2Send0:
; x start address is: 12 (R3)
CMP	R3, #8
IT	GE
BGE	L_String2Send1
;main.c,49 :: 		cByte = val_tab[in_value[x]];
MOVW	R0, #lo_addr(_in_value+0)
MOVT	R0, #hi_addr(_in_value+0)
ADDS	R0, R0, R3
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_val_tab+0)
MOVT	R0, #hi_addr(_val_tab+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
; cByte start address is: 8 (R2)
UXTB	R2, R0
;main.c,50 :: 		if (cByte != ' '){
CMP	R0, #32
IT	EQ
BEQ	L__String2Send68
; cByte end address is: 8 (R2)
; x end address is: 12 (R3)
;main.c,51 :: 		while (!TXE_USART1_SR_bit);                 // sit here and wait until tx is ready
L_String2Send4:
; cByte start address is: 8 (R2)
; x start address is: 12 (R3)
MOVW	R1, #lo_addr(TXE_USART1_SR_bit+0)
MOVT	R1, #hi_addr(TXE_USART1_SR_bit+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_String2Send5
IT	AL
BAL	L_String2Send4
L_String2Send5:
;main.c,52 :: 		USART1_DR = (unsigned int) cByte & 0x00ff;
UXTB	R0, R2
; cByte end address is: 8 (R2)
AND	R1, R0, #255
UXTH	R1, R1
MOVW	R0, #lo_addr(USART1_DR+0)
MOVT	R0, #hi_addr(USART1_DR+0)
STR	R1, [R0, #0]
;main.c,53 :: 		Delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_String2Send6:
SUBS	R7, R7, #1
BNE	L_String2Send6
NOP
NOP
NOP
; x end address is: 12 (R3)
SXTB	R1, R3
;main.c,54 :: 		}
IT	AL
BAL	L_String2Send3
L__String2Send68:
;main.c,50 :: 		if (cByte != ' '){
SXTB	R1, R3
;main.c,54 :: 		}
L_String2Send3:
;main.c,48 :: 		for (x=0; x<MAX_KEY_IN_CHARS; x++){
; x start address is: 4 (R1)
ADDS	R0, R1, #1
; x end address is: 4 (R1)
; x start address is: 12 (R3)
SXTB	R3, R0
;main.c,55 :: 		}
; x end address is: 12 (R3)
IT	AL
BAL	L_String2Send0
L_String2Send1:
;main.c,57 :: 		USART1_DR = (unsigned int) cByte & 0x00ff;
MOVW	R1, #13
MOVW	R0, #lo_addr(USART1_DR+0)
MOVT	R0, #hi_addr(USART1_DR+0)
STR	R1, [R0, #0]
;main.c,58 :: 		}
L_end_String2Send:
ADD	SP, SP, #4
BX	LR
; end of _String2Send
_isAvailable:
;main.c,60 :: 		char isAvailable()
SUB	SP, SP, #4
;main.c,62 :: 		return (in_ptr != out_ptr);
MOVW	R0, #lo_addr(main_out_ptr+0)
MOVT	R0, #hi_addr(main_out_ptr+0)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(main_in_ptr+0)
MOVT	R0, #hi_addr(main_in_ptr+0)
LDRH	R0, [R0, #0]
CMP	R0, R1
MOVW	R0, #0
BEQ	L__isAvailable77
MOVS	R0, #1
L__isAvailable77:
;main.c,63 :: 		}
L_end_isAvailable:
ADD	SP, SP, #4
BX	LR
; end of _isAvailable
_getChar:
;main.c,65 :: 		char getChar()
SUB	SP, SP, #4
;main.c,68 :: 		ch = in_buffer[out_ptr++];
MOVW	R2, #lo_addr(main_out_ptr+0)
MOVT	R2, #hi_addr(main_out_ptr+0)
LDRH	R1, [R2, #0]
MOVW	R0, #lo_addr(main_in_buffer+0)
MOVT	R0, #hi_addr(main_in_buffer+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
; ch start address is: 12 (R3)
UXTB	R3, R0
MOV	R0, R2
LDRH	R0, [R0, #0]
ADDS	R0, R0, #1
UXTH	R0, R0
STRH	R0, [R2, #0]
;main.c,69 :: 		if (out_ptr >= MAX_IN_BUFFER) out_ptr = 0;
CMP	R0, #128
IT	CC
BCC	L_getChar8
MOVS	R1, #0
MOVW	R0, #lo_addr(main_out_ptr+0)
MOVT	R0, #hi_addr(main_out_ptr+0)
STRH	R1, [R0, #0]
L_getChar8:
;main.c,70 :: 		return ch;
UXTB	R0, R3
; ch end address is: 12 (R3)
;main.c,71 :: 		}
L_end_getChar:
ADD	SP, SP, #4
BX	LR
; end of _getChar
_ClearNextTextLine:
;main.c,73 :: 		void ClearNextTextLine(int y_cur_pos, unsigned int Color)
SUB	SP, SP, #16
STR	LR, [SP, #0]
STRH	R0, [SP, #8]
STRH	R1, [SP, #12]
;main.c,77 :: 		if (y_cur_pos-STEP_Y_POS >= 0){                                         // make sure we only use positive values
LDRSH	R2, [SP, #8]
SUBS	R2, #14
SXTH	R2, R2
CMP	R2, #0
IT	LT
BLT	L_ClearNextTextLine9
;main.c,78 :: 		for(i=0; i<320; ++i) {                                              // 320 pixels = full horizontal scan line
MOVS	R2, #0
STRH	R2, [SP, #4]
L_ClearNextTextLine10:
LDRH	R2, [SP, #4]
CMP	R2, #320
IT	CS
BCS	L_ClearNextTextLine11
;main.c,79 :: 		Point_SCR(i,y_cur_pos-STEP_Y_POS);                              // set screen addresses
LDRSH	R2, [SP, #8]
SUBS	R2, #14
UXTH	R1, R2
LDRH	R0, [SP, #4]
BL	_Point_SCR+0
;main.c,80 :: 		for(j=y_cur_pos-STEP_Y_POS; j<y_cur_pos; ++j)                   // rows are 1 character tall = 14
LDRSH	R2, [SP, #8]
SUBS	R2, #14
STRH	R2, [SP, #6]
L_ClearNextTextLine13:
LDRSH	R3, [SP, #8]
LDRH	R2, [SP, #6]
CMP	R2, R3
IT	CS
BCS	L_ClearNextTextLine14
;main.c,81 :: 		Set_Pixel(Color);                                           // make the pixels black
LDRH	R0, [SP, #12]
BL	_Set_Pixel+0
;main.c,80 :: 		for(j=y_cur_pos-STEP_Y_POS; j<y_cur_pos; ++j)                   // rows are 1 character tall = 14
LDRH	R2, [SP, #6]
ADDS	R2, R2, #1
STRH	R2, [SP, #6]
;main.c,81 :: 		Set_Pixel(Color);                                           // make the pixels black
IT	AL
BAL	L_ClearNextTextLine13
L_ClearNextTextLine14:
;main.c,78 :: 		for(i=0; i<320; ++i) {                                              // 320 pixels = full horizontal scan line
LDRH	R2, [SP, #4]
ADDS	R2, R2, #1
STRH	R2, [SP, #4]
;main.c,82 :: 		}
IT	AL
BAL	L_ClearNextTextLine10
L_ClearNextTextLine11:
;main.c,83 :: 		}
L_ClearNextTextLine9:
;main.c,84 :: 		}
L_end_ClearNextTextLine:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _ClearNextTextLine
_Handle_UART_Input:
;main.c,86 :: 		void Handle_UART_Input()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;main.c,90 :: 		if (isAvailable()){
BL	_isAvailable+0
CMP	R0, #0
IT	EQ
BEQ	L_Handle_UART_Input16
;main.c,91 :: 		bPrompt = 0;                                            // cancel prompt signal
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_bPrompt+0)
MOVT	R0, #hi_addr(_bPrompt+0)
STR	R1, [R0, #0]
;main.c,92 :: 		ch = getChar();
BL	_getChar+0
;main.c,93 :: 		switch (ch){
IT	AL
BAL	L_Handle_UART_Input17
;main.c,94 :: 		case 0x1B:                                          // ESC signals screen clear
L_Handle_UART_Input19:
;main.c,95 :: 		x_pos = 1;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(main_x_pos+0)
MOVT	R0, #hi_addr(main_x_pos+0)
STRH	R1, [R0, #0]
;main.c,96 :: 		y_pos =  MAX_Y_POS-STEP_Y_POS;                  // go back to top
MOVS	R1, #224
SXTH	R1, R1
MOVW	R0, #lo_addr(main_y_pos+0)
MOVT	R0, #hi_addr(main_y_pos+0)
STRH	R1, [R0, #0]
;main.c,97 :: 		Clear_Screen(BLACK);
MOVS	R0, #0
BL	_Clear_Screen+0
;main.c,98 :: 		break;
IT	AL
BAL	L_Handle_UART_Input18
;main.c,99 :: 		case '\r': x_pos = 1; break;                        // <CR> just go back to line start
L_Handle_UART_Input20:
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(main_x_pos+0)
MOVT	R0, #hi_addr(main_x_pos+0)
STRH	R1, [R0, #0]
IT	AL
BAL	L_Handle_UART_Input18
;main.c,100 :: 		case '\n':                                          // <LF> line feed
L_Handle_UART_Input21:
;main.c,101 :: 		ClearNextTextLine(y_pos, BLACK);                // make sure the next line is empty
MOVW	R0, #lo_addr(main_y_pos+0)
MOVT	R0, #hi_addr(main_y_pos+0)
LDRSH	R0, [R0, #0]
MOVS	R1, #0
BL	_ClearNextTextLine+0
;main.c,102 :: 		y_pos-=STEP_Y_POS;                              // move to next text row (y is reversed!)
MOVW	R1, #lo_addr(main_y_pos+0)
MOVT	R1, #hi_addr(main_y_pos+0)
LDRSH	R0, [R1, #0]
SUBS	R0, #14
SXTH	R0, R0
STRH	R0, [R1, #0]
;main.c,103 :: 		if (y_pos < 0){                                 // if we are at the Y bottom
CMP	R0, #0
IT	GE
BGE	L_Handle_UART_Input22
;main.c,104 :: 		y_pos =  MAX_Y_POS-STEP_Y_POS;              // go back to top
MOVS	R1, #224
SXTH	R1, R1
MOVW	R0, #lo_addr(main_y_pos+0)
MOVT	R0, #hi_addr(main_y_pos+0)
STRH	R1, [R0, #0]
;main.c,105 :: 		}
L_Handle_UART_Input22:
;main.c,106 :: 		break;
IT	AL
BAL	L_Handle_UART_Input18
;main.c,107 :: 		default:
L_Handle_UART_Input23:
;main.c,108 :: 		Display_Char(x_pos, y_pos, WHITE,PRN, ch);      // show the current displayable character
UXTB	R2, R0
MOVW	R0, #lo_addr(main_y_pos+0)
MOVT	R0, #hi_addr(main_y_pos+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(main_x_pos+0)
MOVT	R0, #hi_addr(main_x_pos+0)
LDRSH	R0, [R0, #0]
PUSH	(R2)
MOVS	R3, #0
MOVW	R2, #65535
BL	_Display_Char+0
ADD	SP, SP, #4
;main.c,109 :: 		x_pos+=STEP_X_POS;                              // move to next character position
MOVW	R2, #lo_addr(main_x_pos+0)
MOVT	R2, #hi_addr(main_x_pos+0)
LDRSH	R0, [R2, #0]
ADDW	R1, R0, #9
SXTH	R1, R1
STRH	R1, [R2, #0]
;main.c,110 :: 		if (x_pos >= MAX_X_POS){                        // if we hit last column then wrap
MOVW	R0, #315
CMP	R1, R0
IT	LT
BLT	L_Handle_UART_Input24
;main.c,111 :: 		x_pos = 1;                                  // move x to starting column
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(main_x_pos+0)
MOVT	R0, #hi_addr(main_x_pos+0)
STRH	R1, [R0, #0]
;main.c,112 :: 		ClearNextTextLine(y_pos, BLACK);            // make sure the next line is empty
MOVW	R0, #lo_addr(main_y_pos+0)
MOVT	R0, #hi_addr(main_y_pos+0)
LDRSH	R0, [R0, #0]
MOVS	R1, #0
BL	_ClearNextTextLine+0
;main.c,113 :: 		y_pos-=STEP_Y_POS;                          // move to next text row (y is reversed!)
MOVW	R1, #lo_addr(main_y_pos+0)
MOVT	R1, #hi_addr(main_y_pos+0)
LDRSH	R0, [R1, #0]
SUBS	R0, #14
SXTH	R0, R0
STRH	R0, [R1, #0]
;main.c,114 :: 		if (y_pos < 0){                             // if we are at the Y bottom
CMP	R0, #0
IT	GE
BGE	L_Handle_UART_Input25
;main.c,115 :: 		y_pos =  MAX_Y_POS-STEP_Y_POS;          // go back to top
MOVS	R1, #224
SXTH	R1, R1
MOVW	R0, #lo_addr(main_y_pos+0)
MOVT	R0, #hi_addr(main_y_pos+0)
STRH	R1, [R0, #0]
;main.c,116 :: 		}
L_Handle_UART_Input25:
;main.c,117 :: 		}
L_Handle_UART_Input24:
;main.c,118 :: 		break;
IT	AL
BAL	L_Handle_UART_Input18
;main.c,119 :: 		}
L_Handle_UART_Input17:
CMP	R0, #27
IT	EQ
BEQ	L_Handle_UART_Input19
CMP	R0, #13
IT	EQ
BEQ	L_Handle_UART_Input20
CMP	R0, #10
IT	EQ
BEQ	L_Handle_UART_Input21
IT	AL
BAL	L_Handle_UART_Input23
L_Handle_UART_Input18:
;main.c,120 :: 		}
L_Handle_UART_Input16:
;main.c,121 :: 		}
L_end_Handle_UART_Input:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Handle_UART_Input
_HandleKeyPress:
;main.c,123 :: 		void HandleKeyPress(void)
SUB	SP, SP, #12
STR	LR, [SP, #0]
;main.c,127 :: 		cur_key_press = KeyScan();
BL	_KeyScan+0
MOVW	R1, #lo_addr(main_cur_key_press+0)
MOVT	R1, #hi_addr(main_cur_key_press+0)
STRB	R0, [R1, #0]
;main.c,128 :: 		switch (cur_key_press){
IT	AL
BAL	L_HandleKeyPress26
;main.c,129 :: 		case KEYCODE_VOID:                              // no keys are pressed
L_HandleKeyPress28:
;main.c,130 :: 		if (bPrompt){                               // but a good place to handle prompt feature
MOVW	R1, #lo_addr(_bPrompt+0)
MOVT	R1, #hi_addr(_bPrompt+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_HandleKeyPress29
;main.c,131 :: 		if (++prompt_count==10){
MOVW	R1, #lo_addr(HandleKeyPress_prompt_count_L0+0)
MOVT	R1, #hi_addr(HandleKeyPress_prompt_count_L0+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
SXTH	R0, R0
STRH	R0, [R1, #0]
CMP	R0, #10
IT	NE
BNE	L_HandleKeyPress30
;main.c,132 :: 		Display_Char(x_pos, y_pos, WHITE,PRN, '_');     // show '_'
MOVS	R2, #95
MOVW	R0, #lo_addr(main_y_pos+0)
MOVT	R0, #hi_addr(main_y_pos+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(main_x_pos+0)
MOVT	R0, #hi_addr(main_x_pos+0)
LDRSH	R0, [R0, #0]
PUSH	(R2)
MOVS	R3, #0
MOVW	R2, #65535
BL	_Display_Char+0
ADD	SP, SP, #4
;main.c,133 :: 		} else if (prompt_count==20){
IT	AL
BAL	L_HandleKeyPress31
L_HandleKeyPress30:
MOVW	R0, #lo_addr(HandleKeyPress_prompt_count_L0+0)
MOVT	R0, #hi_addr(HandleKeyPress_prompt_count_L0+0)
LDRSH	R0, [R0, #0]
CMP	R0, #20
IT	NE
BNE	L_HandleKeyPress32
;main.c,134 :: 		prompt_count = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(HandleKeyPress_prompt_count_L0+0)
MOVT	R0, #hi_addr(HandleKeyPress_prompt_count_L0+0)
STRH	R1, [R0, #0]
;main.c,135 :: 		Display_Char(x_pos, y_pos, WHITE,PRN, val_tab[in_value[in_value_index]]);   // now show char
MOVW	R0, #lo_addr(_in_value_index+0)
MOVT	R0, #hi_addr(_in_value_index+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_in_value+0)
MOVT	R0, #hi_addr(_in_value+0)
ADDS	R0, R0, R1
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_val_tab+0)
MOVT	R0, #hi_addr(_val_tab+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
UXTB	R2, R0
MOVW	R0, #lo_addr(main_y_pos+0)
MOVT	R0, #hi_addr(main_y_pos+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(main_x_pos+0)
MOVT	R0, #hi_addr(main_x_pos+0)
LDRSH	R0, [R0, #0]
PUSH	(R2)
MOVS	R3, #0
MOVW	R2, #65535
BL	_Display_Char+0
ADD	SP, SP, #4
;main.c,136 :: 		}
L_HandleKeyPress32:
L_HandleKeyPress31:
;main.c,137 :: 		}
L_HandleKeyPress29:
;main.c,138 :: 		break;
IT	AL
BAL	L_HandleKeyPress27
;main.c,140 :: 		case KEYCODE_PLAY:                              // this is the A button
L_HandleKeyPress33:
;main.c,141 :: 		x_pos = 1;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(main_x_pos+0)
MOVT	R0, #hi_addr(main_x_pos+0)
STRH	R1, [R0, #0]
;main.c,142 :: 		y_pos =  MAX_Y_POS-STEP_Y_POS;              // go back to top
MOVS	R1, #224
SXTH	R1, R1
MOVW	R0, #lo_addr(main_y_pos+0)
MOVT	R0, #hi_addr(main_y_pos+0)
STRH	R1, [R0, #0]
;main.c,143 :: 		Clear_Screen(BLACK);
MOVS	R0, #0
BL	_Clear_Screen+0
;main.c,144 :: 		break;
IT	AL
BAL	L_HandleKeyPress27
;main.c,146 :: 		case KEYCODE_MANU:
L_HandleKeyPress34:
;main.c,147 :: 		String2Send();
BL	_String2Send+0
;main.c,148 :: 		ClearNextTextLine(y_pos+STEP_Y_POS, BLACK);            // make sure the next line is empty
MOVW	R0, #lo_addr(main_y_pos+0)
MOVT	R0, #hi_addr(main_y_pos+0)
LDRSH	R0, [R0, #0]
ADDS	R0, #14
MOVS	R1, #0
BL	_ClearNextTextLine+0
;main.c,149 :: 		bPrompt = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_bPrompt+0)
MOVT	R0, #hi_addr(_bPrompt+0)
STR	R1, [R0, #0]
;main.c,150 :: 		for (in_value_index=0; in_value_index<MAX_KEY_IN_CHARS; in_value_index++)
MOVS	R1, #0
MOVW	R0, #lo_addr(_in_value_index+0)
MOVT	R0, #hi_addr(_in_value_index+0)
STRB	R1, [R0, #0]
L_HandleKeyPress35:
MOVW	R0, #lo_addr(_in_value_index+0)
MOVT	R0, #hi_addr(_in_value_index+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CS
BCS	L_HandleKeyPress36
;main.c,151 :: 		in_value[in_value_index] = 0;
MOVW	R2, #lo_addr(_in_value_index+0)
MOVT	R2, #hi_addr(_in_value_index+0)
LDRB	R1, [R2, #0]
MOVW	R0, #lo_addr(_in_value+0)
MOVT	R0, #hi_addr(_in_value+0)
ADDS	R1, R0, R1
MOVS	R0, #0
STRB	R0, [R1, #0]
;main.c,150 :: 		for (in_value_index=0; in_value_index<MAX_KEY_IN_CHARS; in_value_index++)
MOV	R0, R2
LDRB	R0, [R0, #0]
ADDS	R0, R0, #1
STRB	R0, [R2, #0]
;main.c,151 :: 		in_value[in_value_index] = 0;
IT	AL
BAL	L_HandleKeyPress35
L_HandleKeyPress36:
;main.c,152 :: 		in_value_index = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_in_value_index+0)
MOVT	R0, #hi_addr(_in_value_index+0)
STRB	R1, [R0, #0]
;main.c,153 :: 		break;    // this is the OK button
IT	AL
BAL	L_HandleKeyPress27
;main.c,155 :: 		case KEYCODE_UP:
L_HandleKeyPress38:
;main.c,156 :: 		bPrompt = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_bPrompt+0)
MOVT	R0, #hi_addr(_bPrompt+0)
STR	R1, [R0, #0]
;main.c,157 :: 		if (in_value[in_value_index]<MAX_KEY_IN_TABLE-1) in_value[in_value_index]++;
MOVW	R0, #lo_addr(_in_value_index+0)
MOVT	R0, #hi_addr(_in_value_index+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_in_value+0)
MOVT	R0, #hi_addr(_in_value+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
CMP	R0, #11
IT	CS
BCS	L_HandleKeyPress39
MOVW	R0, #lo_addr(_in_value_index+0)
MOVT	R0, #hi_addr(_in_value_index+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_in_value+0)
MOVT	R0, #hi_addr(_in_value+0)
ADDS	R1, R0, R1
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
STRB	R0, [R1, #0]
IT	AL
BAL	L_HandleKeyPress40
L_HandleKeyPress39:
;main.c,158 :: 		else in_value[in_value_index] = 0;
MOVW	R0, #lo_addr(_in_value_index+0)
MOVT	R0, #hi_addr(_in_value_index+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_in_value+0)
MOVT	R0, #hi_addr(_in_value+0)
ADDS	R1, R0, R1
MOVS	R0, #0
STRB	R0, [R1, #0]
L_HandleKeyPress40:
;main.c,159 :: 		Display_Char(x_pos, y_pos, WHITE,PRN, val_tab[in_value[in_value_index]]);
MOVW	R0, #lo_addr(_in_value_index+0)
MOVT	R0, #hi_addr(_in_value_index+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_in_value+0)
MOVT	R0, #hi_addr(_in_value+0)
ADDS	R0, R0, R1
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_val_tab+0)
MOVT	R0, #hi_addr(_val_tab+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
UXTB	R2, R0
MOVW	R0, #lo_addr(main_y_pos+0)
MOVT	R0, #hi_addr(main_y_pos+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(main_x_pos+0)
MOVT	R0, #hi_addr(main_x_pos+0)
LDRSH	R0, [R0, #0]
PUSH	(R2)
MOVS	R3, #0
MOVW	R2, #65535
BL	_Display_Char+0
ADD	SP, SP, #4
;main.c,160 :: 		break;
IT	AL
BAL	L_HandleKeyPress27
;main.c,162 :: 		case KEYCODE_DOWN:
L_HandleKeyPress41:
;main.c,163 :: 		bPrompt = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_bPrompt+0)
MOVT	R0, #hi_addr(_bPrompt+0)
STR	R1, [R0, #0]
;main.c,164 :: 		if (in_value[in_value_index]>0) in_value[in_value_index]--;
MOVW	R0, #lo_addr(_in_value_index+0)
MOVT	R0, #hi_addr(_in_value_index+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_in_value+0)
MOVT	R0, #hi_addr(_in_value+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	LS
BLS	L_HandleKeyPress42
MOVW	R0, #lo_addr(_in_value_index+0)
MOVT	R0, #hi_addr(_in_value_index+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_in_value+0)
MOVT	R0, #hi_addr(_in_value+0)
ADDS	R1, R0, R1
LDRB	R0, [R1, #0]
SUBS	R0, R0, #1
STRB	R0, [R1, #0]
IT	AL
BAL	L_HandleKeyPress43
L_HandleKeyPress42:
;main.c,165 :: 		else in_value[in_value_index] = MAX_KEY_IN_TABLE-1;
MOVW	R0, #lo_addr(_in_value_index+0)
MOVT	R0, #hi_addr(_in_value_index+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_in_value+0)
MOVT	R0, #hi_addr(_in_value+0)
ADDS	R1, R0, R1
MOVS	R0, #11
STRB	R0, [R1, #0]
L_HandleKeyPress43:
;main.c,166 :: 		Display_Char(x_pos, y_pos, WHITE,PRN, val_tab[in_value[in_value_index]]);
MOVW	R0, #lo_addr(_in_value_index+0)
MOVT	R0, #hi_addr(_in_value_index+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_in_value+0)
MOVT	R0, #hi_addr(_in_value+0)
ADDS	R0, R0, R1
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_val_tab+0)
MOVT	R0, #hi_addr(_val_tab+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
UXTB	R2, R0
MOVW	R0, #lo_addr(main_y_pos+0)
MOVT	R0, #hi_addr(main_y_pos+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(main_x_pos+0)
MOVT	R0, #hi_addr(main_x_pos+0)
LDRSH	R0, [R0, #0]
PUSH	(R2)
MOVS	R3, #0
MOVW	R2, #65535
BL	_Display_Char+0
ADD	SP, SP, #4
;main.c,167 :: 		break;
IT	AL
BAL	L_HandleKeyPress27
;main.c,169 :: 		case KEYCODE_LEFT:
L_HandleKeyPress44:
;main.c,170 :: 		bPrompt = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_bPrompt+0)
MOVT	R0, #hi_addr(_bPrompt+0)
STR	R1, [R0, #0]
;main.c,171 :: 		if (in_value_index>0){
MOVW	R0, #lo_addr(_in_value_index+0)
MOVT	R0, #hi_addr(_in_value_index+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	LS
BLS	L_HandleKeyPress45
;main.c,172 :: 		if (in_value[in_value_index] == 0){
MOVW	R0, #lo_addr(_in_value_index+0)
MOVT	R0, #hi_addr(_in_value_index+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_in_value+0)
MOVT	R0, #hi_addr(_in_value+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_HandleKeyPress46
;main.c,173 :: 		Display_Char(x_pos, y_pos, WHITE,PRN, ' ');
MOVS	R2, #32
MOVW	R0, #lo_addr(main_y_pos+0)
MOVT	R0, #hi_addr(main_y_pos+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(main_x_pos+0)
MOVT	R0, #hi_addr(main_x_pos+0)
LDRSH	R0, [R0, #0]
PUSH	(R2)
MOVS	R3, #0
MOVW	R2, #65535
BL	_Display_Char+0
ADD	SP, SP, #4
;main.c,174 :: 		} else {
IT	AL
BAL	L_HandleKeyPress47
L_HandleKeyPress46:
;main.c,175 :: 		Display_Char(x_pos, y_pos, WHITE,PRN, val_tab[in_value[in_value_index]]);
MOVW	R0, #lo_addr(_in_value_index+0)
MOVT	R0, #hi_addr(_in_value_index+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_in_value+0)
MOVT	R0, #hi_addr(_in_value+0)
ADDS	R0, R0, R1
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_val_tab+0)
MOVT	R0, #hi_addr(_val_tab+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
UXTB	R2, R0
MOVW	R0, #lo_addr(main_y_pos+0)
MOVT	R0, #hi_addr(main_y_pos+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(main_x_pos+0)
MOVT	R0, #hi_addr(main_x_pos+0)
LDRSH	R0, [R0, #0]
PUSH	(R2)
MOVS	R3, #0
MOVW	R2, #65535
BL	_Display_Char+0
ADD	SP, SP, #4
;main.c,176 :: 		}
L_HandleKeyPress47:
;main.c,177 :: 		in_value_index--;
MOVW	R1, #lo_addr(_in_value_index+0)
MOVT	R1, #hi_addr(_in_value_index+0)
LDRB	R0, [R1, #0]
SUBS	R2, R0, #1
UXTB	R2, R2
STRB	R2, [R1, #0]
;main.c,178 :: 		x_pos-=STEP_X_POS;
MOVW	R1, #lo_addr(main_x_pos+0)
MOVT	R1, #hi_addr(main_x_pos+0)
LDRSH	R0, [R1, #0]
SUBW	R3, R0, #9
STRH	R3, [R1, #0]
;main.c,179 :: 		Display_Char(x_pos, y_pos, WHITE,PRN, val_tab[in_value[in_value_index]]);
MOVW	R0, #lo_addr(_in_value+0)
MOVT	R0, #hi_addr(_in_value+0)
ADDS	R0, R0, R2
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_val_tab+0)
MOVT	R0, #hi_addr(_val_tab+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
UXTB	R2, R0
MOVW	R0, #lo_addr(main_y_pos+0)
MOVT	R0, #hi_addr(main_y_pos+0)
LDRSH	R1, [R0, #0]
UXTH	R0, R3
PUSH	(R2)
MOVS	R3, #0
MOVW	R2, #65535
BL	_Display_Char+0
ADD	SP, SP, #4
;main.c,180 :: 		}
L_HandleKeyPress45:
;main.c,181 :: 		break;
IT	AL
BAL	L_HandleKeyPress27
;main.c,183 :: 		case KEYCODE_RIGHT:
L_HandleKeyPress48:
;main.c,184 :: 		bPrompt = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_bPrompt+0)
MOVT	R0, #hi_addr(_bPrompt+0)
STR	R1, [R0, #0]
;main.c,185 :: 		if (in_value[in_value_index] == 0) in_value[in_value_index] = 1;
MOVW	R0, #lo_addr(_in_value_index+0)
MOVT	R0, #hi_addr(_in_value_index+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_in_value+0)
MOVT	R0, #hi_addr(_in_value+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_HandleKeyPress49
MOVW	R0, #lo_addr(_in_value_index+0)
MOVT	R0, #hi_addr(_in_value_index+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_in_value+0)
MOVT	R0, #hi_addr(_in_value+0)
ADDS	R1, R0, R1
MOVS	R0, #1
STRB	R0, [R1, #0]
L_HandleKeyPress49:
;main.c,186 :: 		if (in_value_index<MAX_KEY_IN_CHARS){
MOVW	R0, #lo_addr(_in_value_index+0)
MOVT	R0, #hi_addr(_in_value_index+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	CS
BCS	L_HandleKeyPress50
;main.c,187 :: 		Display_Char(x_pos, y_pos, WHITE,PRN, val_tab[in_value[in_value_index]]);
MOVW	R0, #lo_addr(_in_value_index+0)
MOVT	R0, #hi_addr(_in_value_index+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_in_value+0)
MOVT	R0, #hi_addr(_in_value+0)
ADDS	R0, R0, R1
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_val_tab+0)
MOVT	R0, #hi_addr(_val_tab+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
UXTB	R2, R0
MOVW	R0, #lo_addr(main_y_pos+0)
MOVT	R0, #hi_addr(main_y_pos+0)
STR	R0, [SP, #8]
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(main_x_pos+0)
MOVT	R0, #hi_addr(main_x_pos+0)
STR	R0, [SP, #4]
LDRSH	R0, [R0, #0]
PUSH	(R2)
MOVS	R3, #0
MOVW	R2, #65535
BL	_Display_Char+0
ADD	SP, SP, #4
;main.c,188 :: 		in_value_index++;
MOVW	R1, #lo_addr(_in_value_index+0)
MOVT	R1, #hi_addr(_in_value_index+0)
LDRB	R0, [R1, #0]
ADDS	R2, R0, #1
UXTB	R2, R2
STRB	R2, [R1, #0]
;main.c,189 :: 		x_pos+=STEP_X_POS;
LDR	R1, [SP, #4]
MOV	R0, R1
LDRSH	R0, [R0, #0]
ADDW	R3, R0, #9
STRH	R3, [R1, #0]
;main.c,190 :: 		Display_Char(x_pos, y_pos, WHITE,PRN, val_tab[in_value[in_value_index]]);
MOVW	R0, #lo_addr(_in_value+0)
MOVT	R0, #hi_addr(_in_value+0)
ADDS	R0, R0, R2
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_val_tab+0)
MOVT	R0, #hi_addr(_val_tab+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
UXTB	R2, R0
LDR	R0, [SP, #8]
LDRSH	R1, [R0, #0]
UXTH	R0, R3
PUSH	(R2)
MOVS	R3, #0
MOVW	R2, #65535
BL	_Display_Char+0
ADD	SP, SP, #4
;main.c,191 :: 		}
L_HandleKeyPress50:
;main.c,192 :: 		break;
IT	AL
BAL	L_HandleKeyPress27
;main.c,193 :: 		}
L_HandleKeyPress26:
MOVW	R0, #lo_addr(main_cur_key_press+0)
MOVT	R0, #hi_addr(main_cur_key_press+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_HandleKeyPress28
MOVW	R0, #lo_addr(main_cur_key_press+0)
MOVT	R0, #hi_addr(main_cur_key_press+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_HandleKeyPress33
MOVW	R0, #lo_addr(main_cur_key_press+0)
MOVT	R0, #hi_addr(main_cur_key_press+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_HandleKeyPress34
MOVW	R0, #lo_addr(main_cur_key_press+0)
MOVT	R0, #hi_addr(main_cur_key_press+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_HandleKeyPress38
MOVW	R0, #lo_addr(main_cur_key_press+0)
MOVT	R0, #hi_addr(main_cur_key_press+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	EQ
BEQ	L_HandleKeyPress41
MOVW	R0, #lo_addr(main_cur_key_press+0)
MOVT	R0, #hi_addr(main_cur_key_press+0)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	EQ
BEQ	L_HandleKeyPress44
MOVW	R0, #lo_addr(main_cur_key_press+0)
MOVT	R0, #hi_addr(main_cur_key_press+0)
LDRB	R0, [R0, #0]
CMP	R0, #6
IT	EQ
BEQ	L_HandleKeyPress48
L_HandleKeyPress27:
;main.c,194 :: 		}
L_end_HandleKeyPress:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _HandleKeyPress
_main:
;main.c,198 :: 		void main(void)
SUB	SP, SP, #4
;main.c,202 :: 		Delay_ms(200);
MOVW	R7, #40703
MOVT	R7, #36
NOP
NOP
L_main51:
SUBS	R7, R7, #1
BNE	L_main51
NOP
NOP
NOP
;main.c,203 :: 		GPIO_Configure();
BL	_GPIO_Configure+0
;main.c,204 :: 		InitUART1();
BL	_InitUART1+0
;main.c,205 :: 		InitTimers();
BL	_InitTimers+0
;main.c,206 :: 		LCD_Initial();
BL	_LCD_Initial+0
;main.c,207 :: 		Clear_Screen(BLACK);
MOVS	R0, #0
BL	_Clear_Screen+0
;main.c,208 :: 		Display_Str(2, 2, WHITE,PRN, "Terminal rev 1.0");
MOVW	R0, #lo_addr(?lstr_1_main+0)
MOVT	R0, #hi_addr(?lstr_1_main+0)
PUSH	(R0)
MOVS	R3, #0
MOVW	R2, #65535
MOVS	R1, #2
MOVS	R0, #2
BL	_Display_Str+0
ADD	SP, SP, #4
;main.c,209 :: 		Delay_ms(2000);
MOVW	R7, #13823
MOVT	R7, #366
NOP
NOP
L_main53:
SUBS	R7, R7, #1
BNE	L_main53
NOP
NOP
NOP
;main.c,210 :: 		Clear_Screen(BLACK);
MOVS	R0, #0
BL	_Clear_Screen+0
;main.c,212 :: 		while (1){
L_main55:
;main.c,213 :: 		Handle_UART_Input();
BL	_Handle_UART_Input+0
;main.c,214 :: 		if (b20ms){
MOVW	R1, #lo_addr(_b20ms+0)
MOVT	R1, #hi_addr(_b20ms+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main57
;main.c,215 :: 		b20ms = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_b20ms+0)
MOVT	R0, #hi_addr(_b20ms+0)
STR	R1, [R0, #0]
;main.c,216 :: 		HandleKeyPress();
BL	_HandleKeyPress+0
;main.c,217 :: 		}
L_main57:
;main.c,218 :: 		}
IT	AL
BAL	L_main55
;main.c,219 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
_Timer2_interrupt:
;main.c,225 :: 		void Timer2_interrupt() iv IVT_INT_TIM2
SUB	SP, SP, #4
;main.c,229 :: 		TIM2_SR.UIF = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_SR+0)
MOVT	R0, #hi_addr(TIM2_SR+0)
STR	R1, [R0, #0]
;main.c,230 :: 		b1ms = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_b1ms+0)
MOVT	R0, #hi_addr(_b1ms+0)
STR	R1, [R0, #0]
;main.c,232 :: 		if (count20<20) count20++;
MOVW	R0, #lo_addr(Timer2_interrupt_count20_L0+0)
MOVT	R0, #hi_addr(Timer2_interrupt_count20_L0+0)
LDRSB	R0, [R0, #0]
CMP	R0, #20
IT	GE
BGE	L_Timer2_interrupt58
MOVW	R1, #lo_addr(Timer2_interrupt_count20_L0+0)
MOVT	R1, #hi_addr(Timer2_interrupt_count20_L0+0)
LDRSB	R0, [R1, #0]
ADDS	R0, R0, #1
STRB	R0, [R1, #0]
IT	AL
BAL	L_Timer2_interrupt59
L_Timer2_interrupt58:
;main.c,234 :: 		count20 = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(Timer2_interrupt_count20_L0+0)
MOVT	R0, #hi_addr(Timer2_interrupt_count20_L0+0)
STRB	R1, [R0, #0]
;main.c,235 :: 		b20ms = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_b20ms+0)
MOVT	R0, #hi_addr(_b20ms+0)
STR	R1, [R0, #0]
;main.c,236 :: 		}
L_Timer2_interrupt59:
;main.c,237 :: 		}
L_end_Timer2_interrupt:
ADD	SP, SP, #4
BX	LR
; end of _Timer2_interrupt
_Usart1_ISR:
;main.c,239 :: 		void Usart1_ISR() iv IVT_INT_USART1 ics ICS_AUTO
SUB	SP, SP, #4
;main.c,241 :: 		if (TXE_USART1_SR_bit == 1 && TXEIE_USART1_CR1_bit == 1){     // make sure the high speed modem is ready to transmit
MOVW	R1, #lo_addr(TXE_USART1_SR_bit+0)
MOVT	R1, #hi_addr(TXE_USART1_SR_bit+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__Usart1_ISR72
MOVW	R1, #lo_addr(TXEIE_USART1_CR1_bit+0)
MOVT	R1, #hi_addr(TXEIE_USART1_CR1_bit+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__Usart1_ISR71
L__Usart1_ISR70:
;main.c,242 :: 		USART1_SR = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(USART1_SR+0)
MOVT	R0, #hi_addr(USART1_SR+0)
STR	R1, [R0, #0]
;main.c,243 :: 		USART1_DR = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(USART1_DR+0)
MOVT	R0, #hi_addr(USART1_DR+0)
STR	R1, [R0, #0]
;main.c,244 :: 		} else if (RXNE_USART1_SR_bit == 1 && RXNEIE_USART1_CR1_bit == 1){
IT	AL
BAL	L_Usart1_ISR63
;main.c,241 :: 		if (TXE_USART1_SR_bit == 1 && TXEIE_USART1_CR1_bit == 1){     // make sure the high speed modem is ready to transmit
L__Usart1_ISR72:
L__Usart1_ISR71:
;main.c,244 :: 		} else if (RXNE_USART1_SR_bit == 1 && RXNEIE_USART1_CR1_bit == 1){
MOVW	R1, #lo_addr(RXNE_USART1_SR_bit+0)
MOVT	R1, #hi_addr(RXNE_USART1_SR_bit+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__Usart1_ISR74
MOVW	R1, #lo_addr(RXNEIE_USART1_CR1_bit+0)
MOVT	R1, #hi_addr(RXNEIE_USART1_CR1_bit+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__Usart1_ISR73
L__Usart1_ISR69:
;main.c,245 :: 		in_buffer[in_ptr++] = (char)((unsigned int)(USART1_DR & (unsigned int)0x00ff));
MOVW	R2, #lo_addr(main_in_ptr+0)
MOVT	R2, #hi_addr(main_in_ptr+0)
LDRH	R1, [R2, #0]
MOVW	R0, #lo_addr(main_in_buffer+0)
MOVT	R0, #hi_addr(main_in_buffer+0)
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(USART1_DR+0)
MOVT	R0, #hi_addr(USART1_DR+0)
LDR	R0, [R0, #0]
AND	R0, R0, #255
UXTB	R0, R0
STRB	R0, [R1, #0]
MOV	R0, R2
LDRH	R0, [R0, #0]
ADDS	R0, R0, #1
UXTH	R0, R0
STRH	R0, [R2, #0]
;main.c,246 :: 		if (in_ptr>=MAX_IN_BUFFER) in_ptr = 0;
CMP	R0, #128
IT	CC
BCC	L_Usart1_ISR67
MOVS	R1, #0
MOVW	R0, #lo_addr(main_in_ptr+0)
MOVT	R0, #hi_addr(main_in_ptr+0)
STRH	R1, [R0, #0]
L_Usart1_ISR67:
;main.c,244 :: 		} else if (RXNE_USART1_SR_bit == 1 && RXNEIE_USART1_CR1_bit == 1){
L__Usart1_ISR74:
L__Usart1_ISR73:
;main.c,247 :: 		}
L_Usart1_ISR63:
;main.c,248 :: 		}
L_end_Usart1_ISR:
ADD	SP, SP, #4
BX	LR
; end of _Usart1_ISR
