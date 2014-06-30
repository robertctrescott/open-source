_Delayms:
;Function.c,122 :: 		void Delayms(u16 mS)
SUB	SP, SP, #4
;Function.c,123 :: 		{  Delay_Counter=mS;  while(Delay_Counter) {}; }
MOVW	R1, #lo_addr(_Delay_Counter+0)
MOVT	R1, #hi_addr(_Delay_Counter+0)
STRB	R0, [R1, #0]
L_Delayms0:
MOVW	R1, #lo_addr(_Delay_Counter+0)
MOVT	R1, #hi_addr(_Delay_Counter+0)
LDRB	R1, [R1, #0]
CMP	R1, #0
IT	EQ
BEQ	L_Delayms1
IT	AL
BAL	L_Delayms0
L_Delayms1:
L_end_Delayms:
ADD	SP, SP, #4
BX	LR
; end of _Delayms
_Sync_Trig:
;Function.c,128 :: 		void Sync_Trig(void)
SUB	SP, SP, #4
;Function.c,131 :: 		for(_t0=150; _t0<(0x1000-X_SIZE);++_t0){
MOVS	R1, #150
MOVW	R0, #lo_addr(__t0+0)
MOVT	R0, #hi_addr(__t0+0)
STRB	R1, [R0, #0]
L_Sync_Trig2:
MOVW	R0, #lo_addr(__t0+0)
MOVT	R0, #hi_addr(__t0+0)
LDRB	R1, [R0, #0]
MOVW	R0, #3796
CMP	R1, R0
IT	GE
BGE	L_Sync_Trig3
;Function.c,132 :: 		if(_t0>=(0x1000-DMA_CNDTR1)) break;
MOVW	R0, 1073872908
MOVT	R0, 16386
LDR	R0, [R0, #0]
RSB	R1, R0, #4096
MOVW	R0, #lo_addr(__t0+0)
MOVT	R0, #hi_addr(__t0+0)
LDRB	R0, [R0, #0]
CMP	R0, R1
IT	CC
BCC	L_Sync_Trig5
IT	AL
BAL	L_Sync_Trig3
L_Sync_Trig5:
;Function.c,133 :: 		Vs=120+(Km[Item_Index[Y_SENSITIVITY]]*(2048-Scan_Buffer[_t0]))/4096;
MOVW	R0, #lo_addr(_Item_Index+1)
MOVT	R0, #hi_addr(_Item_Index+1)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_Km+0)
MOVT	R0, #hi_addr(_Km+0)
ADDS	R0, R0, R1
LDRB	R2, [R0, #0]
MOVW	R0, #lo_addr(__t0+0)
MOVT	R0, #hi_addr(__t0+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_Scan_Buffer+0)
MOVT	R0, #hi_addr(_Scan_Buffer+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
RSB	R0, R0, #2048
SXTH	R0, R0
MULS	R0, R2, R0
SXTH	R0, R0
ASRS	R0, R0, #12
SXTH	R0, R0
ADDS	R0, #120
; Vs start address is: 8 (R2)
SXTH	R2, R0
;Function.c,134 :: 		if(Item_Index[TRIG_SLOPE]==0) { //rising edge
MOVW	R0, #lo_addr(_Item_Index+7)
MOVT	R0, #hi_addr(_Item_Index+7)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_Sync_Trig6
;Function.c,135 :: 		if(Vs<(_vt-Item_Index[TRIG_SENSITIVITY])&&(Sync==0)) Sync=1;
MOVW	R0, #lo_addr(_Item_Index+6)
MOVT	R0, #hi_addr(_Item_Index+6)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(__vt+0)
MOVT	R0, #hi_addr(__vt+0)
LDRB	R0, [R0, #0]
SUB	R0, R0, R1
SXTH	R0, R0
CMP	R2, R0
IT	GE
BGE	L__Sync_Trig204
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L__Sync_Trig203
L__Sync_Trig202:
MOVS	R1, #1
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
STRB	R1, [R0, #0]
L__Sync_Trig204:
L__Sync_Trig203:
;Function.c,136 :: 		if(Vs>(_vt+Item_Index[TRIG_SENSITIVITY])&&(Sync==1)) Sync=2;
MOVW	R0, #lo_addr(_Item_Index+6)
MOVT	R0, #hi_addr(_Item_Index+6)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(__vt+0)
MOVT	R0, #hi_addr(__vt+0)
LDRB	R0, [R0, #0]
ADDS	R0, R0, R1
SXTH	R0, R0
CMP	R2, R0
IT	LE
BLE	L__Sync_Trig206
; Vs end address is: 8 (R2)
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L__Sync_Trig205
L__Sync_Trig201:
MOVS	R1, #2
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
STRB	R1, [R0, #0]
L__Sync_Trig206:
L__Sync_Trig205:
;Function.c,137 :: 		} else {                       //falling edge
IT	AL
BAL	L_Sync_Trig13
L_Sync_Trig6:
;Function.c,138 :: 		if(Vs>(_vt+Item_Index[TRIG_SENSITIVITY])&&(Sync==0)) Sync=1;
; Vs start address is: 8 (R2)
MOVW	R0, #lo_addr(_Item_Index+6)
MOVT	R0, #hi_addr(_Item_Index+6)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(__vt+0)
MOVT	R0, #hi_addr(__vt+0)
LDRB	R0, [R0, #0]
ADDS	R0, R0, R1
SXTH	R0, R0
CMP	R2, R0
IT	LE
BLE	L__Sync_Trig208
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L__Sync_Trig207
L__Sync_Trig200:
MOVS	R1, #1
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
STRB	R1, [R0, #0]
L__Sync_Trig208:
L__Sync_Trig207:
;Function.c,139 :: 		if(Vs<(_vt-Item_Index[TRIG_SENSITIVITY])&&(Sync==1)) Sync=2;
MOVW	R0, #lo_addr(_Item_Index+6)
MOVT	R0, #hi_addr(_Item_Index+6)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(__vt+0)
MOVT	R0, #hi_addr(__vt+0)
LDRB	R0, [R0, #0]
SUB	R0, R0, R1
SXTH	R0, R0
CMP	R2, R0
IT	GE
BGE	L__Sync_Trig210
; Vs end address is: 8 (R2)
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L__Sync_Trig209
L__Sync_Trig199:
MOVS	R1, #2
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
STRB	R1, [R0, #0]
L__Sync_Trig210:
L__Sync_Trig209:
;Function.c,140 :: 		}
L_Sync_Trig13:
;Function.c,141 :: 		if(Sync==2) break;
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_Sync_Trig20
IT	AL
BAL	L_Sync_Trig3
L_Sync_Trig20:
;Function.c,131 :: 		for(_t0=150; _t0<(0x1000-X_SIZE);++_t0){
MOVW	R1, #lo_addr(__t0+0)
MOVT	R1, #hi_addr(__t0+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
STRB	R0, [R1, #0]
;Function.c,142 :: 		}
IT	AL
BAL	L_Sync_Trig2
L_Sync_Trig3:
;Function.c,143 :: 		X_Counter=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_X_Counter+0)
MOVT	R0, #hi_addr(_X_Counter+0)
STRB	R1, [R0, #0]
;Function.c,144 :: 		if(_t0>=(0x1000-X_SIZE)) Sync=3;//Fail
MOVW	R0, #lo_addr(__t0+0)
MOVT	R0, #hi_addr(__t0+0)
LDRB	R1, [R0, #0]
MOVW	R0, #3796
CMP	R1, R0
IT	LT
BLT	L_Sync_Trig21
MOVS	R1, #3
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
STRB	R1, [R0, #0]
L_Sync_Trig21:
;Function.c,146 :: 		}
L_end_Sync_Trig:
ADD	SP, SP, #4
BX	LR
; end of _Sync_Trig
_Signal_Process:
;Function.c,151 :: 		void Signal_Process(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Function.c,154 :: 		if(Sync==3) _t0=150; //If SYNC Fail
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BNE	L_Signal_Process22
MOVS	R1, #150
MOVW	R0, #lo_addr(__t0+0)
MOVT	R0, #hi_addr(__t0+0)
STRB	R1, [R0, #0]
L_Signal_Process22:
;Function.c,155 :: 		p=_t0+Item_Index[X_POSITION]-4096;
MOVW	R0, #lo_addr(_Item_Index+14)
MOVT	R0, #hi_addr(_Item_Index+14)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(__t0+0)
MOVT	R0, #hi_addr(__t0+0)
LDRB	R0, [R0, #0]
ADDS	R4, R0, R1
SXTH	R4, R4
SUB	R4, R4, #4096
SXTH	R4, R4
; p start address is: 16 (R4)
;Function.c,156 :: 		for(i=X_Counter; i<(X_SIZE); ++i){
MOVW	R0, #lo_addr(_X_Counter+0)
MOVT	R0, #hi_addr(_X_Counter+0)
; i start address is: 20 (R5)
LDRB	R5, [R0, #0]
; i end address is: 20 (R5)
L_Signal_Process23:
; i start address is: 20 (R5)
; p start address is: 16 (R4)
; p end address is: 16 (R4)
CMP	R5, #300
IT	GE
BGE	L_Signal_Process24
; p end address is: 16 (R4)
;Function.c,157 :: 		Sync=5;
; p start address is: 16 (R4)
MOVS	R1, #5
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
STRB	R1, [R0, #0]
;Function.c,158 :: 		q=p+(i*1024)/Ks[Item_Index[X_SENSITIVITY]];
LSLS	R2, R5, #10
SXTH	R2, R2
MOVW	R0, #lo_addr(_Item_Index+2)
MOVT	R0, #hi_addr(_Item_Index+2)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_Ks+0)
MOVT	R0, #hi_addr(_Ks+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
SDIV	R0, R2, R0
SXTH	R0, R0
ADDS	R0, R4, R0
SXTH	R0, R0
; q start address is: 4 (R1)
SXTH	R1, R0
;Function.c,159 :: 		if(q<0) {
CMP	R0, #0
IT	GE
BGE	L__Signal_Process222
; q end address is: 4 (R1)
;Function.c,160 :: 		q=0;
; q start address is: 8 (R2)
MOVS	R2, #0
SXTH	R2, R2
;Function.c,161 :: 		Item_Index[X_POSITION]++;
MOVW	R1, #lo_addr(_Item_Index+14)
MOVT	R1, #hi_addr(_Item_Index+14)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
STRB	R0, [R1, #0]
; q end address is: 8 (R2)
SXTH	R6, R2
;Function.c,162 :: 		}
IT	AL
BAL	L_Signal_Process26
L__Signal_Process222:
;Function.c,159 :: 		if(q<0) {
SXTH	R6, R1
;Function.c,162 :: 		}
L_Signal_Process26:
;Function.c,163 :: 		if(q>=0x1000) {
; q start address is: 24 (R6)
CMP	R6, #4096
IT	LT
BLT	L__Signal_Process223
;Function.c,164 :: 		q=0x1000-1;
MOVW	R6, #4095
SXTH	R6, R6
;Function.c,165 :: 		Item_Index[X_POSITION]--;
MOVW	R1, #lo_addr(_Item_Index+14)
MOVT	R1, #hi_addr(_Item_Index+14)
LDRB	R0, [R1, #0]
SUBS	R0, R0, #1
STRB	R0, [R1, #0]
; q end address is: 24 (R6)
;Function.c,166 :: 		}
IT	AL
BAL	L_Signal_Process27
L__Signal_Process223:
;Function.c,163 :: 		if(q>=0x1000) {
;Function.c,166 :: 		}
L_Signal_Process27:
;Function.c,167 :: 		if(q>=(0x1000-DMA_CNDTR1)) break;
; q start address is: 24 (R6)
MOVW	R0, 1073872908
MOVT	R0, 16386
LDR	R0, [R0, #0]
RSB	R0, R0, #4096
CMP	R6, R0
IT	CC
BCC	L_Signal_Process28
; p end address is: 16 (R4)
; q end address is: 24 (R6)
; i end address is: 20 (R5)
IT	AL
BAL	L_Signal_Process24
L_Signal_Process28:
;Function.c,168 :: 		X_Counter=i+1;
; i start address is: 20 (R5)
; q start address is: 24 (R6)
; p start address is: 16 (R4)
ADDS	R1, R5, #1
MOVW	R0, #lo_addr(_X_Counter+0)
MOVT	R0, #hi_addr(_X_Counter+0)
STRB	R1, [R0, #0]
;Function.c,169 :: 		Vr=Km[Item_Index[Y_SENSITIVITY]]*(Scan_Buffer[q+1]-Scan_Buffer[q])/4096;
MOVW	R0, #lo_addr(_Item_Index+1)
MOVT	R0, #hi_addr(_Item_Index+1)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_Km+0)
MOVT	R0, #hi_addr(_Km+0)
ADDS	R0, R0, R1
LDRB	R3, [R0, #0]
ADDS	R1, R6, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_Scan_Buffer+0)
MOVT	R0, #hi_addr(_Scan_Buffer+0)
ADDS	R0, R0, R1
LDRB	R2, [R0, #0]
MOVW	R0, #lo_addr(_Scan_Buffer+0)
MOVT	R0, #hi_addr(_Scan_Buffer+0)
ADDS	R0, R0, R6
; q end address is: 24 (R6)
LDRB	R1, [R0, #0]
SUB	R0, R2, R1
SXTH	R0, R0
MULS	R0, R3, R0
SXTH	R0, R0
ASRS	R0, R0, #12
; Vr start address is: 24 (R6)
SXTH	R6, R0
;Function.c,170 :: 		Vs=(Km[Item_Index[Y_SENSITIVITY]]*(2048-Scan_Buffer[q]))/4096+120
RSB	R0, R1, #2048
SXTH	R0, R0
MULS	R0, R3, R0
SXTH	R0, R0
ASRS	R0, R0, #12
SXTH	R0, R0
ADDW	R3, R0, #120
SXTH	R3, R3
;Function.c,171 :: 		-(((i*1024)%Ks[Item_Index[X_SENSITIVITY]])*Vr)/Ks[Item_Index[X_SENSITIVITY]];
LSLS	R2, R5, #10
SXTH	R2, R2
MOVW	R0, #lo_addr(_Item_Index+2)
MOVT	R0, #hi_addr(_Item_Index+2)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_Ks+0)
MOVT	R0, #hi_addr(_Ks+0)
ADDS	R0, R0, R1
LDRB	R1, [R0, #0]
SDIV	R0, R2, R1
MLS	R0, R1, R0, R2
SXTH	R0, R0
MULS	R0, R6, R0
SXTH	R0, R0
; Vr end address is: 24 (R6)
SDIV	R0, R0, R1
SXTH	R0, R0
SUB	R0, R3, R0
SXTH	R0, R0
; Vs start address is: 4 (R1)
SXTH	R1, R0
;Function.c,172 :: 		if(Vs>MAX_Y)  Vs=MAX_Y;
CMP	R0, #219
IT	LE
BLE	L_Signal_Process29
MOVS	R1, #219
SXTH	R1, R1
IT	AL
BAL	L_Signal_Process30
L_Signal_Process29:
;Function.c,173 :: 		else if(Vs<MIN_Y) Vs=MIN_Y;
CMP	R1, #19
IT	GE
BGE	L__Signal_Process224
; Vs end address is: 4 (R1)
MOVS	R0, #19
SXTH	R0, R0
SXTH	R1, R0
IT	AL
BAL	L_Signal_Process31
L__Signal_Process224:
L_Signal_Process31:
; Vs start address is: 4 (R1)
; Vs end address is: 4 (R1)
L_Signal_Process30:
;Function.c,174 :: 		Signal_Buffer[i]=Vs;
; Vs start address is: 4 (R1)
MOVW	R0, #lo_addr(_Signal_Buffer+0)
MOVT	R0, #hi_addr(_Signal_Buffer+0)
ADDS	R0, R0, R5
STRB	R1, [R0, #0]
; Vs end address is: 4 (R1)
;Function.c,175 :: 		Sync=4;       //Process finish
MOVS	R1, #4
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
STRB	R1, [R0, #0]
;Function.c,156 :: 		for(i=X_Counter; i<(X_SIZE); ++i){
ADDS	R5, R5, #1
SXTH	R5, R5
;Function.c,176 :: 		}
; p end address is: 16 (R4)
; i end address is: 20 (R5)
IT	AL
BAL	L_Signal_Process23
L_Signal_Process24:
;Function.c,177 :: 		if(DMA_CNDTR1==0) {
MOVW	R0, 1073872908
MOVT	R0, 16386
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_Signal_Process32
;Function.c,178 :: 		Measure_Wave();
BL	_Measure_Wave+0
;Function.c,179 :: 		if(Item_Index[RUNNING_STATUS]==RUN) ADC_Start();
MOVW	R0, #lo_addr(_Item_Index+15)
MOVT	R0, #hi_addr(_Item_Index+15)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_Signal_Process33
BL	_ADC_Start+0
L_Signal_Process33:
;Function.c,180 :: 		}
L_Signal_Process32:
;Function.c,181 :: 		}
L_end_Signal_Process:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Signal_Process
_Erase_Draw:
;Function.c,186 :: 		void Erase_Draw(void)
SUB	SP, SP, #12
STR	LR, [SP, #0]
;Function.c,191 :: 		y1=View_Buffer[0];
MOVW	R0, #lo_addr(_View_Buffer+0)
MOVT	R0, #hi_addr(_View_Buffer+0)
LDRB	R0, [R0, #0]
STRB	R0, [SP, #6]
;Function.c,192 :: 		y3=Signal_Buffer[0];
MOVW	R0, #lo_addr(_Signal_Buffer+0)
MOVT	R0, #hi_addr(_Signal_Buffer+0)
LDRB	R0, [R0, #0]
STRB	R0, [SP, #8]
;Function.c,193 :: 		y5=Ref_Buffer[0];
MOVW	R0, #lo_addr(_Ref_Buffer+0)
MOVT	R0, #hi_addr(_Ref_Buffer+0)
LDRB	R0, [R0, #0]
STRB	R0, [SP, #9]
;Function.c,195 :: 		for(i=0; i<X_Counter; ++i){
; i start address is: 4 (R1)
MOVS	R1, #0
; i end address is: 4 (R1)
L_Erase_Draw34:
; i start address is: 4 (R1)
MOVW	R0, #lo_addr(_X_Counter+0)
MOVT	R0, #hi_addr(_X_Counter+0)
LDRB	R0, [R0, #0]
CMP	R1, R0
IT	CS
BCS	L_Erase_Draw35
;Function.c,196 :: 		y2=View_Buffer[i];
MOVW	R0, #lo_addr(_View_Buffer+0)
MOVT	R0, #hi_addr(_View_Buffer+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [SP, #7]
;Function.c,197 :: 		Erase_SEG(i,y1,y2);
STRB	R1, [SP, #4]
UXTB	R2, R0
UXTB	R0, R1
LDRB	R1, [SP, #6]
BL	_Erase_SEG+0
LDRB	R1, [SP, #4]
;Function.c,198 :: 		y1 = y2;
LDRB	R0, [SP, #7]
STRB	R0, [SP, #6]
;Function.c,199 :: 		y4=Signal_Buffer[i];
MOVW	R0, #lo_addr(_Signal_Buffer+0)
MOVT	R0, #hi_addr(_Signal_Buffer+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
; y4 start address is: 8 (R2)
UXTB	R2, R0
;Function.c,200 :: 		Draw_SEG(i,y3,y4,CURVE);
STRB	R2, [SP, #4]
STRB	R1, [SP, #5]
MOVS	R3, #142
UXTB	R2, R0
UXTB	R0, R1
LDRB	R1, [SP, #8]
BL	_Draw_SEG+0
LDRB	R1, [SP, #5]
LDRB	R2, [SP, #4]
;Function.c,201 :: 		y3 = y4;
STRB	R2, [SP, #8]
;Function.c,202 :: 		View_Buffer[i]=y4;
MOVW	R0, #lo_addr(_View_Buffer+0)
MOVT	R0, #hi_addr(_View_Buffer+0)
ADDS	R0, R0, R1
STRB	R2, [R0, #0]
; y4 end address is: 8 (R2)
;Function.c,203 :: 		y6=Ref_Buffer[i];
MOVW	R0, #lo_addr(_Ref_Buffer+0)
MOVT	R0, #hi_addr(_Ref_Buffer+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
; y6 start address is: 8 (R2)
UXTB	R2, R0
;Function.c,204 :: 		if(Hide_Ref==0) Draw_SEG(i,y5,y6,MODEL);
MOVW	R0, #lo_addr(_Hide_Ref+0)
MOVT	R0, #hi_addr(_Hide_Ref+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_Erase_Draw37
STRB	R2, [SP, #4]
STRB	R1, [SP, #5]
MOVS	R3, #94
UXTB	R0, R1
LDRB	R1, [SP, #9]
BL	_Draw_SEG+0
LDRB	R1, [SP, #5]
LDRB	R2, [SP, #4]
L_Erase_Draw37:
;Function.c,205 :: 		y5 = y6;
STRB	R2, [SP, #9]
; y6 end address is: 8 (R2)
;Function.c,195 :: 		for(i=0; i<X_Counter; ++i){
ADDS	R0, R1, #1
; i end address is: 4 (R1)
;Function.c,206 :: 		}
UXTB	R1, R0
IT	AL
BAL	L_Erase_Draw34
L_Erase_Draw35:
;Function.c,208 :: 		if(X_Counter>=X_SIZE-1) {//frame finish
MOVW	R0, #lo_addr(_X_Counter+0)
MOVT	R0, #hi_addr(_X_Counter+0)
LDRB	R1, [R0, #0]
MOVW	R0, #299
CMP	R1, R0
IT	LT
BLT	L_Erase_Draw38
;Function.c,209 :: 		Stop=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Stop+0)
MOVT	R0, #hi_addr(_Stop+0)
STRB	R1, [R0, #0]
;Function.c,210 :: 		X_Counter=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_X_Counter+0)
MOVT	R0, #hi_addr(_X_Counter+0)
STRB	R1, [R0, #0]
;Function.c,211 :: 		Battery_Detect();
BL	_Battery_Detect+0
;Function.c,212 :: 		if((((Frame+2)*X_SIZE)+_t0+Item_Index[14])<0x1000) Frame++;
MOVW	R0, #lo_addr(_Frame+0)
MOVT	R0, #hi_addr(_Frame+0)
LDRB	R0, [R0, #0]
ADDS	R1, R0, #2
SXTH	R1, R1
MOVW	R0, #300
SXTH	R0, R0
MULS	R1, R0, R1
SXTH	R1, R1
MOVW	R0, #lo_addr(__t0+0)
MOVT	R0, #hi_addr(__t0+0)
LDRB	R0, [R0, #0]
ADDS	R1, R1, R0
SXTH	R1, R1
MOVW	R0, #lo_addr(_Item_Index+14)
MOVT	R0, #hi_addr(_Item_Index+14)
LDRB	R0, [R0, #0]
ADDS	R0, R1, R0
SXTH	R0, R0
CMP	R0, #4096
IT	GE
BGE	L_Erase_Draw39
MOVW	R1, #lo_addr(_Frame+0)
MOVT	R1, #hi_addr(_Frame+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
STRB	R0, [R1, #0]
IT	AL
BAL	L_Erase_Draw40
L_Erase_Draw39:
;Function.c,214 :: 		Frame=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Frame+0)
MOVT	R0, #hi_addr(_Frame+0)
STRB	R1, [R0, #0]
;Function.c,215 :: 		Sync=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
STRB	R1, [R0, #0]
;Function.c,216 :: 		}
L_Erase_Draw40:
;Function.c,217 :: 		Delay_Counter=100;
MOVS	R1, #100
MOVW	R0, #lo_addr(_Delay_Counter+0)
MOVT	R0, #hi_addr(_Delay_Counter+0)
STRB	R1, [R0, #0]
;Function.c,218 :: 		if(Item_Index[0]!=4) Sync=0;//Resume
MOVW	R0, #lo_addr(_Item_Index+0)
MOVT	R0, #hi_addr(_Item_Index+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	EQ
BEQ	L_Erase_Draw41
MOVS	R1, #0
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
STRB	R1, [R0, #0]
IT	AL
BAL	L_Erase_Draw42
L_Erase_Draw41:
;Function.c,219 :: 		else Erase_Wave(CURVE);
MOVS	R0, #142
BL	_Erase_Wave+0
L_Erase_Draw42:
;Function.c,220 :: 		} else {
IT	AL
BAL	L_Erase_Draw43
L_Erase_Draw38:
;Function.c,221 :: 		Sync=2;
MOVS	R1, #2
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
STRB	R1, [R0, #0]
;Function.c,222 :: 		Stop=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Stop+0)
MOVT	R0, #hi_addr(_Stop+0)
STRB	R1, [R0, #0]
;Function.c,223 :: 		}
L_Erase_Draw43:
;Function.c,224 :: 		}
L_end_Erase_Draw:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _Erase_Draw
_Scan_Wave:
;Function.c,229 :: 		void Scan_Wave(void)//SYNC mode: AUTO¡¢NORM¡¢SIGN¡¢NONE
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Function.c,233 :: 		if(Item_Index[SYNC_MODE]==0) {
MOVW	R0, #lo_addr(_Item_Index+0)
MOVT	R0, #hi_addr(_Item_Index+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_Scan_Wave44
;Function.c,234 :: 		Frame=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Frame+0)
MOVT	R0, #hi_addr(_Frame+0)
STRB	R1, [R0, #0]
;Function.c,235 :: 		if(Item_Index[RUNNING_STATUS]==RUN){
MOVW	R0, #lo_addr(_Item_Index+15)
MOVT	R0, #hi_addr(_Item_Index+15)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_Scan_Wave45
;Function.c,236 :: 		Stop=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Stop+0)
MOVT	R0, #hi_addr(_Stop+0)
STRB	R1, [R0, #0]
;Function.c,237 :: 		if((Sync==0)||(Sync==1)) Sync_Trig();
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L__Scan_Wave235
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L__Scan_Wave234
IT	AL
BAL	L_Scan_Wave48
L__Scan_Wave235:
L__Scan_Wave234:
BL	_Sync_Trig+0
L_Scan_Wave48:
;Function.c,238 :: 		} else {                //in 'HOLD' status
IT	AL
BAL	L_Scan_Wave49
L_Scan_Wave45:
;Function.c,239 :: 		Sync=2;
MOVS	R1, #2
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
STRB	R1, [R0, #0]
;Function.c,240 :: 		X_Counter=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_X_Counter+0)
MOVT	R0, #hi_addr(_X_Counter+0)
STRB	R1, [R0, #0]
;Function.c,241 :: 		}
L_Scan_Wave49:
;Function.c,242 :: 		if((Sync==2)||(Sync==3)) Signal_Process();
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L__Scan_Wave237
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L__Scan_Wave236
IT	AL
BAL	L_Scan_Wave52
L__Scan_Wave237:
L__Scan_Wave236:
BL	_Signal_Process+0
L_Scan_Wave52:
;Function.c,243 :: 		if((Sync>3)&&(Delay_Counter==0)) Erase_Draw();
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	LS
BLS	L__Scan_Wave239
MOVW	R0, #lo_addr(_Delay_Counter+0)
MOVT	R0, #hi_addr(_Delay_Counter+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L__Scan_Wave238
L__Scan_Wave231:
BL	_Erase_Draw+0
L__Scan_Wave239:
L__Scan_Wave238:
;Function.c,244 :: 		}
L_Scan_Wave44:
;Function.c,247 :: 		if(Item_Index[SYNC_MODE]==1){
MOVW	R0, #lo_addr(_Item_Index+0)
MOVT	R0, #hi_addr(_Item_Index+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_Scan_Wave56
;Function.c,248 :: 		Frame=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Frame+0)
MOVT	R0, #hi_addr(_Frame+0)
STRB	R1, [R0, #0]
;Function.c,249 :: 		if(Item_Index[RUNNING_STATUS]==RUN){
MOVW	R0, #lo_addr(_Item_Index+15)
MOVT	R0, #hi_addr(_Item_Index+15)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_Scan_Wave57
;Function.c,250 :: 		Stop=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Stop+0)
MOVT	R0, #hi_addr(_Stop+0)
STRB	R1, [R0, #0]
;Function.c,251 :: 		if((Sync==0)||(Sync==1)) Sync_Trig();
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L__Scan_Wave241
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L__Scan_Wave240
IT	AL
BAL	L_Scan_Wave60
L__Scan_Wave241:
L__Scan_Wave240:
BL	_Sync_Trig+0
L_Scan_Wave60:
;Function.c,252 :: 		} else {                //in 'HOLD' status
IT	AL
BAL	L_Scan_Wave61
L_Scan_Wave57:
;Function.c,253 :: 		Sync=2;
MOVS	R1, #2
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
STRB	R1, [R0, #0]
;Function.c,254 :: 		X_Counter=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_X_Counter+0)
MOVT	R0, #hi_addr(_X_Counter+0)
STRB	R1, [R0, #0]
;Function.c,255 :: 		}
L_Scan_Wave61:
;Function.c,256 :: 		if(Sync==3) Erase_Wave(CURVE);
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BNE	L_Scan_Wave62
MOVS	R0, #142
BL	_Erase_Wave+0
L_Scan_Wave62:
;Function.c,257 :: 		if(Sync==2) Signal_Process();
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_Scan_Wave63
BL	_Signal_Process+0
L_Scan_Wave63:
;Function.c,258 :: 		if((Sync>3)&&(Delay_Counter==0)) Erase_Draw();
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	LS
BLS	L__Scan_Wave243
MOVW	R0, #lo_addr(_Delay_Counter+0)
MOVT	R0, #hi_addr(_Delay_Counter+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L__Scan_Wave242
L__Scan_Wave229:
BL	_Erase_Draw+0
L__Scan_Wave243:
L__Scan_Wave242:
;Function.c,259 :: 		}
L_Scan_Wave56:
;Function.c,261 :: 		if(Item_Index[SYNC_MODE]==2){
MOVW	R0, #lo_addr(_Item_Index+0)
MOVT	R0, #hi_addr(_Item_Index+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_Scan_Wave67
;Function.c,262 :: 		Frame=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Frame+0)
MOVT	R0, #hi_addr(_Frame+0)
STRB	R1, [R0, #0]
;Function.c,263 :: 		if(Item_Index[RUNNING_STATUS]==RUN){  //in 'RUN' status
MOVW	R0, #lo_addr(_Item_Index+15)
MOVT	R0, #hi_addr(_Item_Index+15)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_Scan_Wave68
;Function.c,264 :: 		Stop=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Stop+0)
MOVT	R0, #hi_addr(_Stop+0)
STRB	R1, [R0, #0]
;Function.c,265 :: 		if((Sync==0)||(Sync==1)) Sync_Trig();
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L__Scan_Wave245
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L__Scan_Wave244
IT	AL
BAL	L_Scan_Wave71
L__Scan_Wave245:
L__Scan_Wave244:
BL	_Sync_Trig+0
L_Scan_Wave71:
;Function.c,266 :: 		} else {                //in 'HOLD' status
IT	AL
BAL	L_Scan_Wave72
L_Scan_Wave68:
;Function.c,267 :: 		Sync=2;
MOVS	R1, #2
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
STRB	R1, [R0, #0]
;Function.c,268 :: 		X_Counter=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_X_Counter+0)
MOVT	R0, #hi_addr(_X_Counter+0)
STRB	R1, [R0, #0]
;Function.c,269 :: 		}
L_Scan_Wave72:
;Function.c,270 :: 		if(Sync==3) Erase_Wave(CURVE);
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BNE	L_Scan_Wave73
MOVS	R0, #142
BL	_Erase_Wave+0
L_Scan_Wave73:
;Function.c,271 :: 		if(Sync==2) Signal_Process();
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_Scan_Wave74
BL	_Signal_Process+0
L_Scan_Wave74:
;Function.c,272 :: 		if((Sync>3)&&(Delay_Counter==0)) Erase_Draw();
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	LS
BLS	L__Scan_Wave247
MOVW	R0, #lo_addr(_Delay_Counter+0)
MOVT	R0, #hi_addr(_Delay_Counter+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L__Scan_Wave246
L__Scan_Wave227:
BL	_Erase_Draw+0
L__Scan_Wave247:
L__Scan_Wave246:
;Function.c,273 :: 		Item_Index[RUNNING_STATUS]=HOLD;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Item_Index+15)
MOVT	R0, #hi_addr(_Item_Index+15)
STRB	R1, [R0, #0]
;Function.c,274 :: 		Update[RUNNING_STATUS]=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Update+15)
MOVT	R0, #hi_addr(_Update+15)
STRB	R1, [R0, #0]
;Function.c,275 :: 		}
L_Scan_Wave67:
;Function.c,277 :: 		if(Item_Index[SYNC_MODE]==3){
MOVW	R0, #lo_addr(_Item_Index+0)
MOVT	R0, #hi_addr(_Item_Index+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BNE	L_Scan_Wave78
;Function.c,278 :: 		Frame=0; X_Counter=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Frame+0)
MOVT	R0, #hi_addr(_Frame+0)
STRB	R1, [R0, #0]
MOVS	R1, #0
MOVW	R0, #lo_addr(_X_Counter+0)
MOVT	R0, #hi_addr(_X_Counter+0)
STRB	R1, [R0, #0]
;Function.c,279 :: 		if(Item_Index[RUNNING_STATUS]==RUN){  //in 'RUN' status
MOVW	R0, #lo_addr(_Item_Index+15)
MOVT	R0, #hi_addr(_Item_Index+15)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_Scan_Wave79
;Function.c,280 :: 		Sync=3; Stop=0;
MOVS	R1, #3
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
STRB	R1, [R0, #0]
MOVS	R1, #0
MOVW	R0, #lo_addr(_Stop+0)
MOVT	R0, #hi_addr(_Stop+0)
STRB	R1, [R0, #0]
;Function.c,281 :: 		} else {                //in 'HOLD' status
IT	AL
BAL	L_Scan_Wave80
L_Scan_Wave79:
;Function.c,282 :: 		Sync=2;
MOVS	R1, #2
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
STRB	R1, [R0, #0]
;Function.c,283 :: 		}
L_Scan_Wave80:
;Function.c,284 :: 		if((Sync==2)||(Sync==3)) Signal_Process();
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L__Scan_Wave249
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L__Scan_Wave248
IT	AL
BAL	L_Scan_Wave83
L__Scan_Wave249:
L__Scan_Wave248:
BL	_Signal_Process+0
L_Scan_Wave83:
;Function.c,286 :: 		if((Sync>3)&&(Delay_Counter==0)) Erase_Draw();
MOVW	R0, #lo_addr(_Sync+0)
MOVT	R0, #hi_addr(_Sync+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	LS
BLS	L__Scan_Wave251
MOVW	R0, #lo_addr(_Delay_Counter+0)
MOVT	R0, #hi_addr(_Delay_Counter+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L__Scan_Wave250
L__Scan_Wave225:
BL	_Erase_Draw+0
L__Scan_Wave251:
L__Scan_Wave250:
;Function.c,287 :: 		}
L_Scan_Wave78:
;Function.c,288 :: 		}
L_end_Scan_Wave:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Scan_Wave
_Measure_Wave:
;Function.c,292 :: 		void Measure_Wave(void)
SUB	SP, SP, #4
;Function.c,294 :: 		unsigned short i=0, Edge=0, Trig=0;
; Edge start address is: 24 (R6)
MOVS	R6, #0
; Trig start address is: 28 (R7)
MOVS	R7, #0
;Function.c,297 :: 		First_Edge=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_First_Edge+0)
MOVT	R0, #hi_addr(_First_Edge+0)
STRB	R1, [R0, #0]
;Function.c,298 :: 		Last_Edge=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Last_Edge+0)
MOVT	R0, #hi_addr(_Last_Edge+0)
STRB	R1, [R0, #0]
;Function.c,299 :: 		Threshold1=2048-((_vt-Item_Index[TRIG_SENSITIVITY]-120)*4096)
MOVW	R5, #lo_addr(_Item_Index+6)
MOVT	R5, #hi_addr(_Item_Index+6)
LDRB	R1, [R5, #0]
MOVW	R4, #lo_addr(__vt+0)
MOVT	R4, #hi_addr(__vt+0)
LDRB	R0, [R4, #0]
SUB	R0, R0, R1
SXTH	R0, R0
SUBS	R0, #120
SXTH	R0, R0
LSLS	R3, R0, #12
SXTH	R3, R3
;Function.c,300 :: 		/Km[Item_Index[Y_SENSITIVITY]];
MOVW	R0, #lo_addr(_Item_Index+1)
MOVT	R0, #hi_addr(_Item_Index+1)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_Km+0)
MOVT	R0, #hi_addr(_Km+0)
ADDS	R0, R0, R1
LDRB	R2, [R0, #0]
SDIV	R0, R3, R2
SXTH	R0, R0
RSB	R3, R0, #2048
UXTH	R3, R3
; Threshold1 start address is: 12 (R3)
;Function.c,301 :: 		Threshold2=2048-((_vt+Item_Index[TRIG_SENSITIVITY]-120)*4096)
MOV	R0, R5
LDRB	R1, [R0, #0]
MOV	R0, R4
LDRB	R0, [R0, #0]
ADDS	R0, R0, R1
SXTH	R0, R0
SUBS	R0, #120
SXTH	R0, R0
LSLS	R0, R0, #12
SXTH	R0, R0
;Function.c,302 :: 		/Km[Item_Index[Y_SENSITIVITY]];
SDIV	R0, R0, R2
SXTH	R0, R0
RSB	R0, R0, #2048
; Threshold2 start address is: 4 (R1)
UXTH	R1, R0
;Function.c,303 :: 		Threshold3=2048-((_vt-120)*4096)/Km[Item_Index[Y_SENSITIVITY]];
MOV	R0, R4
LDRB	R0, [R0, #0]
SUBS	R0, #120
SXTH	R0, R0
LSLS	R0, R0, #12
SXTH	R0, R0
SDIV	R0, R0, R2
SXTH	R0, R0
RSB	R0, R0, #2048
UXTH	R0, R0
;Function.c,304 :: 		for(i=0;i<0x1000;++i){
; i start address is: 16 (R4)
MOVS	R4, #0
; Edge end address is: 24 (R6)
; Trig end address is: 28 (R7)
; Threshold2 end address is: 4 (R1)
; i end address is: 16 (R4)
UXTB	R5, R6
UXTB	R6, R7
UXTH	R2, R1
UXTH	R1, R0
L_Measure_Wave87:
; i start address is: 16 (R4)
; Threshold2 start address is: 8 (R2)
; Threshold3 start address is: 4 (R1)
; Threshold2 start address is: 8 (R2)
; Threshold2 end address is: 8 (R2)
; Threshold1 start address is: 12 (R3)
; Threshold1 end address is: 12 (R3)
; Trig start address is: 24 (R6)
; Edge start address is: 20 (R5)
CMP	R4, #4096
IT	GE
BGE	L_Measure_Wave88
; Threshold2 end address is: 8 (R2)
; Threshold1 end address is: 12 (R3)
;Function.c,305 :: 		if((Scan_Buffer[i]>Threshold1)&&(Trig==0))  Trig=1;
; Threshold1 start address is: 12 (R3)
; Threshold2 start address is: 8 (R2)
MOVW	R0, #lo_addr(_Scan_Buffer+0)
MOVT	R0, #hi_addr(_Scan_Buffer+0)
ADDS	R0, R0, R4
LDRB	R0, [R0, #0]
CMP	R0, R3
IT	LS
BLS	L__Measure_Wave217
CMP	R6, #0
IT	NE
BNE	L__Measure_Wave218
; Trig end address is: 24 (R6)
L__Measure_Wave212:
MOVS	R0, #1
UXTB	R6, R0
IT	AL
BAL	L__Measure_Wave214
L__Measure_Wave217:
L__Measure_Wave214:
; Trig start address is: 24 (R6)
; Trig end address is: 24 (R6)
IT	AL
BAL	L__Measure_Wave213
L__Measure_Wave218:
L__Measure_Wave213:
;Function.c,306 :: 		if((Scan_Buffer[i]<Threshold2)&&(Trig==1)) {
; Trig start address is: 24 (R6)
MOVW	R0, #lo_addr(_Scan_Buffer+0)
MOVT	R0, #hi_addr(_Scan_Buffer+0)
ADDS	R0, R0, R4
LDRB	R0, [R0, #0]
CMP	R0, R2
IT	CS
BCS	L__Measure_Wave219
CMP	R6, #1
IT	NE
BNE	L__Measure_Wave220
; Trig end address is: 24 (R6)
L__Measure_Wave211:
;Function.c,307 :: 		Trig=0;
; Trig start address is: 24 (R6)
MOVS	R6, #0
;Function.c,308 :: 		if(First_Edge==0) {
MOVW	R0, #lo_addr(_First_Edge+0)
MOVT	R0, #hi_addr(_First_Edge+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_Measure_Wave96
; Edge end address is: 20 (R5)
;Function.c,309 :: 		First_Edge=i;
MOVW	R0, #lo_addr(_First_Edge+0)
MOVT	R0, #hi_addr(_First_Edge+0)
STRB	R4, [R0, #0]
;Function.c,310 :: 		Last_Edge=i;
MOVW	R0, #lo_addr(_Last_Edge+0)
MOVT	R0, #hi_addr(_Last_Edge+0)
STRB	R4, [R0, #0]
;Function.c,311 :: 		Edge=0;
MOVS	R0, #0
;Function.c,312 :: 		} else {
IT	AL
BAL	L_Measure_Wave97
L_Measure_Wave96:
;Function.c,313 :: 		Last_Edge=i;
; Edge start address is: 20 (R5)
MOVW	R0, #lo_addr(_Last_Edge+0)
MOVT	R0, #hi_addr(_Last_Edge+0)
STRB	R4, [R0, #0]
;Function.c,314 :: 		Edge++;
ADDS	R5, R5, #1
UXTB	R5, R5
; Edge end address is: 20 (R5)
UXTB	R0, R5
;Function.c,315 :: 		}
L_Measure_Wave97:
;Function.c,306 :: 		if((Scan_Buffer[i]<Threshold2)&&(Trig==1)) {
; Trig end address is: 24 (R6)
UXTB	R5, R0
IT	AL
BAL	L__Measure_Wave216
L__Measure_Wave219:
L__Measure_Wave216:
; Edge start address is: 20 (R5)
; Trig start address is: 24 (R6)
; Trig end address is: 24 (R6)
; Edge end address is: 20 (R5)
IT	AL
BAL	L__Measure_Wave215
L__Measure_Wave220:
L__Measure_Wave215:
;Function.c,304 :: 		for(i=0;i<0x1000;++i){
; Trig start address is: 24 (R6)
; Edge start address is: 20 (R5)
ADDS	R4, R4, #1
UXTB	R4, R4
;Function.c,317 :: 		}
; Threshold2 end address is: 8 (R2)
; Threshold1 end address is: 12 (R3)
; Trig end address is: 24 (R6)
; i end address is: 16 (R4)
IT	AL
BAL	L_Measure_Wave87
L_Measure_Wave88:
;Function.c,318 :: 		if(Edge!=0){
CMP	R5, #0
IT	EQ
BEQ	L_Measure_Wave98
;Function.c,319 :: 		Vm = 0;
; Vm start address is: 24 (R6)
MOVS	R6, #0
SXTH	R6, R6
;Function.c,320 :: 		for(i=First_Edge; i<Last_Edge; ++i){
MOVW	R0, #lo_addr(_First_Edge+0)
MOVT	R0, #hi_addr(_First_Edge+0)
; i start address is: 8 (R2)
LDRB	R2, [R0, #0]
; Edge end address is: 20 (R5)
; Vm end address is: 24 (R6)
; i end address is: 8 (R2)
L_Measure_Wave99:
; i start address is: 8 (R2)
; Vm start address is: 24 (R6)
; Edge start address is: 20 (R5)
; Threshold3 start address is: 4 (R1)
; Threshold3 end address is: 4 (R1)
MOVW	R0, #lo_addr(_Last_Edge+0)
MOVT	R0, #hi_addr(_Last_Edge+0)
LDRB	R0, [R0, #0]
CMP	R2, R0
IT	CS
BCS	L_Measure_Wave100
; Threshold3 end address is: 4 (R1)
;Function.c,321 :: 		if(Scan_Buffer[i]<Threshold3) Vm++;
; Threshold3 start address is: 4 (R1)
MOVW	R0, #lo_addr(_Scan_Buffer+0)
MOVT	R0, #hi_addr(_Scan_Buffer+0)
ADDS	R0, R0, R2
LDRB	R0, [R0, #0]
CMP	R0, R1
IT	CS
BCS	L__Measure_Wave221
ADDS	R0, R6, #1
; Vm end address is: 24 (R6)
; Vm start address is: 12 (R3)
SXTH	R3, R0
; Vm end address is: 12 (R3)
SXTH	R6, R3
IT	AL
BAL	L_Measure_Wave102
L__Measure_Wave221:
L_Measure_Wave102:
;Function.c,320 :: 		for(i=First_Edge; i<Last_Edge; ++i){
; Vm start address is: 24 (R6)
ADDS	R2, R2, #1
UXTB	R2, R2
;Function.c,322 :: 		}
; Threshold3 end address is: 4 (R1)
; i end address is: 8 (R2)
IT	AL
BAL	L_Measure_Wave99
L_Measure_Wave100:
;Function.c,323 :: 		if(Type==PRN) {
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_Measure_Wave103
;Function.c,324 :: 		Frequency = (Edge*(1000000000/T_Scale[Item_Index[X_SENSITIVITY]])/(Last_Edge-First_Edge))*1000;
MOVW	R0, #lo_addr(_Item_Index+2)
MOVT	R0, #hi_addr(_Item_Index+2)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #1
MOVW	R0, #lo_addr(_T_Scale+0)
MOVT	R0, #hi_addr(_T_Scale+0)
ADDS	R4, R0, R1
LDRH	R1, [R4, #0]
MOVW	R0, #51712
MOVT	R0, #15258
SDIV	R0, R0, R1
MUL	R3, R5, R0
MOVW	R0, #lo_addr(_First_Edge+0)
MOVT	R0, #hi_addr(_First_Edge+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_Last_Edge+0)
MOVT	R0, #hi_addr(_Last_Edge+0)
LDRB	R0, [R0, #0]
SUB	R2, R0, R1
SXTH	R2, R2
SDIV	R1, R3, R2
MOVW	R0, #1000
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_Frequency+0)
MOVT	R0, #hi_addr(_Frequency+0)
STRH	R1, [R0, #0]
;Function.c,325 :: 		Cycle = ((Last_Edge-First_Edge)*T_Scale[Item_Index[X_SENSITIVITY]])/Edge;
LDRH	R0, [R4, #0]
MULS	R0, R2, R0
UXTH	R0, R0
UDIV	R1, R0, R5
; Edge end address is: 20 (R5)
MOVW	R0, #lo_addr(_Cycle+0)
MOVT	R0, #hi_addr(_Cycle+0)
STRH	R1, [R0, #0]
;Function.c,326 :: 		Duty = 100000*Vm/(Last_Edge-First_Edge);
MOVW	R0, #34464
MOVT	R0, #1
MULS	R0, R6, R0
; Vm end address is: 24 (R6)
SDIV	R1, R0, R2
MOVW	R0, #lo_addr(_Duty+0)
MOVT	R0, #hi_addr(_Duty+0)
STRH	R1, [R0, #0]
;Function.c,327 :: 		}
L_Measure_Wave103:
;Function.c,328 :: 		} else {
IT	AL
BAL	L_Measure_Wave104
L_Measure_Wave98:
;Function.c,329 :: 		Frequency = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_Frequency+0)
MOVT	R0, #hi_addr(_Frequency+0)
STRH	R1, [R0, #0]
;Function.c,330 :: 		Cycle     = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_Cycle+0)
MOVT	R0, #hi_addr(_Cycle+0)
STRH	R1, [R0, #0]
;Function.c,331 :: 		Duty      = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_Duty+0)
MOVT	R0, #hi_addr(_Duty+0)
STRH	R1, [R0, #0]
;Function.c,332 :: 		}
L_Measure_Wave104:
;Function.c,333 :: 		}
L_end_Measure_Wave:
ADD	SP, SP, #4
BX	LR
; end of _Measure_Wave
_Update_Item:
;Function.c,337 :: 		void Update_Item(void)
SUB	SP, SP, #12
STR	LR, [SP, #0]
;Function.c,341 :: 		if( Update[SYNC_MODE]!=0){
MOVW	R0, #lo_addr(_Update+0)
MOVT	R0, #hi_addr(_Update+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Update_Item105
;Function.c,342 :: 		Update[SYNC_MODE]=Type;
MOVW	R2, #lo_addr(_Type+0)
MOVT	R2, #hi_addr(_Type+0)
LDRB	R1, [R2, #0]
MOVW	R0, #lo_addr(_Update+0)
MOVT	R0, #hi_addr(_Update+0)
STRB	R1, [R0, #0]
;Function.c,343 :: 		Display_Str(3,224,GRN,Type,MODE_Unit[Item_Index[SYNC_MODE]]);
MOVW	R0, #lo_addr(_Item_Index+0)
MOVT	R0, #hi_addr(_Item_Index+0)
LDRB	R1, [R0, #0]
MOVS	R0, #5
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_MODE_Unit+0)
MOVT	R0, #hi_addr(_MODE_Unit+0)
ADDS	R1, R0, R1
MOV	R0, R2
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #224
MOVS	R1, #224
MOVS	R0, #3
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,344 :: 		}
L_Update_Item105:
;Function.c,346 :: 		if( Update[Y_SENSITIVITY]!=0){
MOVW	R0, #lo_addr(_Update+1)
MOVT	R0, #hi_addr(_Update+1)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Update_Item106
;Function.c,347 :: 		Update[Y_SENSITIVITY]=Type;
MOVW	R2, #lo_addr(_Type+0)
MOVT	R2, #hi_addr(_Type+0)
LDRB	R1, [R2, #0]
MOVW	R0, #lo_addr(_Update+1)
MOVT	R0, #hi_addr(_Update+1)
STRB	R1, [R0, #0]
;Function.c,348 :: 		Display_Str(40,224,YEL,Type,Item_V[Item_Index[Y_SENSITIVITY]]);
MOVW	R0, #lo_addr(_Item_Index+1)
MOVT	R0, #hi_addr(_Item_Index+1)
STR	R0, [SP, #8]
LDRB	R1, [R0, #0]
MOVS	R0, #11
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_Item_V+0)
MOVT	R0, #hi_addr(_Item_V+0)
ADDS	R1, R0, R1
MOV	R0, R2
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #224
MOVS	R0, #40
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,349 :: 		Update[TRIG_LEVEL]=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Update+19)
MOVT	R0, #hi_addr(_Update+19)
STRB	R1, [R0, #0]
;Function.c,350 :: 		Update[Y_VERNIER_1]=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Update+18)
MOVT	R0, #hi_addr(_Update+18)
STRB	R1, [R0, #0]
;Function.c,351 :: 		Set_Range(Item_Index[Y_SENSITIVITY]);
LDR	R0, [SP, #8]
LDRB	R0, [R0, #0]
BL	_Set_Range+0
;Function.c,352 :: 		Set_Y_Pos(_v0);
MOVW	R0, #lo_addr(__v0+0)
MOVT	R0, #hi_addr(__v0+0)
LDRB	R0, [R0, #0]
BL	_Set_Y_Pos+0
;Function.c,353 :: 		}
L_Update_Item106:
;Function.c,355 :: 		if( Update[X_SENSITIVITY]!=0){
MOVW	R0, #lo_addr(_Update+2)
MOVT	R0, #hi_addr(_Update+2)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Update_Item107
;Function.c,356 :: 		Update[X_SENSITIVITY]=Type;
MOVW	R2, #lo_addr(_Type+0)
MOVT	R2, #hi_addr(_Type+0)
LDRB	R1, [R2, #0]
MOVW	R0, #lo_addr(_Update+2)
MOVT	R0, #hi_addr(_Update+2)
STRB	R1, [R0, #0]
;Function.c,357 :: 		Display_Str(109,224,YEL,Type,Item_T[Item_Index[X_SENSITIVITY]]);
MOVW	R0, #lo_addr(_Item_Index+2)
MOVT	R0, #hi_addr(_Item_Index+2)
LDRB	R1, [R0, #0]
MOVS	R0, #12
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_Item_T+0)
MOVT	R0, #hi_addr(_Item_T+0)
ADDS	R1, R0, R1
MOV	R0, R2
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #224
MOVS	R0, #109
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,358 :: 		Display_Str(109,224,YEL,Type,Item_T[Item_Index[X_SENSITIVITY]]);
MOVW	R0, #lo_addr(_Item_Index+2)
MOVT	R0, #hi_addr(_Item_Index+2)
LDRB	R1, [R0, #0]
MOVS	R0, #12
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_Item_T+0)
MOVT	R0, #hi_addr(_Item_T+0)
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #224
MOVS	R0, #109
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,359 :: 		Set_Base(Item_Index[X_SENSITIVITY]);
MOVW	R0, #lo_addr(_Item_Index+2)
MOVT	R0, #hi_addr(_Item_Index+2)
LDRB	R0, [R0, #0]
BL	_Set_Base+0
;Function.c,360 :: 		Update[DELTA_T]=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Update+16)
MOVT	R0, #hi_addr(_Update+16)
STRB	R1, [R0, #0]
;Function.c,361 :: 		}
L_Update_Item107:
;Function.c,363 :: 		if( Update[Y_POSITION]!=0){
MOVW	R0, #lo_addr(_Update+3)
MOVT	R0, #hi_addr(_Update+3)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Update_Item108
;Function.c,364 :: 		Update[Y_POSITION]=Type;
MOVW	R2, #lo_addr(_Type+0)
MOVT	R2, #hi_addr(_Type+0)
LDRB	R1, [R2, #0]
MOVW	R0, #lo_addr(_Update+3)
MOVT	R0, #hi_addr(_Update+3)
STRB	R1, [R0, #0]
;Function.c,365 :: 		Display_Str(186,224,MODEL,Type,"Y.POS");
MOVW	R1, #lo_addr(?lstr_1_Function+0)
MOVT	R1, #hi_addr(?lstr_1_Function+0)
MOV	R0, R2
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #94
MOVS	R1, #224
MOVS	R0, #186
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,366 :: 		Draw_Dot_v0();
BL	_Draw_Dot_v0+0
;Function.c,367 :: 		if(Hide_v0) Erase_Vn(_v0);
MOVW	R0, #lo_addr(_Hide_v0+0)
MOVT	R0, #hi_addr(_Hide_v0+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Update_Item109
MOVW	R0, #lo_addr(__v0+0)
MOVT	R0, #hi_addr(__v0+0)
LDRB	R0, [R0, #0]
BL	_Erase_Vn+0
IT	AL
BAL	L_Update_Item110
L_Update_Item109:
;Function.c,368 :: 		else        Draw_v0();
BL	_Draw_v0+0
L_Update_Item110:
;Function.c,369 :: 		Set_Y_Pos(_v0);
MOVW	R0, #lo_addr(__v0+0)
MOVT	R0, #hi_addr(__v0+0)
LDRB	R0, [R0, #0]
BL	_Set_Y_Pos+0
;Function.c,370 :: 		Update[VERNIERS]=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Update+20)
MOVT	R0, #hi_addr(_Update+20)
STRB	R1, [R0, #0]
;Function.c,371 :: 		}
L_Update_Item108:
;Function.c,373 :: 		if( Update[MEASUR_KIND]!=0){
MOVW	R0, #lo_addr(_Update+4)
MOVT	R0, #hi_addr(_Update+4)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Update_Item111
;Function.c,374 :: 		Update[MEASUR_KIND]=Type;
MOVW	R2, #lo_addr(_Type+0)
MOVT	R2, #hi_addr(_Type+0)
LDRB	R1, [R2, #0]
MOVW	R0, #lo_addr(_Update+4)
MOVT	R0, #hi_addr(_Update+4)
STRB	R1, [R0, #0]
;Function.c,375 :: 		if(Type==0) Display_Str(231,224,WHITE,PRN,TEST_Unit[Item_Index[MEASUR_KIND]]);
MOV	R0, R2
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_Update_Item112
MOVW	R0, #lo_addr(_Item_Index+4)
MOVT	R0, #hi_addr(_Item_Index+4)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #3
MOVW	R0, #lo_addr(_TEST_Unit+0)
MOVT	R0, #hi_addr(_TEST_Unit+0)
ADDS	R0, R0, R1
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #255
MOVS	R1, #224
MOVS	R0, #231
BL	_Display_Str+0
ADD	SP, SP, #4
IT	AL
BAL	L_Update_Item113
L_Update_Item112:
;Function.c,377 :: 		switch (Item_Index[4]){
IT	AL
BAL	L_Update_Item114
;Function.c,378 :: 		case 0://Frequency
L_Update_Item116:
;Function.c,379 :: 		if(Frequency==0)
MOVW	R0, #lo_addr(_Frequency+0)
MOVT	R0, #hi_addr(_Frequency+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_Update_Item117
;Function.c,380 :: 		Display_Str(231,224,WHITE,INV,TEST_Unit[Item_Index[MEASUR_KIND]]);
MOVW	R0, #lo_addr(_Item_Index+4)
MOVT	R0, #hi_addr(_Item_Index+4)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #3
MOVW	R0, #lo_addr(_TEST_Unit+0)
MOVT	R0, #hi_addr(_TEST_Unit+0)
ADDS	R0, R0, R1
PUSH	(R0)
MOVS	R3, #1
MOVS	R2, #255
MOVS	R1, #224
MOVS	R0, #231
BL	_Display_Str+0
ADD	SP, SP, #4
IT	AL
BAL	L_Update_Item118
L_Update_Item117:
;Function.c,382 :: 		Int32String(&Num, Frequency, 4);
MOVW	R0, #lo_addr(_Frequency+0)
MOVT	R0, #hi_addr(_Frequency+0)
LDRSH	R0, [R0, #0]
MOVS	R2, #4
SXTH	R2, R2
SXTH	R1, R0
MOVW	R0, #lo_addr(_Num+0)
MOVT	R0, #hi_addr(_Num+0)
BL	_Int32String+0
;Function.c,383 :: 		Display_Str(231,224,WHITE,Type,(unsigned const char *)Num.str);
MOVW	R1, #lo_addr(_Num+2)
MOVT	R1, #hi_addr(_Num+2)
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #224
MOVS	R0, #231
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,384 :: 		Display_Str(231+40,224,WHITE,Type,F_Unit[Num.decPos]);
MOVW	R0, #lo_addr(_Num+0)
MOVT	R0, #hi_addr(_Num+0)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #2
MOVW	R0, #lo_addr(_F_Unit+0)
MOVT	R0, #hi_addr(_F_Unit+0)
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #224
MOVS	R0, #15
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,385 :: 		}
L_Update_Item118:
;Function.c,386 :: 		break;
IT	AL
BAL	L_Update_Item115
;Function.c,387 :: 		case 1://Cycle
L_Update_Item119:
;Function.c,388 :: 		if(Cycle==0)
MOVW	R0, #lo_addr(_Cycle+0)
MOVT	R0, #hi_addr(_Cycle+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_Update_Item120
;Function.c,389 :: 		Display_Str(231,224,WHITE,INV,TEST_Unit[Item_Index[MEASUR_KIND]]);
MOVW	R0, #lo_addr(_Item_Index+4)
MOVT	R0, #hi_addr(_Item_Index+4)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #3
MOVW	R0, #lo_addr(_TEST_Unit+0)
MOVT	R0, #hi_addr(_TEST_Unit+0)
ADDS	R0, R0, R1
PUSH	(R0)
MOVS	R3, #1
MOVS	R2, #255
MOVS	R1, #224
MOVS	R0, #231
BL	_Display_Str+0
ADD	SP, SP, #4
IT	AL
BAL	L_Update_Item121
L_Update_Item120:
;Function.c,391 :: 		Int32String(&Num, Cycle, 4);
MOVW	R0, #lo_addr(_Cycle+0)
MOVT	R0, #hi_addr(_Cycle+0)
LDRSH	R0, [R0, #0]
MOVS	R2, #4
SXTH	R2, R2
SXTH	R1, R0
MOVW	R0, #lo_addr(_Num+0)
MOVT	R0, #hi_addr(_Num+0)
BL	_Int32String+0
;Function.c,392 :: 		Display_Str(231,224,WHITE,Type,(unsigned const char *)Num.str);
MOVW	R1, #lo_addr(_Num+2)
MOVT	R1, #hi_addr(_Num+2)
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #224
MOVS	R0, #231
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,393 :: 		Display_Str(231+40,224,WHITE,Type,T_Unit[Num.decPos]);
MOVW	R0, #lo_addr(_Num+0)
MOVT	R0, #hi_addr(_Num+0)
LDRB	R1, [R0, #0]
MOVS	R0, #3
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_T_Unit+0)
MOVT	R0, #hi_addr(_T_Unit+0)
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #224
MOVS	R0, #15
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,394 :: 		}
L_Update_Item121:
;Function.c,395 :: 		break;
IT	AL
BAL	L_Update_Item115
;Function.c,396 :: 		case 2://Duty
L_Update_Item122:
;Function.c,397 :: 		if(Duty==0)
MOVW	R0, #lo_addr(_Duty+0)
MOVT	R0, #hi_addr(_Duty+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_Update_Item123
;Function.c,398 :: 		Display_Str(231,224,WHITE,INV,TEST_Unit[Item_Index[MEASUR_KIND]]);
MOVW	R0, #lo_addr(_Item_Index+4)
MOVT	R0, #hi_addr(_Item_Index+4)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #3
MOVW	R0, #lo_addr(_TEST_Unit+0)
MOVT	R0, #hi_addr(_TEST_Unit+0)
ADDS	R0, R0, R1
PUSH	(R0)
MOVS	R3, #1
MOVS	R2, #255
MOVS	R1, #224
MOVS	R0, #231
BL	_Display_Str+0
ADD	SP, SP, #4
IT	AL
BAL	L_Update_Item124
L_Update_Item123:
;Function.c,400 :: 		Int32String(&Num, Duty, 4);
MOVW	R0, #lo_addr(_Duty+0)
MOVT	R0, #hi_addr(_Duty+0)
LDRSH	R0, [R0, #0]
MOVS	R2, #4
SXTH	R2, R2
SXTH	R1, R0
MOVW	R0, #lo_addr(_Num+0)
MOVT	R0, #hi_addr(_Num+0)
BL	_Int32String+0
;Function.c,401 :: 		Display_Str(231,224,WHITE,Type,(unsigned const char *)Num.str);
MOVW	R1, #lo_addr(_Num+2)
MOVT	R1, #hi_addr(_Num+2)
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #224
MOVS	R0, #231
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,402 :: 		Display_Str(231+40,224,WHITE,Type,"% ");
MOVW	R1, #lo_addr(?lstr_2_Function+0)
MOVT	R1, #hi_addr(?lstr_2_Function+0)
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #224
MOVS	R0, #15
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,403 :: 		}
L_Update_Item124:
;Function.c,404 :: 		break;
IT	AL
BAL	L_Update_Item115
;Function.c,405 :: 		}
L_Update_Item114:
MOVW	R0, #lo_addr(_Item_Index+4)
MOVT	R0, #hi_addr(_Item_Index+4)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Update_Item116
MOVW	R0, #lo_addr(_Item_Index+4)
MOVT	R0, #hi_addr(_Item_Index+4)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_Update_Item119
MOVW	R0, #lo_addr(_Item_Index+4)
MOVT	R0, #hi_addr(_Item_Index+4)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_Update_Item122
L_Update_Item115:
;Function.c,406 :: 		}
L_Update_Item113:
;Function.c,407 :: 		}
L_Update_Item111:
;Function.c,409 :: 		if( Update[POWER_INFOMATION]!=0){
MOVW	R0, #lo_addr(_Update+5)
MOVT	R0, #hi_addr(_Update+5)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Update_Item125
;Function.c,410 :: 		Update[POWER_INFOMATION]=Type;
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_Update+5)
MOVT	R0, #hi_addr(_Update+5)
STRB	R1, [R0, #0]
;Function.c,411 :: 		if(Test_USB_ON())
BL	_Test_USB_ON+0
CMP	R0, #0
IT	EQ
BEQ	L_Update_Item126
;Function.c,412 :: 		Display_Str(292,224,Battery_Color[4],PRN,Battery_Status[4]);
MOVW	R0, #lo_addr(_Battery_Status+16)
MOVT	R0, #hi_addr(_Battery_Status+16)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #0
MOVS	R1, #224
MOVS	R0, #36
BL	_Display_Str+0
ADD	SP, SP, #4
IT	AL
BAL	L_Update_Item127
L_Update_Item126:
;Function.c,415 :: 		Battery_Status[Item_Index[POWER_INFOMATION]]);
MOVW	R3, #lo_addr(_Item_Index+5)
MOVT	R3, #hi_addr(_Item_Index+5)
LDRB	R0, [R3, #0]
LSLS	R1, R0, #2
MOVW	R0, #lo_addr(_Battery_Status+0)
MOVT	R0, #hi_addr(_Battery_Status+0)
ADDS	R2, R0, R1
;Function.c,414 :: 		Display_Str(292,224,Battery_Color[Item_Index[5]],PRN,
MOV	R0, R3
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_Battery_Color+0)
MOVT	R0, #hi_addr(_Battery_Color+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
;Function.c,415 :: 		Battery_Status[Item_Index[POWER_INFOMATION]]);
PUSH	(R2)
;Function.c,414 :: 		Display_Str(292,224,Battery_Color[Item_Index[5]],PRN,
MOVS	R3, #0
UXTB	R2, R0
MOVS	R1, #224
MOVS	R0, #36
;Function.c,415 :: 		Battery_Status[Item_Index[POWER_INFOMATION]]);
BL	_Display_Str+0
ADD	SP, SP, #4
L_Update_Item127:
;Function.c,416 :: 		}
L_Update_Item125:
;Function.c,418 :: 		if( Update[TRIG_SENSITIVITY]!=0){
MOVW	R0, #lo_addr(_Update+6)
MOVT	R0, #hi_addr(_Update+6)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Update_Item128
;Function.c,419 :: 		Update[TRIG_SENSITIVITY]=Type;
MOVW	R2, #lo_addr(_Type+0)
MOVT	R2, #hi_addr(_Type+0)
LDRB	R1, [R2, #0]
MOVW	R0, #lo_addr(_Update+6)
MOVT	R0, #hi_addr(_Update+6)
STRB	R1, [R0, #0]
;Function.c,420 :: 		Display_Str(303, 195, YEL,Type, "TR");
MOVW	R1, #lo_addr(?lstr_3_Function+0)
MOVT	R1, #hi_addr(?lstr_3_Function+0)
MOV	R0, R2
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #195
MOVS	R0, #47
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,421 :: 		if(Item==TRIG_SENSITIVITY){
MOVW	R0, #lo_addr(_Item+0)
MOVT	R0, #hi_addr(_Item+0)
LDRB	R0, [R0, #0]
CMP	R0, #6
IT	NE
BNE	L_Update_Item129
;Function.c,422 :: 		Display_Str(88,2,WHITE,Type,"Trig!Sensitive");
MOVW	R1, #lo_addr(?lstr_4_Function+0)
MOVT	R1, #hi_addr(?lstr_4_Function+0)
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #88
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,423 :: 		temp=_vt;
MOVW	R2, #lo_addr(__vt+0)
MOVT	R2, #hi_addr(__vt+0)
LDRB	R1, [R2, #0]
MOVW	R0, #lo_addr(_temp+0)
MOVT	R0, #hi_addr(_temp+0)
STRB	R1, [R0, #0]
;Function.c,424 :: 		for(_vt=temp-2; _vt>(temp-Item_Index[6]); _vt=_vt-2) Draw_vt();
MOV	R0, R2
LDRB	R0, [R0, #0]
SUBS	R0, R0, #2
STRB	R0, [R2, #0]
L_Update_Item130:
MOVW	R0, #lo_addr(_Item_Index+6)
MOVT	R0, #hi_addr(_Item_Index+6)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_temp+0)
MOVT	R0, #hi_addr(_temp+0)
LDRB	R0, [R0, #0]
SUB	R1, R0, R1
SXTH	R1, R1
MOVW	R0, #lo_addr(__vt+0)
MOVT	R0, #hi_addr(__vt+0)
LDRB	R0, [R0, #0]
CMP	R0, R1
IT	LE
BLE	L_Update_Item131
BL	_Draw_vt+0
MOVW	R1, #lo_addr(__vt+0)
MOVT	R1, #hi_addr(__vt+0)
LDRB	R0, [R1, #0]
SUBS	R0, R0, #2
STRB	R0, [R1, #0]
IT	AL
BAL	L_Update_Item130
L_Update_Item131:
;Function.c,425 :: 		for(_vt=(temp+2); _vt<(temp+Item_Index[6]); _vt=_vt+2) Draw_vt();
MOVW	R0, #lo_addr(_temp+0)
MOVT	R0, #hi_addr(_temp+0)
LDRB	R0, [R0, #0]
ADDS	R1, R0, #2
MOVW	R0, #lo_addr(__vt+0)
MOVT	R0, #hi_addr(__vt+0)
STRB	R1, [R0, #0]
L_Update_Item133:
MOVW	R0, #lo_addr(_Item_Index+6)
MOVT	R0, #hi_addr(_Item_Index+6)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_temp+0)
MOVT	R0, #hi_addr(_temp+0)
LDRB	R0, [R0, #0]
ADDS	R1, R0, R1
SXTH	R1, R1
MOVW	R0, #lo_addr(__vt+0)
MOVT	R0, #hi_addr(__vt+0)
LDRB	R0, [R0, #0]
CMP	R0, R1
IT	GE
BGE	L_Update_Item134
BL	_Draw_vt+0
MOVW	R1, #lo_addr(__vt+0)
MOVT	R1, #hi_addr(__vt+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #2
STRB	R0, [R1, #0]
IT	AL
BAL	L_Update_Item133
L_Update_Item134:
;Function.c,426 :: 		_vt=temp;
MOVW	R0, #lo_addr(_temp+0)
MOVT	R0, #hi_addr(_temp+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(__vt+0)
MOVT	R0, #hi_addr(__vt+0)
STRB	R1, [R0, #0]
;Function.c,427 :: 		}
L_Update_Item129:
;Function.c,428 :: 		}
L_Update_Item128:
;Function.c,430 :: 		if( Update[TRIG_SLOPE]!=0){
MOVW	R0, #lo_addr(_Update+7)
MOVT	R0, #hi_addr(_Update+7)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Update_Item136
;Function.c,431 :: 		Update[TRIG_SLOPE]=Type;
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_Update+7)
MOVT	R0, #hi_addr(_Update+7)
STRB	R1, [R0, #0]
;Function.c,432 :: 		if(Item_Index[TRIG_SLOPE]==RISING) Display_Str(303, 175, YEL,Type, "^S");
MOVW	R0, #lo_addr(_Item_Index+7)
MOVT	R0, #hi_addr(_Item_Index+7)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_Update_Item137
MOVW	R1, #lo_addr(?lstr_5_Function+0)
MOVT	R1, #hi_addr(?lstr_5_Function+0)
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #175
MOVS	R0, #47
BL	_Display_Str+0
ADD	SP, SP, #4
IT	AL
BAL	L_Update_Item138
L_Update_Item137:
;Function.c,433 :: 		else                               Display_Str(303, 175, YEL,Type, "_S");
MOVW	R1, #lo_addr(?lstr_6_Function+0)
MOVT	R1, #hi_addr(?lstr_6_Function+0)
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #175
MOVS	R0, #47
BL	_Display_Str+0
ADD	SP, SP, #4
L_Update_Item138:
;Function.c,434 :: 		if(Item==TRIG_SLOPE){
MOVW	R0, #lo_addr(_Item+0)
MOVT	R0, #hi_addr(_Item+0)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	NE
BNE	L_Update_Item139
;Function.c,435 :: 		if(Item_Index[TRIG_SLOPE]==0) Display_Str(88,2,WHITE,Type,"!Trig.Slope=!^!");
MOVW	R0, #lo_addr(_Item_Index+7)
MOVT	R0, #hi_addr(_Item_Index+7)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_Update_Item140
MOVW	R1, #lo_addr(?lstr_7_Function+0)
MOVT	R1, #hi_addr(?lstr_7_Function+0)
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #88
BL	_Display_Str+0
ADD	SP, SP, #4
IT	AL
BAL	L_Update_Item141
L_Update_Item140:
;Function.c,436 :: 		else                          Display_Str(88,2,WHITE,Type,"!Trig.Slope=!_!");
MOVW	R1, #lo_addr(?lstr_8_Function+0)
MOVT	R1, #hi_addr(?lstr_8_Function+0)
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #88
BL	_Display_Str+0
ADD	SP, SP, #4
L_Update_Item141:
;Function.c,437 :: 		}
L_Update_Item139:
;Function.c,438 :: 		}
L_Update_Item136:
;Function.c,440 :: 		if( Update[INPUT_ATTENUATOR]!=0){
MOVW	R0, #lo_addr(_Update+8)
MOVT	R0, #hi_addr(_Update+8)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Update_Item142
;Function.c,441 :: 		Update[INPUT_ATTENUATOR]=Type;
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_Update+8)
MOVT	R0, #hi_addr(_Update+8)
STRB	R1, [R0, #0]
;Function.c,442 :: 		if(Item_Index[INPUT_ATTENUATOR]==0) Display_Str(303, 155, YEL,Type, "*1");
MOVW	R0, #lo_addr(_Item_Index+8)
MOVT	R0, #hi_addr(_Item_Index+8)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_Update_Item143
MOVW	R1, #lo_addr(?lstr_9_Function+0)
MOVT	R1, #hi_addr(?lstr_9_Function+0)
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #155
MOVS	R0, #47
BL	_Display_Str+0
ADD	SP, SP, #4
IT	AL
BAL	L_Update_Item144
L_Update_Item143:
;Function.c,443 :: 		else                                Display_Str(303, 155, YEL,Type, "10");
MOVW	R1, #lo_addr(?lstr_10_Function+0)
MOVT	R1, #hi_addr(?lstr_10_Function+0)
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #155
MOVS	R0, #47
BL	_Display_Str+0
ADD	SP, SP, #4
L_Update_Item144:
;Function.c,444 :: 		if(Item==INPUT_ATTENUATOR){
MOVW	R0, #lo_addr(_Item+0)
MOVT	R0, #hi_addr(_Item+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	NE
BNE	L_Update_Item145
;Function.c,445 :: 		if(Item_Index[INPUT_ATTENUATOR]==0) Display_Str(88,2,WHITE,Type,"!INP.Scale!=*1!");
MOVW	R0, #lo_addr(_Item_Index+8)
MOVT	R0, #hi_addr(_Item_Index+8)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_Update_Item146
MOVW	R1, #lo_addr(?lstr_11_Function+0)
MOVT	R1, #hi_addr(?lstr_11_Function+0)
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #88
BL	_Display_Str+0
ADD	SP, SP, #4
IT	AL
BAL	L_Update_Item147
L_Update_Item146:
;Function.c,446 :: 		else                                Display_Str(88,2,WHITE,Type,"!INP.Scale=*10");
MOVW	R1, #lo_addr(?lstr_12_Function+0)
MOVT	R1, #hi_addr(?lstr_12_Function+0)
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #88
BL	_Display_Str+0
ADD	SP, SP, #4
L_Update_Item147:
;Function.c,447 :: 		}
L_Update_Item145:
;Function.c,448 :: 		Update[Y_SENSITIVITY]=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Update+1)
MOVT	R0, #hi_addr(_Update+1)
STRB	R1, [R0, #0]
;Function.c,449 :: 		}
L_Update_Item142:
;Function.c,450 :: 		if( Update[SAVE_WAVE_CURVE]!=0){
MOVW	R0, #lo_addr(_Update+9)
MOVT	R0, #hi_addr(_Update+9)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Update_Item148
;Function.c,451 :: 		Update[SAVE_WAVE_CURVE]=Type;
MOVW	R2, #lo_addr(_Type+0)
MOVT	R2, #hi_addr(_Type+0)
LDRB	R1, [R2, #0]
MOVW	R0, #lo_addr(_Update+9)
MOVT	R0, #hi_addr(_Update+9)
STRB	R1, [R0, #0]
;Function.c,452 :: 		Display_Str(303, 135, YEL,Type, "FS");
MOVW	R1, #lo_addr(?lstr_13_Function+0)
MOVT	R1, #hi_addr(?lstr_13_Function+0)
MOV	R0, R2
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #135
MOVS	R0, #47
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,453 :: 		if(Item==SAVE_WAVE_CURVE){
MOVW	R0, #lo_addr(_Item+0)
MOVT	R0, #hi_addr(_Item+0)
LDRB	R0, [R0, #0]
CMP	R0, #9
IT	NE
BNE	L_Update_Item149
;Function.c,454 :: 		Char_to_Str(FileNum,Item_Index[SAVE_WAVE_CURVE]);
MOVW	R0, #lo_addr(_Item_Index+9)
MOVT	R0, #hi_addr(_Item_Index+9)
LDRB	R0, [R0, #0]
UXTB	R1, R0
MOVW	R0, #lo_addr(_FileNum+0)
MOVT	R0, #hi_addr(_FileNum+0)
BL	_Char_to_Str+0
;Function.c,455 :: 		Display_Str(88,2,WHITE,Type,"!Save File");
MOVW	R1, #lo_addr(?lstr_14_Function+0)
MOVT	R1, #hi_addr(?lstr_14_Function+0)
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #88
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,456 :: 		Display_Str(164,2,WHITE,Type,FileNum);
MOVW	R1, #lo_addr(_FileNum+0)
MOVT	R1, #hi_addr(_FileNum+0)
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #164
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,457 :: 		Display_Str(188,2,WHITE,Type," ");
MOVW	R1, #lo_addr(?lstr_15_Function+0)
MOVT	R1, #hi_addr(?lstr_15_Function+0)
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #188
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,458 :: 		}
L_Update_Item149:
;Function.c,459 :: 		}
L_Update_Item148:
;Function.c,460 :: 		if( Update[LOAD_WAVE_CURVE]!=0){
MOVW	R0, #lo_addr(_Update+10)
MOVT	R0, #hi_addr(_Update+10)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Update_Item150
;Function.c,461 :: 		Update[LOAD_WAVE_CURVE]=Type;
MOVW	R2, #lo_addr(_Type+0)
MOVT	R2, #hi_addr(_Type+0)
LDRB	R1, [R2, #0]
MOVW	R0, #lo_addr(_Update+10)
MOVT	R0, #hi_addr(_Update+10)
STRB	R1, [R0, #0]
;Function.c,462 :: 		Display_Str(303, 115, YEL, Type,"FL");
MOVW	R1, #lo_addr(?lstr_16_Function+0)
MOVT	R1, #hi_addr(?lstr_16_Function+0)
MOV	R0, R2
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #115
MOVS	R0, #47
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,463 :: 		if(Item==LOAD_WAVE_CURVE){
MOVW	R0, #lo_addr(_Item+0)
MOVT	R0, #hi_addr(_Item+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	NE
BNE	L_Update_Item151
;Function.c,464 :: 		Char_to_Str(FileNum,Item_Index[LOAD_WAVE_CURVE]);
MOVW	R0, #lo_addr(_Item_Index+10)
MOVT	R0, #hi_addr(_Item_Index+10)
LDRB	R0, [R0, #0]
UXTB	R1, R0
MOVW	R0, #lo_addr(_FileNum+0)
MOVT	R0, #hi_addr(_FileNum+0)
BL	_Char_to_Str+0
;Function.c,465 :: 		Display_Str(88,2,WHITE,Type,"!Load File");
MOVW	R1, #lo_addr(?lstr_17_Function+0)
MOVT	R1, #hi_addr(?lstr_17_Function+0)
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #88
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,466 :: 		Display_Str(164,2,WHITE,Type,FileNum);
MOVW	R1, #lo_addr(_FileNum+0)
MOVT	R1, #hi_addr(_FileNum+0)
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #164
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,467 :: 		Display_Str(188,2,WHITE,Type," ");
MOVW	R1, #lo_addr(?lstr_18_Function+0)
MOVT	R1, #hi_addr(?lstr_18_Function+0)
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #188
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,468 :: 		}
L_Update_Item151:
;Function.c,469 :: 		}
L_Update_Item150:
;Function.c,471 :: 		if( Update[OUTPUT_FREQUENCY]!=0){
MOVW	R0, #lo_addr(_Update+11)
MOVT	R0, #hi_addr(_Update+11)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Update_Item152
;Function.c,472 :: 		Update[OUTPUT_FREQUENCY]=Type;
MOVW	R3, #lo_addr(_Type+0)
MOVT	R3, #hi_addr(_Type+0)
LDRB	R1, [R3, #0]
MOVW	R0, #lo_addr(_Update+11)
MOVT	R0, #hi_addr(_Update+11)
STRB	R1, [R0, #0]
;Function.c,473 :: 		TIM4_PSC = Fout_PSC[Item_Index[OUTPUT_FREQUENCY]];
MOVW	R0, #lo_addr(_Item_Index+11)
MOVT	R0, #hi_addr(_Item_Index+11)
LDRB	R0, [R0, #0]
LSLS	R2, R0, #1
MOVW	R0, #lo_addr(_Fout_PSC+0)
MOVT	R0, #hi_addr(_Fout_PSC+0)
ADDS	R0, R0, R2
LDRH	R1, [R0, #0]
MOVW	R0, 1073743912
MOVT	R0, 16384
STR	R1, [R0, #0]
;Function.c,474 :: 		TIM4_ARR = Fout_ARR[Item_Index[OUTPUT_FREQUENCY]];
MOVW	R0, #lo_addr(_Fout_ARR+0)
MOVT	R0, #hi_addr(_Fout_ARR+0)
ADDS	R2, R0, R2
LDRH	R1, [R2, #0]
MOVW	R0, 1073743916
MOVT	R0, 16384
STR	R1, [R0, #0]
;Function.c,475 :: 		TIM4_CCR1 = (Fout_ARR[Item_Index[OUTPUT_FREQUENCY]]+1)/2;
LDRH	R0, [R2, #0]
ADDS	R0, R0, #1
UXTH	R0, R0
LSRS	R1, R0, #1
UXTH	R1, R1
MOVW	R0, 1073743924
MOVT	R0, 16384
STR	R1, [R0, #0]
;Function.c,476 :: 		Display_Str(303, 95, YEL,Type, "Fo");
MOVW	R1, #lo_addr(?lstr_19_Function+0)
MOVT	R1, #hi_addr(?lstr_19_Function+0)
MOV	R0, R3
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #95
MOVS	R0, #47
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,477 :: 		if(Item==11){
MOVW	R0, #lo_addr(_Item+0)
MOVT	R0, #hi_addr(_Item+0)
LDRB	R0, [R0, #0]
CMP	R0, #11
IT	NE
BNE	L_Update_Item153
;Function.c,478 :: 		Display_Str(88,2,WHITE,Type," Fout!=");
MOVW	R1, #lo_addr(?lstr_20_Function+0)
MOVT	R1, #hi_addr(?lstr_20_Function+0)
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #88
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,479 :: 		Display_Str(140,2,WHITE,Type,Item_F[Item_Index[OUTPUT_FREQUENCY]]);
MOVW	R0, #lo_addr(_Item_Index+11)
MOVT	R0, #hi_addr(_Item_Index+11)
LDRB	R1, [R0, #0]
MOVS	R0, #7
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_Item_F+0)
MOVT	R0, #hi_addr(_Item_F+0)
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #140
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,480 :: 		Display_Str(188,2,WHITE,Type," ");
MOVW	R1, #lo_addr(?lstr_21_Function+0)
MOVT	R1, #hi_addr(?lstr_21_Function+0)
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #188
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,481 :: 		}
L_Update_Item153:
;Function.c,482 :: 		}
L_Update_Item152:
;Function.c,484 :: 		if( Update[X_VERNIER_2]!=0){
MOVW	R0, #lo_addr(_Update+12)
MOVT	R0, #hi_addr(_Update+12)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Update_Item154
;Function.c,485 :: 		Update[X_VERNIER_2]=Type;
MOVW	R2, #lo_addr(_Type+0)
MOVT	R2, #hi_addr(_Type+0)
LDRB	R1, [R2, #0]
MOVW	R0, #lo_addr(_Update+12)
MOVT	R0, #hi_addr(_Update+12)
STRB	R1, [R0, #0]
;Function.c,486 :: 		Display_Str(303, 75,  YEL,Type, "T2");
MOVW	R1, #lo_addr(?lstr_22_Function+0)
MOVT	R1, #hi_addr(?lstr_22_Function+0)
MOV	R0, R2
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #75
MOVS	R0, #47
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,487 :: 		if(Item==X_VERNIER_2){
MOVW	R0, #lo_addr(_Item+0)
MOVT	R0, #hi_addr(_Item+0)
LDRB	R0, [R0, #0]
CMP	R0, #12
IT	NE
BNE	L_Update_Item155
;Function.c,488 :: 		Display_Str(88,2,WHITE,Type,"!Time Cursor2 ");
MOVW	R1, #lo_addr(?lstr_23_Function+0)
MOVT	R1, #hi_addr(?lstr_23_Function+0)
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #88
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,489 :: 		if(Hide_t1==0) Draw_ti(_t1);
MOVW	R0, #lo_addr(_Hide_t1+0)
MOVT	R0, #hi_addr(_Hide_t1+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_Update_Item156
MOVW	R0, #lo_addr(__t1+0)
MOVT	R0, #hi_addr(__t1+0)
LDRB	R0, [R0, #0]
BL	_Draw_ti+0
L_Update_Item156:
;Function.c,490 :: 		Draw_Dot_ti(_t1);
MOVW	R0, #lo_addr(__t1+0)
MOVT	R0, #hi_addr(__t1+0)
LDRB	R0, [R0, #0]
BL	_Draw_Dot_ti+0
;Function.c,491 :: 		}
L_Update_Item155:
;Function.c,492 :: 		}
L_Update_Item154:
;Function.c,494 :: 		if( Update[X_VERNIER_1]!=0){
MOVW	R0, #lo_addr(_Update+13)
MOVT	R0, #hi_addr(_Update+13)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Update_Item157
;Function.c,495 :: 		Update[X_VERNIER_1]=Type;
MOVW	R2, #lo_addr(_Type+0)
MOVT	R2, #hi_addr(_Type+0)
LDRB	R1, [R2, #0]
MOVW	R0, #lo_addr(_Update+13)
MOVT	R0, #hi_addr(_Update+13)
STRB	R1, [R0, #0]
;Function.c,496 :: 		Display_Str(303, 55,  YEL,Type, "T1");
MOVW	R1, #lo_addr(?lstr_24_Function+0)
MOVT	R1, #hi_addr(?lstr_24_Function+0)
MOV	R0, R2
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #55
MOVS	R0, #47
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,497 :: 		if(Item==X_VERNIER_1){
MOVW	R0, #lo_addr(_Item+0)
MOVT	R0, #hi_addr(_Item+0)
LDRB	R0, [R0, #0]
CMP	R0, #13
IT	NE
BNE	L_Update_Item158
;Function.c,498 :: 		Display_Str(88,2,WHITE,Type,"!Time Cursor1 ");
MOVW	R1, #lo_addr(?lstr_25_Function+0)
MOVT	R1, #hi_addr(?lstr_25_Function+0)
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #88
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,499 :: 		if(Hide_t1==0) Draw_ti(_t1);
MOVW	R0, #lo_addr(_Hide_t1+0)
MOVT	R0, #hi_addr(_Hide_t1+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_Update_Item159
MOVW	R0, #lo_addr(__t1+0)
MOVT	R0, #hi_addr(__t1+0)
LDRB	R0, [R0, #0]
BL	_Draw_ti+0
L_Update_Item159:
;Function.c,500 :: 		Draw_Dot_ti(_t1);
MOVW	R0, #lo_addr(__t1+0)
MOVT	R0, #hi_addr(__t1+0)
LDRB	R0, [R0, #0]
BL	_Draw_Dot_ti+0
;Function.c,501 :: 		}
L_Update_Item158:
;Function.c,502 :: 		}
L_Update_Item157:
;Function.c,504 :: 		if( Update[X_POSITION]!=0){
MOVW	R0, #lo_addr(_Update+14)
MOVT	R0, #hi_addr(_Update+14)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Update_Item160
;Function.c,505 :: 		Update[X_POSITION]=Type;
MOVW	R2, #lo_addr(_Type+0)
MOVT	R2, #hi_addr(_Type+0)
LDRB	R1, [R2, #0]
MOVW	R0, #lo_addr(_Update+14)
MOVT	R0, #hi_addr(_Update+14)
STRB	R1, [R0, #0]
;Function.c,506 :: 		Display_Str(303, 35,  YEL,Type, "T0");
MOVW	R1, #lo_addr(?lstr_26_Function+0)
MOVT	R1, #hi_addr(?lstr_26_Function+0)
MOV	R0, R2
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #35
MOVS	R0, #47
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,507 :: 		if(Item==X_POSITION){
MOVW	R0, #lo_addr(_Item+0)
MOVT	R0, #hi_addr(_Item+0)
LDRB	R0, [R0, #0]
CMP	R0, #14
IT	NE
BNE	L_Update_Item161
;Function.c,508 :: 		Display_Str(88,2,WHITE,Type,"!X.POS Adjust ");
MOVW	R1, #lo_addr(?lstr_27_Function+0)
MOVT	R1, #hi_addr(?lstr_27_Function+0)
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R0, [R0, #0]
PUSH	(R1)
UXTB	R3, R0
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #88
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,509 :: 		}
L_Update_Item161:
;Function.c,510 :: 		}
L_Update_Item160:
;Function.c,512 :: 		if( Update[RUNNING_STATUS]!=0){
MOVW	R0, #lo_addr(_Update+15)
MOVT	R0, #hi_addr(_Update+15)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Update_Item162
;Function.c,513 :: 		Update[RUNNING_STATUS]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Update+15)
MOVT	R0, #hi_addr(_Update+15)
STRB	R1, [R0, #0]
;Function.c,514 :: 		if(Item_Index[RUNNING_STATUS]==0) Display_Str(284,2,GRN,PRN,"!RUN!");
MOVW	R0, #lo_addr(_Item_Index+15)
MOVT	R0, #hi_addr(_Item_Index+15)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_Update_Item163
MOVW	R0, #lo_addr(?lstr_28_Function+0)
MOVT	R0, #hi_addr(?lstr_28_Function+0)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #224
MOVS	R1, #2
MOVS	R0, #28
BL	_Display_Str+0
ADD	SP, SP, #4
IT	AL
BAL	L_Update_Item164
L_Update_Item163:
;Function.c,515 :: 		else  Display_Str(284,2,RED,PRN,"HOLD");
MOVW	R0, #lo_addr(?lstr_29_Function+0)
MOVT	R0, #hi_addr(?lstr_29_Function+0)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #31
MOVS	R1, #2
MOVS	R0, #28
BL	_Display_Str+0
ADD	SP, SP, #4
L_Update_Item164:
;Function.c,516 :: 		}
L_Update_Item162:
;Function.c,518 :: 		if( Update[DELTA_T]!=0){
MOVW	R0, #lo_addr(_Update+16)
MOVT	R0, #hi_addr(_Update+16)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Update_Item165
;Function.c,519 :: 		Update[DELTA_T]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Update+16)
MOVT	R0, #hi_addr(_Update+16)
STRB	R1, [R0, #0]
;Function.c,520 :: 		Int32String_sign(&Num, (_t2-_t1)*T_Scale[Item_Index[X_SENSITIVITY]], 3);//
MOVW	R0, #lo_addr(__t1+0)
MOVT	R0, #hi_addr(__t1+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(__t2+0)
MOVT	R0, #hi_addr(__t2+0)
LDRB	R0, [R0, #0]
SUB	R2, R0, R1
SXTH	R2, R2
MOVW	R0, #lo_addr(_Item_Index+2)
MOVT	R0, #hi_addr(_Item_Index+2)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #1
MOVW	R0, #lo_addr(_T_Scale+0)
MOVT	R0, #hi_addr(_T_Scale+0)
ADDS	R0, R0, R1
LDRH	R0, [R0, #0]
MULS	R0, R2, R0
MOVS	R2, #3
SXTH	R2, R2
SXTH	R1, R0
MOVW	R0, #lo_addr(_Num+0)
MOVT	R0, #hi_addr(_Num+0)
BL	_Int32String_sign+0
;Function.c,521 :: 		Display_Str(199,2,YEL,PRN,"[T=");
MOVW	R0, #lo_addr(?lstr_30_Function+0)
MOVT	R0, #hi_addr(?lstr_30_Function+0)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #199
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,522 :: 		Display_Str(224,2,YEL,PRN,(unsigned const char *)Num.str);
MOVW	R0, #lo_addr(_Num+2)
MOVT	R0, #hi_addr(_Num+2)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #224
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,523 :: 		Display_Str(224+Num.len*8,2,YEL,PRN," ");
MOVW	R1, #lo_addr(?lstr_31_Function+0)
MOVT	R1, #hi_addr(?lstr_31_Function+0)
MOVW	R0, #lo_addr(_Num+1)
MOVT	R0, #hi_addr(_Num+1)
LDRB	R0, [R0, #0]
LSLS	R0, R0, #3
SXTH	R0, R0
ADDS	R0, #224
PUSH	(R1)
MOVS	R3, #0
MOVS	R2, #255
MOVS	R1, #2
UXTB	R0, R0
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,524 :: 		Display_Str(224+40,2,YEL,PRN,T_Unit[Num.decPos]);
MOVW	R0, #lo_addr(_Num+0)
MOVT	R0, #hi_addr(_Num+0)
LDRB	R1, [R0, #0]
MOVS	R0, #3
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_T_Unit+0)
MOVT	R0, #hi_addr(_T_Unit+0)
ADDS	R0, R0, R1
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #8
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,525 :: 		}
L_Update_Item165:
;Function.c,527 :: 		if( Update[Y_VERNIER_2]!=0){
MOVW	R0, #lo_addr(_Update+17)
MOVT	R0, #hi_addr(_Update+17)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Update_Item166
;Function.c,528 :: 		Update[Y_VERNIER_2]=Type;
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_Update+17)
MOVT	R0, #hi_addr(_Update+17)
STRB	R1, [R0, #0]
;Function.c,529 :: 		if(Item!=Y_VERNIER_2) Tmp=PRN;
MOVW	R0, #lo_addr(_Item+0)
MOVT	R0, #hi_addr(_Item+0)
LDRB	R0, [R0, #0]
CMP	R0, #17
IT	EQ
BEQ	L_Update_Item167
; Tmp start address is: 12 (R3)
MOVS	R3, #0
; Tmp end address is: 12 (R3)
IT	AL
BAL	L_Update_Item168
L_Update_Item167:
;Function.c,530 :: 		else                  Tmp=Type;
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
; Tmp start address is: 12 (R3)
LDRB	R3, [R0, #0]
; Tmp end address is: 12 (R3)
L_Update_Item168:
;Function.c,531 :: 		if((Item<6)||(Item>14)){
; Tmp start address is: 12 (R3)
MOVW	R0, #lo_addr(_Item+0)
MOVT	R0, #hi_addr(_Item+0)
LDRB	R0, [R0, #0]
CMP	R0, #6
IT	CC
BCC	L__Update_Item255
MOVW	R0, #lo_addr(_Item+0)
MOVT	R0, #hi_addr(_Item+0)
LDRB	R0, [R0, #0]
CMP	R0, #14
IT	HI
BHI	L__Update_Item254
; Tmp end address is: 12 (R3)
IT	AL
BAL	L_Update_Item171
L__Update_Item255:
; Tmp start address is: 12 (R3)
L__Update_Item254:
;Function.c,532 :: 		Int32String_sign(&Num, (_v1-_v2)*V_Scale[Item_Index[Y_SENSITIVITY]], 3);//
MOVW	R0, #lo_addr(__v2+0)
MOVT	R0, #hi_addr(__v2+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(__v1+0)
MOVT	R0, #hi_addr(__v1+0)
LDRB	R0, [R0, #0]
SUB	R2, R0, R1
SXTH	R2, R2
MOVW	R0, #lo_addr(_Item_Index+1)
MOVT	R0, #hi_addr(_Item_Index+1)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #1
MOVW	R0, #lo_addr(_V_Scale+0)
MOVT	R0, #hi_addr(_V_Scale+0)
ADDS	R0, R0, R1
LDRH	R0, [R0, #0]
MULS	R0, R2, R0
STRB	R3, [SP, #4]
MOVS	R2, #3
SXTH	R2, R2
SXTH	R1, R0
MOVW	R0, #lo_addr(_Num+0)
MOVT	R0, #hi_addr(_Num+0)
BL	_Int32String_sign+0
;Function.c,533 :: 		Display_Str(88,2, WHITE,PRN,"V1");
MOVW	R0, #lo_addr(?lstr_32_Function+0)
MOVT	R0, #hi_addr(?lstr_32_Function+0)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #88
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,534 :: 		Display_Str(105,2,WHITE,PRN,"-");
MOVW	R0, #lo_addr(?lstr_33_Function+0)
MOVT	R0, #hi_addr(?lstr_33_Function+0)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #105
BL	_Display_Str+0
ADD	SP, SP, #4
LDRB	R3, [SP, #4]
;Function.c,535 :: 		Display_Str(114,2,WHITE,Tmp,"V2");
MOVW	R0, #lo_addr(?lstr_34_Function+0)
MOVT	R0, #hi_addr(?lstr_34_Function+0)
PUSH	(R0)
; Tmp end address is: 12 (R3)
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #114
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,536 :: 		Display_Str(131,2,WHITE,PRN,"=");
MOVW	R0, #lo_addr(?lstr_35_Function+0)
MOVT	R0, #hi_addr(?lstr_35_Function+0)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #131
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,537 :: 		Display_Str(139,2,WHITE,PRN,(unsigned const char *)Num.str);
MOVW	R0, #lo_addr(_Num+2)
MOVT	R0, #hi_addr(_Num+2)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #139
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,538 :: 		Display_Str(139+40,2,WHITE,PRN,V_Unit[Num.decPos]);
MOVW	R0, #lo_addr(_Num+0)
MOVT	R0, #hi_addr(_Num+0)
LDRB	R1, [R0, #0]
MOVS	R0, #3
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_V_Unit+0)
MOVT	R0, #hi_addr(_V_Unit+0)
ADDS	R0, R0, R1
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #179
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,539 :: 		}
L_Update_Item171:
;Function.c,540 :: 		}
L_Update_Item166:
;Function.c,542 :: 		if( Update[Y_VERNIER_1]!=0){
MOVW	R0, #lo_addr(_Update+18)
MOVT	R0, #hi_addr(_Update+18)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Update_Item172
;Function.c,543 :: 		Update[Y_VERNIER_1]=Type;
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_Update+18)
MOVT	R0, #hi_addr(_Update+18)
STRB	R1, [R0, #0]
;Function.c,544 :: 		if(Item!=Y_VERNIER_1) Tmp=PRN;
MOVW	R0, #lo_addr(_Item+0)
MOVT	R0, #hi_addr(_Item+0)
LDRB	R0, [R0, #0]
CMP	R0, #18
IT	EQ
BEQ	L_Update_Item173
; Tmp start address is: 12 (R3)
MOVS	R3, #0
; Tmp end address is: 12 (R3)
IT	AL
BAL	L_Update_Item174
L_Update_Item173:
;Function.c,545 :: 		else                  Tmp=Type;
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
; Tmp start address is: 12 (R3)
LDRB	R3, [R0, #0]
; Tmp end address is: 12 (R3)
L_Update_Item174:
;Function.c,546 :: 		if((Item<6)||(Item>14)){
; Tmp start address is: 12 (R3)
MOVW	R0, #lo_addr(_Item+0)
MOVT	R0, #hi_addr(_Item+0)
LDRB	R0, [R0, #0]
CMP	R0, #6
IT	CC
BCC	L__Update_Item257
MOVW	R0, #lo_addr(_Item+0)
MOVT	R0, #hi_addr(_Item+0)
LDRB	R0, [R0, #0]
CMP	R0, #14
IT	HI
BHI	L__Update_Item256
; Tmp end address is: 12 (R3)
IT	AL
BAL	L_Update_Item177
L__Update_Item257:
; Tmp start address is: 12 (R3)
L__Update_Item256:
;Function.c,547 :: 		Int32String_sign(&Num, (_v1-_v2)*V_Scale[Item_Index[Y_SENSITIVITY]], 3);//
MOVW	R0, #lo_addr(__v2+0)
MOVT	R0, #hi_addr(__v2+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(__v1+0)
MOVT	R0, #hi_addr(__v1+0)
LDRB	R0, [R0, #0]
SUB	R2, R0, R1
SXTH	R2, R2
MOVW	R0, #lo_addr(_Item_Index+1)
MOVT	R0, #hi_addr(_Item_Index+1)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #1
MOVW	R0, #lo_addr(_V_Scale+0)
MOVT	R0, #hi_addr(_V_Scale+0)
ADDS	R0, R0, R1
LDRH	R0, [R0, #0]
MULS	R0, R2, R0
STRB	R3, [SP, #4]
MOVS	R2, #3
SXTH	R2, R2
SXTH	R1, R0
MOVW	R0, #lo_addr(_Num+0)
MOVT	R0, #hi_addr(_Num+0)
BL	_Int32String_sign+0
LDRB	R3, [SP, #4]
;Function.c,548 :: 		Display_Str(88,2,WHITE,Tmp,"V1");
MOVW	R0, #lo_addr(?lstr_36_Function+0)
MOVT	R0, #hi_addr(?lstr_36_Function+0)
PUSH	(R0)
; Tmp end address is: 12 (R3)
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #88
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,549 :: 		Display_Str(105,2,WHITE,PRN,"-");
MOVW	R0, #lo_addr(?lstr_37_Function+0)
MOVT	R0, #hi_addr(?lstr_37_Function+0)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #105
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,550 :: 		Display_Str(139,2,WHITE,PRN,(unsigned const char *)Num.str);
MOVW	R0, #lo_addr(_Num+2)
MOVT	R0, #hi_addr(_Num+2)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #139
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,551 :: 		Display_Str(139+40,2,WHITE,PRN,V_Unit[Num.decPos]);
MOVW	R0, #lo_addr(_Num+0)
MOVT	R0, #hi_addr(_Num+0)
LDRB	R1, [R0, #0]
MOVS	R0, #3
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_V_Unit+0)
MOVT	R0, #hi_addr(_V_Unit+0)
ADDS	R0, R0, R1
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #179
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,552 :: 		}
L_Update_Item177:
;Function.c,553 :: 		}
L_Update_Item172:
;Function.c,555 :: 		if( Update[TRIG_LEVEL]!=0){
MOVW	R0, #lo_addr(_Update+19)
MOVT	R0, #hi_addr(_Update+19)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Update_Item178
;Function.c,556 :: 		Update[TRIG_LEVEL]=Type;
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_Update+19)
MOVT	R0, #hi_addr(_Update+19)
STRB	R1, [R0, #0]
;Function.c,557 :: 		Update[VERNIERS]=1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Update+20)
MOVT	R0, #hi_addr(_Update+20)
STRB	R1, [R0, #0]
;Function.c,558 :: 		if(Item!=TRIG_LEVEL) Tmp=PRN;
MOVW	R0, #lo_addr(_Item+0)
MOVT	R0, #hi_addr(_Item+0)
LDRB	R0, [R0, #0]
CMP	R0, #19
IT	EQ
BEQ	L_Update_Item179
; Tmp start address is: 12 (R3)
MOVS	R3, #0
; Tmp end address is: 12 (R3)
IT	AL
BAL	L_Update_Item180
L_Update_Item179:
;Function.c,559 :: 		else                 Tmp=Type;
MOVW	R0, #lo_addr(_Type+0)
MOVT	R0, #hi_addr(_Type+0)
; Tmp start address is: 12 (R3)
LDRB	R3, [R0, #0]
; Tmp end address is: 12 (R3)
L_Update_Item180:
;Function.c,560 :: 		Int32String_sign(&Num, (_vt-_v0)*V_Scale[Item_Index[Y_SENSITIVITY]], 3);//
; Tmp start address is: 12 (R3)
MOVW	R0, #lo_addr(__v0+0)
MOVT	R0, #hi_addr(__v0+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(__vt+0)
MOVT	R0, #hi_addr(__vt+0)
LDRB	R0, [R0, #0]
SUB	R2, R0, R1
SXTH	R2, R2
MOVW	R0, #lo_addr(_Item_Index+1)
MOVT	R0, #hi_addr(_Item_Index+1)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #1
MOVW	R0, #lo_addr(_V_Scale+0)
MOVT	R0, #hi_addr(_V_Scale+0)
ADDS	R0, R0, R1
LDRH	R0, [R0, #0]
MULS	R0, R2, R0
STRB	R3, [SP, #4]
MOVS	R2, #3
SXTH	R2, R2
SXTH	R1, R0
MOVW	R0, #lo_addr(_Num+0)
MOVT	R0, #hi_addr(_Num+0)
BL	_Int32String_sign+0
LDRB	R3, [SP, #4]
;Function.c,561 :: 		Display_Str(3,2,YEL,Tmp,"Vt");
MOVW	R0, #lo_addr(?lstr_38_Function+0)
MOVT	R0, #hi_addr(?lstr_38_Function+0)
PUSH	(R0)
; Tmp end address is: 12 (R3)
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #3
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,562 :: 		Display_Str(20,2,YEL,PRN,"=");
MOVW	R0, #lo_addr(?lstr_39_Function+0)
MOVT	R0, #hi_addr(?lstr_39_Function+0)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #20
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,563 :: 		Display_Str(28,2,YEL,PRN,(unsigned const char *)Num.str);
MOVW	R0, #lo_addr(_Num+2)
MOVT	R0, #hi_addr(_Num+2)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #28
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,564 :: 		Display_Str(28+40,2,YEL,PRN,V_Unit[Num.decPos]);
MOVW	R0, #lo_addr(_Num+0)
MOVT	R0, #hi_addr(_Num+0)
LDRB	R1, [R0, #0]
MOVS	R0, #3
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_V_Unit+0)
MOVT	R0, #hi_addr(_V_Unit+0)
ADDS	R0, R0, R1
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #255
MOVS	R1, #2
MOVS	R0, #68
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,565 :: 		}
L_Update_Item178:
;Function.c,567 :: 		if(Hide_vs){
MOVW	R0, #lo_addr(_Hide_vs+0)
MOVT	R0, #hi_addr(_Hide_vs+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Update_Item181
;Function.c,568 :: 		temp=_vt;
MOVW	R2, #lo_addr(__vt+0)
MOVT	R2, #hi_addr(__vt+0)
LDRB	R1, [R2, #0]
MOVW	R0, #lo_addr(_temp+0)
MOVT	R0, #hi_addr(_temp+0)
STRB	R1, [R0, #0]
;Function.c,569 :: 		for(_vt=temp-2; _vt>=(temp-Item_Index[TRIG_SENSITIVITY]); _vt=_vt-2)   Erase_Vn(_vt);
MOV	R0, R2
LDRB	R0, [R0, #0]
SUBS	R0, R0, #2
STRB	R0, [R2, #0]
L_Update_Item182:
MOVW	R0, #lo_addr(_Item_Index+6)
MOVT	R0, #hi_addr(_Item_Index+6)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_temp+0)
MOVT	R0, #hi_addr(_temp+0)
LDRB	R0, [R0, #0]
SUB	R1, R0, R1
SXTH	R1, R1
MOVW	R0, #lo_addr(__vt+0)
MOVT	R0, #hi_addr(__vt+0)
LDRB	R0, [R0, #0]
CMP	R0, R1
IT	LT
BLT	L_Update_Item183
MOVW	R0, #lo_addr(__vt+0)
MOVT	R0, #hi_addr(__vt+0)
LDRB	R0, [R0, #0]
BL	_Erase_Vn+0
MOVW	R1, #lo_addr(__vt+0)
MOVT	R1, #hi_addr(__vt+0)
LDRB	R0, [R1, #0]
SUBS	R0, R0, #2
STRB	R0, [R1, #0]
IT	AL
BAL	L_Update_Item182
L_Update_Item183:
;Function.c,570 :: 		for(_vt=(temp+2); _vt<=(temp+Item_Index[TRIG_SENSITIVITY]); _vt=_vt+2) Erase_Vn(_vt);
MOVW	R0, #lo_addr(_temp+0)
MOVT	R0, #hi_addr(_temp+0)
LDRB	R0, [R0, #0]
ADDS	R1, R0, #2
MOVW	R0, #lo_addr(__vt+0)
MOVT	R0, #hi_addr(__vt+0)
STRB	R1, [R0, #0]
L_Update_Item185:
MOVW	R0, #lo_addr(_Item_Index+6)
MOVT	R0, #hi_addr(_Item_Index+6)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_temp+0)
MOVT	R0, #hi_addr(_temp+0)
LDRB	R0, [R0, #0]
ADDS	R1, R0, R1
SXTH	R1, R1
MOVW	R0, #lo_addr(__vt+0)
MOVT	R0, #hi_addr(__vt+0)
LDRB	R0, [R0, #0]
CMP	R0, R1
IT	GT
BGT	L_Update_Item186
MOVW	R0, #lo_addr(__vt+0)
MOVT	R0, #hi_addr(__vt+0)
LDRB	R0, [R0, #0]
BL	_Erase_Vn+0
MOVW	R1, #lo_addr(__vt+0)
MOVT	R1, #hi_addr(__vt+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #2
STRB	R0, [R1, #0]
IT	AL
BAL	L_Update_Item185
L_Update_Item186:
;Function.c,571 :: 		_vt=temp;
MOVW	R0, #lo_addr(_temp+0)
MOVT	R0, #hi_addr(_temp+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(__vt+0)
MOVT	R0, #hi_addr(__vt+0)
STRB	R1, [R0, #0]
;Function.c,572 :: 		Hide_vs=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Hide_vs+0)
MOVT	R0, #hi_addr(_Hide_vs+0)
STRB	R1, [R0, #0]
;Function.c,573 :: 		}
L_Update_Item181:
;Function.c,575 :: 		if(Update[VERNIERS]){
MOVW	R0, #lo_addr(_Update+20)
MOVT	R0, #hi_addr(_Update+20)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Update_Item188
;Function.c,576 :: 		Update[VERNIERS]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Update+20)
MOVT	R0, #hi_addr(_Update+20)
STRB	R1, [R0, #0]
;Function.c,577 :: 		if(Hide_t1) Erase_Ti(_t1);
MOVW	R0, #lo_addr(_Hide_t1+0)
MOVT	R0, #hi_addr(_Hide_t1+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Update_Item189
MOVW	R0, #lo_addr(__t1+0)
MOVT	R0, #hi_addr(__t1+0)
LDRB	R0, [R0, #0]
BL	_Erase_Ti+0
IT	AL
BAL	L_Update_Item190
L_Update_Item189:
;Function.c,578 :: 		else        Draw_ti(_t1);
MOVW	R0, #lo_addr(__t1+0)
MOVT	R0, #hi_addr(__t1+0)
LDRB	R0, [R0, #0]
BL	_Draw_ti+0
L_Update_Item190:
;Function.c,579 :: 		if(Hide_t2) Erase_Ti(_t2);
MOVW	R0, #lo_addr(_Hide_t2+0)
MOVT	R0, #hi_addr(_Hide_t2+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Update_Item191
MOVW	R0, #lo_addr(__t2+0)
MOVT	R0, #hi_addr(__t2+0)
LDRB	R0, [R0, #0]
BL	_Erase_Ti+0
IT	AL
BAL	L_Update_Item192
L_Update_Item191:
;Function.c,580 :: 		else        Draw_ti(_t2);
MOVW	R0, #lo_addr(__t2+0)
MOVT	R0, #hi_addr(__t2+0)
LDRB	R0, [R0, #0]
BL	_Draw_ti+0
L_Update_Item192:
;Function.c,581 :: 		if(Hide_v1) Erase_Vi(_v1);
MOVW	R0, #lo_addr(_Hide_v1+0)
MOVT	R0, #hi_addr(_Hide_v1+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Update_Item193
MOVW	R0, #lo_addr(__v1+0)
MOVT	R0, #hi_addr(__v1+0)
LDRB	R0, [R0, #0]
BL	_Erase_Vi+0
IT	AL
BAL	L_Update_Item194
L_Update_Item193:
;Function.c,582 :: 		else        Draw_vi(_v1);
MOVW	R0, #lo_addr(__v1+0)
MOVT	R0, #hi_addr(__v1+0)
LDRB	R0, [R0, #0]
BL	_Draw_vi+0
L_Update_Item194:
;Function.c,583 :: 		if(Hide_v2) Erase_Vi(_v2);
MOVW	R0, #lo_addr(_Hide_v2+0)
MOVT	R0, #hi_addr(_Hide_v2+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Update_Item195
MOVW	R0, #lo_addr(__v2+0)
MOVT	R0, #hi_addr(__v2+0)
LDRB	R0, [R0, #0]
BL	_Erase_Vi+0
IT	AL
BAL	L_Update_Item196
L_Update_Item195:
;Function.c,584 :: 		else        Draw_vi(_v2);
MOVW	R0, #lo_addr(__v2+0)
MOVT	R0, #hi_addr(__v2+0)
LDRB	R0, [R0, #0]
BL	_Draw_vi+0
L_Update_Item196:
;Function.c,585 :: 		if(Hide_vt) Erase_Vn(_vt);
MOVW	R0, #lo_addr(_Hide_vt+0)
MOVT	R0, #hi_addr(_Hide_vt+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Update_Item197
MOVW	R0, #lo_addr(__vt+0)
MOVT	R0, #hi_addr(__vt+0)
LDRB	R0, [R0, #0]
BL	_Erase_Vn+0
IT	AL
BAL	L_Update_Item198
L_Update_Item197:
;Function.c,586 :: 		else        Draw_vt();
BL	_Draw_vt+0
L_Update_Item198:
;Function.c,587 :: 		Draw_Dot_vt();
BL	_Draw_Dot_vt+0
;Function.c,588 :: 		Draw_Dot_vi(_v1);
MOVW	R0, #lo_addr(__v1+0)
MOVT	R0, #hi_addr(__v1+0)
LDRB	R0, [R0, #0]
BL	_Draw_Dot_vi+0
;Function.c,589 :: 		Draw_Dot_vi(_v2);
MOVW	R0, #lo_addr(__v2+0)
MOVT	R0, #hi_addr(__v2+0)
LDRB	R0, [R0, #0]
BL	_Draw_Dot_vi+0
;Function.c,590 :: 		Draw_Dot_ti(_t1);
MOVW	R0, #lo_addr(__t1+0)
MOVT	R0, #hi_addr(__t1+0)
LDRB	R0, [R0, #0]
BL	_Draw_Dot_ti+0
;Function.c,591 :: 		Draw_Dot_ti(_t2);
MOVW	R0, #lo_addr(__t2+0)
MOVT	R0, #hi_addr(__t2+0)
LDRB	R0, [R0, #0]
BL	_Draw_Dot_ti+0
;Function.c,592 :: 		}
L_Update_Item188:
;Function.c,593 :: 		}
L_end_Update_Item:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _Update_Item
_Test_Display:
;Function.c,594 :: 		void Test_Display(int Var)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Function.c,596 :: 		Int32String_sign(&Num, Var, 4);
MOVS	R2, #4
SXTH	R2, R2
SXTH	R1, R0
MOVW	R0, #lo_addr(_Num+0)
MOVT	R0, #hi_addr(_Num+0)
BL	_Int32String_sign+0
;Function.c,597 :: 		Display_Str(28,60,YEL,PRN,(unsigned const char *)Num.str);
MOVW	R1, #lo_addr(_Num+2)
MOVT	R1, #hi_addr(_Num+2)
PUSH	(R1)
MOVS	R3, #0
MOVS	R2, #255
MOVS	R1, #60
MOVS	R0, #28
BL	_Display_Str+0
ADD	SP, SP, #4
;Function.c,598 :: 		}
L_end_Test_Display:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Test_Display
