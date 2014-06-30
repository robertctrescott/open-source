_FAT_Info:
;Files.c,17 :: 		char FAT_Info(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Files.c,19 :: 		char Rvalue = 0xFF;
;Files.c,20 :: 		DiskStart =0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_DiskStart+0)
MOVT	R0, #hi_addr(_DiskStart+0)
STRH	R1, [R0, #0]
;Files.c,21 :: 		Rvalue=MSD_ReadBlock(SectorBuff, 0, 512);
MOVS	R2, #0
MOVS	R1, #0
MOVW	R0, #lo_addr(_SectorBuff+0)
MOVT	R0, #hi_addr(_SectorBuff+0)
BL	_MSD_ReadBlock+0
; Rvalue start address is: 4 (R1)
UXTB	R1, R0
;Files.c,22 :: 		if(Rvalue!=0) return Rvalue;
CMP	R0, #0
IT	EQ
BEQ	L_FAT_Info0
UXTB	R0, R1
; Rvalue end address is: 4 (R1)
IT	AL
BAL	L_end_FAT_Info
L_FAT_Info0:
;Files.c,23 :: 		if((SectorBuff[0] != 0xEB)&&(SectorBuff[0] != 0xE9)){
MOVW	R0, #lo_addr(_SectorBuff+0)
MOVT	R0, #hi_addr(_SectorBuff+0)
LDRB	R0, [R0, #0]
CMP	R0, #235
IT	EQ
BEQ	L__FAT_Info30
MOVW	R0, #lo_addr(_SectorBuff+0)
MOVT	R0, #hi_addr(_SectorBuff+0)
LDRB	R0, [R0, #0]
CMP	R0, #233
IT	EQ
BEQ	L__FAT_Info29
L__FAT_Info28:
;Files.c,24 :: 		DiskStart =(SectorBuff[0x1C9]<<24)+(SectorBuff[0x1C8]<<16)+(SectorBuff[0x1C7]<<8)+(SectorBuff[0x1C6]);
MOVW	R0, #lo_addr(_SectorBuff+456)
MOVT	R0, #hi_addr(_SectorBuff+456)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #16
UXTH	R1, R1
MOVW	R0, #lo_addr(_SectorBuff+455)
MOVT	R0, #hi_addr(_SectorBuff+455)
LDRB	R0, [R0, #0]
LSLS	R0, R0, #8
UXTH	R0, R0
ADDS	R1, R1, R0
UXTH	R1, R1
MOVW	R0, #lo_addr(_SectorBuff+454)
MOVT	R0, #hi_addr(_SectorBuff+454)
LDRB	R0, [R0, #0]
ADDS	R1, R1, R0
UXTH	R1, R1
MOVW	R0, #lo_addr(_DiskStart+0)
MOVT	R0, #hi_addr(_DiskStart+0)
STRH	R1, [R0, #0]
;Files.c,25 :: 		Rvalue=MSD_ReadBlock(SectorBuff, DiskStart<<9, 512);
LSLS	R0, R1, #9
UXTH	R0, R0
MOVS	R2, #0
UXTH	R1, R0
MOVW	R0, #lo_addr(_SectorBuff+0)
MOVT	R0, #hi_addr(_SectorBuff+0)
BL	_MSD_ReadBlock+0
; Rvalue start address is: 4 (R1)
UXTB	R1, R0
;Files.c,26 :: 		if(Rvalue!=0) return Rvalue;
CMP	R0, #0
IT	EQ
BEQ	L_FAT_Info4
UXTB	R0, R1
; Rvalue end address is: 4 (R1)
IT	AL
BAL	L_end_FAT_Info
L_FAT_Info4:
;Files.c,23 :: 		if((SectorBuff[0] != 0xEB)&&(SectorBuff[0] != 0xE9)){
L__FAT_Info30:
L__FAT_Info29:
;Files.c,28 :: 		SecPerClus = SectorBuff[0x0D];
MOVW	R0, #lo_addr(_SectorBuff+13)
MOVT	R0, #hi_addr(_SectorBuff+13)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_SecPerClus+0)
MOVT	R0, #hi_addr(_SecPerClus+0)
STRB	R1, [R0, #0]
;Files.c,29 :: 		RsvdSecCnt =(SectorBuff[0x0F]<<8)+(SectorBuff[0x0E]);//0x0001
MOVW	R0, #lo_addr(_SectorBuff+15)
MOVT	R0, #hi_addr(_SectorBuff+15)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #8
UXTH	R1, R1
MOVW	R0, #lo_addr(_SectorBuff+14)
MOVT	R0, #hi_addr(_SectorBuff+14)
LDRB	R0, [R0, #0]
ADDS	R1, R1, R0
MOVW	R0, #lo_addr(_RsvdSecCnt+0)
MOVT	R0, #hi_addr(_RsvdSecCnt+0)
STRB	R1, [R0, #0]
;Files.c,30 :: 		FAT_Size16 =(SectorBuff[0x17]<<8)+(SectorBuff[0x16]);//0x001F
MOVW	R0, #lo_addr(_SectorBuff+23)
MOVT	R0, #hi_addr(_SectorBuff+23)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #8
UXTH	R1, R1
MOVW	R0, #lo_addr(_SectorBuff+22)
MOVT	R0, #hi_addr(_SectorBuff+22)
LDRB	R0, [R0, #0]
ADDS	R2, R1, R0
MOVW	R0, #lo_addr(_FAT_Size16+0)
MOVT	R0, #hi_addr(_FAT_Size16+0)
STRB	R2, [R0, #0]
;Files.c,31 :: 		Hidden_Sec =(SectorBuff[0x1F]<<24)+(SectorBuff[0x1E]<<16)+(SectorBuff[0x1D]<<8)+(SectorBuff[0x1C]);
MOVW	R0, #lo_addr(_SectorBuff+30)
MOVT	R0, #hi_addr(_SectorBuff+30)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #16
UXTH	R1, R1
MOVW	R0, #lo_addr(_SectorBuff+29)
MOVT	R0, #hi_addr(_SectorBuff+29)
LDRB	R0, [R0, #0]
LSLS	R0, R0, #8
UXTH	R0, R0
ADDS	R1, R1, R0
UXTH	R1, R1
MOVW	R0, #lo_addr(_SectorBuff+28)
MOVT	R0, #hi_addr(_SectorBuff+28)
LDRB	R0, [R0, #0]
ADDS	R1, R1, R0
MOVW	R0, #lo_addr(_Hidden_Sec+0)
MOVT	R0, #hi_addr(_Hidden_Sec+0)
STRH	R1, [R0, #0]
;Files.c,32 :: 		FAT_Size32 =(SectorBuff[0x25]<<8)+(SectorBuff[0x24]);
MOVW	R0, #lo_addr(_SectorBuff+37)
MOVT	R0, #hi_addr(_SectorBuff+37)
LDRB	R0, [R0, #0]
LSLS	R1, R0, #8
UXTH	R1, R1
MOVW	R0, #lo_addr(_SectorBuff+36)
MOVT	R0, #hi_addr(_SectorBuff+36)
LDRB	R0, [R0, #0]
ADDS	R1, R1, R0
MOVW	R0, #lo_addr(_FAT_Size32+0)
MOVT	R0, #hi_addr(_FAT_Size32+0)
STRB	R1, [R0, #0]
;Files.c,33 :: 		if(FAT_Size16==0)
UXTB	R0, R2
CMP	R0, #0
IT	NE
BNE	L_FAT_Info5
;Files.c,34 :: 		Root_Addr =(DiskStart + RsvdSecCnt + 2*FAT_Size32)*512;
MOVW	R0, #lo_addr(_RsvdSecCnt+0)
MOVT	R0, #hi_addr(_RsvdSecCnt+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_DiskStart+0)
MOVT	R0, #hi_addr(_DiskStart+0)
LDRH	R0, [R0, #0]
ADDS	R1, R0, R1
UXTH	R1, R1
MOVW	R0, #lo_addr(_FAT_Size32+0)
MOVT	R0, #hi_addr(_FAT_Size32+0)
LDRB	R0, [R0, #0]
LSLS	R0, R0, #1
SXTH	R0, R0
ADDS	R0, R1, R0
UXTH	R0, R0
LSLS	R1, R0, #9
MOVW	R0, #lo_addr(_Root_Addr+0)
MOVT	R0, #hi_addr(_Root_Addr+0)
STRH	R1, [R0, #0]
IT	AL
BAL	L_FAT_Info6
L_FAT_Info5:
;Files.c,36 :: 		Root_Addr =(DiskStart + RsvdSecCnt + 2*FAT_Size16)*512; //(61+1+1F+1F)*512=14000
MOVW	R0, #lo_addr(_RsvdSecCnt+0)
MOVT	R0, #hi_addr(_RsvdSecCnt+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_DiskStart+0)
MOVT	R0, #hi_addr(_DiskStart+0)
LDRH	R0, [R0, #0]
ADDS	R1, R0, R1
UXTH	R1, R1
MOVW	R0, #lo_addr(_FAT_Size16+0)
MOVT	R0, #hi_addr(_FAT_Size16+0)
LDRB	R0, [R0, #0]
LSLS	R0, R0, #1
SXTH	R0, R0
ADDS	R0, R1, R0
UXTH	R0, R0
LSLS	R1, R0, #9
MOVW	R0, #lo_addr(_Root_Addr+0)
MOVT	R0, #hi_addr(_Root_Addr+0)
STRH	R1, [R0, #0]
L_FAT_Info6:
;Files.c,37 :: 		return 0;
MOVS	R0, #0
;Files.c,38 :: 		}
L_end_FAT_Info:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _FAT_Info
_Open_File:
;Files.c,42 :: 		char Open_File(unsigned char *n)
SUB	SP, SP, #12
STR	LR, [SP, #0]
MOV	R3, R0
; n start address is: 12 (R3)
;Files.c,44 :: 		char Rvalue = 0xFF;
;Files.c,46 :: 		DirFliePtr =0;
MOVS	R2, #0
MOVW	R1, #lo_addr(_DirFliePtr+0)
MOVT	R1, #hi_addr(_DirFliePtr+0)
STRB	R2, [R1, #0]
;Files.c,47 :: 		DirFlieSec =0;
MOVS	R2, #0
MOVW	R1, #lo_addr(_DirFlieSec+0)
MOVT	R1, #hi_addr(_DirFlieSec+0)
STRB	R2, [R1, #0]
;Files.c,48 :: 		if(FAT_Size16==0)
MOVW	R1, #lo_addr(_FAT_Size16+0)
MOVT	R1, #hi_addr(_FAT_Size16+0)
LDRB	R1, [R1, #0]
CMP	R1, #0
IT	NE
BNE	L_Open_File7
;Files.c,49 :: 		DirSecNum =0;
MOVS	R2, #0
MOVW	R1, #lo_addr(_DirSecNum+0)
MOVT	R1, #hi_addr(_DirSecNum+0)
STRB	R2, [R1, #0]
IT	AL
BAL	L_Open_File8
L_Open_File7:
;Files.c,51 :: 		DirSecNum = 0x20;
MOVS	R2, #32
MOVW	R1, #lo_addr(_DirSecNum+0)
MOVT	R1, #hi_addr(_DirSecNum+0)
STRB	R2, [R1, #0]
L_Open_File8:
;Files.c,53 :: 		Rvalue=MSD_ReadBlock(SectorBuff, Root_Addr, 512);
MOVW	R1, #lo_addr(_Root_Addr+0)
MOVT	R1, #hi_addr(_Root_Addr+0)
LDRH	R1, [R1, #0]
STR	R3, [SP, #4]
MOVS	R2, #0
MOVW	R0, #lo_addr(_SectorBuff+0)
MOVT	R0, #hi_addr(_SectorBuff+0)
BL	_MSD_ReadBlock+0
LDR	R3, [SP, #4]
;Files.c,54 :: 		if(Rvalue!=0){
CMP	R0, #0
IT	EQ
BEQ	L_Open_File9
; n end address is: 12 (R3)
;Files.c,55 :: 		return 0xFF;
MOVS	R0, #255
IT	AL
BAL	L_end_Open_File
;Files.c,56 :: 		}
L_Open_File9:
;Files.c,57 :: 		for(SectorCnt=0;SectorCnt<DirSecNum;++SectorCnt){
; n start address is: 12 (R3)
MOVS	R0, #0
; n end address is: 12 (R3)
MOV	R4, R3
UXTB	R3, R0
L_Open_File10:
; SectorCnt start address is: 12 (R3)
; n start address is: 16 (R4)
MOVW	R1, #lo_addr(_DirSecNum+0)
MOVT	R1, #hi_addr(_DirSecNum+0)
LDRB	R1, [R1, #0]
CMP	R3, R1
IT	CS
BCS	L_Open_File11
;Files.c,58 :: 		Rvalue=MSD_ReadBlock(SectorBuff, Root_Addr + SectorCnt*512, 512);
LSLS	R2, R3, #9
SXTH	R2, R2
MOVW	R1, #lo_addr(_Root_Addr+0)
MOVT	R1, #hi_addr(_Root_Addr+0)
LDRH	R1, [R1, #0]
ADDS	R1, R1, R2
UXTH	R1, R1
STR	R4, [SP, #4]
STRB	R3, [SP, #8]
MOVS	R2, #0
MOVW	R0, #lo_addr(_SectorBuff+0)
MOVT	R0, #hi_addr(_SectorBuff+0)
BL	_MSD_ReadBlock+0
LDRB	R3, [SP, #8]
LDR	R4, [SP, #4]
; Rvalue start address is: 4 (R1)
UXTB	R1, R0
;Files.c,59 :: 		if(Rvalue!=0){
CMP	R0, #0
IT	EQ
BEQ	L_Open_File13
; n end address is: 16 (R4)
; SectorCnt end address is: 12 (R3)
;Files.c,60 :: 		return Rvalue;
UXTB	R0, R1
; Rvalue end address is: 4 (R1)
IT	AL
BAL	L_end_Open_File
;Files.c,61 :: 		}
L_Open_File13:
;Files.c,62 :: 		for(i=0; i<512; i+=32){
; SectorCnt start address is: 12 (R3)
; n start address is: 16 (R4)
MOVS	R0, #0
; n end address is: 16 (R4)
; SectorCnt end address is: 12 (R3)
L_Open_File14:
; n start address is: 16 (R4)
; SectorCnt start address is: 12 (R3)
CMP	R0, #512
IT	GE
BGE	L_Open_File15
;Files.c,63 :: 		if((SectorBuff[i]=='F')&&(SectorBuff[i+1]=='I')&&(SectorBuff[i+2]=='L')&&(SectorBuff[i+3]=='E')){
MOVW	R1, #lo_addr(_SectorBuff+0)
MOVT	R1, #hi_addr(_SectorBuff+0)
ADDS	R1, R1, R0
LDRB	R1, [R1, #0]
CMP	R1, #70
IT	NE
BNE	L__Open_File43
ADDS	R2, R0, #1
SXTH	R2, R2
MOVW	R1, #lo_addr(_SectorBuff+0)
MOVT	R1, #hi_addr(_SectorBuff+0)
ADDS	R1, R1, R2
LDRB	R1, [R1, #0]
CMP	R1, #73
IT	NE
BNE	L__Open_File42
ADDS	R2, R0, #2
SXTH	R2, R2
MOVW	R1, #lo_addr(_SectorBuff+0)
MOVT	R1, #hi_addr(_SectorBuff+0)
ADDS	R1, R1, R2
LDRB	R1, [R1, #0]
CMP	R1, #76
IT	NE
BNE	L__Open_File41
ADDS	R2, R0, #3
SXTH	R2, R2
MOVW	R1, #lo_addr(_SectorBuff+0)
MOVT	R1, #hi_addr(_SectorBuff+0)
ADDS	R1, R1, R2
LDRB	R1, [R1, #0]
CMP	R1, #69
IT	NE
BNE	L__Open_File40
L__Open_File33:
;Files.c,64 :: 		if((SectorBuff[i+8]=='D')&&(SectorBuff[i+9]=='A')&&(SectorBuff[i+10]=='T')){
ADDW	R2, R0, #8
SXTH	R2, R2
MOVW	R1, #lo_addr(_SectorBuff+0)
MOVT	R1, #hi_addr(_SectorBuff+0)
ADDS	R1, R1, R2
LDRB	R1, [R1, #0]
CMP	R1, #68
IT	NE
BNE	L__Open_File39
ADDW	R2, R0, #9
SXTH	R2, R2
MOVW	R1, #lo_addr(_SectorBuff+0)
MOVT	R1, #hi_addr(_SectorBuff+0)
ADDS	R1, R1, R2
LDRB	R1, [R1, #0]
CMP	R1, #65
IT	NE
BNE	L__Open_File38
ADDW	R2, R0, #10
SXTH	R2, R2
MOVW	R1, #lo_addr(_SectorBuff+0)
MOVT	R1, #hi_addr(_SectorBuff+0)
ADDS	R1, R1, R2
LDRB	R1, [R1, #0]
CMP	R1, #84
IT	NE
BNE	L__Open_File37
L__Open_File32:
;Files.c,65 :: 		if((SectorBuff[i+4]==*n)&&(SectorBuff[i+5]==*(n+1))&&(SectorBuff[i+6]==*(n+2))){
ADDS	R2, R0, #4
SXTH	R2, R2
MOVW	R1, #lo_addr(_SectorBuff+0)
MOVT	R1, #hi_addr(_SectorBuff+0)
ADDS	R1, R1, R2
LDRB	R2, [R1, #0]
LDRB	R1, [R4, #0]
CMP	R2, R1
IT	NE
BNE	L__Open_File36
ADDS	R2, R0, #5
SXTH	R2, R2
MOVW	R1, #lo_addr(_SectorBuff+0)
MOVT	R1, #hi_addr(_SectorBuff+0)
ADDS	R1, R1, R2
LDRB	R2, [R1, #0]
ADDS	R1, R4, #1
LDRB	R1, [R1, #0]
CMP	R2, R1
IT	NE
BNE	L__Open_File35
ADDS	R2, R0, #6
SXTH	R2, R2
MOVW	R1, #lo_addr(_SectorBuff+0)
MOVT	R1, #hi_addr(_SectorBuff+0)
ADDS	R1, R1, R2
LDRB	R2, [R1, #0]
ADDS	R1, R4, #2
LDRB	R1, [R1, #0]
CMP	R2, R1
IT	NE
BNE	L__Open_File34
; n end address is: 16 (R4)
L__Open_File31:
;Files.c,66 :: 		DirFliePtr = i;
MOVW	R1, #lo_addr(_DirFliePtr+0)
MOVT	R1, #hi_addr(_DirFliePtr+0)
STRB	R0, [R1, #0]
;Files.c,67 :: 		DirFlieSec = SectorCnt;
MOVW	R1, #lo_addr(_DirFlieSec+0)
MOVT	R1, #hi_addr(_DirFlieSec+0)
STRB	R3, [R1, #0]
; SectorCnt end address is: 12 (R3)
;Files.c,68 :: 		if(FAT_Size16 ==0) SectorBuff[i+0x15]=SectorBuff[i+0x14]=0;
MOVW	R1, #lo_addr(_FAT_Size16+0)
MOVT	R1, #hi_addr(_FAT_Size16+0)
LDRB	R1, [R1, #0]
CMP	R1, #0
IT	NE
BNE	L_Open_File26
ADDW	R2, R0, #21
SXTH	R2, R2
MOVW	R1, #lo_addr(_SectorBuff+0)
MOVT	R1, #hi_addr(_SectorBuff+0)
ADDS	R3, R1, R2
ADDW	R2, R0, #20
SXTH	R2, R2
MOVW	R1, #lo_addr(_SectorBuff+0)
MOVT	R1, #hi_addr(_SectorBuff+0)
ADDS	R2, R1, R2
MOVS	R1, #0
STRB	R1, [R2, #0]
LDRB	R1, [R2, #0]
STRB	R1, [R3, #0]
L_Open_File26:
;Files.c,69 :: 		ClusterNum =((SectorBuff[i+0x15]<<24)+(SectorBuff[i+0x14]<<16)+(SectorBuff[i+0x1B]<<8)+(SectorBuff[i+0x1A]));
ADDW	R2, R0, #20
SXTH	R2, R2
MOVW	R1, #lo_addr(_SectorBuff+0)
MOVT	R1, #hi_addr(_SectorBuff+0)
ADDS	R1, R1, R2
LDRB	R1, [R1, #0]
LSLS	R3, R1, #16
UXTH	R3, R3
ADDW	R2, R0, #27
SXTH	R2, R2
MOVW	R1, #lo_addr(_SectorBuff+0)
MOVT	R1, #hi_addr(_SectorBuff+0)
ADDS	R1, R1, R2
LDRB	R1, [R1, #0]
LSLS	R1, R1, #8
UXTH	R1, R1
ADDS	R3, R3, R1
UXTH	R3, R3
ADDW	R2, R0, #26
SXTH	R2, R2
MOVW	R1, #lo_addr(_SectorBuff+0)
MOVT	R1, #hi_addr(_SectorBuff+0)
ADDS	R1, R1, R2
LDRB	R1, [R1, #0]
ADDS	R2, R3, R1
UXTH	R2, R2
MOVW	R1, #lo_addr(_ClusterNum+0)
MOVT	R1, #hi_addr(_ClusterNum+0)
STRH	R2, [R1, #0]
;Files.c,70 :: 		File_Addr = Root_Addr +(DirSecNum +(ClusterNum -2)*SecPerClus)*512;
SUBS	R2, R2, #2
UXTH	R2, R2
MOVW	R1, #lo_addr(_SecPerClus+0)
MOVT	R1, #hi_addr(_SecPerClus+0)
LDRB	R1, [R1, #0]
MULS	R2, R1, R2
UXTH	R2, R2
MOVW	R1, #lo_addr(_DirSecNum+0)
MOVT	R1, #hi_addr(_DirSecNum+0)
LDRB	R1, [R1, #0]
ADDS	R1, R1, R2
UXTH	R1, R1
LSLS	R2, R1, #9
UXTH	R2, R2
MOVW	R1, #lo_addr(_Root_Addr+0)
MOVT	R1, #hi_addr(_Root_Addr+0)
LDRH	R1, [R1, #0]
ADDS	R2, R1, R2
MOVW	R1, #lo_addr(_File_Addr+0)
MOVT	R1, #hi_addr(_File_Addr+0)
STRH	R2, [R1, #0]
;Files.c,71 :: 		return 0;
MOVS	R0, #0
IT	AL
BAL	L_end_Open_File
;Files.c,65 :: 		if((SectorBuff[i+4]==*n)&&(SectorBuff[i+5]==*(n+1))&&(SectorBuff[i+6]==*(n+2))){
L__Open_File36:
; SectorCnt start address is: 12 (R3)
; n start address is: 16 (R4)
L__Open_File35:
L__Open_File34:
;Files.c,64 :: 		if((SectorBuff[i+8]=='D')&&(SectorBuff[i+9]=='A')&&(SectorBuff[i+10]=='T')){
L__Open_File39:
L__Open_File38:
L__Open_File37:
;Files.c,63 :: 		if((SectorBuff[i]=='F')&&(SectorBuff[i+1]=='I')&&(SectorBuff[i+2]=='L')&&(SectorBuff[i+3]=='E')){
L__Open_File43:
L__Open_File42:
L__Open_File41:
L__Open_File40:
;Files.c,62 :: 		for(i=0; i<512; i+=32){
ADDW	R1, R0, #32
UXTB	R0, R1
;Files.c,75 :: 		}
IT	AL
BAL	L_Open_File14
L_Open_File15:
;Files.c,57 :: 		for(SectorCnt=0;SectorCnt<DirSecNum;++SectorCnt){
ADDS	R3, R3, #1
UXTB	R3, R3
;Files.c,76 :: 		}
; n end address is: 16 (R4)
; SectorCnt end address is: 12 (R3)
IT	AL
BAL	L_Open_File10
L_Open_File11:
;Files.c,77 :: 		return 0xFF;
MOVS	R0, #255
;Files.c,78 :: 		}
L_end_Open_File:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _Open_File
_Read_File:
;Files.c,82 :: 		char Read_File(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Files.c,84 :: 		return MSD_ReadBlock(SectorBuff, File_Addr, 512);
MOVW	R0, #lo_addr(_File_Addr+0)
MOVT	R0, #hi_addr(_File_Addr+0)
LDRH	R0, [R0, #0]
MOVS	R2, #0
MOV	R1, R0
MOVW	R0, #lo_addr(_SectorBuff+0)
MOVT	R0, #hi_addr(_SectorBuff+0)
BL	_MSD_ReadBlock+0
;Files.c,85 :: 		}
L_end_Read_File:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Read_File
_Write_File:
;Files.c,89 :: 		char Write_File(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Files.c,91 :: 		char Rvalue = 0xFF;
;Files.c,92 :: 		Rvalue = MSD_WriteBlock(SectorBuff, File_Addr, 512);
MOVW	R0, #lo_addr(_File_Addr+0)
MOVT	R0, #hi_addr(_File_Addr+0)
LDRH	R0, [R0, #0]
MOVS	R2, #0
MOV	R1, R0
MOVW	R0, #lo_addr(_SectorBuff+0)
MOVT	R0, #hi_addr(_SectorBuff+0)
BL	_MSD_WriteBlock+0
; Rvalue start address is: 4 (R1)
UXTB	R1, R0
;Files.c,93 :: 		if(Rvalue!=0) return Rvalue;
CMP	R0, #0
IT	EQ
BEQ	L_Write_File27
UXTB	R0, R1
; Rvalue end address is: 4 (R1)
IT	AL
BAL	L_end_Write_File
L_Write_File27:
;Files.c,94 :: 		return Rvalue;
; Rvalue start address is: 4 (R1)
UXTB	R0, R1
; Rvalue end address is: 4 (R1)
;Files.c,95 :: 		}
L_end_Write_File:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Write_File
