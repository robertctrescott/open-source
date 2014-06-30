_SCSI_Inquiry_Cmd:
;usb_scsi.c,47 :: 		void SCSI_Inquiry_Cmd(void)
SUB	SP, SP, #8
STR	LR, [SP, #0]
;usb_scsi.c,52 :: 		if (CBW.CB[1] & 0x01)/*Evpd is set*/
MOVW	R0, #lo_addr(_CBW+16)
MOVT	R0, #hi_addr(_CBW+16)
LDRB	R0, [R0, #0]
AND	R0, R0, #1
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_SCSI_Inquiry_Cmd0
;usb_scsi.c,54 :: 		Inquiry_Data = Page00_Inquiry_Data;
MOVW	R0, #lo_addr(_Page00_Inquiry_Data+0)
MOVT	R0, #hi_addr(_Page00_Inquiry_Data+0)
;usb_scsi.c,55 :: 		Inquiry_Data_Length = 5;
; Inquiry_Data_Length start address is: 4 (R1)
MOVS	R1, #5
;usb_scsi.c,56 :: 		}
STRB	R1, [SP, #4]
; Inquiry_Data_Length end address is: 4 (R1)
MOV	R1, R0
LDRB	R0, [SP, #4]
IT	AL
BAL	L_SCSI_Inquiry_Cmd1
L_SCSI_Inquiry_Cmd0:
;usb_scsi.c,59 :: 		Inquiry_Data = Standard_Inquiry_Data;
; Inquiry_Data start address is: 4 (R1)
MOVW	R1, #lo_addr(_Standard_Inquiry_Data+0)
MOVT	R1, #hi_addr(_Standard_Inquiry_Data+0)
;usb_scsi.c,60 :: 		if (CBW.CB[4] <= STANDARD_INQUIRY_DATA_LEN)
MOVW	R0, #lo_addr(_CBW+19)
MOVT	R0, #hi_addr(_CBW+19)
LDRB	R0, [R0, #0]
CMP	R0, #36
IT	HI
BHI	L_SCSI_Inquiry_Cmd2
;usb_scsi.c,61 :: 		Inquiry_Data_Length = CBW.CB[4];
MOVW	R0, #lo_addr(_CBW+19)
MOVT	R0, #hi_addr(_CBW+19)
LDRB	R0, [R0, #0]
IT	AL
BAL	L_SCSI_Inquiry_Cmd3
L_SCSI_Inquiry_Cmd2:
;usb_scsi.c,63 :: 		Inquiry_Data_Length = STANDARD_INQUIRY_DATA_LEN;
MOVS	R0, #36
L_SCSI_Inquiry_Cmd3:
;usb_scsi.c,64 :: 		}
; Inquiry_Data end address is: 4 (R1)
L_SCSI_Inquiry_Cmd1:
;usb_scsi.c,65 :: 		Transfer_Data_Request(Inquiry_Data, Inquiry_Data_Length);
; Inquiry_Data start address is: 4 (R1)
STR	R1, [SP, #4]
UXTB	R1, R0
LDR	R0, [SP, #4]
; Inquiry_Data end address is: 4 (R1)
BL	_Transfer_Data_Request+0
;usb_scsi.c,66 :: 		}
L_end_SCSI_Inquiry_Cmd:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _SCSI_Inquiry_Cmd
_SCSI_ReadFormatCapacity_Cmd:
;usb_scsi.c,75 :: 		void SCSI_ReadFormatCapacity_Cmd(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;usb_scsi.c,77 :: 		ReadFormatCapacity_Data[4] = (u8)(Mass_Block_Count >> 24);
MOVW	R2, #lo_addr(_Mass_Block_Count+0)
MOVT	R2, #hi_addr(_Mass_Block_Count+0)
LDR	R0, [R2, #0]
LSRS	R0, R0, #24
UXTB	R1, R0
MOVW	R0, #lo_addr(_ReadFormatCapacity_Data+4)
MOVT	R0, #hi_addr(_ReadFormatCapacity_Data+4)
STRB	R1, [R0, #0]
;usb_scsi.c,78 :: 		ReadFormatCapacity_Data[5] = (u8)(Mass_Block_Count >> 16);
MOV	R0, R2
LDR	R0, [R0, #0]
LSRS	R0, R0, #16
UXTB	R1, R0
MOVW	R0, #lo_addr(_ReadFormatCapacity_Data+5)
MOVT	R0, #hi_addr(_ReadFormatCapacity_Data+5)
STRB	R1, [R0, #0]
;usb_scsi.c,79 :: 		ReadFormatCapacity_Data[6] = (u8)(Mass_Block_Count >>  8);
MOV	R0, R2
LDR	R0, [R0, #0]
LSRS	R0, R0, #8
UXTB	R1, R0
MOVW	R0, #lo_addr(_ReadFormatCapacity_Data+6)
MOVT	R0, #hi_addr(_ReadFormatCapacity_Data+6)
STRB	R1, [R0, #0]
;usb_scsi.c,80 :: 		ReadFormatCapacity_Data[7] = (u8)(Mass_Block_Count);
MOV	R0, R2
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_ReadFormatCapacity_Data+7)
MOVT	R0, #hi_addr(_ReadFormatCapacity_Data+7)
STRB	R1, [R0, #0]
;usb_scsi.c,82 :: 		ReadFormatCapacity_Data[9] = (u8)(Mass_Block_Size >>  16);
MOVW	R2, #lo_addr(_Mass_Block_Size+0)
MOVT	R2, #hi_addr(_Mass_Block_Size+0)
LDR	R0, [R2, #0]
LSRS	R0, R0, #16
UXTB	R1, R0
MOVW	R0, #lo_addr(_ReadFormatCapacity_Data+9)
MOVT	R0, #hi_addr(_ReadFormatCapacity_Data+9)
STRB	R1, [R0, #0]
;usb_scsi.c,83 :: 		ReadFormatCapacity_Data[10] = (u8)(Mass_Block_Size >>  8);
MOV	R0, R2
LDR	R0, [R0, #0]
LSRS	R0, R0, #8
UXTB	R1, R0
MOVW	R0, #lo_addr(_ReadFormatCapacity_Data+10)
MOVT	R0, #hi_addr(_ReadFormatCapacity_Data+10)
STRB	R1, [R0, #0]
;usb_scsi.c,84 :: 		ReadFormatCapacity_Data[11] = (u8)(Mass_Block_Size);
MOV	R0, R2
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_ReadFormatCapacity_Data+11)
MOVT	R0, #hi_addr(_ReadFormatCapacity_Data+11)
STRB	R1, [R0, #0]
;usb_scsi.c,85 :: 		Transfer_Data_Request(ReadFormatCapacity_Data, READ_FORMAT_CAPACITY_DATA_LEN);
MOVS	R1, #12
MOVW	R0, #lo_addr(_ReadFormatCapacity_Data+0)
MOVT	R0, #hi_addr(_ReadFormatCapacity_Data+0)
BL	_Transfer_Data_Request+0
;usb_scsi.c,86 :: 		}
L_end_SCSI_ReadFormatCapacity_Cmd:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _SCSI_ReadFormatCapacity_Cmd
_SCSI_ReadCapacity10_Cmd:
;usb_scsi.c,95 :: 		void SCSI_ReadCapacity10_Cmd(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;usb_scsi.c,97 :: 		ReadCapacity10_Data[0] = (u8)(Mass_Block_Count - 1 >> 24);
MOVW	R0, #lo_addr(_Mass_Block_Count+0)
MOVT	R0, #hi_addr(_Mass_Block_Count+0)
LDR	R0, [R0, #0]
SUBS	R2, R0, #1
LSRS	R0, R2, #24
UXTB	R1, R0
MOVW	R0, #lo_addr(_ReadCapacity10_Data+0)
MOVT	R0, #hi_addr(_ReadCapacity10_Data+0)
STRB	R1, [R0, #0]
;usb_scsi.c,98 :: 		ReadCapacity10_Data[1] = (u8)(Mass_Block_Count - 1 >> 16);
LSRS	R0, R2, #16
UXTB	R1, R0
MOVW	R0, #lo_addr(_ReadCapacity10_Data+1)
MOVT	R0, #hi_addr(_ReadCapacity10_Data+1)
STRB	R1, [R0, #0]
;usb_scsi.c,99 :: 		ReadCapacity10_Data[2] = (u8)(Mass_Block_Count - 1 >>  8);
LSRS	R0, R2, #8
UXTB	R1, R0
MOVW	R0, #lo_addr(_ReadCapacity10_Data+2)
MOVT	R0, #hi_addr(_ReadCapacity10_Data+2)
STRB	R1, [R0, #0]
;usb_scsi.c,100 :: 		ReadCapacity10_Data[3] = (u8)(Mass_Block_Count - 1);
UXTB	R1, R2
MOVW	R0, #lo_addr(_ReadCapacity10_Data+3)
MOVT	R0, #hi_addr(_ReadCapacity10_Data+3)
STRB	R1, [R0, #0]
;usb_scsi.c,102 :: 		ReadCapacity10_Data[4] = (u8)(Mass_Block_Size >>  24);
MOVW	R2, #lo_addr(_Mass_Block_Size+0)
MOVT	R2, #hi_addr(_Mass_Block_Size+0)
LDR	R0, [R2, #0]
LSRS	R0, R0, #24
UXTB	R1, R0
MOVW	R0, #lo_addr(_ReadCapacity10_Data+4)
MOVT	R0, #hi_addr(_ReadCapacity10_Data+4)
STRB	R1, [R0, #0]
;usb_scsi.c,103 :: 		ReadCapacity10_Data[5] = (u8)(Mass_Block_Size >>  16);
MOV	R0, R2
LDR	R0, [R0, #0]
LSRS	R0, R0, #16
UXTB	R1, R0
MOVW	R0, #lo_addr(_ReadCapacity10_Data+5)
MOVT	R0, #hi_addr(_ReadCapacity10_Data+5)
STRB	R1, [R0, #0]
;usb_scsi.c,104 :: 		ReadCapacity10_Data[6] = (u8)(Mass_Block_Size >>  8);
MOV	R0, R2
LDR	R0, [R0, #0]
LSRS	R0, R0, #8
UXTB	R1, R0
MOVW	R0, #lo_addr(_ReadCapacity10_Data+6)
MOVT	R0, #hi_addr(_ReadCapacity10_Data+6)
STRB	R1, [R0, #0]
;usb_scsi.c,105 :: 		ReadCapacity10_Data[7] = (u8)(Mass_Block_Size);
MOV	R0, R2
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_ReadCapacity10_Data+7)
MOVT	R0, #hi_addr(_ReadCapacity10_Data+7)
STRB	R1, [R0, #0]
;usb_scsi.c,106 :: 		Transfer_Data_Request(ReadCapacity10_Data, READ_CAPACITY10_DATA_LEN);
MOVS	R1, #8
MOVW	R0, #lo_addr(_ReadCapacity10_Data+0)
MOVT	R0, #hi_addr(_ReadCapacity10_Data+0)
BL	_Transfer_Data_Request+0
;usb_scsi.c,107 :: 		}
L_end_SCSI_ReadCapacity10_Cmd:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _SCSI_ReadCapacity10_Cmd
_SCSI_ModeSense6_Cmd:
;usb_scsi.c,116 :: 		void SCSI_ModeSense6_Cmd (void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;usb_scsi.c,118 :: 		Transfer_Data_Request(Mode_Sense6_data, MODE_SENSE6_DATA_LEN);
MOVS	R1, #4
MOVW	R0, #lo_addr(_Mode_Sense6_data+0)
MOVT	R0, #hi_addr(_Mode_Sense6_data+0)
BL	_Transfer_Data_Request+0
;usb_scsi.c,119 :: 		}
L_end_SCSI_ModeSense6_Cmd:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _SCSI_ModeSense6_Cmd
_SCSI_ModeSense10_Cmd:
;usb_scsi.c,128 :: 		void SCSI_ModeSense10_Cmd (void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;usb_scsi.c,130 :: 		Transfer_Data_Request(Mode_Sense10_data, MODE_SENSE10_DATA_LEN);
MOVS	R1, #8
MOVW	R0, #lo_addr(_Mode_Sense10_data+0)
MOVT	R0, #hi_addr(_Mode_Sense10_data+0)
BL	_Transfer_Data_Request+0
;usb_scsi.c,131 :: 		}
L_end_SCSI_ModeSense10_Cmd:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _SCSI_ModeSense10_Cmd
_SCSI_RequestSense_Cmd:
;usb_scsi.c,140 :: 		void SCSI_RequestSense_Cmd (void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;usb_scsi.c,144 :: 		if (CBW.CB[4] <= REQUEST_SENSE_DATA_LEN)
MOVW	R0, #lo_addr(_CBW+19)
MOVT	R0, #hi_addr(_CBW+19)
LDRB	R0, [R0, #0]
CMP	R0, #18
IT	HI
BHI	L_SCSI_RequestSense_Cmd4
;usb_scsi.c,146 :: 		Request_Sense_data_Length = CBW.CB[4];
MOVW	R0, #lo_addr(_CBW+19)
MOVT	R0, #hi_addr(_CBW+19)
LDRB	R0, [R0, #0]
;usb_scsi.c,147 :: 		}
IT	AL
BAL	L_SCSI_RequestSense_Cmd5
L_SCSI_RequestSense_Cmd4:
;usb_scsi.c,150 :: 		Request_Sense_data_Length = REQUEST_SENSE_DATA_LEN;
MOVS	R0, #18
;usb_scsi.c,151 :: 		}
L_SCSI_RequestSense_Cmd5:
;usb_scsi.c,152 :: 		Transfer_Data_Request(Scsi_Sense_Data, Request_Sense_data_Length);
UXTB	R1, R0
MOVW	R0, #lo_addr(_Scsi_Sense_Data+0)
MOVT	R0, #hi_addr(_Scsi_Sense_Data+0)
BL	_Transfer_Data_Request+0
;usb_scsi.c,153 :: 		}
L_end_SCSI_RequestSense_Cmd:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _SCSI_RequestSense_Cmd
_Set_Scsi_Sense_Data:
;usb_scsi.c,163 :: 		void Set_Scsi_Sense_Data(u8 Sens_Key, u8 Asc)
; Asc start address is: 4 (R1)
SUB	SP, SP, #4
; Asc end address is: 4 (R1)
; Asc start address is: 4 (R1)
;usb_scsi.c,165 :: 		Scsi_Sense_Data[2] = Sens_Key;
MOVW	R2, #lo_addr(_Scsi_Sense_Data+2)
MOVT	R2, #hi_addr(_Scsi_Sense_Data+2)
STRB	R0, [R2, #0]
;usb_scsi.c,166 :: 		Scsi_Sense_Data[12] = Asc;
MOVW	R2, #lo_addr(_Scsi_Sense_Data+12)
MOVT	R2, #hi_addr(_Scsi_Sense_Data+12)
STRB	R1, [R2, #0]
; Asc end address is: 4 (R1)
;usb_scsi.c,167 :: 		}
L_end_Set_Scsi_Sense_Data:
ADD	SP, SP, #4
BX	LR
; end of _Set_Scsi_Sense_Data
_SCSI_Start_Stop_Unit_Cmd:
;usb_scsi.c,176 :: 		void SCSI_Start_Stop_Unit_Cmd(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;usb_scsi.c,178 :: 		Set_CSW (CSW_CMD_PASSED, SEND_CSW_ENABLE);
MOVS	R1, #1
MOVS	R0, #0
BL	_Set_CSW+0
;usb_scsi.c,179 :: 		}
L_end_SCSI_Start_Stop_Unit_Cmd:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _SCSI_Start_Stop_Unit_Cmd
_SCSI_Read10_Cmd:
;usb_scsi.c,188 :: 		void SCSI_Read10_Cmd(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;usb_scsi.c,191 :: 		if (Bot_State == BOT_IDLE)
MOVW	R0, #lo_addr(_Bot_State+0)
MOVT	R0, #hi_addr(_Bot_State+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_SCSI_Read10_Cmd6
;usb_scsi.c,193 :: 		if (!(Address_Management_Test(SCSI_READ10)))/*address out of range*/
MOVS	R0, #40
BL	_Address_Management_Test+0
CMP	R0, #0
IT	NE
BNE	L_SCSI_Read10_Cmd7
;usb_scsi.c,195 :: 		return;
IT	AL
BAL	L_end_SCSI_Read10_Cmd
;usb_scsi.c,196 :: 		}
L_SCSI_Read10_Cmd7:
;usb_scsi.c,198 :: 		if ((CBW.bmFlags & 0x80) != 0)
MOVW	R0, #lo_addr(_CBW+12)
MOVT	R0, #hi_addr(_CBW+12)
LDRB	R0, [R0, #0]
AND	R0, R0, #128
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_SCSI_Read10_Cmd8
;usb_scsi.c,200 :: 		Bot_State = BOT_DATA_IN;
MOVS	R1, #2
MOVW	R0, #lo_addr(_Bot_State+0)
MOVT	R0, #hi_addr(_Bot_State+0)
STRB	R1, [R0, #0]
;usb_scsi.c,201 :: 		Read_Memory();
BL	_Read_Memory+0
;usb_scsi.c,202 :: 		}
IT	AL
BAL	L_SCSI_Read10_Cmd9
L_SCSI_Read10_Cmd8:
;usb_scsi.c,205 :: 		Bot_Abort(BOTH_DIR);
MOVS	R0, #2
BL	_Bot_Abort+0
;usb_scsi.c,206 :: 		Set_Scsi_Sense_Data(ILLEGAL_REQUEST, INVALID_FIELED_IN_COMMAND);
MOVS	R1, #36
MOVS	R0, #5
BL	_Set_Scsi_Sense_Data+0
;usb_scsi.c,207 :: 		Set_CSW (CSW_CMD_FAILED, SEND_CSW_ENABLE);
MOVS	R1, #1
MOVS	R0, #1
BL	_Set_CSW+0
;usb_scsi.c,208 :: 		}
L_SCSI_Read10_Cmd9:
;usb_scsi.c,209 :: 		return;
IT	AL
BAL	L_end_SCSI_Read10_Cmd
;usb_scsi.c,210 :: 		}
L_SCSI_Read10_Cmd6:
;usb_scsi.c,211 :: 		else if (Bot_State == BOT_DATA_IN)
MOVW	R0, #lo_addr(_Bot_State+0)
MOVT	R0, #hi_addr(_Bot_State+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_SCSI_Read10_Cmd11
;usb_scsi.c,213 :: 		Read_Memory();
BL	_Read_Memory+0
;usb_scsi.c,214 :: 		}
L_SCSI_Read10_Cmd11:
;usb_scsi.c,215 :: 		}
L_end_SCSI_Read10_Cmd:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _SCSI_Read10_Cmd
_SCSI_Write10_Cmd:
;usb_scsi.c,224 :: 		void SCSI_Write10_Cmd(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;usb_scsi.c,227 :: 		if (Bot_State == BOT_IDLE)
MOVW	R0, #lo_addr(_Bot_State+0)
MOVT	R0, #hi_addr(_Bot_State+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_SCSI_Write10_Cmd12
;usb_scsi.c,229 :: 		if (!(Address_Management_Test(SCSI_WRITE10)))/*address out of range*/
MOVS	R0, #42
BL	_Address_Management_Test+0
CMP	R0, #0
IT	NE
BNE	L_SCSI_Write10_Cmd13
;usb_scsi.c,231 :: 		return;
IT	AL
BAL	L_end_SCSI_Write10_Cmd
;usb_scsi.c,232 :: 		}
L_SCSI_Write10_Cmd13:
;usb_scsi.c,234 :: 		if ((CBW.bmFlags & 0x80) == 0)
MOVW	R0, #lo_addr(_CBW+12)
MOVT	R0, #hi_addr(_CBW+12)
LDRB	R0, [R0, #0]
AND	R0, R0, #128
UXTB	R0, R0
CMP	R0, #0
IT	NE
BNE	L_SCSI_Write10_Cmd14
;usb_scsi.c,236 :: 		Bot_State = BOT_DATA_OUT;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Bot_State+0)
MOVT	R0, #hi_addr(_Bot_State+0)
STRB	R1, [R0, #0]
;usb_scsi.c,237 :: 		SetEPRxStatus(ENDP2, EP_RX_VALID);
MOVS	R1, #0
MOVS	R0, #2
BL	_SetEPRxStatus+0
;usb_scsi.c,238 :: 		}
IT	AL
BAL	L_SCSI_Write10_Cmd15
L_SCSI_Write10_Cmd14:
;usb_scsi.c,241 :: 		Bot_Abort(DIR_IN);
MOVS	R0, #0
BL	_Bot_Abort+0
;usb_scsi.c,242 :: 		Set_Scsi_Sense_Data(ILLEGAL_REQUEST, INVALID_FIELED_IN_COMMAND);
MOVS	R1, #36
MOVS	R0, #5
BL	_Set_Scsi_Sense_Data+0
;usb_scsi.c,243 :: 		Set_CSW (CSW_CMD_FAILED, SEND_CSW_DISABLE);
MOVS	R1, #0
MOVS	R0, #1
BL	_Set_CSW+0
;usb_scsi.c,244 :: 		}
L_SCSI_Write10_Cmd15:
;usb_scsi.c,245 :: 		return;
IT	AL
BAL	L_end_SCSI_Write10_Cmd
;usb_scsi.c,246 :: 		}
L_SCSI_Write10_Cmd12:
;usb_scsi.c,247 :: 		else if (Bot_State == BOT_DATA_OUT)
MOVW	R0, #lo_addr(_Bot_State+0)
MOVT	R0, #hi_addr(_Bot_State+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_SCSI_Write10_Cmd17
;usb_scsi.c,249 :: 		Write_Memory();
BL	_Write_Memory+0
;usb_scsi.c,250 :: 		}
L_SCSI_Write10_Cmd17:
;usb_scsi.c,251 :: 		}
L_end_SCSI_Write10_Cmd:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _SCSI_Write10_Cmd
_SCSI_Verify10_Cmd:
;usb_scsi.c,260 :: 		void SCSI_Verify10_Cmd(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;usb_scsi.c,262 :: 		if ((CBW.dDataLength == 0) && !(CBW.CB[1] & BLKVFY))/* BLKVFY not set*/
MOVW	R0, #lo_addr(_CBW+8)
MOVT	R0, #hi_addr(_CBW+8)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L__SCSI_Verify10_Cmd30
MOVW	R0, #lo_addr(_CBW+16)
MOVT	R0, #hi_addr(_CBW+16)
LDRB	R0, [R0, #0]
AND	R0, R0, #4
UXTB	R0, R0
CMP	R0, #0
IT	NE
BNE	L__SCSI_Verify10_Cmd29
L__SCSI_Verify10_Cmd28:
;usb_scsi.c,264 :: 		Set_CSW (CSW_CMD_PASSED, SEND_CSW_ENABLE);
MOVS	R1, #1
MOVS	R0, #0
BL	_Set_CSW+0
;usb_scsi.c,265 :: 		}
IT	AL
BAL	L_SCSI_Verify10_Cmd21
;usb_scsi.c,262 :: 		if ((CBW.dDataLength == 0) && !(CBW.CB[1] & BLKVFY))/* BLKVFY not set*/
L__SCSI_Verify10_Cmd30:
L__SCSI_Verify10_Cmd29:
;usb_scsi.c,268 :: 		Bot_Abort(BOTH_DIR);
MOVS	R0, #2
BL	_Bot_Abort+0
;usb_scsi.c,269 :: 		Set_Scsi_Sense_Data(ILLEGAL_REQUEST, INVALID_FIELED_IN_COMMAND);
MOVS	R1, #36
MOVS	R0, #5
BL	_Set_Scsi_Sense_Data+0
;usb_scsi.c,270 :: 		Set_CSW (CSW_CMD_FAILED, SEND_CSW_DISABLE);
MOVS	R1, #0
MOVS	R0, #1
BL	_Set_CSW+0
;usb_scsi.c,271 :: 		}
L_SCSI_Verify10_Cmd21:
;usb_scsi.c,272 :: 		}
L_end_SCSI_Verify10_Cmd:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _SCSI_Verify10_Cmd
_SCSI_Valid_Cmd:
;usb_scsi.c,281 :: 		void SCSI_Valid_Cmd(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;usb_scsi.c,283 :: 		if (CBW.dDataLength != 0)
MOVW	R0, #lo_addr(_CBW+8)
MOVT	R0, #hi_addr(_CBW+8)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_SCSI_Valid_Cmd22
;usb_scsi.c,285 :: 		Bot_Abort(BOTH_DIR);
MOVS	R0, #2
BL	_Bot_Abort+0
;usb_scsi.c,286 :: 		Set_Scsi_Sense_Data(ILLEGAL_REQUEST, INVALID_COMMAND);
MOVS	R1, #32
MOVS	R0, #5
BL	_Set_Scsi_Sense_Data+0
;usb_scsi.c,287 :: 		Set_CSW (CSW_CMD_FAILED, SEND_CSW_DISABLE);
MOVS	R1, #0
MOVS	R0, #1
BL	_Set_CSW+0
;usb_scsi.c,288 :: 		}
IT	AL
BAL	L_SCSI_Valid_Cmd23
L_SCSI_Valid_Cmd22:
;usb_scsi.c,290 :: 		Set_CSW (CSW_CMD_PASSED, SEND_CSW_ENABLE);
MOVS	R1, #1
MOVS	R0, #0
BL	_Set_CSW+0
L_SCSI_Valid_Cmd23:
;usb_scsi.c,291 :: 		}
L_end_SCSI_Valid_Cmd:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _SCSI_Valid_Cmd
_SCSI_Invalid_Cmd:
;usb_scsi.c,300 :: 		void SCSI_Invalid_Cmd(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;usb_scsi.c,302 :: 		if (CBW.dDataLength == 0)
MOVW	R0, #lo_addr(_CBW+8)
MOVT	R0, #hi_addr(_CBW+8)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_SCSI_Invalid_Cmd24
;usb_scsi.c,304 :: 		Bot_Abort(DIR_IN);
MOVS	R0, #0
BL	_Bot_Abort+0
;usb_scsi.c,305 :: 		}
IT	AL
BAL	L_SCSI_Invalid_Cmd25
L_SCSI_Invalid_Cmd24:
;usb_scsi.c,308 :: 		if ((CBW.bmFlags & 0x80) != 0)
MOVW	R0, #lo_addr(_CBW+12)
MOVT	R0, #hi_addr(_CBW+12)
LDRB	R0, [R0, #0]
AND	R0, R0, #128
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_SCSI_Invalid_Cmd26
;usb_scsi.c,310 :: 		Bot_Abort(DIR_IN);
MOVS	R0, #0
BL	_Bot_Abort+0
;usb_scsi.c,311 :: 		}
IT	AL
BAL	L_SCSI_Invalid_Cmd27
L_SCSI_Invalid_Cmd26:
;usb_scsi.c,314 :: 		Bot_Abort(BOTH_DIR);
MOVS	R0, #2
BL	_Bot_Abort+0
;usb_scsi.c,315 :: 		}
L_SCSI_Invalid_Cmd27:
;usb_scsi.c,316 :: 		}
L_SCSI_Invalid_Cmd25:
;usb_scsi.c,317 :: 		Set_Scsi_Sense_Data(ILLEGAL_REQUEST, INVALID_COMMAND);
MOVS	R1, #32
MOVS	R0, #5
BL	_Set_Scsi_Sense_Data+0
;usb_scsi.c,318 :: 		Set_CSW (CSW_CMD_FAILED, SEND_CSW_DISABLE);
MOVS	R1, #0
MOVS	R0, #1
BL	_Set_CSW+0
;usb_scsi.c,319 :: 		}
L_end_SCSI_Invalid_Cmd:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _SCSI_Invalid_Cmd
