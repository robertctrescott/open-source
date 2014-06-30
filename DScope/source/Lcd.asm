_LCD_WR_REG:
;Lcd.c,118 :: 		void LCD_WR_REG(unsigned int Reg, unsigned int Data)
; Data start address is: 4 (R1)
SUB	SP, SP, #4
; Data end address is: 4 (R1)
; Data start address is: 4 (R1)
;Lcd.c,120 :: 		LCD_DATA_OUT=Reg;     //Reg. Addr.
MOVW	R2, #lo_addr(GPIOE_ODR+0)
MOVT	R2, #hi_addr(GPIOE_ODR+0)
STR	R0, [R2, #0]
;Lcd.c,121 :: 		LCD_RS_LOW();         //RS=0,Piont to Index Reg.
MOVS	R5, #1
SXTB	R5, R5
MOVW	R2, #lo_addr(BR1_GPIOD_BSRR_bit+0)
MOVT	R2, #hi_addr(BR1_GPIOD_BSRR_bit+0)
STR	R5, [R2, #0]
;Lcd.c,122 :: 		LCD_nWR_LOW();
MOVW	R4, #lo_addr(BR5_GPIOD_BSRR_bit+0)
MOVT	R4, #hi_addr(BR5_GPIOD_BSRR_bit+0)
STR	R5, [R4, #0]
;Lcd.c,123 :: 		LCD_nWR_HIGH();
MOVW	R3, #lo_addr(BS5_GPIOD_BSRR_bit+0)
MOVT	R3, #hi_addr(BS5_GPIOD_BSRR_bit+0)
STR	R5, [R3, #0]
;Lcd.c,124 :: 		LCD_RS_HIGH();        //RS=1,Piont to object Reg.
MOVW	R2, #lo_addr(BS1_GPIOD_BSRR_bit+0)
MOVT	R2, #hi_addr(BS1_GPIOD_BSRR_bit+0)
STR	R5, [R2, #0]
;Lcd.c,125 :: 		LCD_DATA_OUT=Data;    //Reg. Data
MOVW	R2, #lo_addr(GPIOE_ODR+0)
MOVT	R2, #hi_addr(GPIOE_ODR+0)
STR	R1, [R2, #0]
; Data end address is: 4 (R1)
;Lcd.c,126 :: 		LCD_nWR_LOW();
STR	R5, [R4, #0]
;Lcd.c,127 :: 		LCD_nWR_HIGH();
STR	R5, [R3, #0]
;Lcd.c,128 :: 		}
L_end_LCD_WR_REG:
ADD	SP, SP, #4
BX	LR
; end of _LCD_WR_REG
_LCD_Initial:
;Lcd.c,133 :: 		void LCD_Initial(void)
SUB	SP, SP, #12
STR	LR, [SP, #0]
;Lcd.c,136 :: 		LCD_DATA_BUS_OUT();   //Set LCD Data Bus as Output Mode
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOE_CRL+0)
MOVT	R0, #hi_addr(GPIOE_CRL+0)
STR	R1, [R0, #0]
;Lcd.c,137 :: 		LCD_nWR_HIGH();
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(BS5_GPIOD_BSRR_bit+0)
MOVT	R0, #hi_addr(BS5_GPIOD_BSRR_bit+0)
STR	R0, [SP, #8]
STR	R1, [R0, #0]
;Lcd.c,138 :: 		LCD_nRD_HIGH();
MOVW	R0, #lo_addr(BS4_GPIOD_BSRR_bit+0)
MOVT	R0, #hi_addr(BS4_GPIOD_BSRR_bit+0)
STR	R1, [R0, #0]
;Lcd.c,139 :: 		LCD_RS_HIGH();        //RS=1
MOVW	R0, #lo_addr(BS1_GPIOD_BSRR_bit+0)
MOVT	R0, #hi_addr(BS1_GPIOD_BSRR_bit+0)
STR	R0, [SP, #4]
STR	R1, [R0, #0]
;Lcd.c,140 :: 		LCD_nRST_HIGH();
MOVW	R0, #lo_addr(BS0_GPIOC_BSRR_bit+0)
MOVT	R0, #hi_addr(BS0_GPIOC_BSRR_bit+0)
STR	R1, [R0, #0]
;Lcd.c,141 :: 		Delay_ms(1);           //RST=1£¬Delay 1ms
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_LCD_Initial0:
SUBS	R7, R7, #1
BNE	L_LCD_Initial0
NOP
NOP
NOP
;Lcd.c,142 :: 		LCD_nRST_LOW();
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(BR0_GPIOC_BSRR_bit+0)
MOVT	R0, #hi_addr(BR0_GPIOC_BSRR_bit+0)
STR	R1, [R0, #0]
;Lcd.c,143 :: 		Delay_ms(1);          //RST=0 Reset LCD£¬Delay 1ms
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_LCD_Initial2:
SUBS	R7, R7, #1
BNE	L_LCD_Initial2
NOP
NOP
NOP
;Lcd.c,144 :: 		LCD_nRST_HIGH();
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(BS0_GPIOC_BSRR_bit+0)
MOVT	R0, #hi_addr(BS0_GPIOC_BSRR_bit+0)
STR	R1, [R0, #0]
;Lcd.c,145 :: 		Delay_ms(5);          //RST=1£¬Delay 5 ms
MOVW	R7, #59999
MOVT	R7, #0
NOP
NOP
L_LCD_Initial4:
SUBS	R7, R7, #1
BNE	L_LCD_Initial4
NOP
NOP
NOP
;Lcd.c,147 :: 		LCD_WR_REG(0x00FF, 0x0001);
MOVS	R1, #1
MOVS	R0, #255
BL	_LCD_WR_REG+0
;Lcd.c,148 :: 		LCD_WR_REG(0x00F3, 0x0008);
MOVS	R1, #8
MOVS	R0, #243
BL	_LCD_WR_REG+0
;Lcd.c,149 :: 		LCD_DATA_OUT=0x00F3;
MOVS	R1, #243
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;Lcd.c,150 :: 		LCD_RS_LOW();
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(BR1_GPIOD_BSRR_bit+0)
MOVT	R0, #hi_addr(BR1_GPIOD_BSRR_bit+0)
STR	R1, [R0, #0]
;Lcd.c,151 :: 		LCD_nWR_LOW();
MOVW	R0, #lo_addr(BR5_GPIOD_BSRR_bit+0)
MOVT	R0, #hi_addr(BR5_GPIOD_BSRR_bit+0)
STR	R1, [R0, #0]
;Lcd.c,152 :: 		LCD_nWR_HIGH();
LDR	R0, [SP, #8]
STR	R1, [R0, #0]
;Lcd.c,154 :: 		LCD_RS_HIGH();
LDR	R0, [SP, #4]
STR	R1, [R0, #0]
;Lcd.c,156 :: 		LCD_WR_REG(0x0001, 0x0100);    //Output Direct
MOVW	R1, #256
MOVS	R0, #1
BL	_LCD_WR_REG+0
;Lcd.c,157 :: 		LCD_WR_REG(0x0002, 0x0700);    //Line Inversion
MOVW	R1, #1792
MOVS	R0, #2
BL	_LCD_WR_REG+0
;Lcd.c,158 :: 		LCD_WR_REG(0x0003, 0x0030);    //BGR=0,ID=11
MOVS	R1, #48
MOVS	R0, #3
BL	_LCD_WR_REG+0
;Lcd.c,159 :: 		LCD_WR_REG(0x0008, 0x0302);    //Porch Setting
MOVW	R1, #770
MOVS	R0, #8
BL	_LCD_WR_REG+0
;Lcd.c,160 :: 		LCD_WR_REG(0x0009, 0x0000);    //Scan Cycle
MOVS	R1, #0
MOVS	R0, #9
BL	_LCD_WR_REG+0
;Lcd.c,161 :: 		LCD_WR_REG(0x000A, 0x0000);    //FMARK off
MOVS	R1, #0
MOVS	R0, #10
BL	_LCD_WR_REG+0
;Lcd.c,163 :: 		LCD_WR_REG(0x0010, 0x0790);    //Power Control1
MOVW	R1, #1936
MOVS	R0, #16
BL	_LCD_WR_REG+0
;Lcd.c,164 :: 		LCD_WR_REG(0x0011, 0x0005);    //Power Control2
MOVS	R1, #5
MOVS	R0, #17
BL	_LCD_WR_REG+0
;Lcd.c,165 :: 		LCD_WR_REG(0x0012, 0x0000);    //Power Control3
MOVS	R1, #0
MOVS	R0, #18
BL	_LCD_WR_REG+0
;Lcd.c,166 :: 		LCD_WR_REG(0x0013, 0x0000);    //Power Control4
MOVS	R1, #0
MOVS	R0, #19
BL	_LCD_WR_REG+0
;Lcd.c,167 :: 		Delay_ms(100);                  //Delay 100ms
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_LCD_Initial6:
SUBS	R7, R7, #1
BNE	L_LCD_Initial6
NOP
NOP
NOP
;Lcd.c,168 :: 		LCD_WR_REG(0x0010, 0x12B0);    //Power Control1
MOVW	R1, #4784
MOVS	R0, #16
BL	_LCD_WR_REG+0
;Lcd.c,169 :: 		Delay_ms(50);                   //delay 50ms
MOVW	R7, #10175
MOVT	R7, #9
NOP
NOP
L_LCD_Initial8:
SUBS	R7, R7, #1
BNE	L_LCD_Initial8
NOP
NOP
NOP
;Lcd.c,170 :: 		LCD_WR_REG(0x0011, 0x0007);    //Power Control2
MOVS	R1, #7
MOVS	R0, #17
BL	_LCD_WR_REG+0
;Lcd.c,171 :: 		Delay_ms(50);                   //delay 50ms
MOVW	R7, #10175
MOVT	R7, #9
NOP
NOP
L_LCD_Initial10:
SUBS	R7, R7, #1
BNE	L_LCD_Initial10
NOP
NOP
NOP
;Lcd.c,172 :: 		LCD_WR_REG(0x0012, 0x008C);    //Power Control3
MOVS	R1, #140
MOVS	R0, #18
BL	_LCD_WR_REG+0
;Lcd.c,173 :: 		LCD_WR_REG(0x0013, 0x1700);    //Power Control4
MOVW	R1, #5888
MOVS	R0, #19
BL	_LCD_WR_REG+0
;Lcd.c,174 :: 		LCD_WR_REG(0x0029, 0x001A);    //VCOMH Setting
MOVS	R1, #26
MOVS	R0, #41
BL	_LCD_WR_REG+0
;Lcd.c,175 :: 		Delay_ms(50);                   //delay 50ms
MOVW	R7, #10175
MOVT	R7, #9
NOP
NOP
L_LCD_Initial12:
SUBS	R7, R7, #1
BNE	L_LCD_Initial12
NOP
NOP
NOP
;Lcd.c,177 :: 		LCD_WR_REG(0x0030, 0x0000);
MOVS	R1, #0
MOVS	R0, #48
BL	_LCD_WR_REG+0
;Lcd.c,178 :: 		LCD_WR_REG(0x0031, 0x0507);
MOVW	R1, #1287
MOVS	R0, #49
BL	_LCD_WR_REG+0
;Lcd.c,179 :: 		LCD_WR_REG(0x0032, 0x0003);
MOVS	R1, #3
MOVS	R0, #50
BL	_LCD_WR_REG+0
;Lcd.c,180 :: 		LCD_WR_REG(0x0035, 0x0200);
MOVW	R1, #512
MOVS	R0, #53
BL	_LCD_WR_REG+0
;Lcd.c,181 :: 		LCD_WR_REG(0x0036, 0x0106);
MOVW	R1, #262
MOVS	R0, #54
BL	_LCD_WR_REG+0
;Lcd.c,182 :: 		LCD_WR_REG(0x0037, 0x0000);
MOVS	R1, #0
MOVS	R0, #55
BL	_LCD_WR_REG+0
;Lcd.c,183 :: 		LCD_WR_REG(0x0038, 0x0507);
MOVW	R1, #1287
MOVS	R0, #56
BL	_LCD_WR_REG+0
;Lcd.c,184 :: 		LCD_WR_REG(0x0039, 0x0104);
MOVW	R1, #260
MOVS	R0, #57
BL	_LCD_WR_REG+0
;Lcd.c,185 :: 		LCD_WR_REG(0x003C, 0x0200);
MOVW	R1, #512
MOVS	R0, #60
BL	_LCD_WR_REG+0
;Lcd.c,186 :: 		LCD_WR_REG(0x003D, 0x0005);
MOVS	R1, #5
MOVS	R0, #61
BL	_LCD_WR_REG+0
;Lcd.c,188 :: 		LCD_WR_REG(0x0050, 0x0000);
MOVS	R1, #0
MOVS	R0, #80
BL	_LCD_WR_REG+0
;Lcd.c,189 :: 		LCD_WR_REG(0x0051, 0x00EF);
MOVS	R1, #239
MOVS	R0, #81
BL	_LCD_WR_REG+0
;Lcd.c,190 :: 		LCD_WR_REG(0x0052, 0x0000);
MOVS	R1, #0
MOVS	R0, #82
BL	_LCD_WR_REG+0
;Lcd.c,191 :: 		LCD_WR_REG(0x0053, 0x013F);
MOVW	R1, #319
MOVS	R0, #83
BL	_LCD_WR_REG+0
;Lcd.c,193 :: 		LCD_WR_REG(0x0060, 0xA700);
MOVW	R1, #42752
MOVS	R0, #96
BL	_LCD_WR_REG+0
;Lcd.c,194 :: 		LCD_WR_REG(0x0061, 0x0001);
MOVS	R1, #1
MOVS	R0, #97
BL	_LCD_WR_REG+0
;Lcd.c,195 :: 		LCD_WR_REG(0x0090, 0x0033);
MOVS	R1, #51
MOVS	R0, #144
BL	_LCD_WR_REG+0
;Lcd.c,196 :: 		LCD_WR_REG(0x0007, 0x0133);
MOVW	R1, #307
MOVS	R0, #7
BL	_LCD_WR_REG+0
;Lcd.c,197 :: 		Delay_ms(50);                   //delay 50ms
MOVW	R7, #10175
MOVT	R7, #9
NOP
NOP
L_LCD_Initial14:
SUBS	R7, R7, #1
BNE	L_LCD_Initial14
NOP
NOP
NOP
;Lcd.c,198 :: 		}
L_end_LCD_Initial:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _LCD_Initial
_Point_SCR:
;Lcd.c,203 :: 		void Point_SCR(unsigned int x0, unsigned int y0)
; y0 start address is: 4 (R1)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTH	R6, R0
; y0 end address is: 4 (R1)
; x0 start address is: 24 (R6)
; y0 start address is: 4 (R1)
;Lcd.c,205 :: 		LCD_WR_REG(0x0020,y0);
; y0 end address is: 4 (R1)
MOVS	R0, #32
BL	_LCD_WR_REG+0
;Lcd.c,206 :: 		LCD_WR_REG(0x0021,x0);
UXTH	R1, R6
; x0 end address is: 24 (R6)
MOVS	R0, #33
BL	_LCD_WR_REG+0
;Lcd.c,207 :: 		LCD_DATA_OUT=0x0022;  //DRAM Reg.
MOVS	R3, #34
MOVW	R2, #lo_addr(GPIOE_ODR+0)
MOVT	R2, #hi_addr(GPIOE_ODR+0)
STR	R3, [R2, #0]
;Lcd.c,208 :: 		LCD_RS_LOW();
MOVS	R4, #1
SXTB	R4, R4
MOVW	R2, #lo_addr(BR1_GPIOD_BSRR_bit+0)
MOVT	R2, #hi_addr(BR1_GPIOD_BSRR_bit+0)
STR	R4, [R2, #0]
;Lcd.c,209 :: 		LCD_nWR_LOW();
MOVW	R3, #lo_addr(BR5_GPIOD_BSRR_bit+0)
MOVT	R3, #hi_addr(BR5_GPIOD_BSRR_bit+0)
STR	R4, [R3, #0]
;Lcd.c,210 :: 		LCD_nWR_HIGH();
MOVW	R2, #lo_addr(BS5_GPIOD_BSRR_bit+0)
MOVT	R2, #hi_addr(BS5_GPIOD_BSRR_bit+0)
STR	R4, [R2, #0]
;Lcd.c,211 :: 		LCD_nWR_LOW();
STR	R4, [R3, #0]
;Lcd.c,212 :: 		LCD_nWR_HIGH();
STR	R4, [R2, #0]
;Lcd.c,213 :: 		LCD_RS_HIGH();
MOVW	R2, #lo_addr(BS1_GPIOD_BSRR_bit+0)
MOVT	R2, #hi_addr(BS1_GPIOD_BSRR_bit+0)
STR	R4, [R2, #0]
;Lcd.c,214 :: 		}
L_end_Point_SCR:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Point_SCR
_Set_Pixel:
;Lcd.c,218 :: 		void Set_Pixel(unsigned int Color)
SUB	SP, SP, #4
;Lcd.c,220 :: 		LCD_DATA_OUT=Color;   //Color Data
MOVW	R1, #lo_addr(GPIOE_ODR+0)
MOVT	R1, #hi_addr(GPIOE_ODR+0)
STR	R0, [R1, #0]
;Lcd.c,221 :: 		LCD_nWR_LOW();
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(BR5_GPIOD_BSRR_bit+0)
MOVT	R1, #hi_addr(BR5_GPIOD_BSRR_bit+0)
STR	R2, [R1, #0]
;Lcd.c,222 :: 		LCD_nWR_HIGH();
MOVW	R1, #lo_addr(BS5_GPIOD_BSRR_bit+0)
MOVT	R1, #hi_addr(BS5_GPIOD_BSRR_bit+0)
STR	R2, [R1, #0]
;Lcd.c,223 :: 		}
L_end_Set_Pixel:
ADD	SP, SP, #4
BX	LR
; end of _Set_Pixel
_Clear_Screen:
;Lcd.c,228 :: 		void Clear_Screen(unsigned int Color)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTH	R7, R0
; Color start address is: 28 (R7)
;Lcd.c,231 :: 		Point_SCR(0, 0);    //X_pos=0£¬Y_pos=0
MOVS	R1, #0
MOVS	R0, #0
BL	_Point_SCR+0
;Lcd.c,232 :: 		for(i=0; i<240*320; ++i)
; i start address is: 16 (R4)
MOVS	R4, #0
; Color end address is: 28 (R7)
; i end address is: 16 (R4)
UXTH	R3, R7
L_Clear_Screen16:
; i start address is: 16 (R4)
; Color start address is: 12 (R3)
; Color start address is: 12 (R3)
; Color end address is: 12 (R3)
CMP	R4, #76800
IT	CS
BCS	L_Clear_Screen17
; Color end address is: 12 (R3)
;Lcd.c,233 :: 		Set_Pixel(Color);
; Color start address is: 12 (R3)
UXTH	R0, R3
BL	_Set_Pixel+0
;Lcd.c,232 :: 		for(i=0; i<240*320; ++i)
ADDS	R4, R4, #1
;Lcd.c,233 :: 		Set_Pixel(Color);
; Color end address is: 12 (R3)
; i end address is: 16 (R4)
IT	AL
BAL	L_Clear_Screen16
L_Clear_Screen17:
;Lcd.c,234 :: 		}
L_end_Clear_Screen:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Clear_Screen
_Display_Frame:
;Lcd.c,238 :: 		void Display_Frame(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Lcd.c,241 :: 		for(i=0; i<320; ++i) {
; i start address is: 28 (R7)
MOVS	R7, #0
; i end address is: 28 (R7)
L_Display_Frame19:
; i start address is: 28 (R7)
CMP	R7, #320
IT	CS
BCS	L_Display_Frame20
;Lcd.c,242 :: 		Point_SCR(i,0);
MOVS	R1, #0
UXTH	R0, R7
BL	_Point_SCR+0
;Lcd.c,243 :: 		for(j=0; j<MIN_Y-1; ++j) Set_Pixel(PANEL);
; j start address is: 12 (R3)
MOVS	R3, #0
; j end address is: 12 (R3)
; i end address is: 28 (R7)
UXTH	R4, R7
L_Display_Frame22:
; j start address is: 12 (R3)
; i start address is: 16 (R4)
CMP	R3, #18
IT	CS
BCS	L_Display_Frame23
MOVW	R0, #65504
BL	_Set_Pixel+0
ADDS	R3, R3, #1
UXTH	R3, R3
; j end address is: 12 (R3)
IT	AL
BAL	L_Display_Frame22
L_Display_Frame23:
;Lcd.c,241 :: 		for(i=0; i<320; ++i) {
ADDS	R7, R4, #1
UXTH	R7, R7
; i end address is: 16 (R4)
; i start address is: 28 (R7)
;Lcd.c,244 :: 		}
; i end address is: 28 (R7)
IT	AL
BAL	L_Display_Frame19
L_Display_Frame20:
;Lcd.c,245 :: 		for(i=0; i<320; ++i) {
; i start address is: 28 (R7)
MOVS	R7, #0
; i end address is: 28 (R7)
L_Display_Frame25:
; i start address is: 28 (R7)
CMP	R7, #320
IT	CS
BCS	L_Display_Frame26
;Lcd.c,246 :: 		Point_SCR(i,MAX_Y+3);
MOVS	R1, #222
UXTH	R0, R7
BL	_Point_SCR+0
;Lcd.c,247 :: 		for(j=MAX_Y+3; j<240; ++j) Set_Pixel(PANEL);
; j start address is: 12 (R3)
MOVS	R3, #222
; j end address is: 12 (R3)
; i end address is: 28 (R7)
UXTH	R4, R7
L_Display_Frame28:
; j start address is: 12 (R3)
; i start address is: 16 (R4)
CMP	R3, #240
IT	CS
BCS	L_Display_Frame29
MOVW	R0, #65504
BL	_Set_Pixel+0
ADDS	R3, R3, #1
UXTH	R3, R3
; j end address is: 12 (R3)
IT	AL
BAL	L_Display_Frame28
L_Display_Frame29:
;Lcd.c,245 :: 		for(i=0; i<320; ++i) {
ADDS	R0, R4, #1
; i end address is: 16 (R4)
; i start address is: 28 (R7)
UXTH	R7, R0
;Lcd.c,248 :: 		}
; i end address is: 28 (R7)
IT	AL
BAL	L_Display_Frame25
L_Display_Frame26:
;Lcd.c,249 :: 		}
L_end_Display_Frame:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Display_Frame
_Display_Grid:
;Lcd.c,253 :: 		void Display_Grid(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Lcd.c,256 :: 		for(j=MIN_Y; j<=MAX_Y; j+=25)  for(i=MIN_X; i<MAX_X+1; ++i){
; j start address is: 28 (R7)
MOVS	R7, #19
; j end address is: 28 (R7)
L_Display_Grid31:
; j start address is: 28 (R7)
CMP	R7, #219
IT	HI
BHI	L_Display_Grid32
MOVS	R0, #1
; j end address is: 28 (R7)
UXTH	R8, R0
L_Display_Grid34:
; i start address is: 32 (R8)
; j start address is: 28 (R7)
CMP	R8, #302
IT	CS
BCS	L_Display_Grid35
;Lcd.c,257 :: 		Point_SCR(i,j);
UXTH	R1, R7
UXTH	R0, R8
BL	_Point_SCR+0
;Lcd.c,258 :: 		Set_Pixel(GRID);
MOVW	R0, #29582
BL	_Set_Pixel+0
;Lcd.c,256 :: 		for(j=MIN_Y; j<=MAX_Y; j+=25)  for(i=MIN_X; i<MAX_X+1; ++i){
ADD	R8, R8, #1
UXTH	R8, R8
;Lcd.c,259 :: 		}
; i end address is: 32 (R8)
IT	AL
BAL	L_Display_Grid34
L_Display_Grid35:
;Lcd.c,256 :: 		for(j=MIN_Y; j<=MAX_Y; j+=25)  for(i=MIN_X; i<MAX_X+1; ++i){
ADDS	R7, #25
UXTH	R7, R7
;Lcd.c,259 :: 		}
; j end address is: 28 (R7)
IT	AL
BAL	L_Display_Grid31
L_Display_Grid32:
;Lcd.c,260 :: 		for(i=MIN_X;i<=MAX_X; i+=25){
; i start address is: 28 (R7)
MOVS	R7, #1
; i end address is: 28 (R7)
L_Display_Grid37:
; i start address is: 28 (R7)
MOVW	R0, #301
CMP	R7, R0
IT	HI
BHI	L_Display_Grid38
;Lcd.c,261 :: 		Point_SCR(i,MIN_Y);
MOVS	R1, #19
UXTH	R0, R7
BL	_Point_SCR+0
;Lcd.c,262 :: 		for(j=MIN_Y; j<=MAX_Y; ++j) Set_Pixel(GRID);
; j start address is: 12 (R3)
MOVS	R3, #19
; j end address is: 12 (R3)
; i end address is: 28 (R7)
UXTH	R4, R7
L_Display_Grid40:
; j start address is: 12 (R3)
; i start address is: 16 (R4)
CMP	R3, #219
IT	HI
BHI	L_Display_Grid41
MOVW	R0, #29582
BL	_Set_Pixel+0
ADDS	R3, R3, #1
UXTH	R3, R3
; j end address is: 12 (R3)
IT	AL
BAL	L_Display_Grid40
L_Display_Grid41:
;Lcd.c,260 :: 		for(i=MIN_X;i<=MAX_X; i+=25){
ADDW	R7, R4, #25
UXTH	R7, R7
; i end address is: 16 (R4)
; i start address is: 28 (R7)
;Lcd.c,263 :: 		}
; i end address is: 28 (R7)
IT	AL
BAL	L_Display_Grid37
L_Display_Grid38:
;Lcd.c,264 :: 		for(i=MIN_X+5; i<MAX_X; i+=5){
; i start address is: 28 (R7)
MOVS	R7, #6
; i end address is: 28 (R7)
L_Display_Grid43:
; i start address is: 28 (R7)
MOVW	R0, #301
CMP	R7, R0
IT	CS
BCS	L_Display_Grid44
;Lcd.c,265 :: 		Point_SCR(i,MIN_Y+1);
MOVS	R1, #20
UXTH	R0, R7
BL	_Point_SCR+0
;Lcd.c,266 :: 		Set_Pixel(GRID);
MOVW	R0, #29582
BL	_Set_Pixel+0
;Lcd.c,267 :: 		Point_SCR(i,MAX_Y-1);
MOVS	R1, #218
UXTH	R0, R7
BL	_Point_SCR+0
;Lcd.c,268 :: 		Set_Pixel(GRID);
MOVW	R0, #29582
BL	_Set_Pixel+0
;Lcd.c,269 :: 		Point_SCR(i,((MIN_Y+MAX_Y)/2+1));
MOVS	R1, #120
UXTH	R0, R7
BL	_Point_SCR+0
;Lcd.c,270 :: 		Set_Pixel(GRID);
MOVW	R0, #29582
BL	_Set_Pixel+0
;Lcd.c,271 :: 		Point_SCR(i,((MIN_Y+MAX_Y)/2-1));
MOVS	R1, #118
UXTH	R0, R7
BL	_Point_SCR+0
;Lcd.c,272 :: 		Set_Pixel(GRID);
MOVW	R0, #29582
BL	_Set_Pixel+0
;Lcd.c,264 :: 		for(i=MIN_X+5; i<MAX_X; i+=5){
ADDS	R7, R7, #5
UXTH	R7, R7
;Lcd.c,273 :: 		}
; i end address is: 28 (R7)
IT	AL
BAL	L_Display_Grid43
L_Display_Grid44:
;Lcd.c,274 :: 		for(j=MIN_Y+5; j<MAX_Y; j+=5){
; j start address is: 28 (R7)
MOVS	R7, #24
; j end address is: 28 (R7)
L_Display_Grid46:
; j start address is: 28 (R7)
CMP	R7, #219
IT	CS
BCS	L_Display_Grid47
;Lcd.c,275 :: 		Point_SCR(MIN_X+1,j);
UXTH	R1, R7
MOVS	R0, #2
BL	_Point_SCR+0
;Lcd.c,276 :: 		Set_Pixel(GRID);
MOVW	R0, #29582
BL	_Set_Pixel+0
;Lcd.c,277 :: 		Point_SCR(MAX_X-1,j);
UXTH	R1, R7
MOVW	R0, #300
BL	_Point_SCR+0
;Lcd.c,278 :: 		Set_Pixel(GRID);
MOVW	R0, #29582
BL	_Set_Pixel+0
;Lcd.c,279 :: 		Point_SCR(((MIN_X+MAX_X)/2+1),j);
UXTH	R1, R7
MOVS	R0, #152
BL	_Point_SCR+0
;Lcd.c,280 :: 		Set_Pixel(GRID);
MOVW	R0, #29582
BL	_Set_Pixel+0
;Lcd.c,281 :: 		Point_SCR(((MIN_X+MAX_X)/2-1),j);
UXTH	R1, R7
MOVS	R0, #150
BL	_Point_SCR+0
;Lcd.c,282 :: 		Set_Pixel(GRID);
MOVW	R0, #29582
BL	_Set_Pixel+0
;Lcd.c,274 :: 		for(j=MIN_Y+5; j<MAX_Y; j+=5){
ADDS	R7, R7, #5
UXTH	R7, R7
;Lcd.c,283 :: 		}
; j end address is: 28 (R7)
IT	AL
BAL	L_Display_Grid46
L_Display_Grid47:
;Lcd.c,284 :: 		}
L_end_Display_Grid:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Display_Grid
_Display_Char:
;Lcd.c,290 :: 		void Display_Char(unsigned int x0, unsigned int y0, unsigned int Color, unsigned char Mode, char s)
; Mode start address is: 12 (R3)
; Color start address is: 8 (R2)
; y0 start address is: 4 (R1)
SUB	SP, SP, #8
STR	LR, [SP, #0]
UXTH	R9, R0
UXTH	R8, R1
UXTH	R7, R2
UXTB	R10, R3
; Mode end address is: 12 (R3)
; Color end address is: 8 (R2)
; y0 end address is: 4 (R1)
; x0 start address is: 36 (R9)
; y0 start address is: 32 (R8)
; Color start address is: 28 (R7)
; Mode start address is: 40 (R10)
; s start address is: 44 (R11)
LDRB	R11, [SP, #8]
;Lcd.c,294 :: 		Point_SCR(x0, y0);
UXTH	R1, R8
UXTH	R0, R9
BL	_Point_SCR+0
;Lcd.c,295 :: 		for (j=0; j<14;++j){
; j start address is: 20 (R5)
MOVS	R5, #0
SXTH	R5, R5
; Mode end address is: 40 (R10)
; s end address is: 44 (R11)
; Color end address is: 28 (R7)
; y0 end address is: 32 (R8)
; j end address is: 20 (R5)
; x0 end address is: 36 (R9)
UXTB	R6, R10
UXTB	R3, R11
L_Display_Char49:
; j start address is: 20 (R5)
; s start address is: 12 (R3)
; Mode start address is: 24 (R6)
; Color start address is: 28 (R7)
; y0 start address is: 32 (R8)
; x0 start address is: 36 (R9)
CMP	R5, #14
IT	GE
BGE	L_Display_Char50
;Lcd.c,296 :: 		if(Mode==0) Set_Pixel(BLACK);   //Normal replace Display
CMP	R6, #0
IT	NE
BNE	L_Display_Char52
MOVS	R0, #0
BL	_Set_Pixel+0
L_Display_Char52:
;Lcd.c,297 :: 		if(Mode==1) Set_Pixel(Color);   //Inverse replace Display
CMP	R6, #1
IT	NE
BNE	L_Display_Char53
UXTH	R0, R7
BL	_Set_Pixel+0
L_Display_Char53:
;Lcd.c,295 :: 		for (j=0; j<14;++j){
ADDS	R5, R5, #1
SXTH	R5, R5
;Lcd.c,298 :: 		}
; j end address is: 20 (R5)
IT	AL
BAL	L_Display_Char49
L_Display_Char50:
;Lcd.c,300 :: 		x0++;
ADD	R9, R9, #1
UXTH	R9, R9
;Lcd.c,301 :: 		if (s!=0) {
CMP	R3, #0
IT	EQ
BEQ	L_Display_Char54
;Lcd.c,302 :: 		unsigned const int *scanline=Char_Dot+((s-0x22)*8);
SUBW	R4, R3, #34
SXTH	R4, R4
LSLS	R4, R4, #3
SXTH	R4, R4
LSLS	R5, R4, #1
MOVW	R4, #lo_addr(_Char_Dot+0)
MOVT	R4, #hi_addr(_Char_Dot+0)
ADDS	R4, R4, R5
; scanline start address is: 4 (R1)
MOV	R1, R4
;Lcd.c,303 :: 		for(i=0;i<8;++i){
MOVS	R0, #0
SXTH	R0, R0
; Mode end address is: 24 (R6)
; Color end address is: 28 (R7)
; y0 end address is: 32 (R8)
; scanline end address is: 4 (R1)
; s end address is: 12 (R3)
; x0 end address is: 36 (R9)
UXTH	R11, R7
SXTH	R7, R0
UXTB	R0, R3
UXTB	R12, R6
UXTH	R10, R8
MOV	R8, R1
L_Display_Char55:
; i start address is: 28 (R7)
; scanline start address is: 32 (R8)
; x0 start address is: 36 (R9)
; y0 start address is: 40 (R10)
; Color start address is: 44 (R11)
; Mode start address is: 48 (R12)
CMP	R7, #8
IT	GE
BGE	L_Display_Char56
;Lcd.c,304 :: 		Point_SCR(x0+i, y0);
ADD	R4, R9, R7, LSL #0
STRB	R0, [SP, #4]
UXTH	R1, R10
UXTH	R0, R4
BL	_Point_SCR+0
LDRB	R0, [SP, #4]
;Lcd.c,305 :: 		if((s==0x20)||(s==0x21)) b=0x0000;
CMP	R0, #32
IT	EQ
BEQ	L__Display_Char141
CMP	R0, #33
IT	EQ
BEQ	L__Display_Char140
IT	AL
BAL	L_Display_Char60
L__Display_Char141:
L__Display_Char140:
; b start address is: 4 (R1)
MOVS	R1, #0
SXTH	R1, R1
; b end address is: 4 (R1)
IT	AL
BAL	L_Display_Char61
L_Display_Char60:
;Lcd.c,306 :: 		else                       b=scanline[i];
LSLS	R4, R7, #1
ADD	R4, R8, R4, LSL #0
LDRH	R1, [R4, #0]
; b start address is: 4 (R1)
; b end address is: 4 (R1)
L_Display_Char61:
;Lcd.c,307 :: 		if((s==0x21)&&(i==4)) break;
; b start address is: 4 (R1)
CMP	R0, #33
IT	NE
BNE	L__Display_Char143
CMP	R7, #4
IT	NE
BNE	L__Display_Char142
; b end address is: 4 (R1)
; Mode end address is: 48 (R12)
; Color end address is: 44 (R11)
; y0 end address is: 40 (R10)
; x0 end address is: 36 (R9)
; scanline end address is: 32 (R8)
; i end address is: 28 (R7)
L__Display_Char138:
IT	AL
BAL	L_Display_Char56
L__Display_Char143:
; i start address is: 28 (R7)
; scanline start address is: 32 (R8)
; x0 start address is: 36 (R9)
; y0 start address is: 40 (R10)
; Color start address is: 44 (R11)
; Mode start address is: 48 (R12)
; b start address is: 4 (R1)
L__Display_Char142:
;Lcd.c,308 :: 		for(j=0;j<14;++j){
; j start address is: 24 (R6)
MOVS	R6, #0
SXTH	R6, R6
; b end address is: 4 (R1)
; Mode end address is: 48 (R12)
; Color end address is: 44 (R11)
; y0 end address is: 40 (R10)
; x0 end address is: 36 (R9)
; scanline end address is: 32 (R8)
; j end address is: 24 (R6)
; i end address is: 28 (R7)
SXTH	R5, R7
SXTH	R7, R1
UXTB	R3, R0
L_Display_Char65:
; j start address is: 24 (R6)
; b start address is: 28 (R7)
; s start address is: 12 (R3)
; Mode start address is: 48 (R12)
; Color start address is: 44 (R11)
; y0 start address is: 40 (R10)
; x0 start address is: 36 (R9)
; scanline start address is: 32 (R8)
; i start address is: 20 (R5)
CMP	R6, #14
IT	GE
BGE	L_Display_Char66
;Lcd.c,309 :: 		if(b&4) {
AND	R4, R7, #4
SXTH	R4, R4
CMP	R4, #0
IT	EQ
BEQ	L_Display_Char68
;Lcd.c,310 :: 		if(Mode==0) Set_Pixel(Color);
CMP	R12, #0
IT	NE
BNE	L_Display_Char69
UXTH	R0, R11
BL	_Set_Pixel+0
L_Display_Char69:
;Lcd.c,311 :: 		if(Mode==1) Set_Pixel(BLACK);
CMP	R12, #1
IT	NE
BNE	L_Display_Char70
MOVS	R0, #0
BL	_Set_Pixel+0
L_Display_Char70:
;Lcd.c,312 :: 		if(Mode==2) Set_Pixel(Color);
CMP	R12, #2
IT	NE
BNE	L_Display_Char71
UXTH	R0, R11
BL	_Set_Pixel+0
L_Display_Char71:
;Lcd.c,313 :: 		if(Mode==3) Set_Pixel(BLACK);
CMP	R12, #3
IT	NE
BNE	L_Display_Char72
MOVS	R0, #0
BL	_Set_Pixel+0
L_Display_Char72:
;Lcd.c,314 :: 		} else {
IT	AL
BAL	L_Display_Char73
L_Display_Char68:
;Lcd.c,315 :: 		if(Mode==0) Set_Pixel(BLACK);
CMP	R12, #0
IT	NE
BNE	L_Display_Char74
MOVS	R0, #0
BL	_Set_Pixel+0
L_Display_Char74:
;Lcd.c,316 :: 		if(Mode==1) Set_Pixel(Color);
CMP	R12, #1
IT	NE
BNE	L_Display_Char75
UXTH	R0, R11
BL	_Set_Pixel+0
L_Display_Char75:
;Lcd.c,317 :: 		if(Mode==2) Set_Pixel(BLACK);
CMP	R12, #2
IT	NE
BNE	L_Display_Char76
MOVS	R0, #0
BL	_Set_Pixel+0
L_Display_Char76:
;Lcd.c,318 :: 		if(Mode==3) Set_Pixel(Color);
CMP	R12, #3
IT	NE
BNE	L_Display_Char77
UXTH	R0, R11
BL	_Set_Pixel+0
L_Display_Char77:
;Lcd.c,319 :: 		}
L_Display_Char73:
;Lcd.c,320 :: 		b>>=1;
ASRS	R4, R7, #1
; b end address is: 28 (R7)
SXTH	R0, R4
;Lcd.c,308 :: 		for(j=0;j<14;++j){
ADDS	R6, R6, #1
SXTH	R6, R6
;Lcd.c,321 :: 		}
; j end address is: 24 (R6)
SXTH	R7, R0
IT	AL
BAL	L_Display_Char65
L_Display_Char66:
;Lcd.c,303 :: 		for(i=0;i<8;++i){
ADDS	R4, R5, #1
; i end address is: 20 (R5)
; i start address is: 28 (R7)
SXTH	R7, R4
;Lcd.c,322 :: 		}
UXTB	R0, R3
; s end address is: 12 (R3)
; Mode end address is: 48 (R12)
; Color end address is: 44 (R11)
; y0 end address is: 40 (R10)
; x0 end address is: 36 (R9)
; scanline end address is: 32 (R8)
; i end address is: 28 (R7)
IT	AL
BAL	L_Display_Char55
L_Display_Char56:
;Lcd.c,323 :: 		if(s==0x21) x0 +=4;
CMP	R0, #33
IT	NE
BNE	L_Display_Char78
IT	AL
BAL	L_Display_Char79
L_Display_Char78:
;Lcd.c,324 :: 		else  x0 += 8;
L_Display_Char79:
;Lcd.c,325 :: 		}
L_Display_Char54:
;Lcd.c,326 :: 		}
L_end_Display_Char:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _Display_Char
_Display_Str:
;Lcd.c,331 :: 		void Display_Str(unsigned int x0, unsigned int y0, unsigned int Color, unsigned char Mode, unsigned const char *s)
; Mode start address is: 12 (R3)
; Color start address is: 8 (R2)
; y0 start address is: 4 (R1)
SUB	SP, SP, #8
STR	LR, [SP, #0]
UXTH	R7, R0
UXTH	R9, R1
UXTH	R8, R2
UXTB	R10, R3
; Mode end address is: 12 (R3)
; Color end address is: 8 (R2)
; y0 end address is: 4 (R1)
; x0 start address is: 28 (R7)
; y0 start address is: 36 (R9)
; Color start address is: 32 (R8)
; Mode start address is: 40 (R10)
; s start address is: 44 (R11)
LDR	R11, [SP, #8]
;Lcd.c,334 :: 		Point_SCR(x0, y0);
UXTH	R1, R9
UXTH	R0, R7
BL	_Point_SCR+0
;Lcd.c,335 :: 		for (j=0; j<14;++j){
; j start address is: 24 (R6)
MOVS	R6, #0
SXTH	R6, R6
; Mode end address is: 40 (R10)
; s end address is: 44 (R11)
; x0 end address is: 28 (R7)
; j end address is: 24 (R6)
; y0 end address is: 36 (R9)
; Color end address is: 32 (R8)
UXTB	R5, R10
MOV	R3, R11
L_Display_Str80:
; j start address is: 24 (R6)
; s start address is: 12 (R3)
; Mode start address is: 20 (R5)
; Color start address is: 32 (R8)
; y0 start address is: 36 (R9)
; x0 start address is: 28 (R7)
CMP	R6, #14
IT	GE
BGE	L_Display_Str81
;Lcd.c,336 :: 		if(Mode==0) Set_Pixel(BLACK);   //Normal replace Display
CMP	R5, #0
IT	NE
BNE	L_Display_Str83
MOVS	R0, #0
BL	_Set_Pixel+0
L_Display_Str83:
;Lcd.c,337 :: 		if(Mode==1) Set_Pixel(Color);   //Inverse replace Display
CMP	R5, #1
IT	NE
BNE	L_Display_Str84
UXTH	R0, R8
BL	_Set_Pixel+0
L_Display_Str84:
;Lcd.c,335 :: 		for (j=0; j<14;++j){
ADDS	R6, R6, #1
SXTH	R6, R6
;Lcd.c,338 :: 		}
; j end address is: 24 (R6)
IT	AL
BAL	L_Display_Str80
L_Display_Str81:
;Lcd.c,339 :: 		x0++;
ADDS	R1, R7, #1
UXTH	R1, R1
; x0 end address is: 28 (R7)
; x0 start address is: 4 (R1)
; s end address is: 12 (R3)
; Mode end address is: 20 (R5)
; y0 end address is: 36 (R9)
; Color end address is: 32 (R8)
; x0 end address is: 4 (R1)
MOV	R0, R3
UXTB	R7, R5
;Lcd.c,340 :: 		while (*s!=0) {
L_Display_Str85:
; x0 start address is: 4 (R1)
; y0 start address is: 36 (R9)
; Color start address is: 32 (R8)
; Mode start address is: 28 (R7)
LDRB	R4, [R0, #0]
CMP	R4, #0
IT	EQ
BEQ	L_Display_Str86
;Lcd.c,341 :: 		unsigned const int *scanline=Char_Dot+((*s-0x22)*8);
LDRB	R4, [R0, #0]
SUBS	R4, #34
SXTH	R4, R4
LSLS	R4, R4, #3
SXTH	R4, R4
LSLS	R5, R4, #1
MOVW	R4, #lo_addr(_Char_Dot+0)
MOVT	R4, #hi_addr(_Char_Dot+0)
ADD	R12, R4, R5, LSL #0
; scanline start address is: 48 (R12)
;Lcd.c,342 :: 		for(i=0;i<8;++i){
; i start address is: 44 (R11)
MOVW	R11, #0
SXTH	R11, R11
; y0 end address is: 36 (R9)
; Color end address is: 32 (R8)
; Mode end address is: 28 (R7)
; scanline end address is: 48 (R12)
; i end address is: 44 (R11)
; x0 end address is: 4 (R1)
MOV	R10, R0
UXTH	R0, R1
L_Display_Str87:
; i start address is: 44 (R11)
; scanline start address is: 48 (R12)
; s start address is: 40 (R10)
; Mode start address is: 28 (R7)
; Color start address is: 32 (R8)
; y0 start address is: 36 (R9)
CMP	R11, #8
IT	GE
BGE	L_Display_Str88
;Lcd.c,343 :: 		Point_SCR(x0+i, y0);
ADD	R4, R0, R11, LSL #0
STRH	R0, [SP, #4]
UXTH	R1, R9
UXTH	R0, R4
BL	_Point_SCR+0
LDRH	R0, [SP, #4]
;Lcd.c,344 :: 		if((*s==0x20)||(*s==0x21)) b=0x0000;
LDRB	R4, [R10, #0]
CMP	R4, #32
IT	EQ
BEQ	L__Display_Str147
LDRB	R4, [R10, #0]
CMP	R4, #33
IT	EQ
BEQ	L__Display_Str146
IT	AL
BAL	L_Display_Str92
L__Display_Str147:
L__Display_Str146:
MOVS	R4, #0
SXTH	R4, R4
STRH	R4, [SP, #6]
IT	AL
BAL	L_Display_Str93
L_Display_Str92:
;Lcd.c,345 :: 		else                       b=scanline[i];
LSL	R4, R11, #1
ADD	R4, R12, R4, LSL #0
LDRH	R4, [R4, #0]
STRH	R4, [SP, #6]
L_Display_Str93:
;Lcd.c,346 :: 		if((*s==0x21)&&(i==4)) break;
LDRB	R4, [R10, #0]
CMP	R4, #33
IT	NE
BNE	L__Display_Str149
CMP	R11, #4
IT	NE
BNE	L__Display_Str148
; scanline end address is: 48 (R12)
; i end address is: 44 (R11)
L__Display_Str144:
IT	AL
BAL	L_Display_Str88
L__Display_Str149:
; i start address is: 44 (R11)
; scanline start address is: 48 (R12)
L__Display_Str148:
;Lcd.c,347 :: 		for(j=0;j<14;++j){
; j start address is: 20 (R5)
MOVS	R5, #0
SXTH	R5, R5
; y0 end address is: 36 (R9)
; Color end address is: 32 (R8)
; Mode end address is: 28 (R7)
; s end address is: 40 (R10)
; scanline end address is: 48 (R12)
; j end address is: 20 (R5)
; i end address is: 44 (R11)
SXTH	R6, R11
UXTH	R3, R0
L_Display_Str97:
; j start address is: 20 (R5)
; x0 start address is: 12 (R3)
; y0 start address is: 36 (R9)
; Color start address is: 32 (R8)
; Mode start address is: 28 (R7)
; s start address is: 40 (R10)
; scanline start address is: 48 (R12)
; i start address is: 24 (R6)
CMP	R5, #14
IT	GE
BGE	L_Display_Str98
;Lcd.c,348 :: 		if(b&4) {
LDRSH	R4, [SP, #6]
AND	R4, R4, #4
SXTH	R4, R4
CMP	R4, #0
IT	EQ
BEQ	L_Display_Str100
;Lcd.c,349 :: 		if(Mode==0) Set_Pixel(Color);
CMP	R7, #0
IT	NE
BNE	L_Display_Str101
UXTH	R0, R8
BL	_Set_Pixel+0
L_Display_Str101:
;Lcd.c,350 :: 		if(Mode==1) Set_Pixel(BLACK);
CMP	R7, #1
IT	NE
BNE	L_Display_Str102
MOVS	R0, #0
BL	_Set_Pixel+0
L_Display_Str102:
;Lcd.c,351 :: 		if(Mode==2) Set_Pixel(Color);
CMP	R7, #2
IT	NE
BNE	L_Display_Str103
UXTH	R0, R8
BL	_Set_Pixel+0
L_Display_Str103:
;Lcd.c,352 :: 		if(Mode==3) Set_Pixel(BLACK);
CMP	R7, #3
IT	NE
BNE	L_Display_Str104
MOVS	R0, #0
BL	_Set_Pixel+0
L_Display_Str104:
;Lcd.c,353 :: 		} else {
IT	AL
BAL	L_Display_Str105
L_Display_Str100:
;Lcd.c,354 :: 		if(Mode==0) Set_Pixel(BLACK);
CMP	R7, #0
IT	NE
BNE	L_Display_Str106
MOVS	R0, #0
BL	_Set_Pixel+0
L_Display_Str106:
;Lcd.c,355 :: 		if(Mode==1) Set_Pixel(Color);
CMP	R7, #1
IT	NE
BNE	L_Display_Str107
UXTH	R0, R8
BL	_Set_Pixel+0
L_Display_Str107:
;Lcd.c,356 :: 		if(Mode==2) Set_Pixel(BLACK);
CMP	R7, #2
IT	NE
BNE	L_Display_Str108
MOVS	R0, #0
BL	_Set_Pixel+0
L_Display_Str108:
;Lcd.c,357 :: 		if(Mode==3) Set_Pixel(Color);
CMP	R7, #3
IT	NE
BNE	L_Display_Str109
UXTH	R0, R8
BL	_Set_Pixel+0
L_Display_Str109:
;Lcd.c,358 :: 		}
L_Display_Str105:
;Lcd.c,359 :: 		b>>=1;
LDRSH	R4, [SP, #6]
ASRS	R4, R4, #1
STRH	R4, [SP, #6]
;Lcd.c,347 :: 		for(j=0;j<14;++j){
ADDS	R5, R5, #1
SXTH	R5, R5
;Lcd.c,360 :: 		}
; j end address is: 20 (R5)
IT	AL
BAL	L_Display_Str97
L_Display_Str98:
;Lcd.c,342 :: 		for(i=0;i<8;++i){
ADDS	R4, R6, #1
; i end address is: 24 (R6)
; i start address is: 44 (R11)
SXTH	R11, R4
;Lcd.c,361 :: 		}
UXTH	R0, R3
; x0 end address is: 12 (R3)
; scanline end address is: 48 (R12)
; i end address is: 44 (R11)
IT	AL
BAL	L_Display_Str87
L_Display_Str88:
;Lcd.c,362 :: 		if(*s==0x21) x0 +=4;
LDRB	R4, [R10, #0]
CMP	R4, #33
IT	NE
BNE	L_Display_Str110
ADDS	R1, R0, #4
UXTH	R1, R1
; x0 start address is: 4 (R1)
; x0 end address is: 4 (R1)
IT	AL
BAL	L_Display_Str111
L_Display_Str110:
;Lcd.c,363 :: 		else  x0 += 8;
ADDW	R1, R0, #8
UXTH	R1, R1
; x0 start address is: 4 (R1)
; x0 end address is: 4 (R1)
L_Display_Str111:
;Lcd.c,364 :: 		++s;                           //next character
; x0 start address is: 4 (R1)
ADD	R4, R10, #1
; s end address is: 40 (R10)
MOV	R0, R4
;Lcd.c,365 :: 		}
; y0 end address is: 36 (R9)
; Color end address is: 32 (R8)
; Mode end address is: 28 (R7)
; x0 end address is: 4 (R1)
IT	AL
BAL	L_Display_Str85
L_Display_Str86:
;Lcd.c,366 :: 		}
L_end_Display_Str:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _Display_Str
_Display_Logo:
;Lcd.c,370 :: 		void Display_Logo(unsigned int Dot_x, unsigned int Dot_y)
; Dot_y start address is: 4 (R1)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; Dot_y end address is: 4 (R1)
; Dot_y start address is: 4 (R1)
;Lcd.c,373 :: 		for (i=0; i<256;++i)
; i start address is: 28 (R7)
MOVS	R7, #0
; Dot_y end address is: 4 (R1)
; i end address is: 28 (R7)
UXTH	R9, R0
UXTH	R8, R1
L_Display_Logo112:
; i start address is: 28 (R7)
; Dot_y start address is: 32 (R8)
; Dot_x start address is: 36 (R9)
CMP	R7, #256
IT	CS
BCS	L_Display_Logo113
;Lcd.c,375 :: 		Point_SCR(Dot_x+i, Dot_y);
ADD	R2, R9, R7, LSL #0
UXTH	R1, R8
UXTH	R0, R2
BL	_Point_SCR+0
;Lcd.c,376 :: 		for (j=0; j<2;++j)
MOVS	R0, #0
; Dot_y end address is: 32 (R8)
; Dot_x end address is: 36 (R9)
; i end address is: 28 (R7)
UXTH	R6, R7
UXTH	R5, R8
UXTH	R1, R9
L_Display_Logo115:
; Dot_x start address is: 4 (R1)
; Dot_y start address is: 20 (R5)
; i start address is: 24 (R6)
CMP	R0, #2
IT	CS
BCS	L_Display_Logo116
;Lcd.c,378 :: 		b=Logo_Dot[(i*2)+j];
LSLS	R2, R6, #1
UXTH	R2, R2
ADDS	R2, R2, R0
UXTH	R2, R2
LSLS	R3, R2, #2
MOVW	R2, #lo_addr(_Logo_Dot+0)
MOVT	R2, #hi_addr(_Logo_Dot+0)
ADDS	R2, R2, R3
LDR	R7, [R2, #0]
; b start address is: 28 (R7)
;Lcd.c,379 :: 		for (k=0;k<32;++k)
; k start address is: 16 (R4)
MOVS	R4, #0
; Dot_x end address is: 4 (R1)
; i end address is: 24 (R6)
; Dot_y end address is: 20 (R5)
; b end address is: 28 (R7)
; k end address is: 16 (R4)
UXTH	R8, R0
UXTH	R3, R6
UXTH	R6, R1
L_Display_Logo118:
; k start address is: 16 (R4)
; b start address is: 28 (R7)
; i start address is: 12 (R3)
; Dot_y start address is: 20 (R5)
; Dot_x start address is: 24 (R6)
; j start address is: 32 (R8)
CMP	R4, #32
IT	CS
BCS	L_Display_Logo119
;Lcd.c,381 :: 		if(b&0x80000000)
AND	R2, R7, #-2147483648
CMP	R2, #0
IT	EQ
BEQ	L_Display_Logo121
;Lcd.c,383 :: 		Color=0x07E0; //Green?
MOVW	R0, #2016
;Lcd.c,384 :: 		}
IT	AL
BAL	L_Display_Logo122
L_Display_Logo121:
;Lcd.c,385 :: 		else Color=0;
MOVS	R0, #0
L_Display_Logo122:
;Lcd.c,386 :: 		Set_Pixel(Color);
BL	_Set_Pixel+0
;Lcd.c,387 :: 		b <<=1;
LSLS	R7, R7, #1
;Lcd.c,379 :: 		for (k=0;k<32;++k)
ADDS	R4, R4, #1
UXTH	R4, R4
;Lcd.c,388 :: 		}
; b end address is: 28 (R7)
; k end address is: 16 (R4)
IT	AL
BAL	L_Display_Logo118
L_Display_Logo119:
;Lcd.c,376 :: 		for (j=0; j<2;++j)
ADD	R2, R8, #1
; j end address is: 32 (R8)
UXTH	R0, R2
;Lcd.c,389 :: 		}
UXTH	R1, R6
; i end address is: 12 (R3)
; Dot_x end address is: 24 (R6)
UXTH	R6, R3
IT	AL
BAL	L_Display_Logo115
L_Display_Logo116:
;Lcd.c,373 :: 		for (i=0; i<256;++i)
; i start address is: 24 (R6)
; Dot_x start address is: 4 (R1)
ADDS	R7, R6, #1
UXTH	R7, R7
; i end address is: 24 (R6)
; i start address is: 28 (R7)
;Lcd.c,390 :: 		}
UXTH	R9, R1
; Dot_x end address is: 4 (R1)
; Dot_y end address is: 20 (R5)
; i end address is: 28 (R7)
UXTH	R8, R5
IT	AL
BAL	L_Display_Logo112
L_Display_Logo113:
;Lcd.c,392 :: 		for(i=3; i<317; ++i)
; i start address is: 28 (R7)
MOVS	R7, #3
; i end address is: 28 (R7)
L_Display_Logo123:
; i start address is: 28 (R7)
MOVW	R2, #317
CMP	R7, R2
IT	CS
BCS	L_Display_Logo124
;Lcd.c,394 :: 		Point_SCR(i, 3);
MOVS	R1, #3
UXTH	R0, R7
BL	_Point_SCR+0
;Lcd.c,395 :: 		Set_Pixel(0xFFFF);
MOVW	R0, #65535
BL	_Set_Pixel+0
;Lcd.c,396 :: 		Point_SCR(i, 236);
MOVS	R1, #236
UXTH	R0, R7
BL	_Point_SCR+0
;Lcd.c,397 :: 		Set_Pixel(0xFFFF);
MOVW	R0, #65535
BL	_Set_Pixel+0
;Lcd.c,392 :: 		for(i=3; i<317; ++i)
ADDS	R7, R7, #1
UXTH	R7, R7
;Lcd.c,398 :: 		}
; i end address is: 28 (R7)
IT	AL
BAL	L_Display_Logo123
L_Display_Logo124:
;Lcd.c,400 :: 		Point_SCR(0, 0);
MOVS	R1, #0
MOVS	R0, #0
BL	_Point_SCR+0
;Lcd.c,401 :: 		for(j=0; j<240; ++j) Set_Pixel(0xFFFF);
; j start address is: 12 (R3)
MOVS	R3, #0
; j end address is: 12 (R3)
L_Display_Logo126:
; j start address is: 12 (R3)
CMP	R3, #240
IT	CS
BCS	L_Display_Logo127
MOVW	R0, #65535
BL	_Set_Pixel+0
ADDS	R3, R3, #1
UXTH	R3, R3
; j end address is: 12 (R3)
IT	AL
BAL	L_Display_Logo126
L_Display_Logo127:
;Lcd.c,402 :: 		Point_SCR(3, 3);
MOVS	R1, #3
MOVS	R0, #3
BL	_Point_SCR+0
;Lcd.c,403 :: 		for(j=3; j<237; ++j) Set_Pixel(0xFFFF);
; j start address is: 12 (R3)
MOVS	R3, #3
; j end address is: 12 (R3)
L_Display_Logo129:
; j start address is: 12 (R3)
CMP	R3, #237
IT	CS
BCS	L_Display_Logo130
MOVW	R0, #65535
BL	_Set_Pixel+0
ADDS	R3, R3, #1
UXTH	R3, R3
; j end address is: 12 (R3)
IT	AL
BAL	L_Display_Logo129
L_Display_Logo130:
;Lcd.c,404 :: 		Point_SCR(316, 3);
MOVS	R1, #3
MOVW	R0, #316
BL	_Point_SCR+0
;Lcd.c,405 :: 		for(j=3; j<237; ++j) Set_Pixel(0xFFFF);
; j start address is: 12 (R3)
MOVS	R3, #3
; j end address is: 12 (R3)
L_Display_Logo132:
; j start address is: 12 (R3)
CMP	R3, #237
IT	CS
BCS	L_Display_Logo133
MOVW	R0, #65535
BL	_Set_Pixel+0
ADDS	R3, R3, #1
UXTH	R3, R3
; j end address is: 12 (R3)
IT	AL
BAL	L_Display_Logo132
L_Display_Logo133:
;Lcd.c,406 :: 		Point_SCR(319, 0);
MOVS	R1, #0
MOVW	R0, #319
BL	_Point_SCR+0
;Lcd.c,407 :: 		for(j=0; j<240; ++j) Set_Pixel(0xFFFF);
; j start address is: 12 (R3)
MOVS	R3, #0
; j end address is: 12 (R3)
L_Display_Logo135:
; j start address is: 12 (R3)
CMP	R3, #240
IT	CS
BCS	L_Display_Logo136
MOVW	R0, #65535
BL	_Set_Pixel+0
ADDS	R3, R3, #1
UXTH	R3, R3
; j end address is: 12 (R3)
IT	AL
BAL	L_Display_Logo135
L_Display_Logo136:
;Lcd.c,409 :: 		}
L_end_Display_Logo:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Display_Logo
