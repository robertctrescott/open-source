_Get_Medium_Characteristics:
;memory.c,33 :: 		void Get_Medium_Characteristics(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;memory.c,35 :: 		unsigned int temp1 = 0;
;memory.c,36 :: 		unsigned int temp2 = 0;
;memory.c,38 :: 		MSD_GetCSDRegister(&MSD_csd);
MOVW	R0, #lo_addr(_MSD_csd+0)
MOVT	R0, #hi_addr(_MSD_csd+0)
BL	_MSD_GetCSDRegister+0
;memory.c,39 :: 		temp1 = MSD_csd.DeviceSize + 1;
MOVW	R0, #lo_addr(_MSD_csd+13)
MOVT	R0, #hi_addr(_MSD_csd+13)
LDRB	R0, [R0, #0]
ADDS	R2, R0, #1
;memory.c,40 :: 		temp2 = 1 << (MSD_csd.DeviceSizeMul + 2);
MOVW	R0, #lo_addr(_MSD_csd+18)
MOVT	R0, #hi_addr(_MSD_csd+18)
LDRB	R0, [R0, #0]
ADDS	R1, R0, #2
SXTH	R1, R1
MOVS	R0, #1
LSL	R1, R0, R1
UXTH	R1, R1
;memory.c,41 :: 		Mass_Block_Count = temp1 * temp2;
UXTH	R0, R2
MULS	R0, R1, R0
UXTH	R0, R0
MOVW	R2, #lo_addr(_Mass_Block_Count+0)
MOVT	R2, #hi_addr(_Mass_Block_Count+0)
STR	R0, [R2, #0]
;memory.c,42 :: 		Mass_Block_Size =  1 << MSD_csd.RdBlockLen;
MOVW	R0, #lo_addr(_MSD_csd+7)
MOVT	R0, #hi_addr(_MSD_csd+7)
LDRB	R1, [R0, #0]
MOVS	R0, #1
LSL	R1, R0, R1
UXTH	R1, R1
MOVW	R0, #lo_addr(_Mass_Block_Size+0)
MOVT	R0, #hi_addr(_Mass_Block_Size+0)
STR	R1, [R0, #0]
;memory.c,43 :: 		Mass_Memory_Size = (Mass_Block_Count * Mass_Block_Size);
LDR	R1, [R0, #0]
MOV	R0, R2
LDR	R0, [R0, #0]
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_Mass_Memory_Size+0)
MOVT	R0, #hi_addr(_Mass_Memory_Size+0)
STR	R1, [R0, #0]
;memory.c,44 :: 		}
L_end_Get_Medium_Characteristics:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Get_Medium_Characteristics
_Read_Memory:
;memory.c,52 :: 		void Read_Memory(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;memory.c,54 :: 		if (!Block_Read_count)
MOVW	R0, #lo_addr(_Block_Read_count+0)
MOVT	R0, #hi_addr(_Block_Read_count+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_Read_Memory0
;memory.c,56 :: 		MSD_ReadBlock(Data_Buffer, Memory_Offset, 512);
MOVW	R0, #lo_addr(_Memory_Offset+0)
MOVT	R0, #hi_addr(_Memory_Offset+0)
LDR	R0, [R0, #0]
MOVS	R2, #0
MOV	R1, R0
MOVW	R0, #lo_addr(_Data_Buffer+0)
MOVT	R0, #hi_addr(_Data_Buffer+0)
BL	_MSD_ReadBlock+0
;memory.c,57 :: 		UserToPMABufferCopy(Data_Buffer, ENDP1_TXADDR, BULK_MAX_PACKET_SIZE);
MOVS	R2, #64
MOVS	R1, #152
MOVW	R0, #lo_addr(_Data_Buffer+0)
MOVT	R0, #hi_addr(_Data_Buffer+0)
BL	_UserToPMABufferCopy+0
;memory.c,58 :: 		Block_Read_count = 512 - BULK_MAX_PACKET_SIZE;
MOVW	R1, #448
MOVW	R0, #lo_addr(_Block_Read_count+0)
MOVT	R0, #hi_addr(_Block_Read_count+0)
STR	R1, [R0, #0]
;memory.c,59 :: 		Block_offset = BULK_MAX_PACKET_SIZE;
MOVS	R1, #64
MOVW	R0, #lo_addr(_Block_offset+0)
MOVT	R0, #hi_addr(_Block_offset+0)
STR	R1, [R0, #0]
;memory.c,60 :: 		}
IT	AL
BAL	L_Read_Memory1
L_Read_Memory0:
;memory.c,63 :: 		UserToPMABufferCopy(Data_Buffer + Block_offset, ENDP1_TXADDR, BULK_MAX_PACKET_SIZE);
MOVW	R0, #lo_addr(_Block_offset+0)
MOVT	R0, #hi_addr(_Block_offset+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_Data_Buffer+0)
MOVT	R0, #hi_addr(_Data_Buffer+0)
ADDS	R0, R0, R1
MOVS	R2, #64
MOVS	R1, #152
BL	_UserToPMABufferCopy+0
;memory.c,64 :: 		Block_Read_count -= BULK_MAX_PACKET_SIZE;
MOVW	R0, #lo_addr(_Block_Read_count+0)
MOVT	R0, #hi_addr(_Block_Read_count+0)
LDR	R0, [R0, #0]
SUBW	R1, R0, #64
MOVW	R0, #lo_addr(_Block_Read_count+0)
MOVT	R0, #hi_addr(_Block_Read_count+0)
STR	R1, [R0, #0]
;memory.c,65 :: 		Block_offset += BULK_MAX_PACKET_SIZE;
MOVW	R0, #lo_addr(_Block_offset+0)
MOVT	R0, #hi_addr(_Block_offset+0)
LDR	R0, [R0, #0]
ADDW	R1, R0, #64
MOVW	R0, #lo_addr(_Block_offset+0)
MOVT	R0, #hi_addr(_Block_offset+0)
STR	R1, [R0, #0]
;memory.c,66 :: 		}
L_Read_Memory1:
;memory.c,68 :: 		SetEPTxCount(ENDP1, BULK_MAX_PACKET_SIZE);
MOVS	R1, #64
MOVS	R0, #1
BL	_SetEPTxCount+0
;memory.c,69 :: 		SetEPTxStatus(ENDP1, EP_TX_VALID);
MOVS	R1, #48
MOVS	R0, #1
BL	_SetEPTxStatus+0
;memory.c,72 :: 		Memory_Offset += BULK_MAX_PACKET_SIZE;
MOVW	R0, #lo_addr(_Memory_Offset+0)
MOVT	R0, #hi_addr(_Memory_Offset+0)
LDR	R0, [R0, #0]
ADDW	R1, R0, #64
MOVW	R0, #lo_addr(_Memory_Offset+0)
MOVT	R0, #hi_addr(_Memory_Offset+0)
STR	R1, [R0, #0]
;memory.c,73 :: 		Transfer_Length -= BULK_MAX_PACKET_SIZE;
MOVW	R1, #lo_addr(_Transfer_Length+0)
MOVT	R1, #hi_addr(_Transfer_Length+0)
LDR	R0, [R1, #0]
SUBW	R2, R0, #64
STR	R2, [R1, #0]
;memory.c,75 :: 		CSW.dDataResidue -= BULK_MAX_PACKET_SIZE;
MOVW	R1, #lo_addr(_CSW+8)
MOVT	R1, #hi_addr(_CSW+8)
LDR	R0, [R1, #0]
SUBS	R0, #64
STR	R0, [R1, #0]
;memory.c,77 :: 		if (Transfer_Length == 0)
CMP	R2, #0
IT	NE
BNE	L_Read_Memory2
;memory.c,79 :: 		Block_Read_count = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Block_Read_count+0)
MOVT	R0, #hi_addr(_Block_Read_count+0)
STR	R1, [R0, #0]
;memory.c,80 :: 		Block_offset = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Block_offset+0)
MOVT	R0, #hi_addr(_Block_offset+0)
STR	R1, [R0, #0]
;memory.c,81 :: 		Memory_Offset = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Memory_Offset+0)
MOVT	R0, #hi_addr(_Memory_Offset+0)
STR	R1, [R0, #0]
;memory.c,82 :: 		Bot_State = BOT_DATA_IN_LAST;
MOVS	R1, #3
MOVW	R0, #lo_addr(_Bot_State+0)
MOVT	R0, #hi_addr(_Bot_State+0)
STRB	R1, [R0, #0]
;memory.c,83 :: 		}
L_Read_Memory2:
;memory.c,84 :: 		}
L_end_Read_Memory:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Read_Memory
_Write_Memory:
;memory.c,93 :: 		void Write_Memory(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;memory.c,95 :: 		u32 temp =  Counter + 64;
MOVW	R0, #lo_addr(_Counter+0)
MOVT	R0, #hi_addr(_Counter+0)
LDR	R0, [R0, #0]
ADDW	R4, R0, #64
; temp start address is: 16 (R4)
;memory.c,98 :: 		i = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
STR	R1, [R0, #0]
; temp end address is: 16 (R4)
;memory.c,99 :: 		for (; Counter < temp; Counter++)
L_Write_Memory3:
; temp start address is: 16 (R4)
MOVW	R0, #lo_addr(_Counter+0)
MOVT	R0, #hi_addr(_Counter+0)
LDR	R0, [R0, #0]
CMP	R0, R4
IT	CS
BCS	L_Write_Memory4
;memory.c,101 :: 		Data_Buffer[Counter] = Bulk_Data_Buff[i];
MOVW	R0, #lo_addr(_Counter+0)
MOVT	R0, #hi_addr(_Counter+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_Data_Buffer+0)
MOVT	R0, #hi_addr(_Data_Buffer+0)
ADDS	R3, R0, R1
MOVW	R2, #lo_addr(_i+0)
MOVT	R2, #hi_addr(_i+0)
LDR	R1, [R2, #0]
MOVW	R0, #lo_addr(_Bulk_Data_Buff+0)
MOVT	R0, #hi_addr(_Bulk_Data_Buff+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STRB	R0, [R3, #0]
;memory.c,102 :: 		i++;
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R0, R0, #1
STR	R0, [R2, #0]
;memory.c,99 :: 		for (; Counter < temp; Counter++)
MOVW	R0, #lo_addr(_Counter+0)
MOVT	R0, #hi_addr(_Counter+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(_Counter+0)
MOVT	R0, #hi_addr(_Counter+0)
STR	R1, [R0, #0]
;memory.c,103 :: 		}
; temp end address is: 16 (R4)
IT	AL
BAL	L_Write_Memory3
L_Write_Memory4:
;memory.c,105 :: 		Memory_Offset += Data_Len;
MOVW	R2, #lo_addr(_Data_Len+0)
MOVT	R2, #hi_addr(_Data_Len+0)
LDRB	R1, [R2, #0]
MOVW	R0, #lo_addr(_Memory_Offset+0)
MOVT	R0, #hi_addr(_Memory_Offset+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(_Memory_Offset+0)
MOVT	R0, #hi_addr(_Memory_Offset+0)
STR	R1, [R0, #0]
;memory.c,106 :: 		Transfer_Length -= Data_Len;
MOV	R0, R2
LDRB	R1, [R0, #0]
MOVW	R2, #lo_addr(_Transfer_Length+0)
MOVT	R2, #hi_addr(_Transfer_Length+0)
LDR	R0, [R2, #0]
SUB	R1, R0, R1
STR	R1, [R2, #0]
;memory.c,108 :: 		if (!(Transfer_Length % 512))
MOVW	R0, #511
AND	R0, R1, R0, LSL #0
CMP	R0, #0
IT	NE
BNE	L_Write_Memory6
;memory.c,110 :: 		Counter = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Counter+0)
MOVT	R0, #hi_addr(_Counter+0)
STR	R1, [R0, #0]
;memory.c,111 :: 		MSD_WriteBlock(Data_Buffer, Memory_Offset - 512, 512);
MOVW	R0, #lo_addr(_Memory_Offset+0)
MOVT	R0, #hi_addr(_Memory_Offset+0)
LDR	R0, [R0, #0]
SUB	R0, R0, #512
MOVS	R2, #0
MOV	R1, R0
MOVW	R0, #lo_addr(_Data_Buffer+0)
MOVT	R0, #hi_addr(_Data_Buffer+0)
BL	_MSD_WriteBlock+0
;memory.c,112 :: 		}
L_Write_Memory6:
;memory.c,114 :: 		CSW.dDataResidue -= Data_Len;
MOVW	R0, #lo_addr(_Data_Len+0)
MOVT	R0, #hi_addr(_Data_Len+0)
LDRB	R2, [R0, #0]
MOVW	R1, #lo_addr(_CSW+8)
MOVT	R1, #hi_addr(_CSW+8)
LDR	R0, [R1, #0]
SUB	R0, R0, R2
STR	R0, [R1, #0]
;memory.c,115 :: 		SetEPRxStatus(ENDP2, EP_RX_VALID); //enable the next transaction
MOVS	R1, #0
MOVS	R0, #2
BL	_SetEPRxStatus+0
;memory.c,117 :: 		if ((Transfer_Length == 0) || (Bot_State == BOT_CSW_Send))
MOVW	R0, #lo_addr(_Transfer_Length+0)
MOVT	R0, #hi_addr(_Transfer_Length+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L__Write_Memory17
MOVW	R0, #lo_addr(_Bot_State+0)
MOVT	R0, #hi_addr(_Bot_State+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	EQ
BEQ	L__Write_Memory16
IT	AL
BAL	L_Write_Memory9
L__Write_Memory17:
L__Write_Memory16:
;memory.c,119 :: 		Counter = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Counter+0)
MOVT	R0, #hi_addr(_Counter+0)
STR	R1, [R0, #0]
;memory.c,120 :: 		Set_CSW (CSW_CMD_PASSED, SEND_CSW_ENABLE);
MOVS	R1, #1
MOVS	R0, #0
BL	_Set_CSW+0
;memory.c,121 :: 		}
L_Write_Memory9:
;memory.c,122 :: 		}
L_end_Write_Memory:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Write_Memory
_Address_Management_Test:
;memory.c,131 :: 		int Address_Management_Test(u8 Cmd)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;memory.c,138 :: 		(CBW.CB[3] << 16) |
MOVW	R1, #lo_addr(_CBW+18)
MOVT	R1, #hi_addr(_CBW+18)
LDRB	R1, [R1, #0]
LSLS	R2, R1, #16
UXTH	R2, R2
;memory.c,139 :: 		(CBW.CB[4] <<  8) |
MOVW	R1, #lo_addr(_CBW+19)
MOVT	R1, #hi_addr(_CBW+19)
LDRB	R1, [R1, #0]
LSLS	R1, R1, #8
UXTH	R1, R1
ORRS	R2, R1
UXTH	R2, R2
;memory.c,140 :: 		(CBW.CB[5] <<  0);
MOVW	R1, #lo_addr(_CBW+20)
MOVT	R1, #hi_addr(_CBW+20)
LDRB	R1, [R1, #0]
ORR	R1, R2, R1, LSL #0
UXTH	R1, R1
; temp1 start address is: 16 (R4)
UXTH	R4, R1
;memory.c,142 :: 		temp2 = (CBW.CB[7] <<  8) |
MOVW	R1, #lo_addr(_CBW+22)
MOVT	R1, #hi_addr(_CBW+22)
LDRB	R1, [R1, #0]
LSLS	R2, R1, #8
UXTH	R2, R2
;memory.c,143 :: 		(CBW.CB[8] <<  0);
MOVW	R1, #lo_addr(_CBW+23)
MOVT	R1, #hi_addr(_CBW+23)
LDRB	R1, [R1, #0]
ORR	R1, R2, R1, LSL #0
UXTH	R1, R1
; temp2 start address is: 20 (R5)
UXTH	R5, R1
;memory.c,145 :: 		Memory_Offset = temp1 * Mass_Block_Size;
MOVW	R3, #lo_addr(_Mass_Block_Size+0)
MOVT	R3, #hi_addr(_Mass_Block_Size+0)
LDR	R1, [R3, #0]
MUL	R2, R4, R1
; temp1 end address is: 16 (R4)
MOVW	R1, #lo_addr(_Memory_Offset+0)
MOVT	R1, #hi_addr(_Memory_Offset+0)
STR	R2, [R1, #0]
;memory.c,146 :: 		Transfer_Length = temp2 * Mass_Block_Size;
MOV	R1, R3
LDR	R1, [R1, #0]
MUL	R2, R5, R1
; temp2 end address is: 20 (R5)
MOVW	R1, #lo_addr(_Transfer_Length+0)
MOVT	R1, #hi_addr(_Transfer_Length+0)
STR	R2, [R1, #0]
;memory.c,148 :: 		if ((Memory_Offset + Transfer_Length) > Mass_Memory_Size)
MOVW	R1, #lo_addr(_Memory_Offset+0)
MOVT	R1, #hi_addr(_Memory_Offset+0)
LDR	R1, [R1, #0]
ADDS	R2, R1, R2
MOVW	R1, #lo_addr(_Mass_Memory_Size+0)
MOVT	R1, #hi_addr(_Mass_Memory_Size+0)
LDR	R1, [R1, #0]
CMP	R2, R1
IT	LS
BLS	L_Address_Management_Test10
;memory.c,150 :: 		if (Cmd == SCSI_WRITE10)
CMP	R0, #42
IT	NE
BNE	L_Address_Management_Test11
;memory.c,152 :: 		Bot_Abort(BOTH_DIR);
MOVS	R0, #2
BL	_Bot_Abort+0
;memory.c,153 :: 		}
L_Address_Management_Test11:
;memory.c,154 :: 		Bot_Abort(DIR_IN);
MOVS	R0, #0
BL	_Bot_Abort+0
;memory.c,155 :: 		Set_Scsi_Sense_Data(ILLEGAL_REQUEST, ADDRESS_OUT_OF_RANGE);
MOVS	R1, #33
MOVS	R0, #5
BL	_Set_Scsi_Sense_Data+0
;memory.c,156 :: 		Set_CSW (CSW_CMD_FAILED, SEND_CSW_DISABLE);
MOVS	R1, #0
MOVS	R0, #1
BL	_Set_CSW+0
;memory.c,157 :: 		return (0);
MOVS	R0, #0
SXTH	R0, R0
IT	AL
BAL	L_end_Address_Management_Test
;memory.c,158 :: 		}
L_Address_Management_Test10:
;memory.c,161 :: 		if (CBW.dDataLength != Transfer_Length)
MOVW	R1, #lo_addr(_Transfer_Length+0)
MOVT	R1, #hi_addr(_Transfer_Length+0)
LDR	R2, [R1, #0]
MOVW	R1, #lo_addr(_CBW+8)
MOVT	R1, #hi_addr(_CBW+8)
LDR	R1, [R1, #0]
CMP	R1, R2
IT	EQ
BEQ	L_Address_Management_Test12
;memory.c,163 :: 		if (Cmd == SCSI_WRITE10)
CMP	R0, #42
IT	NE
BNE	L_Address_Management_Test13
;memory.c,165 :: 		Bot_Abort(BOTH_DIR);
MOVS	R0, #2
BL	_Bot_Abort+0
;memory.c,166 :: 		}
IT	AL
BAL	L_Address_Management_Test14
L_Address_Management_Test13:
;memory.c,169 :: 		Bot_Abort(DIR_IN);
MOVS	R0, #0
BL	_Bot_Abort+0
;memory.c,170 :: 		}
L_Address_Management_Test14:
;memory.c,171 :: 		Set_Scsi_Sense_Data(ILLEGAL_REQUEST, INVALID_FIELED_IN_COMMAND);
MOVS	R1, #36
MOVS	R0, #5
BL	_Set_Scsi_Sense_Data+0
;memory.c,172 :: 		Set_CSW (CSW_CMD_FAILED, SEND_CSW_DISABLE);
MOVS	R1, #0
MOVS	R0, #1
BL	_Set_CSW+0
;memory.c,173 :: 		return (0);
MOVS	R0, #0
SXTH	R0, R0
IT	AL
BAL	L_end_Address_Management_Test
;memory.c,174 :: 		}
L_Address_Management_Test12:
;memory.c,175 :: 		return (1);
MOVS	R0, #1
SXTH	R0, R0
;memory.c,176 :: 		}
L_end_Address_Management_Test:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Address_Management_Test
