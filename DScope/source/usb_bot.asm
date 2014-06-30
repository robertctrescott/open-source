_Mass_Storage_In:
;usb_bot.c,45 :: 		void Mass_Storage_In (void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;usb_bot.c,47 :: 		switch (Bot_State)
IT	AL
BAL	L_Mass_Storage_In0
;usb_bot.c,49 :: 		case BOT_CSW_Send:
L_Mass_Storage_In2:
;usb_bot.c,50 :: 		case BOT_ERROR:
L_Mass_Storage_In3:
;usb_bot.c,51 :: 		Bot_State = BOT_IDLE;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Bot_State+0)
MOVT	R0, #hi_addr(_Bot_State+0)
STRB	R1, [R0, #0]
;usb_bot.c,52 :: 		SetEPRxStatus(ENDP2, EP_RX_VALID);/* enable the Endpoint to recive the next cmd*/
MOVS	R1, #0
MOVS	R0, #2
BL	_SetEPRxStatus+0
;usb_bot.c,53 :: 		break;
IT	AL
BAL	L_Mass_Storage_In1
;usb_bot.c,54 :: 		case BOT_DATA_IN:
L_Mass_Storage_In4:
;usb_bot.c,55 :: 		switch (CBW.CB[0])
IT	AL
BAL	L_Mass_Storage_In5
;usb_bot.c,57 :: 		case SCSI_READ10:
L_Mass_Storage_In7:
;usb_bot.c,58 :: 		SCSI_Read10_Cmd();
BL	_SCSI_Read10_Cmd+0
;usb_bot.c,59 :: 		break;
IT	AL
BAL	L_Mass_Storage_In6
;usb_bot.c,60 :: 		}
L_Mass_Storage_In5:
MOVW	R0, #lo_addr(_CBW+15)
MOVT	R0, #hi_addr(_CBW+15)
LDRB	R0, [R0, #0]
CMP	R0, #40
IT	EQ
BEQ	L_Mass_Storage_In7
L_Mass_Storage_In6:
;usb_bot.c,61 :: 		break;
IT	AL
BAL	L_Mass_Storage_In1
;usb_bot.c,62 :: 		case BOT_DATA_IN_LAST:
L_Mass_Storage_In8:
;usb_bot.c,63 :: 		Set_CSW (CSW_CMD_PASSED, SEND_CSW_ENABLE);
MOVS	R1, #1
MOVS	R0, #0
BL	_Set_CSW+0
;usb_bot.c,64 :: 		SetEPRxStatus(ENDP2, EP_RX_VALID);
MOVS	R1, #0
MOVS	R0, #2
BL	_SetEPRxStatus+0
;usb_bot.c,65 :: 		break;
IT	AL
BAL	L_Mass_Storage_In1
;usb_bot.c,67 :: 		default:
L_Mass_Storage_In9:
;usb_bot.c,68 :: 		break;
IT	AL
BAL	L_Mass_Storage_In1
;usb_bot.c,69 :: 		}
L_Mass_Storage_In0:
MOVW	R0, #lo_addr(_Bot_State+0)
MOVT	R0, #hi_addr(_Bot_State+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	EQ
BEQ	L_Mass_Storage_In2
MOVW	R0, #lo_addr(_Bot_State+0)
MOVT	R0, #hi_addr(_Bot_State+0)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	EQ
BEQ	L_Mass_Storage_In3
MOVW	R0, #lo_addr(_Bot_State+0)
MOVT	R0, #hi_addr(_Bot_State+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_Mass_Storage_In4
MOVW	R0, #lo_addr(_Bot_State+0)
MOVT	R0, #hi_addr(_Bot_State+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_Mass_Storage_In8
IT	AL
BAL	L_Mass_Storage_In9
L_Mass_Storage_In1:
;usb_bot.c,70 :: 		}
L_end_Mass_Storage_In:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Mass_Storage_In
_Mass_Storage_Out:
;usb_bot.c,79 :: 		void Mass_Storage_Out (void)
SUB	SP, SP, #8
STR	LR, [SP, #0]
;usb_bot.c,82 :: 		CMD = CBW.CB[0];
MOVW	R0, #lo_addr(_CBW+15)
MOVT	R0, #hi_addr(_CBW+15)
LDRB	R0, [R0, #0]
STRB	R0, [SP, #4]
;usb_bot.c,83 :: 		Data_Len = GetEPRxCount(ENDP2);
MOVS	R0, #2
BL	_GetEPRxCount+0
MOVW	R1, #lo_addr(_Data_Len+0)
MOVT	R1, #hi_addr(_Data_Len+0)
STRB	R0, [R1, #0]
;usb_bot.c,85 :: 		PMAToUserBufferCopy(Bulk_Data_Buff, ENDP2_RXADDR, Data_Len);
UXTB	R2, R0
MOVS	R1, #216
MOVW	R0, #lo_addr(_Bulk_Data_Buff+0)
MOVT	R0, #hi_addr(_Bulk_Data_Buff+0)
BL	_PMAToUserBufferCopy+0
;usb_bot.c,87 :: 		switch (Bot_State)
IT	AL
BAL	L_Mass_Storage_Out10
;usb_bot.c,89 :: 		case BOT_IDLE:
L_Mass_Storage_Out12:
;usb_bot.c,90 :: 		CBW_Decode();
BL	_CBW_Decode+0
;usb_bot.c,91 :: 		break;
IT	AL
BAL	L_Mass_Storage_Out11
;usb_bot.c,92 :: 		case BOT_DATA_OUT:
L_Mass_Storage_Out13:
;usb_bot.c,93 :: 		if (CMD == SCSI_WRITE10)
LDRB	R0, [SP, #4]
CMP	R0, #42
IT	NE
BNE	L_Mass_Storage_Out14
;usb_bot.c,95 :: 		SCSI_Write10_Cmd();
BL	_SCSI_Write10_Cmd+0
;usb_bot.c,96 :: 		break;
IT	AL
BAL	L_Mass_Storage_Out11
;usb_bot.c,97 :: 		}
L_Mass_Storage_Out14:
;usb_bot.c,98 :: 		Bot_Abort(DIR_OUT);
MOVS	R0, #1
BL	_Bot_Abort+0
;usb_bot.c,99 :: 		Set_Scsi_Sense_Data(ILLEGAL_REQUEST, INVALID_FIELED_IN_COMMAND);
MOVS	R1, #36
MOVS	R0, #5
BL	_Set_Scsi_Sense_Data+0
;usb_bot.c,100 :: 		Set_CSW (CSW_PHASE_ERROR, SEND_CSW_DISABLE);
MOVS	R1, #0
MOVS	R0, #2
BL	_Set_CSW+0
;usb_bot.c,101 :: 		break;
IT	AL
BAL	L_Mass_Storage_Out11
;usb_bot.c,102 :: 		default:
L_Mass_Storage_Out15:
;usb_bot.c,103 :: 		Bot_Abort(BOTH_DIR);
MOVS	R0, #2
BL	_Bot_Abort+0
;usb_bot.c,104 :: 		Set_Scsi_Sense_Data(ILLEGAL_REQUEST, INVALID_FIELED_IN_COMMAND);
MOVS	R1, #36
MOVS	R0, #5
BL	_Set_Scsi_Sense_Data+0
;usb_bot.c,105 :: 		Set_CSW (CSW_PHASE_ERROR, SEND_CSW_DISABLE);
MOVS	R1, #0
MOVS	R0, #2
BL	_Set_CSW+0
;usb_bot.c,106 :: 		break;
IT	AL
BAL	L_Mass_Storage_Out11
;usb_bot.c,107 :: 		}
L_Mass_Storage_Out10:
MOVW	R0, #lo_addr(_Bot_State+0)
MOVT	R0, #hi_addr(_Bot_State+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Mass_Storage_Out12
MOVW	R0, #lo_addr(_Bot_State+0)
MOVT	R0, #hi_addr(_Bot_State+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_Mass_Storage_Out13
IT	AL
BAL	L_Mass_Storage_Out15
L_Mass_Storage_Out11:
;usb_bot.c,108 :: 		}
L_end_Mass_Storage_Out:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _Mass_Storage_Out
_CBW_Decode:
;usb_bot.c,118 :: 		void CBW_Decode(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;usb_bot.c,122 :: 		for (Counter = 0; Counter < Data_Len; Counter++)
; Counter start address is: 8 (R2)
MOVS	R2, #0
; Counter end address is: 8 (R2)
L_CBW_Decode16:
; Counter start address is: 8 (R2)
MOVW	R0, #lo_addr(_Data_Len+0)
MOVT	R0, #hi_addr(_Data_Len+0)
LDRB	R0, [R0, #0]
CMP	R2, R0
IT	CS
BCS	L_CBW_Decode17
;usb_bot.c,124 :: 		*((u8 *)&CBW + Counter) = Bulk_Data_Buff[Counter];
MOVW	R0, #lo_addr(_CBW+0)
MOVT	R0, #hi_addr(_CBW+0)
ADDS	R1, R0, R2
MOVW	R0, #lo_addr(_Bulk_Data_Buff+0)
MOVT	R0, #hi_addr(_Bulk_Data_Buff+0)
ADDS	R0, R0, R2
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;usb_bot.c,122 :: 		for (Counter = 0; Counter < Data_Len; Counter++)
ADDS	R2, R2, #1
;usb_bot.c,125 :: 		}
; Counter end address is: 8 (R2)
IT	AL
BAL	L_CBW_Decode16
L_CBW_Decode17:
;usb_bot.c,126 :: 		CSW.dTag = CBW.dTag;
MOVW	R0, #lo_addr(_CBW+4)
MOVT	R0, #hi_addr(_CBW+4)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_CSW+4)
MOVT	R0, #hi_addr(_CSW+4)
STR	R1, [R0, #0]
;usb_bot.c,127 :: 		CSW.dDataResidue = CBW.dDataLength;
MOVW	R0, #lo_addr(_CBW+8)
MOVT	R0, #hi_addr(_CBW+8)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_CSW+8)
MOVT	R0, #hi_addr(_CSW+8)
STR	R1, [R0, #0]
;usb_bot.c,128 :: 		if (Data_Len != BOT_CBW_PACKET_LENGTH)
MOVW	R0, #lo_addr(_Data_Len+0)
MOVT	R0, #hi_addr(_Data_Len+0)
LDRB	R0, [R0, #0]
CMP	R0, #31
IT	EQ
BEQ	L_CBW_Decode19
;usb_bot.c,130 :: 		Bot_Abort(BOTH_DIR);
MOVS	R0, #2
BL	_Bot_Abort+0
;usb_bot.c,132 :: 		CBW.dSignature = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_CBW+0)
MOVT	R0, #hi_addr(_CBW+0)
STR	R1, [R0, #0]
;usb_bot.c,133 :: 		Set_Scsi_Sense_Data(ILLEGAL_REQUEST, PARAMETER_LIST_LENGTH_ERROR);
MOVS	R1, #26
MOVS	R0, #5
BL	_Set_Scsi_Sense_Data+0
;usb_bot.c,134 :: 		Set_CSW (CSW_CMD_FAILED, SEND_CSW_DISABLE);
MOVS	R1, #0
MOVS	R0, #1
BL	_Set_CSW+0
;usb_bot.c,135 :: 		return;
IT	AL
BAL	L_end_CBW_Decode
;usb_bot.c,136 :: 		}
L_CBW_Decode19:
;usb_bot.c,138 :: 		if (CBW.dSignature == BOT_CBW_SIGNATURE)
MOVW	R0, #lo_addr(_CBW+0)
MOVT	R0, #hi_addr(_CBW+0)
LDR	R1, [R0, #0]
MOVW	R0, #21333
MOVT	R0, #17218
CMP	R1, R0
IT	NE
BNE	L_CBW_Decode20
;usb_bot.c,141 :: 		if ((CBW.bLUN != 0) || (CBW.bCBLength < 1) || (CBW.bCBLength > 16))
MOVW	R0, #lo_addr(_CBW+13)
MOVT	R0, #hi_addr(_CBW+13)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L__CBW_Decode64
MOVW	R0, #lo_addr(_CBW+14)
MOVT	R0, #hi_addr(_CBW+14)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	CC
BCC	L__CBW_Decode63
MOVW	R0, #lo_addr(_CBW+14)
MOVT	R0, #hi_addr(_CBW+14)
LDRB	R0, [R0, #0]
CMP	R0, #16
IT	HI
BHI	L__CBW_Decode62
IT	AL
BAL	L_CBW_Decode23
L__CBW_Decode64:
L__CBW_Decode63:
L__CBW_Decode62:
;usb_bot.c,143 :: 		Bot_Abort(BOTH_DIR);
MOVS	R0, #2
BL	_Bot_Abort+0
;usb_bot.c,144 :: 		Set_Scsi_Sense_Data(ILLEGAL_REQUEST, INVALID_FIELED_IN_COMMAND);
MOVS	R1, #36
MOVS	R0, #5
BL	_Set_Scsi_Sense_Data+0
;usb_bot.c,145 :: 		Set_CSW (CSW_CMD_FAILED, SEND_CSW_DISABLE);
MOVS	R1, #0
MOVS	R0, #1
BL	_Set_CSW+0
;usb_bot.c,146 :: 		}
IT	AL
BAL	L_CBW_Decode24
L_CBW_Decode23:
;usb_bot.c,149 :: 		switch (CBW.CB[0])
IT	AL
BAL	L_CBW_Decode25
;usb_bot.c,151 :: 		case SCSI_REQUEST_SENSE:
L_CBW_Decode27:
;usb_bot.c,152 :: 		SCSI_RequestSense_Cmd ();
BL	_SCSI_RequestSense_Cmd+0
;usb_bot.c,153 :: 		break;
IT	AL
BAL	L_CBW_Decode26
;usb_bot.c,154 :: 		case SCSI_INQUIRY:
L_CBW_Decode28:
;usb_bot.c,155 :: 		SCSI_Inquiry_Cmd();
BL	_SCSI_Inquiry_Cmd+0
;usb_bot.c,156 :: 		break;
IT	AL
BAL	L_CBW_Decode26
;usb_bot.c,157 :: 		case SCSI_START_STOP_UNIT:
L_CBW_Decode29:
;usb_bot.c,158 :: 		SCSI_Start_Stop_Unit_Cmd();
BL	_SCSI_Start_Stop_Unit_Cmd+0
;usb_bot.c,159 :: 		case SCSI_ALLOW_MEDIUM_REMOVAL:
L_CBW_Decode30:
;usb_bot.c,160 :: 		SCSI_Start_Stop_Unit_Cmd();
BL	_SCSI_Start_Stop_Unit_Cmd+0
;usb_bot.c,161 :: 		break;
IT	AL
BAL	L_CBW_Decode26
;usb_bot.c,162 :: 		case SCSI_MODE_SENSE6:
L_CBW_Decode31:
;usb_bot.c,163 :: 		SCSI_ModeSense6_Cmd ();
BL	_SCSI_ModeSense6_Cmd+0
;usb_bot.c,164 :: 		break;
IT	AL
BAL	L_CBW_Decode26
;usb_bot.c,165 :: 		case SCSI_MODE_SENSE10:
L_CBW_Decode32:
;usb_bot.c,166 :: 		SCSI_ModeSense10_Cmd ();
BL	_SCSI_ModeSense10_Cmd+0
;usb_bot.c,167 :: 		break;
IT	AL
BAL	L_CBW_Decode26
;usb_bot.c,168 :: 		case SCSI_READ_FORMAT_CAPACITIES:
L_CBW_Decode33:
;usb_bot.c,169 :: 		SCSI_ReadFormatCapacity_Cmd();
BL	_SCSI_ReadFormatCapacity_Cmd+0
;usb_bot.c,170 :: 		break;
IT	AL
BAL	L_CBW_Decode26
;usb_bot.c,171 :: 		case SCSI_READ_CAPACITY10:
L_CBW_Decode34:
;usb_bot.c,172 :: 		SCSI_ReadCapacity10_Cmd();
BL	_SCSI_ReadCapacity10_Cmd+0
;usb_bot.c,173 :: 		break;
IT	AL
BAL	L_CBW_Decode26
;usb_bot.c,174 :: 		case SCSI_TEST_UNIT_READY:
L_CBW_Decode35:
;usb_bot.c,175 :: 		SCSI_TestUnitReady_Cmd();
BL	_SCSI_Valid_Cmd+0
;usb_bot.c,176 :: 		break;
IT	AL
BAL	L_CBW_Decode26
;usb_bot.c,177 :: 		case SCSI_READ10:
L_CBW_Decode36:
;usb_bot.c,178 :: 		SCSI_Read10_Cmd();
BL	_SCSI_Read10_Cmd+0
;usb_bot.c,179 :: 		break;
IT	AL
BAL	L_CBW_Decode26
;usb_bot.c,180 :: 		case SCSI_WRITE10:
L_CBW_Decode37:
;usb_bot.c,181 :: 		SCSI_Write10_Cmd();
BL	_SCSI_Write10_Cmd+0
;usb_bot.c,182 :: 		break;
IT	AL
BAL	L_CBW_Decode26
;usb_bot.c,183 :: 		case SCSI_VERIFY10:
L_CBW_Decode38:
;usb_bot.c,184 :: 		SCSI_Verify10_Cmd();
BL	_SCSI_Verify10_Cmd+0
;usb_bot.c,185 :: 		break;
IT	AL
BAL	L_CBW_Decode26
;usb_bot.c,188 :: 		case SCSI_MODE_SELECT10:
L_CBW_Decode39:
;usb_bot.c,189 :: 		SCSI_Mode_Select10_Cmd();
BL	_SCSI_Invalid_Cmd+0
;usb_bot.c,190 :: 		break;
IT	AL
BAL	L_CBW_Decode26
;usb_bot.c,191 :: 		case SCSI_MODE_SELECT6:
L_CBW_Decode40:
;usb_bot.c,192 :: 		SCSI_Mode_Select6_Cmd();
BL	_SCSI_Invalid_Cmd+0
;usb_bot.c,193 :: 		break;
IT	AL
BAL	L_CBW_Decode26
;usb_bot.c,194 :: 		case SCSI_FORMAT_UNIT:
L_CBW_Decode41:
;usb_bot.c,195 :: 		SCSI_FormatUnit_Cmd();
BL	_SCSI_Invalid_Cmd+0
;usb_bot.c,196 :: 		break;
IT	AL
BAL	L_CBW_Decode26
;usb_bot.c,197 :: 		case SCSI_SEND_DIAGNOSTIC:
L_CBW_Decode42:
;usb_bot.c,198 :: 		SCSI_Send_Diagnostic_Cmd();
BL	_SCSI_Invalid_Cmd+0
;usb_bot.c,199 :: 		break;
IT	AL
BAL	L_CBW_Decode26
;usb_bot.c,200 :: 		case SCSI_READ6:
L_CBW_Decode43:
;usb_bot.c,201 :: 		SCSI_Read6_Cmd();
BL	_SCSI_Invalid_Cmd+0
;usb_bot.c,202 :: 		break;
IT	AL
BAL	L_CBW_Decode26
;usb_bot.c,203 :: 		case SCSI_READ12:
L_CBW_Decode44:
;usb_bot.c,204 :: 		SCSI_Read12_Cmd();
BL	_SCSI_Invalid_Cmd+0
;usb_bot.c,205 :: 		break;
IT	AL
BAL	L_CBW_Decode26
;usb_bot.c,206 :: 		case SCSI_READ16:
L_CBW_Decode45:
;usb_bot.c,207 :: 		SCSI_Read16_Cmd();
BL	_SCSI_Invalid_Cmd+0
;usb_bot.c,208 :: 		break;
IT	AL
BAL	L_CBW_Decode26
;usb_bot.c,209 :: 		case SCSI_READ_CAPACITY16:
L_CBW_Decode46:
;usb_bot.c,210 :: 		SCSI_READ_CAPACITY16_Cmd();
BL	_SCSI_Invalid_Cmd+0
;usb_bot.c,211 :: 		break;
IT	AL
BAL	L_CBW_Decode26
;usb_bot.c,212 :: 		case SCSI_WRITE6:
L_CBW_Decode47:
;usb_bot.c,213 :: 		SCSI_Write6_Cmd();
BL	_SCSI_Invalid_Cmd+0
;usb_bot.c,214 :: 		break;
IT	AL
BAL	L_CBW_Decode26
;usb_bot.c,215 :: 		case SCSI_WRITE12:
L_CBW_Decode48:
;usb_bot.c,216 :: 		SCSI_Write12_Cmd();
BL	_SCSI_Invalid_Cmd+0
;usb_bot.c,217 :: 		break;
IT	AL
BAL	L_CBW_Decode26
;usb_bot.c,218 :: 		case SCSI_WRITE16:
L_CBW_Decode49:
;usb_bot.c,219 :: 		SCSI_Write16_Cmd();
BL	_SCSI_Invalid_Cmd+0
;usb_bot.c,220 :: 		break;
IT	AL
BAL	L_CBW_Decode26
;usb_bot.c,221 :: 		case SCSI_VERIFY12:
L_CBW_Decode50:
;usb_bot.c,222 :: 		SCSI_Verify12_Cmd();
BL	_SCSI_Invalid_Cmd+0
;usb_bot.c,223 :: 		break;
IT	AL
BAL	L_CBW_Decode26
;usb_bot.c,224 :: 		case SCSI_VERIFY16:
L_CBW_Decode51:
;usb_bot.c,225 :: 		SCSI_Verify16_Cmd();
BL	_SCSI_Invalid_Cmd+0
;usb_bot.c,226 :: 		break;
IT	AL
BAL	L_CBW_Decode26
;usb_bot.c,228 :: 		default:
L_CBW_Decode52:
;usb_bot.c,230 :: 		Bot_Abort(BOTH_DIR);
MOVS	R0, #2
BL	_Bot_Abort+0
;usb_bot.c,231 :: 		Set_Scsi_Sense_Data(ILLEGAL_REQUEST, INVALID_COMMAND);
MOVS	R1, #32
MOVS	R0, #5
BL	_Set_Scsi_Sense_Data+0
;usb_bot.c,232 :: 		Set_CSW (CSW_CMD_FAILED, SEND_CSW_DISABLE);
MOVS	R1, #0
MOVS	R0, #1
BL	_Set_CSW+0
;usb_bot.c,234 :: 		}
IT	AL
BAL	L_CBW_Decode26
L_CBW_Decode25:
MOVW	R0, #lo_addr(_CBW+15)
MOVT	R0, #hi_addr(_CBW+15)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_CBW_Decode27
MOVW	R0, #lo_addr(_CBW+15)
MOVT	R0, #hi_addr(_CBW+15)
LDRB	R0, [R0, #0]
CMP	R0, #18
IT	EQ
BEQ	L_CBW_Decode28
MOVW	R0, #lo_addr(_CBW+15)
MOVT	R0, #hi_addr(_CBW+15)
LDRB	R0, [R0, #0]
CMP	R0, #27
IT	EQ
BEQ	L_CBW_Decode29
MOVW	R0, #lo_addr(_CBW+15)
MOVT	R0, #hi_addr(_CBW+15)
LDRB	R0, [R0, #0]
CMP	R0, #30
IT	EQ
BEQ	L_CBW_Decode30
MOVW	R0, #lo_addr(_CBW+15)
MOVT	R0, #hi_addr(_CBW+15)
LDRB	R0, [R0, #0]
CMP	R0, #26
IT	EQ
BEQ	L_CBW_Decode31
MOVW	R0, #lo_addr(_CBW+15)
MOVT	R0, #hi_addr(_CBW+15)
LDRB	R0, [R0, #0]
CMP	R0, #90
IT	EQ
BEQ	L_CBW_Decode32
MOVW	R0, #lo_addr(_CBW+15)
MOVT	R0, #hi_addr(_CBW+15)
LDRB	R0, [R0, #0]
CMP	R0, #35
IT	EQ
BEQ	L_CBW_Decode33
MOVW	R0, #lo_addr(_CBW+15)
MOVT	R0, #hi_addr(_CBW+15)
LDRB	R0, [R0, #0]
CMP	R0, #37
IT	EQ
BEQ	L_CBW_Decode34
MOVW	R0, #lo_addr(_CBW+15)
MOVT	R0, #hi_addr(_CBW+15)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_CBW_Decode35
MOVW	R0, #lo_addr(_CBW+15)
MOVT	R0, #hi_addr(_CBW+15)
LDRB	R0, [R0, #0]
CMP	R0, #40
IT	EQ
BEQ	L_CBW_Decode36
MOVW	R0, #lo_addr(_CBW+15)
MOVT	R0, #hi_addr(_CBW+15)
LDRB	R0, [R0, #0]
CMP	R0, #42
IT	EQ
BEQ	L_CBW_Decode37
MOVW	R0, #lo_addr(_CBW+15)
MOVT	R0, #hi_addr(_CBW+15)
LDRB	R0, [R0, #0]
CMP	R0, #47
IT	EQ
BEQ	L_CBW_Decode38
MOVW	R0, #lo_addr(_CBW+15)
MOVT	R0, #hi_addr(_CBW+15)
LDRB	R0, [R0, #0]
CMP	R0, #85
IT	EQ
BEQ	L_CBW_Decode39
MOVW	R0, #lo_addr(_CBW+15)
MOVT	R0, #hi_addr(_CBW+15)
LDRB	R0, [R0, #0]
CMP	R0, #21
IT	EQ
BEQ	L_CBW_Decode40
MOVW	R0, #lo_addr(_CBW+15)
MOVT	R0, #hi_addr(_CBW+15)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	EQ
BEQ	L_CBW_Decode41
MOVW	R0, #lo_addr(_CBW+15)
MOVT	R0, #hi_addr(_CBW+15)
LDRB	R0, [R0, #0]
CMP	R0, #29
IT	EQ
BEQ	L_CBW_Decode42
MOVW	R0, #lo_addr(_CBW+15)
MOVT	R0, #hi_addr(_CBW+15)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	EQ
BEQ	L_CBW_Decode43
MOVW	R0, #lo_addr(_CBW+15)
MOVT	R0, #hi_addr(_CBW+15)
LDRB	R0, [R0, #0]
CMP	R0, #168
IT	EQ
BEQ	L_CBW_Decode44
MOVW	R0, #lo_addr(_CBW+15)
MOVT	R0, #hi_addr(_CBW+15)
LDRB	R0, [R0, #0]
CMP	R0, #136
IT	EQ
BEQ	L_CBW_Decode45
MOVW	R0, #lo_addr(_CBW+15)
MOVT	R0, #hi_addr(_CBW+15)
LDRB	R0, [R0, #0]
CMP	R0, #158
IT	EQ
BEQ	L_CBW_Decode46
MOVW	R0, #lo_addr(_CBW+15)
MOVT	R0, #hi_addr(_CBW+15)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	EQ
BEQ	L_CBW_Decode47
MOVW	R0, #lo_addr(_CBW+15)
MOVT	R0, #hi_addr(_CBW+15)
LDRB	R0, [R0, #0]
CMP	R0, #170
IT	EQ
BEQ	L_CBW_Decode48
MOVW	R0, #lo_addr(_CBW+15)
MOVT	R0, #hi_addr(_CBW+15)
LDRB	R0, [R0, #0]
CMP	R0, #138
IT	EQ
BEQ	L_CBW_Decode49
MOVW	R0, #lo_addr(_CBW+15)
MOVT	R0, #hi_addr(_CBW+15)
LDRB	R0, [R0, #0]
CMP	R0, #175
IT	EQ
BEQ	L_CBW_Decode50
MOVW	R0, #lo_addr(_CBW+15)
MOVT	R0, #hi_addr(_CBW+15)
LDRB	R0, [R0, #0]
CMP	R0, #143
IT	EQ
BEQ	L_CBW_Decode51
IT	AL
BAL	L_CBW_Decode52
L_CBW_Decode26:
;usb_bot.c,235 :: 		}
L_CBW_Decode24:
;usb_bot.c,236 :: 		}
IT	AL
BAL	L_CBW_Decode53
L_CBW_Decode20:
;usb_bot.c,240 :: 		Bot_Abort(BOTH_DIR);
MOVS	R0, #2
BL	_Bot_Abort+0
;usb_bot.c,241 :: 		Set_Scsi_Sense_Data(ILLEGAL_REQUEST, INVALID_COMMAND);
MOVS	R1, #32
MOVS	R0, #5
BL	_Set_Scsi_Sense_Data+0
;usb_bot.c,242 :: 		Set_CSW (CSW_CMD_FAILED, SEND_CSW_DISABLE);
MOVS	R1, #0
MOVS	R0, #1
BL	_Set_CSW+0
;usb_bot.c,243 :: 		}
L_CBW_Decode53:
;usb_bot.c,244 :: 		}
L_end_CBW_Decode:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _CBW_Decode
_Transfer_Data_Request:
;usb_bot.c,254 :: 		void Transfer_Data_Request(u8* Data_Pointer, u16 Data_Len)
SUB	SP, SP, #8
STR	LR, [SP, #0]
STRB	R1, [SP, #4]
;usb_bot.c,256 :: 		UserToPMABufferCopy(Data_Pointer, ENDP1_TXADDR, Data_Len);
LDRB	R2, [SP, #4]
MOVS	R1, #152
BL	_UserToPMABufferCopy+0
;usb_bot.c,258 :: 		SetEPTxCount(ENDP1, Data_Len);
LDRB	R1, [SP, #4]
MOVS	R0, #1
BL	_SetEPTxCount+0
;usb_bot.c,259 :: 		SetEPTxStatus(ENDP1, EP_TX_VALID);
MOVS	R1, #48
MOVS	R0, #1
BL	_SetEPTxStatus+0
;usb_bot.c,260 :: 		Bot_State = BOT_DATA_IN_LAST;
MOVS	R3, #3
MOVW	R2, #lo_addr(_Bot_State+0)
MOVT	R2, #hi_addr(_Bot_State+0)
STRB	R3, [R2, #0]
;usb_bot.c,261 :: 		CSW.dDataResidue -= Data_Len;
LDRB	R4, [SP, #4]
MOVW	R3, #lo_addr(_CSW+8)
MOVT	R3, #hi_addr(_CSW+8)
LDR	R2, [R3, #0]
SUB	R2, R2, R4
STR	R2, [R3, #0]
;usb_bot.c,262 :: 		CSW.bStatus = CSW_CMD_PASSED;
MOVS	R3, #0
MOVW	R2, #lo_addr(_CSW+12)
MOVT	R2, #hi_addr(_CSW+12)
STRB	R3, [R2, #0]
;usb_bot.c,263 :: 		}
L_end_Transfer_Data_Request:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _Transfer_Data_Request
_Set_CSW:
;usb_bot.c,273 :: 		void Set_CSW (u8 CSW_Status, u8 Send_Permission)
SUB	SP, SP, #8
STR	LR, [SP, #0]
STRB	R1, [SP, #4]
;usb_bot.c,275 :: 		CSW.dSignature = BOT_CSW_SIGNATURE;
MOVW	R3, #21333
MOVT	R3, #21314
MOVW	R2, #lo_addr(_CSW+0)
MOVT	R2, #hi_addr(_CSW+0)
STR	R3, [R2, #0]
;usb_bot.c,276 :: 		CSW.bStatus = CSW_Status;
MOVW	R2, #lo_addr(_CSW+12)
MOVT	R2, #hi_addr(_CSW+12)
STRB	R0, [R2, #0]
;usb_bot.c,278 :: 		UserToPMABufferCopy(((u8 *)& CSW), ENDP1_TXADDR, CSW_DATA_LENGTH);
MOVS	R2, #13
MOVS	R1, #152
MOVW	R0, #lo_addr(_CSW+0)
MOVT	R0, #hi_addr(_CSW+0)
BL	_UserToPMABufferCopy+0
;usb_bot.c,280 :: 		SetEPTxCount(ENDP1, CSW_DATA_LENGTH);
MOVS	R1, #13
MOVS	R0, #1
BL	_SetEPTxCount+0
;usb_bot.c,281 :: 		Bot_State = BOT_ERROR;
MOVS	R3, #5
MOVW	R2, #lo_addr(_Bot_State+0)
MOVT	R2, #hi_addr(_Bot_State+0)
STRB	R3, [R2, #0]
;usb_bot.c,282 :: 		if (Send_Permission)
LDRB	R2, [SP, #4]
CMP	R2, #0
IT	EQ
BEQ	L_Set_CSW54
;usb_bot.c,284 :: 		Bot_State = BOT_CSW_Send;
MOVS	R3, #4
MOVW	R2, #lo_addr(_Bot_State+0)
MOVT	R2, #hi_addr(_Bot_State+0)
STRB	R3, [R2, #0]
;usb_bot.c,285 :: 		SetEPTxStatus(ENDP1, EP_TX_VALID);
MOVS	R1, #48
MOVS	R0, #1
BL	_SetEPTxStatus+0
;usb_bot.c,286 :: 		}
L_Set_CSW54:
;usb_bot.c,288 :: 		}
L_end_Set_CSW:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _Set_CSW
_Bot_Abort:
;usb_bot.c,297 :: 		void Bot_Abort(u8 Direction)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;usb_bot.c,299 :: 		switch (Direction)
IT	AL
BAL	L_Bot_Abort55
;usb_bot.c,301 :: 		case DIR_IN :
L_Bot_Abort57:
;usb_bot.c,302 :: 		SetEPTxStatus(ENDP1, EP_TX_STALL);
MOVS	R1, #16
MOVS	R0, #1
BL	_SetEPTxStatus+0
;usb_bot.c,303 :: 		break;
IT	AL
BAL	L_Bot_Abort56
;usb_bot.c,304 :: 		case DIR_OUT :
L_Bot_Abort58:
;usb_bot.c,305 :: 		SetEPRxStatus(ENDP2, EP_RX_STALL);
MOVS	R1, #0
MOVS	R0, #2
BL	_SetEPRxStatus+0
;usb_bot.c,306 :: 		break;
IT	AL
BAL	L_Bot_Abort56
;usb_bot.c,307 :: 		case BOTH_DIR :
L_Bot_Abort59:
;usb_bot.c,308 :: 		SetEPTxStatus(ENDP1, EP_TX_STALL);
MOVS	R1, #16
MOVS	R0, #1
BL	_SetEPTxStatus+0
;usb_bot.c,309 :: 		SetEPRxStatus(ENDP2, EP_RX_STALL);
MOVS	R1, #0
MOVS	R0, #2
BL	_SetEPRxStatus+0
;usb_bot.c,310 :: 		break;
IT	AL
BAL	L_Bot_Abort56
;usb_bot.c,311 :: 		default:
L_Bot_Abort60:
;usb_bot.c,312 :: 		break;
IT	AL
BAL	L_Bot_Abort56
;usb_bot.c,313 :: 		}
L_Bot_Abort55:
CMP	R0, #0
IT	EQ
BEQ	L_Bot_Abort57
CMP	R0, #1
IT	EQ
BEQ	L_Bot_Abort58
CMP	R0, #2
IT	EQ
BEQ	L_Bot_Abort59
IT	AL
BAL	L_Bot_Abort60
L_Bot_Abort56:
;usb_bot.c,314 :: 		}
L_end_Bot_Abort:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Bot_Abort
