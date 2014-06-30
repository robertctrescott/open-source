_Delay_us:
;msd.c,13 :: 		void Delay_us(void)
SUB	SP, SP, #4
;msd.c,14 :: 		{ u32 dlyCount = 0x100;
; dlyCount start address is: 4 (R1)
; dlyCount start address is: 4 (R1)
MOV	R1, #256
; dlyCount end address is: 4 (R1)
;msd.c,15 :: 		while(--dlyCount);
L_Delay_us0:
; dlyCount start address is: 4 (R1)
SUBS	R0, R1, #1
MOV	R1, R0
; dlyCount end address is: 4 (R1)
CMP	R0, #0
IT	EQ
BEQ	L_Delay_us1
; dlyCount end address is: 4 (R1)
; dlyCount start address is: 4 (R1)
; dlyCount end address is: 4 (R1)
IT	AL
BAL	L_Delay_us0
L_Delay_us1:
;msd.c,16 :: 		}
L_end_Delay_us:
ADD	SP, SP, #4
BX	LR
; end of _Delay_us
_MSD_Init:
;msd.c,20 :: 		u8 MSD_Init(void)
SUB	SP, SP, #8
STR	LR, [SP, #0]
;msd.c,21 :: 		{  u32 i=0;
;msd.c,22 :: 		SPI_Config();
BL	_SPI_Config+0
;msd.c,23 :: 		MSD_CS_HIGH();
MOVS	R1, #0
MOVW	R0, 1073810448
MOVT	R0, 16385
STR	R1, [R0, #0]
;msd.c,24 :: 		for(i=0; i <10; i++) MSD_WriteByte(DUMMY);  //Send dummy byte: 8 Clock pulses of delay
; i start address is: 4 (R1)
MOVS	R1, #0
; i end address is: 4 (R1)
L_MSD_Init2:
; i start address is: 4 (R1)
CMP	R1, #10
IT	CS
BCS	L_MSD_Init3
STR	R1, [SP, #4]
MOVS	R0, #255
BL	_MSD_WriteByte+0
LDR	R1, [SP, #4]
ADDS	R1, R1, #1
; i end address is: 4 (R1)
IT	AL
BAL	L_MSD_Init2
L_MSD_Init3:
;msd.c,25 :: 		return (MSD_GoIdleState());
BL	_MSD_GoIdleState+0
;msd.c,26 :: 		}
L_end_MSD_Init:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _MSD_Init
_MSD_WriteBlock:
;msd.c,30 :: 		u8 MSD_WriteBlock(u8* pBuffer, u32 WriteAddr, u16 NumByteToWrite)
; WriteAddr start address is: 4 (R1)
SUB	SP, SP, #20
STR	LR, [SP, #0]
STR	R0, [SP, #12]
MOV	R0, R1
STRB	R2, [SP, #16]
; WriteAddr end address is: 4 (R1)
;msd.c,31 :: 		{   u32 i=0;
;msd.c,32 :: 		u8 rvalue = MSD_RESPONSE_FAILURE;
MOVS	R3, #255
STRB	R3, [SP, #8]
;msd.c,33 :: 		MSD_CS_LOW();
MOVS	R4, #0
MOVW	R3, 1073810452
MOVT	R3, 16385
STR	R4, [R3, #0]
;msd.c,34 :: 		Delay_us(1);
MOVW	R7, #11
MOVT	R7, #0
NOP
NOP
L_MSD_WriteBlock5:
SUBS	R7, R7, #1
BNE	L_MSD_WriteBlock5
NOP
NOP
NOP
;msd.c,35 :: 		MSD_SendCmd(MSD_WRITE_BLOCK, WriteAddr, 0xFF);//Send CMD24
MOVS	R2, #255
MOV	R1, R0
MOVS	R0, #24
BL	_MSD_SendCmd+0
;msd.c,36 :: 		if(!MSD_GetResponse(MSD_RESPONSE_NO_ERROR)){
MOVS	R0, #0
BL	_MSD_GetResponse+0
CMP	R0, #0
IT	NE
BNE	L_MSD_WriteBlock7
;msd.c,37 :: 		MSD_WriteByte(DUMMY);                       //Send dummy byte: 8 Clock pulses of delay
MOVS	R0, #255
BL	_MSD_WriteByte+0
;msd.c,38 :: 		MSD_WriteByte(0xFE);
MOVS	R0, #254
BL	_MSD_WriteByte+0
;msd.c,39 :: 		for(i=0; i<NumByteToWrite; i++) {
MOVS	R3, #0
STR	R3, [SP, #4]
L_MSD_WriteBlock8:
LDRB	R4, [SP, #16]
LDR	R3, [SP, #4]
CMP	R3, R4
IT	CS
BCS	L_MSD_WriteBlock9
;msd.c,40 :: 		MSD_WriteByte(*pBuffer); pBuffer++;
LDR	R3, [SP, #12]
LDRB	R3, [R3, #0]
UXTB	R0, R3
BL	_MSD_WriteByte+0
LDR	R3, [SP, #12]
ADDS	R3, R3, #1
STR	R3, [SP, #12]
;msd.c,39 :: 		for(i=0; i<NumByteToWrite; i++) {
LDR	R3, [SP, #4]
ADDS	R3, R3, #1
STR	R3, [SP, #4]
;msd.c,41 :: 		}
IT	AL
BAL	L_MSD_WriteBlock8
L_MSD_WriteBlock9:
;msd.c,42 :: 		MSD_ReadByte(); MSD_ReadByte();             //DUMMY CRC bytes
BL	_MSD_ReadByte+0
BL	_MSD_ReadByte+0
;msd.c,43 :: 		if(MSD_GetDataResponse()==MSD_DATA_OK) rvalue=MSD_RESPONSE_NO_ERROR;
BL	_MSD_GetDataResponse+0
CMP	R0, #5
IT	NE
BNE	L_MSD_WriteBlock11
MOVS	R3, #0
STRB	R3, [SP, #8]
L_MSD_WriteBlock11:
;msd.c,44 :: 		}
L_MSD_WriteBlock7:
;msd.c,45 :: 		MSD_CS_HIGH(); MSD_WriteByte(DUMMY);          //Send dummy byte: 8 Clock pulses of delay
MOVS	R4, #0
MOVW	R3, 1073810448
MOVT	R3, 16385
STR	R4, [R3, #0]
MOVS	R0, #255
BL	_MSD_WriteByte+0
;msd.c,46 :: 		return rvalue;
LDRB	R0, [SP, #8]
;msd.c,47 :: 		}
L_end_MSD_WriteBlock:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _MSD_WriteBlock
_MSD_ReadBlock:
;msd.c,51 :: 		u8 MSD_ReadBlock(u8* pBuffer, u32 ReadAddr, u16 NumByteToRead)
; ReadAddr start address is: 4 (R1)
SUB	SP, SP, #20
STR	LR, [SP, #0]
STR	R0, [SP, #12]
MOV	R0, R1
STRB	R2, [SP, #16]
; ReadAddr end address is: 4 (R1)
;msd.c,52 :: 		{ u32 i = 0; u8 rvalue = MSD_RESPONSE_FAILURE;
MOVS	R3, #255
STRB	R3, [SP, #8]
;msd.c,53 :: 		MSD_CS_LOW(); Delay_us(1);
MOVS	R4, #0
MOVW	R3, 1073810452
MOVT	R3, 16385
STR	R4, [R3, #0]
MOVW	R7, #11
MOVT	R7, #0
NOP
NOP
L_MSD_ReadBlock12:
SUBS	R7, R7, #1
BNE	L_MSD_ReadBlock12
NOP
NOP
NOP
;msd.c,54 :: 		MSD_SendCmd(MSD_READ_SINGLE_BLOCK, ReadAddr, 0xFF);//send CMD17
MOVS	R2, #255
MOV	R1, R0
MOVS	R0, #17
BL	_MSD_SendCmd+0
;msd.c,55 :: 		if (!MSD_GetResponse(MSD_RESPONSE_NO_ERROR)) {
MOVS	R0, #0
BL	_MSD_GetResponse+0
CMP	R0, #0
IT	NE
BNE	L_MSD_ReadBlock14
;msd.c,56 :: 		if (!MSD_GetResponse(MSD_START_DATA_SINGLE_BLOCK_READ)) {
MOVS	R0, #254
BL	_MSD_GetResponse+0
CMP	R0, #0
IT	NE
BNE	L_MSD_ReadBlock15
;msd.c,57 :: 		for (i = 0; i < NumByteToRead; i++) {
MOVS	R3, #0
STR	R3, [SP, #4]
L_MSD_ReadBlock16:
LDRB	R4, [SP, #16]
LDR	R3, [SP, #4]
CMP	R3, R4
IT	CS
BCS	L_MSD_ReadBlock17
;msd.c,58 :: 		*pBuffer = MSD_ReadByte(); pBuffer++;
BL	_MSD_ReadByte+0
LDR	R3, [SP, #12]
STRB	R0, [R3, #0]
LDR	R3, [SP, #12]
ADDS	R3, R3, #1
STR	R3, [SP, #12]
;msd.c,57 :: 		for (i = 0; i < NumByteToRead; i++) {
LDR	R3, [SP, #4]
ADDS	R3, R3, #1
STR	R3, [SP, #4]
;msd.c,59 :: 		}
IT	AL
BAL	L_MSD_ReadBlock16
L_MSD_ReadBlock17:
;msd.c,60 :: 		MSD_ReadByte(); MSD_ReadByte();                //DUMMY CRC bytes
BL	_MSD_ReadByte+0
BL	_MSD_ReadByte+0
;msd.c,61 :: 		rvalue = MSD_RESPONSE_NO_ERROR;
MOVS	R3, #0
STRB	R3, [SP, #8]
;msd.c,62 :: 		}
L_MSD_ReadBlock15:
;msd.c,63 :: 		}
L_MSD_ReadBlock14:
;msd.c,64 :: 		MSD_CS_HIGH(); MSD_WriteByte(DUMMY);               //Send dummy byte: 8 Clock pulses of delay
MOVS	R4, #0
MOVW	R3, 1073810448
MOVT	R3, 16385
STR	R4, [R3, #0]
MOVS	R0, #255
BL	_MSD_WriteByte+0
;msd.c,65 :: 		return rvalue;
LDRB	R0, [SP, #8]
;msd.c,66 :: 		}
L_end_MSD_ReadBlock:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _MSD_ReadBlock
_MSD_WriteBuffer:
;msd.c,70 :: 		u8 MSD_WriteBuffer(u8* pBuffer, u32 WriteAddr, u32 NumByteToWrite)
; NumByteToWrite start address is: 8 (R2)
SUB	SP, SP, #24
STR	LR, [SP, #0]
STR	R0, [SP, #16]
; NumByteToWrite end address is: 8 (R2)
; NumByteToWrite start address is: 8 (R2)
;msd.c,71 :: 		{ u32 i=0, NbrOfBlock=0, Offset=0; u8 rvalue=MSD_RESPONSE_FAILURE;
MOVS	R3, #255
STRB	R3, [SP, #12]
;msd.c,72 :: 		NbrOfBlock = NumByteToWrite/BLOCK_SIZE;
LSRS	R3, R2, #9
; NumByteToWrite end address is: 8 (R2)
STR	R3, [SP, #8]
;msd.c,73 :: 		MSD_CS_LOW(); Delay_us(1);
MOVS	R4, #0
MOVW	R3, 1073810452
MOVT	R3, 16385
STR	R4, [R3, #0]
MOVW	R7, #11
MOVT	R7, #0
NOP
NOP
L_MSD_WriteBuffer19:
SUBS	R7, R7, #1
BNE	L_MSD_WriteBuffer19
NOP
NOP
NOP
;msd.c,74 :: 		while(NbrOfBlock --) {
L_MSD_WriteBuffer21:
LDR	R4, [SP, #8]
LDR	R3, [SP, #8]
SUBS	R3, R3, #1
STR	R3, [SP, #8]
CMP	R4, #0
IT	EQ
BEQ	L_MSD_WriteBuffer22
;msd.c,75 :: 		if(MSD_GetResponse(MSD_RESPONSE_NO_ERROR)){
MOVS	R0, #0
BL	_MSD_GetResponse+0
CMP	R0, #0
IT	EQ
BEQ	L_MSD_WriteBuffer23
;msd.c,76 :: 		return MSD_RESPONSE_FAILURE;
MOVS	R0, #255
IT	AL
BAL	L_end_MSD_WriteBuffer
;msd.c,77 :: 		}
L_MSD_WriteBuffer23:
;msd.c,78 :: 		MSD_WriteByte(DUMMY);                       //Send dummy byte: 8 Clock pulses of delay
MOVS	R0, #255
BL	_MSD_WriteByte+0
;msd.c,79 :: 		MSD_WriteByte(MSD_START_DATA_SINGLE_BLOCK_WRITE);
MOVS	R0, #254
BL	_MSD_WriteByte+0
;msd.c,80 :: 		for(i=0; i<BLOCK_SIZE; i++){
MOVS	R0, #0
L_MSD_WriteBuffer24:
CMP	R0, #512
IT	CS
BCS	L_MSD_WriteBuffer25
;msd.c,81 :: 		MSD_WriteByte(*pBuffer); pBuffer++;
LDR	R3, [SP, #16]
LDRB	R3, [R3, #0]
STR	R0, [SP, #4]
UXTB	R0, R3
BL	_MSD_WriteByte+0
LDR	R0, [SP, #4]
LDR	R3, [SP, #16]
ADDS	R3, R3, #1
STR	R3, [SP, #16]
;msd.c,80 :: 		for(i=0; i<BLOCK_SIZE; i++){
ADDS	R3, R0, #1
; i start address is: 4 (R1)
MOV	R1, R3
;msd.c,82 :: 		}
MOV	R0, R1
; i end address is: 4 (R1)
IT	AL
BAL	L_MSD_WriteBuffer24
L_MSD_WriteBuffer25:
;msd.c,84 :: 		MSD_ReadByte(); MSD_ReadByte();            //DUMMY CRC bytes
BL	_MSD_ReadByte+0
BL	_MSD_ReadByte+0
;msd.c,85 :: 		if(MSD_GetDataResponse()==MSD_DATA_OK) {
BL	_MSD_GetDataResponse+0
CMP	R0, #5
IT	NE
BNE	L_MSD_WriteBuffer27
;msd.c,86 :: 		rvalue=MSD_RESPONSE_NO_ERROR;
MOVS	R3, #0
STRB	R3, [SP, #12]
;msd.c,87 :: 		} else {
IT	AL
BAL	L_MSD_WriteBuffer28
L_MSD_WriteBuffer27:
;msd.c,88 :: 		rvalue=MSD_RESPONSE_FAILURE;
MOVS	R3, #255
STRB	R3, [SP, #12]
;msd.c,89 :: 		}
L_MSD_WriteBuffer28:
;msd.c,90 :: 		}
IT	AL
BAL	L_MSD_WriteBuffer21
L_MSD_WriteBuffer22:
;msd.c,91 :: 		MSD_CS_HIGH(); MSD_WriteByte(DUMMY);         //Send dummy byte: 8 Clock pulses of delay
MOVS	R4, #0
MOVW	R3, 1073810448
MOVT	R3, 16385
STR	R4, [R3, #0]
MOVS	R0, #255
BL	_MSD_WriteByte+0
;msd.c,92 :: 		return rvalue;
LDRB	R0, [SP, #12]
;msd.c,93 :: 		}
L_end_MSD_WriteBuffer:
LDR	LR, [SP, #0]
ADD	SP, SP, #24
BX	LR
; end of _MSD_WriteBuffer
_MSD_ReadBuffer:
;msd.c,97 :: 		u8 MSD_ReadBuffer(u8* pBuffer, u32 ReadAddr, u32 NumByteToRead)
; NumByteToRead start address is: 8 (R2)
SUB	SP, SP, #28
STR	LR, [SP, #0]
STR	R0, [SP, #20]
MOV	R0, R2
STR	R1, [SP, #24]
; NumByteToRead end address is: 8 (R2)
;msd.c,98 :: 		{ u32 i=0, NbrOfBlock=0, Offset=0; u8 rvalue=MSD_RESPONSE_FAILURE;
MOV	R3, #0
STR	R3, [SP, #12]
MOVS	R3, #255
STRB	R3, [SP, #16]
;msd.c,99 :: 		NbrOfBlock=NumByteToRead / BLOCK_SIZE;
LSRS	R3, R0, #9
STR	R3, [SP, #8]
;msd.c,100 :: 		MSD_CS_LOW(); Delay_us(1);
MOVS	R4, #0
MOVW	R3, 1073810452
MOVT	R3, 16385
STR	R4, [R3, #0]
MOVW	R7, #11
MOVT	R7, #0
NOP
NOP
L_MSD_ReadBuffer29:
SUBS	R7, R7, #1
BNE	L_MSD_ReadBuffer29
NOP
NOP
NOP
;msd.c,101 :: 		while(NbrOfBlock --){
L_MSD_ReadBuffer31:
LDR	R4, [SP, #8]
LDR	R3, [SP, #8]
SUBS	R3, R3, #1
STR	R3, [SP, #8]
CMP	R4, #0
IT	EQ
BEQ	L_MSD_ReadBuffer32
;msd.c,102 :: 		MSD_SendCmd (MSD_READ_SINGLE_BLOCK, ReadAddr+Offset, 0xFF);//send CMD17
LDR	R4, [SP, #12]
LDR	R3, [SP, #24]
ADDS	R3, R3, R4
MOVS	R2, #255
MOV	R1, R3
MOVS	R0, #17
BL	_MSD_SendCmd+0
;msd.c,104 :: 		if (MSD_GetResponse(MSD_RESPONSE_NO_ERROR)){
MOVS	R0, #0
BL	_MSD_GetResponse+0
CMP	R0, #0
IT	EQ
BEQ	L_MSD_ReadBuffer33
;msd.c,105 :: 		return  MSD_RESPONSE_FAILURE;
MOVS	R0, #255
IT	AL
BAL	L_end_MSD_ReadBuffer
;msd.c,106 :: 		}
L_MSD_ReadBuffer33:
;msd.c,108 :: 		if (!MSD_GetResponse(MSD_START_DATA_SINGLE_BLOCK_READ)){
MOVS	R0, #254
BL	_MSD_GetResponse+0
CMP	R0, #0
IT	NE
BNE	L_MSD_ReadBuffer34
;msd.c,109 :: 		for(i=0; i<BLOCK_SIZE; i++) {
; i start address is: 16 (R4)
MOVS	R4, #0
; i end address is: 16 (R4)
MOV	R1, R4
L_MSD_ReadBuffer35:
; i start address is: 4 (R1)
CMP	R1, #512
IT	CS
BCS	L_MSD_ReadBuffer36
;msd.c,110 :: 		*pBuffer = MSD_ReadByte(); pBuffer++;
STR	R1, [SP, #4]
BL	_MSD_ReadByte+0
LDR	R1, [SP, #4]
LDR	R3, [SP, #20]
STRB	R0, [R3, #0]
LDR	R3, [SP, #20]
ADDS	R3, R3, #1
STR	R3, [SP, #20]
;msd.c,109 :: 		for(i=0; i<BLOCK_SIZE; i++) {
ADDS	R3, R1, #1
; i end address is: 4 (R1)
; i start address is: 16 (R4)
MOV	R4, R3
;msd.c,111 :: 		}
MOV	R1, R4
; i end address is: 16 (R4)
IT	AL
BAL	L_MSD_ReadBuffer35
L_MSD_ReadBuffer36:
;msd.c,112 :: 		Offset+=512;
LDR	R3, [SP, #12]
ADD	R3, R3, #512
STR	R3, [SP, #12]
;msd.c,113 :: 		MSD_ReadByte(); MSD_ReadByte();         //DUMMY CRC bytes
BL	_MSD_ReadByte+0
BL	_MSD_ReadByte+0
;msd.c,114 :: 		rvalue = MSD_RESPONSE_NO_ERROR;
MOVS	R3, #0
STRB	R3, [SP, #16]
;msd.c,115 :: 		} else {
IT	AL
BAL	L_MSD_ReadBuffer38
L_MSD_ReadBuffer34:
;msd.c,116 :: 		rvalue = MSD_RESPONSE_FAILURE;
MOVS	R3, #255
STRB	R3, [SP, #16]
;msd.c,117 :: 		}
L_MSD_ReadBuffer38:
;msd.c,118 :: 		}
IT	AL
BAL	L_MSD_ReadBuffer31
L_MSD_ReadBuffer32:
;msd.c,119 :: 		MSD_CS_HIGH(); MSD_WriteByte(DUMMY);
MOVS	R4, #0
MOVW	R3, 1073810448
MOVT	R3, 16385
STR	R4, [R3, #0]
MOVS	R0, #255
BL	_MSD_WriteByte+0
;msd.c,120 :: 		return rvalue;
LDRB	R0, [SP, #16]
;msd.c,121 :: 		}
L_end_MSD_ReadBuffer:
LDR	LR, [SP, #0]
ADD	SP, SP, #28
BX	LR
; end of _MSD_ReadBuffer
_MSD_GetCSDRegister:
;msd.c,133 :: 		u8 MSD_GetCSDRegister(sMSD_CSD* MSD_csd)
SUB	SP, SP, #32
STR	LR, [SP, #0]
MOV	R3, R0
; MSD_csd start address is: 12 (R3)
;msd.c,135 :: 		u32 i = 0;
;msd.c,136 :: 		u8 rvalue = MSD_RESPONSE_FAILURE;
; rvalue start address is: 16 (R4)
MOVS	R4, #255
;msd.c,140 :: 		MSD_CS_LOW();
MOVS	R2, #0
MOVW	R1, 1073810452
MOVT	R1, 16385
STR	R2, [R1, #0]
;msd.c,141 :: 		Delay_us(1);
MOVW	R7, #11
MOVT	R7, #0
NOP
NOP
L_MSD_GetCSDRegister39:
SUBS	R7, R7, #1
BNE	L_MSD_GetCSDRegister39
NOP
NOP
NOP
;msd.c,144 :: 		MSD_SendCmd(MSD_SEND_CSD, 0, 0xFF);
STRB	R4, [SP, #4]
STR	R3, [SP, #8]
MOVS	R2, #255
MOVS	R1, #0
MOVS	R0, #9
BL	_MSD_SendCmd+0
;msd.c,147 :: 		if (!MSD_GetResponse(MSD_RESPONSE_NO_ERROR))
MOVS	R0, #0
BL	_MSD_GetResponse+0
LDR	R3, [SP, #8]
LDRB	R4, [SP, #4]
CMP	R0, #0
IT	NE
BNE	L__MSD_GetCSDRegister85
; rvalue end address is: 16 (R4)
;msd.c,149 :: 		if (!MSD_GetResponse(MSD_START_DATA_SINGLE_BLOCK_READ))
STR	R3, [SP, #4]
MOVS	R0, #254
BL	_MSD_GetResponse+0
LDR	R3, [SP, #4]
CMP	R0, #0
IT	NE
BNE	L__MSD_GetCSDRegister84
;msd.c,151 :: 		for (i = 0; i < 16; i++)
; i start address is: 8 (R2)
MOVS	R2, #0
; MSD_csd end address is: 12 (R3)
; i end address is: 8 (R2)
L_MSD_GetCSDRegister43:
; i start address is: 8 (R2)
; MSD_csd start address is: 12 (R3)
CMP	R2, #16
IT	CS
BCS	L_MSD_GetCSDRegister44
;msd.c,154 :: 		CSD_Tab[i] = MSD_ReadByte();
ADD	R1, SP, #12
ADDS	R1, R1, R2
STR	R1, [SP, #28]
STR	R3, [SP, #4]
STR	R2, [SP, #8]
BL	_MSD_ReadByte+0
LDR	R2, [SP, #8]
LDR	R3, [SP, #4]
LDR	R1, [SP, #28]
STRB	R0, [R1, #0]
;msd.c,151 :: 		for (i = 0; i < 16; i++)
ADDS	R2, R2, #1
;msd.c,155 :: 		}
; i end address is: 8 (R2)
IT	AL
BAL	L_MSD_GetCSDRegister43
L_MSD_GetCSDRegister44:
;msd.c,156 :: 		}
MOV	R0, R3
IT	AL
BAL	L_MSD_GetCSDRegister42
; MSD_csd end address is: 12 (R3)
L__MSD_GetCSDRegister84:
;msd.c,149 :: 		if (!MSD_GetResponse(MSD_START_DATA_SINGLE_BLOCK_READ))
MOV	R0, R3
;msd.c,156 :: 		}
L_MSD_GetCSDRegister42:
;msd.c,158 :: 		MSD_WriteByte(DUMMY);
STR	R0, [SP, #4]
MOVS	R0, #255
BL	_MSD_WriteByte+0
;msd.c,159 :: 		MSD_WriteByte(DUMMY);
MOVS	R0, #255
BL	_MSD_WriteByte+0
LDR	R0, [SP, #4]
;msd.c,161 :: 		rvalue = MSD_RESPONSE_NO_ERROR;
; rvalue start address is: 4 (R1)
MOVS	R1, #0
; rvalue end address is: 4 (R1)
MOV	R5, R0
UXTB	R0, R1
;msd.c,162 :: 		}
IT	AL
BAL	L_MSD_GetCSDRegister41
L__MSD_GetCSDRegister85:
;msd.c,147 :: 		if (!MSD_GetResponse(MSD_RESPONSE_NO_ERROR))
UXTB	R0, R4
MOV	R5, R3
;msd.c,162 :: 		}
L_MSD_GetCSDRegister41:
;msd.c,165 :: 		MSD_CS_HIGH();
; MSD_csd start address is: 20 (R5)
MOVS	R2, #0
MOVW	R1, 1073810448
MOVT	R1, 16385
STR	R2, [R1, #0]
;msd.c,167 :: 		MSD_WriteByte(DUMMY);
STR	R5, [SP, #4]
STRB	R0, [SP, #8]
MOVS	R0, #255
BL	_MSD_WriteByte+0
LDRB	R0, [SP, #8]
LDR	R5, [SP, #4]
;msd.c,170 :: 		MSD_csd->CSDStruct = (CSD_Tab[0] & 0xC0) >> 6;
ADD	R4, SP, #12
LDRB	R1, [R4, #0]
AND	R1, R1, #192
UXTB	R1, R1
LSRS	R1, R1, #6
STRB	R1, [R5, #0]
;msd.c,171 :: 		MSD_csd->SysSpecVersion = (CSD_Tab[0] & 0x3C) >> 2;
ADDS	R2, R5, #1
LDRB	R1, [R4, #0]
AND	R1, R1, #60
UXTB	R1, R1
LSRS	R1, R1, #2
STRB	R1, [R2, #0]
;msd.c,172 :: 		MSD_csd->Reserved1 = CSD_Tab[0] & 0x03;
ADDS	R2, R5, #2
LDRB	R1, [R4, #0]
AND	R1, R1, #3
STRB	R1, [R2, #0]
;msd.c,174 :: 		MSD_csd->TAAC = CSD_Tab[1] ;
ADDS	R2, R5, #3
ADDS	R1, R4, #1
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
;msd.c,176 :: 		MSD_csd->NSAC = CSD_Tab[2];
ADDS	R2, R5, #4
ADDS	R1, R4, #2
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
;msd.c,178 :: 		MSD_csd->MaxBusClkFrec = CSD_Tab[3];
ADDS	R2, R5, #5
ADDS	R1, R4, #3
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
;msd.c,180 :: 		MSD_csd->CardComdClasses = CSD_Tab[4] << 4;
ADDS	R2, R5, #6
ADDS	R1, R4, #4
LDRB	R1, [R1, #0]
LSLS	R1, R1, #4
STRB	R1, [R2, #0]
;msd.c,182 :: 		MSD_csd->CardComdClasses |= (CSD_Tab[5] & 0xF0) >> 4;
ADDS	R3, R5, #6
ADDS	R1, R4, #5
LDRB	R1, [R1, #0]
AND	R1, R1, #240
UXTB	R1, R1
LSRS	R2, R1, #4
UXTB	R2, R2
LDRB	R1, [R3, #0]
ORRS	R1, R2
STRB	R1, [R3, #0]
;msd.c,183 :: 		MSD_csd->RdBlockLen = CSD_Tab[5] & 0x0F;
ADDS	R2, R5, #7
ADDS	R1, R4, #5
LDRB	R1, [R1, #0]
AND	R1, R1, #15
STRB	R1, [R2, #0]
;msd.c,185 :: 		MSD_csd->PartBlockRead = (CSD_Tab[6] & 0x80) >> 7;
ADDW	R2, R5, #8
ADDS	R1, R4, #6
LDRB	R1, [R1, #0]
AND	R1, R1, #128
UXTB	R1, R1
LSRS	R1, R1, #7
STRB	R1, [R2, #0]
;msd.c,186 :: 		MSD_csd->WrBlockMisalign = (CSD_Tab[6] & 0x40) >> 6;
ADDW	R2, R5, #9
ADDS	R1, R4, #6
LDRB	R1, [R1, #0]
AND	R1, R1, #64
UXTB	R1, R1
LSRS	R1, R1, #6
STRB	R1, [R2, #0]
;msd.c,187 :: 		MSD_csd->RdBlockMisalign = (CSD_Tab[6] & 0x20) >> 5;
ADDW	R2, R5, #10
ADDS	R1, R4, #6
LDRB	R1, [R1, #0]
AND	R1, R1, #32
UXTB	R1, R1
LSRS	R1, R1, #5
STRB	R1, [R2, #0]
;msd.c,188 :: 		MSD_csd->DSRImpl = (CSD_Tab[6] & 0x10) >> 4;
ADDW	R2, R5, #11
ADDS	R1, R4, #6
LDRB	R1, [R1, #0]
AND	R1, R1, #16
UXTB	R1, R1
LSRS	R1, R1, #4
STRB	R1, [R2, #0]
;msd.c,189 :: 		MSD_csd->Reserved2 = 0; /* Reserved */
ADDW	R2, R5, #12
MOVS	R1, #0
STRB	R1, [R2, #0]
;msd.c,190 :: 		MSD_csd->DeviceSize = (CSD_Tab[6] & 0x03) << 10;
ADDW	R2, R5, #13
ADDS	R1, R4, #6
LDRB	R1, [R1, #0]
AND	R1, R1, #3
UXTB	R1, R1
LSLS	R1, R1, #10
STRB	R1, [R2, #0]
;msd.c,192 :: 		MSD_csd->DeviceSize |= (CSD_Tab[7]) << 2;
ADDW	R3, R5, #13
ADDS	R1, R4, #7
LDRB	R1, [R1, #0]
LSLS	R2, R1, #2
UXTH	R2, R2
LDRB	R1, [R3, #0]
ORRS	R1, R2
STRB	R1, [R3, #0]
;msd.c,194 :: 		MSD_csd->DeviceSize |= (CSD_Tab[8] & 0xC0) >> 6;
ADDW	R3, R5, #13
ADDW	R1, R4, #8
LDRB	R1, [R1, #0]
AND	R1, R1, #192
UXTB	R1, R1
LSRS	R2, R1, #6
UXTB	R2, R2
LDRB	R1, [R3, #0]
ORRS	R1, R2
STRB	R1, [R3, #0]
;msd.c,195 :: 		MSD_csd->MaxRdCurrentVDDMin = (CSD_Tab[8] & 0x38) >> 3;
ADDW	R2, R5, #14
ADDW	R1, R4, #8
LDRB	R1, [R1, #0]
AND	R1, R1, #56
UXTB	R1, R1
LSRS	R1, R1, #3
STRB	R1, [R2, #0]
;msd.c,196 :: 		MSD_csd->MaxRdCurrentVDDMax = (CSD_Tab[8] & 0x07);
ADDW	R2, R5, #15
ADDW	R1, R4, #8
LDRB	R1, [R1, #0]
AND	R1, R1, #7
STRB	R1, [R2, #0]
;msd.c,198 :: 		MSD_csd->MaxWrCurrentVDDMin = (CSD_Tab[9] & 0xE0) >> 5;
ADDW	R2, R5, #16
ADDW	R1, R4, #9
LDRB	R1, [R1, #0]
AND	R1, R1, #224
UXTB	R1, R1
LSRS	R1, R1, #5
STRB	R1, [R2, #0]
;msd.c,199 :: 		MSD_csd->MaxWrCurrentVDDMax = (CSD_Tab[9] & 0x1C) >> 2;
ADDW	R2, R5, #17
ADDW	R1, R4, #9
LDRB	R1, [R1, #0]
AND	R1, R1, #28
UXTB	R1, R1
LSRS	R1, R1, #2
STRB	R1, [R2, #0]
;msd.c,200 :: 		MSD_csd->DeviceSizeMul = (CSD_Tab[9] & 0x03) << 1;
ADDW	R2, R5, #18
ADDW	R1, R4, #9
LDRB	R1, [R1, #0]
AND	R1, R1, #3
UXTB	R1, R1
LSLS	R1, R1, #1
STRB	R1, [R2, #0]
;msd.c,202 :: 		MSD_csd->DeviceSizeMul |= (CSD_Tab[10] & 0x80) >> 7;
ADDW	R3, R5, #18
ADDW	R1, R4, #10
LDRB	R1, [R1, #0]
AND	R1, R1, #128
UXTB	R1, R1
LSRS	R2, R1, #7
UXTB	R2, R2
LDRB	R1, [R3, #0]
ORRS	R1, R2
STRB	R1, [R3, #0]
;msd.c,203 :: 		MSD_csd->EraseGrSize = (CSD_Tab[10] & 0x7C) >> 2;
ADDW	R2, R5, #19
ADDW	R1, R4, #10
LDRB	R1, [R1, #0]
AND	R1, R1, #124
UXTB	R1, R1
LSRS	R1, R1, #2
STRB	R1, [R2, #0]
;msd.c,204 :: 		MSD_csd->EraseGrMul = (CSD_Tab[10] & 0x03) << 3;
ADDW	R2, R5, #20
ADDW	R1, R4, #10
LDRB	R1, [R1, #0]
AND	R1, R1, #3
UXTB	R1, R1
LSLS	R1, R1, #3
STRB	R1, [R2, #0]
;msd.c,206 :: 		MSD_csd->EraseGrMul |= (CSD_Tab[11] & 0xE0) >> 5;
ADDW	R3, R5, #20
ADDW	R1, R4, #11
LDRB	R1, [R1, #0]
AND	R1, R1, #224
UXTB	R1, R1
LSRS	R2, R1, #5
UXTB	R2, R2
LDRB	R1, [R3, #0]
ORRS	R1, R2
STRB	R1, [R3, #0]
;msd.c,207 :: 		MSD_csd->WrProtectGrSize = (CSD_Tab[11] & 0x1F);
ADDW	R2, R5, #21
ADDW	R1, R4, #11
LDRB	R1, [R1, #0]
AND	R1, R1, #31
STRB	R1, [R2, #0]
;msd.c,209 :: 		MSD_csd->WrProtectGrEnable = (CSD_Tab[12] & 0x80) >> 7;
ADDW	R2, R5, #22
ADDW	R1, R4, #12
LDRB	R1, [R1, #0]
AND	R1, R1, #128
UXTB	R1, R1
LSRS	R1, R1, #7
STRB	R1, [R2, #0]
;msd.c,210 :: 		MSD_csd->ManDeflECC = (CSD_Tab[12] & 0x60) >> 5;
ADDW	R2, R5, #23
ADDW	R1, R4, #12
LDRB	R1, [R1, #0]
AND	R1, R1, #96
UXTB	R1, R1
LSRS	R1, R1, #5
STRB	R1, [R2, #0]
;msd.c,211 :: 		MSD_csd->WrSpeedFact = (CSD_Tab[12] & 0x1C) >> 2;
ADDW	R2, R5, #24
ADDW	R1, R4, #12
LDRB	R1, [R1, #0]
AND	R1, R1, #28
UXTB	R1, R1
LSRS	R1, R1, #2
STRB	R1, [R2, #0]
;msd.c,212 :: 		MSD_csd->MaxWrBlockLen = (CSD_Tab[12] & 0x03) << 2;
ADDW	R2, R5, #25
ADDW	R1, R4, #12
LDRB	R1, [R1, #0]
AND	R1, R1, #3
UXTB	R1, R1
LSLS	R1, R1, #2
STRB	R1, [R2, #0]
;msd.c,214 :: 		MSD_csd->MaxWrBlockLen |= (CSD_Tab[13] & 0xc0) >> 6;
ADDW	R3, R5, #25
ADDW	R1, R4, #13
LDRB	R1, [R1, #0]
AND	R1, R1, #192
UXTB	R1, R1
LSRS	R2, R1, #6
UXTB	R2, R2
LDRB	R1, [R3, #0]
ORRS	R1, R2
STRB	R1, [R3, #0]
;msd.c,215 :: 		MSD_csd->WriteBlockPaPartial = (CSD_Tab[13] & 0x20) >> 5;
ADDW	R2, R5, #26
ADDW	R1, R4, #13
LDRB	R1, [R1, #0]
AND	R1, R1, #32
UXTB	R1, R1
LSRS	R1, R1, #5
STRB	R1, [R2, #0]
;msd.c,216 :: 		MSD_csd->Reserved3 = 0;
ADDW	R2, R5, #27
MOVS	R1, #0
STRB	R1, [R2, #0]
;msd.c,217 :: 		MSD_csd->ContentProtectAppli = (CSD_Tab[13] & 0x01);
ADDW	R2, R5, #28
ADDW	R1, R4, #13
LDRB	R1, [R1, #0]
AND	R1, R1, #1
STRB	R1, [R2, #0]
;msd.c,219 :: 		MSD_csd->FileFormatGrouop = (CSD_Tab[14] & 0x80) >> 7;
ADDW	R2, R5, #29
ADDW	R1, R4, #14
LDRB	R1, [R1, #0]
AND	R1, R1, #128
UXTB	R1, R1
LSRS	R1, R1, #7
STRB	R1, [R2, #0]
;msd.c,220 :: 		MSD_csd->CopyFlag = (CSD_Tab[14] & 0x40) >> 6;
ADDW	R2, R5, #30
ADDW	R1, R4, #14
LDRB	R1, [R1, #0]
AND	R1, R1, #64
UXTB	R1, R1
LSRS	R1, R1, #6
STRB	R1, [R2, #0]
;msd.c,221 :: 		MSD_csd->PermWrProtect = (CSD_Tab[14] & 0x20) >> 5;
ADDW	R2, R5, #31
ADDW	R1, R4, #14
LDRB	R1, [R1, #0]
AND	R1, R1, #32
UXTB	R1, R1
LSRS	R1, R1, #5
STRB	R1, [R2, #0]
;msd.c,222 :: 		MSD_csd->TempWrProtect = (CSD_Tab[14] & 0x10) >> 4;
ADDW	R2, R5, #32
ADDW	R1, R4, #14
LDRB	R1, [R1, #0]
AND	R1, R1, #16
UXTB	R1, R1
LSRS	R1, R1, #4
STRB	R1, [R2, #0]
;msd.c,223 :: 		MSD_csd->FileFormat = (CSD_Tab[14] & 0x0C) >> 2;
ADDW	R2, R5, #33
ADDW	R1, R4, #14
LDRB	R1, [R1, #0]
AND	R1, R1, #12
UXTB	R1, R1
LSRS	R1, R1, #2
STRB	R1, [R2, #0]
;msd.c,224 :: 		MSD_csd->ECC = (CSD_Tab[14] & 0x03);
ADDW	R2, R5, #34
ADDW	R1, R4, #14
LDRB	R1, [R1, #0]
AND	R1, R1, #3
STRB	R1, [R2, #0]
;msd.c,226 :: 		MSD_csd->CRC = (CSD_Tab[15] & 0xFE) >> 1;
ADDW	R2, R5, #35
ADDW	R1, R4, #15
LDRB	R1, [R1, #0]
AND	R1, R1, #254
UXTB	R1, R1
LSRS	R1, R1, #1
STRB	R1, [R2, #0]
;msd.c,227 :: 		MSD_csd->Reserved4 = 1;
ADDW	R2, R5, #36
; MSD_csd end address is: 20 (R5)
MOVS	R1, #1
STRB	R1, [R2, #0]
;msd.c,230 :: 		return rvalue;
;msd.c,231 :: 		}
L_end_MSD_GetCSDRegister:
LDR	LR, [SP, #0]
ADD	SP, SP, #32
BX	LR
; end of _MSD_GetCSDRegister
_MSD_GetCIDRegister:
;msd.c,243 :: 		u8 MSD_GetCIDRegister(sMSD_CID* MSD_cid)
SUB	SP, SP, #32
STR	LR, [SP, #0]
MOV	R3, R0
; MSD_cid start address is: 12 (R3)
;msd.c,245 :: 		u32 i = 0;
;msd.c,246 :: 		u8 rvalue = MSD_RESPONSE_FAILURE;
; rvalue start address is: 16 (R4)
MOVS	R4, #255
;msd.c,250 :: 		MSD_CS_LOW();
MOVS	R2, #0
MOVW	R1, 1073810452
MOVT	R1, 16385
STR	R2, [R1, #0]
;msd.c,251 :: 		Delay_us(1);
MOVW	R7, #11
MOVT	R7, #0
NOP
NOP
L_MSD_GetCIDRegister46:
SUBS	R7, R7, #1
BNE	L_MSD_GetCIDRegister46
NOP
NOP
NOP
;msd.c,254 :: 		MSD_SendCmd(MSD_SEND_CID, 0, 0xFF);
STRB	R4, [SP, #4]
STR	R3, [SP, #8]
MOVS	R2, #255
MOVS	R1, #0
MOVS	R0, #10
BL	_MSD_SendCmd+0
;msd.c,257 :: 		if (!MSD_GetResponse(MSD_RESPONSE_NO_ERROR))
MOVS	R0, #0
BL	_MSD_GetResponse+0
LDR	R3, [SP, #8]
LDRB	R4, [SP, #4]
CMP	R0, #0
IT	NE
BNE	L__MSD_GetCIDRegister87
; rvalue end address is: 16 (R4)
;msd.c,259 :: 		if (!MSD_GetResponse(MSD_START_DATA_SINGLE_BLOCK_READ))
STR	R3, [SP, #4]
MOVS	R0, #254
BL	_MSD_GetResponse+0
LDR	R3, [SP, #4]
CMP	R0, #0
IT	NE
BNE	L__MSD_GetCIDRegister86
;msd.c,262 :: 		for (i = 0; i < 16; i++)
; i start address is: 8 (R2)
MOVS	R2, #0
; MSD_cid end address is: 12 (R3)
; i end address is: 8 (R2)
L_MSD_GetCIDRegister50:
; i start address is: 8 (R2)
; MSD_cid start address is: 12 (R3)
CMP	R2, #16
IT	CS
BCS	L_MSD_GetCIDRegister51
;msd.c,264 :: 		CID_Tab[i] = MSD_ReadByte();
ADD	R1, SP, #12
ADDS	R1, R1, R2
STR	R1, [SP, #28]
STR	R3, [SP, #4]
STR	R2, [SP, #8]
BL	_MSD_ReadByte+0
LDR	R2, [SP, #8]
LDR	R3, [SP, #4]
LDR	R1, [SP, #28]
STRB	R0, [R1, #0]
;msd.c,262 :: 		for (i = 0; i < 16; i++)
ADDS	R2, R2, #1
;msd.c,265 :: 		}
; i end address is: 8 (R2)
IT	AL
BAL	L_MSD_GetCIDRegister50
L_MSD_GetCIDRegister51:
;msd.c,266 :: 		}
MOV	R0, R3
IT	AL
BAL	L_MSD_GetCIDRegister49
; MSD_cid end address is: 12 (R3)
L__MSD_GetCIDRegister86:
;msd.c,259 :: 		if (!MSD_GetResponse(MSD_START_DATA_SINGLE_BLOCK_READ))
MOV	R0, R3
;msd.c,266 :: 		}
L_MSD_GetCIDRegister49:
;msd.c,268 :: 		MSD_WriteByte(DUMMY);
STR	R0, [SP, #4]
MOVS	R0, #255
BL	_MSD_WriteByte+0
;msd.c,269 :: 		MSD_WriteByte(DUMMY);
MOVS	R0, #255
BL	_MSD_WriteByte+0
LDR	R0, [SP, #4]
;msd.c,271 :: 		rvalue = MSD_RESPONSE_NO_ERROR;
; rvalue start address is: 4 (R1)
MOVS	R1, #0
; rvalue end address is: 4 (R1)
MOV	R5, R0
UXTB	R0, R1
;msd.c,272 :: 		}
IT	AL
BAL	L_MSD_GetCIDRegister48
L__MSD_GetCIDRegister87:
;msd.c,257 :: 		if (!MSD_GetResponse(MSD_RESPONSE_NO_ERROR))
UXTB	R0, R4
MOV	R5, R3
;msd.c,272 :: 		}
L_MSD_GetCIDRegister48:
;msd.c,275 :: 		MSD_CS_HIGH();
; MSD_cid start address is: 20 (R5)
MOVS	R2, #0
MOVW	R1, 1073810448
MOVT	R1, 16385
STR	R2, [R1, #0]
;msd.c,277 :: 		MSD_WriteByte(DUMMY);
STR	R5, [SP, #4]
STRB	R0, [SP, #8]
MOVS	R0, #255
BL	_MSD_WriteByte+0
LDRB	R0, [SP, #8]
LDR	R5, [SP, #4]
;msd.c,280 :: 		MSD_cid->ManufacturerID = CID_Tab[0];
ADD	R4, SP, #12
LDRB	R1, [R4, #0]
STRB	R1, [R5, #0]
;msd.c,282 :: 		MSD_cid->OEM_AppliID = CID_Tab[1] << 8;
ADDS	R2, R5, #1
ADDS	R1, R4, #1
LDRB	R1, [R1, #0]
LSLS	R1, R1, #8
STRB	R1, [R2, #0]
;msd.c,284 :: 		MSD_cid->OEM_AppliID |= CID_Tab[2];
ADDS	R3, R5, #1
ADDS	R1, R4, #2
LDRB	R2, [R1, #0]
LDRB	R1, [R3, #0]
ORRS	R1, R2
STRB	R1, [R3, #0]
;msd.c,286 :: 		MSD_cid->ProdName1 = CID_Tab[3] << 24;
ADDS	R2, R5, #4
MOVW	R1, #0
STR	R1, [R2, #0]
;msd.c,288 :: 		MSD_cid->ProdName1 |= CID_Tab[4] << 16;
ADDS	R3, R5, #4
ADDS	R1, R4, #4
LDRB	R1, [R1, #0]
LSLS	R2, R1, #16
UXTH	R2, R2
LDR	R1, [R3, #0]
ORRS	R1, R2
STR	R1, [R3, #0]
;msd.c,290 :: 		MSD_cid->ProdName1 |= CID_Tab[5] << 8;
ADDS	R3, R5, #4
ADDS	R1, R4, #5
LDRB	R1, [R1, #0]
LSLS	R2, R1, #8
UXTH	R2, R2
LDR	R1, [R3, #0]
ORRS	R1, R2
STR	R1, [R3, #0]
;msd.c,292 :: 		MSD_cid->ProdName1 |= CID_Tab[6];
ADDS	R3, R5, #4
ADDS	R1, R4, #6
LDRB	R2, [R1, #0]
LDR	R1, [R3, #0]
ORRS	R1, R2
STR	R1, [R3, #0]
;msd.c,294 :: 		MSD_cid->ProdName2 = CID_Tab[7];
ADDW	R2, R5, #8
ADDS	R1, R4, #7
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
;msd.c,296 :: 		MSD_cid->ProdRev = CID_Tab[8];
ADDW	R2, R5, #9
ADDW	R1, R4, #8
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
;msd.c,298 :: 		MSD_cid->ProdSN = CID_Tab[9] << 24;
ADDW	R2, R5, #12
MOVW	R1, #0
STR	R1, [R2, #0]
;msd.c,300 :: 		MSD_cid->ProdSN |= CID_Tab[10] << 16;
ADDW	R3, R5, #12
ADDW	R1, R4, #10
LDRB	R1, [R1, #0]
LSLS	R2, R1, #16
UXTH	R2, R2
LDR	R1, [R3, #0]
ORRS	R1, R2
STR	R1, [R3, #0]
;msd.c,302 :: 		MSD_cid->ProdSN |= CID_Tab[11] << 8;
ADDW	R3, R5, #12
ADDW	R1, R4, #11
LDRB	R1, [R1, #0]
LSLS	R2, R1, #8
UXTH	R2, R2
LDR	R1, [R3, #0]
ORRS	R1, R2
STR	R1, [R3, #0]
;msd.c,304 :: 		MSD_cid->ProdSN |= CID_Tab[12];
ADDW	R3, R5, #12
ADDW	R1, R4, #12
LDRB	R2, [R1, #0]
LDR	R1, [R3, #0]
ORRS	R1, R2
STR	R1, [R3, #0]
;msd.c,306 :: 		MSD_cid->Reserved1 |= (CID_Tab[13] & 0xF0) >> 4;
ADDW	R3, R5, #16
ADDW	R1, R4, #13
LDRB	R1, [R1, #0]
AND	R1, R1, #240
UXTB	R1, R1
LSRS	R2, R1, #4
UXTB	R2, R2
LDRB	R1, [R3, #0]
ORRS	R1, R2
STRB	R1, [R3, #0]
;msd.c,308 :: 		MSD_cid->ManufactDate = (CID_Tab[13] & 0x0F) << 8;
ADDW	R2, R5, #17
ADDW	R1, R4, #13
LDRB	R1, [R1, #0]
AND	R1, R1, #15
UXTB	R1, R1
LSLS	R1, R1, #8
STRB	R1, [R2, #0]
;msd.c,310 :: 		MSD_cid->ManufactDate |= CID_Tab[14];
ADDW	R3, R5, #17
ADDW	R1, R4, #14
LDRB	R2, [R1, #0]
LDRB	R1, [R3, #0]
ORRS	R1, R2
STRB	R1, [R3, #0]
;msd.c,312 :: 		MSD_cid->CRC = (CID_Tab[15] & 0xFE) >> 1;
ADDW	R2, R5, #18
ADDW	R1, R4, #15
LDRB	R1, [R1, #0]
AND	R1, R1, #254
UXTB	R1, R1
LSRS	R1, R1, #1
STRB	R1, [R2, #0]
;msd.c,313 :: 		MSD_cid->Reserved2 = 1;
ADDW	R2, R5, #19
; MSD_cid end address is: 20 (R5)
MOVS	R1, #1
STRB	R1, [R2, #0]
;msd.c,316 :: 		return rvalue;
;msd.c,317 :: 		}
L_end_MSD_GetCIDRegister:
LDR	LR, [SP, #0]
ADD	SP, SP, #32
BX	LR
; end of _MSD_GetCIDRegister
_MSD_SendCmd:
;msd.c,328 :: 		void MSD_SendCmd(u8 Cmd, u32 Arg, u8 Crc)
; Crc start address is: 8 (R2)
; Arg start address is: 4 (R1)
SUB	SP, SP, #16
STR	LR, [SP, #0]
; Crc end address is: 8 (R2)
; Arg end address is: 4 (R1)
; Arg start address is: 4 (R1)
; Crc start address is: 8 (R2)
;msd.c,329 :: 		{ u32 i=0; u8 Frame[6];
;msd.c,330 :: 		Frame[0] = (Cmd | 0x40);
ADD	R5, SP, #8
ORR	R3, R0, #64
STRB	R3, [R5, #0]
;msd.c,331 :: 		Frame[1] = (u8)(Arg >> 24);
ADDS	R4, R5, #1
LSRS	R3, R1, #24
UXTB	R3, R3
STRB	R3, [R4, #0]
;msd.c,332 :: 		Frame[2] = (u8)(Arg >> 16);
ADDS	R4, R5, #2
LSRS	R3, R1, #16
UXTB	R3, R3
STRB	R3, [R4, #0]
;msd.c,333 :: 		Frame[3] = (u8)(Arg >> 8);
ADDS	R4, R5, #3
LSRS	R3, R1, #8
UXTB	R3, R3
STRB	R3, [R4, #0]
;msd.c,334 :: 		Frame[4] = (u8)(Arg);
ADDS	R4, R5, #4
UXTB	R3, R1
; Arg end address is: 4 (R1)
STRB	R3, [R4, #0]
;msd.c,335 :: 		Frame[5] = (Crc);
ADDS	R3, R5, #5
STRB	R2, [R3, #0]
; Crc end address is: 8 (R2)
;msd.c,336 :: 		for (i=0; i<6; i++) MSD_WriteByte(Frame[i]);
MOVS	R0, #0
L_MSD_SendCmd53:
CMP	R0, #6
IT	CS
BCS	L_MSD_SendCmd54
ADD	R3, SP, #8
ADDS	R3, R3, R0
LDRB	R3, [R3, #0]
STR	R0, [SP, #4]
UXTB	R0, R3
BL	_MSD_WriteByte+0
LDR	R0, [SP, #4]
ADDS	R0, R0, #1
IT	AL
BAL	L_MSD_SendCmd53
L_MSD_SendCmd54:
;msd.c,337 :: 		}
L_end_MSD_SendCmd:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _MSD_SendCmd
_MSD_GetDataResponse:
;msd.c,349 :: 		u8 MSD_GetDataResponse(void)
SUB	SP, SP, #12
STR	LR, [SP, #0]
;msd.c,350 :: 		{ u32 i=0; u8 response, rvalue;
; i start address is: 4 (R1)
MOV	R1, #0
; i end address is: 4 (R1)
;msd.c,351 :: 		while (i<=64){
L_MSD_GetDataResponse56:
; i start address is: 4 (R1)
CMP	R1, #64
IT	HI
BHI	L_MSD_GetDataResponse57
;msd.c,352 :: 		response = MSD_ReadByte();//Read resonse
STR	R1, [SP, #4]
BL	_MSD_ReadByte+0
LDR	R1, [SP, #4]
;msd.c,353 :: 		response &= 0x1F;//Mask unused bits
AND	R0, R0, #31
STRB	R0, [SP, #8]
;msd.c,354 :: 		switch (response){
IT	AL
BAL	L_MSD_GetDataResponse58
;msd.c,355 :: 		case MSD_DATA_OK:
L_MSD_GetDataResponse60:
;msd.c,357 :: 		rvalue = MSD_DATA_OK;
MOVS	R0, #5
;msd.c,358 :: 		break;
; i end address is: 4 (R1)
IT	AL
BAL	L_MSD_GetDataResponse59
;msd.c,360 :: 		case MSD_DATA_CRC_ERROR:
L_MSD_GetDataResponse61:
;msd.c,361 :: 		return MSD_DATA_CRC_ERROR;
MOVS	R0, #11
IT	AL
BAL	L_end_MSD_GetDataResponse
;msd.c,362 :: 		case MSD_DATA_WRITE_ERROR:
L_MSD_GetDataResponse62:
;msd.c,363 :: 		return MSD_DATA_WRITE_ERROR;
MOVS	R0, #13
IT	AL
BAL	L_end_MSD_GetDataResponse
;msd.c,364 :: 		default:
L_MSD_GetDataResponse63:
;msd.c,366 :: 		rvalue = MSD_DATA_OTHER_ERROR;
; i start address is: 4 (R1)
MOVS	R0, #255
;msd.c,367 :: 		break;
IT	AL
BAL	L_MSD_GetDataResponse59
;msd.c,369 :: 		}
L_MSD_GetDataResponse58:
LDRB	R0, [SP, #8]
CMP	R0, #5
IT	EQ
BEQ	L_MSD_GetDataResponse60
LDRB	R0, [SP, #8]
CMP	R0, #11
IT	EQ
BEQ	L_MSD_GetDataResponse61
LDRB	R0, [SP, #8]
CMP	R0, #13
IT	EQ
BEQ	L_MSD_GetDataResponse62
IT	AL
BAL	L_MSD_GetDataResponse63
L_MSD_GetDataResponse59:
;msd.c,370 :: 		if (rvalue == MSD_DATA_OK)//Exit loop in case of data ok
CMP	R0, #5
IT	NE
BNE	L_MSD_GetDataResponse64
; i end address is: 4 (R1)
;msd.c,371 :: 		break;
IT	AL
BAL	L_MSD_GetDataResponse57
L_MSD_GetDataResponse64:
;msd.c,372 :: 		i++;//Increment loop counter
; i start address is: 4 (R1)
ADDS	R1, R1, #1
;msd.c,373 :: 		}
; i end address is: 4 (R1)
IT	AL
BAL	L_MSD_GetDataResponse56
L_MSD_GetDataResponse57:
;msd.c,374 :: 		while (MSD_ReadByte()==0);//Wait null data
L_MSD_GetDataResponse65:
BL	_MSD_ReadByte+0
CMP	R0, #0
IT	NE
BNE	L_MSD_GetDataResponse66
IT	AL
BAL	L_MSD_GetDataResponse65
L_MSD_GetDataResponse66:
;msd.c,375 :: 		return response;//Return response
LDRB	R0, [SP, #8]
;msd.c,376 :: 		}
L_end_MSD_GetDataResponse:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _MSD_GetDataResponse
_MSD_GetResponse:
;msd.c,385 :: 		u8 MSD_GetResponse(u8 Response)
; Count start address is: 12 (R3)
SUB	SP, SP, #12
STR	LR, [SP, #0]
;msd.c,386 :: 		{ u32 Count=0xFFF;
;msd.c,385 :: 		u8 MSD_GetResponse(u8 Response)
;msd.c,386 :: 		{ u32 Count=0xFFF;
;msd.c,385 :: 		u8 MSD_GetResponse(u8 Response)
STRB	R0, [SP, #8]
; Count end address is: 12 (R3)
;msd.c,386 :: 		{ u32 Count=0xFFF;
; Count start address is: 12 (R3)
MOVW	R3, #4095
MOVT	R3, #0
; Count end address is: 12 (R3)
MOV	R2, R3
;msd.c,387 :: 		while ((MSD_ReadByte()!=Response)&& Count) Count--;//Check if response is got or a timeout is happen
L_MSD_GetResponse67:
; Count start address is: 8 (R2)
STR	R2, [SP, #4]
BL	_MSD_ReadByte+0
LDR	R2, [SP, #4]
LDRB	R1, [SP, #8]
CMP	R0, R1
IT	EQ
BEQ	L__MSD_GetResponse83
CMP	R2, #0
IT	EQ
BEQ	L__MSD_GetResponse82
L__MSD_GetResponse81:
SUBS	R1, R2, #1
; Count end address is: 8 (R2)
; Count start address is: 12 (R3)
MOV	R3, R1
MOV	R2, R3
; Count end address is: 12 (R3)
IT	AL
BAL	L_MSD_GetResponse67
L__MSD_GetResponse83:
; Count start address is: 8 (R2)
L__MSD_GetResponse82:
;msd.c,388 :: 		if (Count==0) return MSD_RESPONSE_FAILURE;//After time out
CMP	R2, #0
IT	NE
BNE	L_MSD_GetResponse71
; Count end address is: 8 (R2)
MOVS	R0, #255
IT	AL
BAL	L_end_MSD_GetResponse
L_MSD_GetResponse71:
;msd.c,389 :: 		else return MSD_RESPONSE_NO_ERROR;//Right response got
MOVS	R0, #0
;msd.c,390 :: 		}
L_end_MSD_GetResponse:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _MSD_GetResponse
_MSD_GetStatus:
;msd.c,398 :: 		u16 MSD_GetStatus(void)
SUB	SP, SP, #8
STR	LR, [SP, #0]
;msd.c,400 :: 		u16 Status = 0;
;msd.c,403 :: 		MSD_CS_LOW();
MOVS	R1, #0
MOVW	R0, 1073810452
MOVT	R0, 16385
STR	R1, [R0, #0]
;msd.c,404 :: 		Delay_us(1);
MOVW	R7, #11
MOVT	R7, #0
NOP
NOP
L_MSD_GetStatus73:
SUBS	R7, R7, #1
BNE	L_MSD_GetStatus73
NOP
NOP
NOP
;msd.c,407 :: 		MSD_SendCmd(MSD_SEND_STATUS, 0, 0xFF);
MOVS	R2, #255
MOVS	R1, #0
MOVS	R0, #13
BL	_MSD_SendCmd+0
;msd.c,409 :: 		Status = MSD_ReadByte();
BL	_MSD_ReadByte+0
STRB	R0, [SP, #4]
;msd.c,410 :: 		Status |= (u16)(MSD_ReadByte() << 8);
BL	_MSD_ReadByte+0
LSLS	R0, R0, #8
UXTB	R1, R0
LDRB	R0, [SP, #4]
ORRS	R0, R1
STRB	R0, [SP, #4]
;msd.c,413 :: 		MSD_CS_HIGH();
MOVS	R1, #0
MOVW	R0, 1073810448
MOVT	R0, 16385
STR	R1, [R0, #0]
;msd.c,415 :: 		MSD_WriteByte(DUMMY);
MOVS	R0, #255
BL	_MSD_WriteByte+0
;msd.c,417 :: 		return Status;
LDRB	R0, [SP, #4]
;msd.c,418 :: 		}
L_end_MSD_GetStatus:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _MSD_GetStatus
_MSD_GoIdleState:
;msd.c,428 :: 		u8 MSD_GoIdleState(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;msd.c,431 :: 		MSD_CS_LOW();
MOVS	R1, #0
MOVW	R0, 1073810452
MOVT	R0, 16385
STR	R1, [R0, #0]
;msd.c,432 :: 		Delay_us(1);
MOVW	R7, #11
MOVT	R7, #0
NOP
NOP
L_MSD_GoIdleState75:
SUBS	R7, R7, #1
BNE	L_MSD_GoIdleState75
NOP
NOP
NOP
;msd.c,435 :: 		MSD_SendCmd(MSD_GO_IDLE_STATE, 0, 0x95);
MOVS	R2, #149
MOVS	R1, #0
MOVS	R0, #0
BL	_MSD_SendCmd+0
;msd.c,438 :: 		if (MSD_GetResponse(MSD_IN_IDLE_STATE))
MOVS	R0, #1
BL	_MSD_GetResponse+0
CMP	R0, #0
IT	EQ
BEQ	L_MSD_GoIdleState77
;msd.c,441 :: 		return MSD_RESPONSE_FAILURE;
MOVS	R0, #255
IT	AL
BAL	L_end_MSD_GoIdleState
;msd.c,442 :: 		}
L_MSD_GoIdleState77:
;msd.c,444 :: 		do
L_MSD_GoIdleState78:
;msd.c,447 :: 		MSD_CS_HIGH();
MOVS	R1, #0
MOVW	R0, 1073810448
MOVT	R0, 16385
STR	R1, [R0, #0]
;msd.c,449 :: 		MSD_WriteByte(DUMMY);
MOVS	R0, #255
BL	_MSD_WriteByte+0
;msd.c,452 :: 		MSD_CS_LOW();
MOVS	R1, #0
MOVW	R0, 1073810452
MOVT	R0, 16385
STR	R1, [R0, #0]
;msd.c,455 :: 		MSD_SendCmd(MSD_SEND_OP_COND, 0, 0xFF);
MOVS	R2, #255
MOVS	R1, #0
MOVS	R0, #1
BL	_MSD_SendCmd+0
;msd.c,458 :: 		while (MSD_GetResponse(MSD_RESPONSE_NO_ERROR));
MOVS	R0, #0
BL	_MSD_GetResponse+0
CMP	R0, #0
IT	NE
BNE	L_MSD_GoIdleState78
;msd.c,461 :: 		MSD_CS_HIGH();
MOVS	R1, #0
MOVW	R0, 1073810448
MOVT	R0, 16385
STR	R1, [R0, #0]
;msd.c,463 :: 		MSD_WriteByte(DUMMY);
MOVS	R0, #255
BL	_MSD_WriteByte+0
;msd.c,465 :: 		return MSD_RESPONSE_NO_ERROR;
MOVS	R0, #0
;msd.c,466 :: 		}
L_end_MSD_GoIdleState:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _MSD_GoIdleState
