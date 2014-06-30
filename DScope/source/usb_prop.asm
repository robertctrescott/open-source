_Mass_Storage_SetConfiguration:
;usb_prop.c,104 :: 		void Mass_Storage_SetConfiguration(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;usb_prop.c,106 :: 		if (pInformation->Current_Configuration)
MOVW	R0, #lo_addr(_pInformation+0)
MOVT	R0, #hi_addr(_pInformation+0)
LDR	R0, [R0, #0]
ADDS	R0, #10
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Mass_Storage_SetConfiguration0
;usb_prop.c,108 :: 		ClearDTOG_TX(ENDP1);
MOVS	R0, #1
BL	_ClearDTOG_TX+0
;usb_prop.c,109 :: 		ClearDTOG_RX(ENDP2);
MOVS	R0, #2
BL	_ClearDTOG_RX+0
;usb_prop.c,110 :: 		Bot_State = BOT_IDLE; /* set the Bot state machine to the IDLE state */
MOVS	R1, #0
MOVW	R0, #lo_addr(_Bot_State+0)
MOVT	R0, #hi_addr(_Bot_State+0)
STRB	R1, [R0, #0]
;usb_prop.c,111 :: 		}
L_Mass_Storage_SetConfiguration0:
;usb_prop.c,112 :: 		}
L_end_Mass_Storage_SetConfiguration:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Mass_Storage_SetConfiguration
_Mass_Storage_ClearFeature:
;usb_prop.c,121 :: 		void Mass_Storage_ClearFeature(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;usb_prop.c,125 :: 		if (CBW.dSignature != BOT_CBW_SIGNATURE)
MOVW	R0, #lo_addr(_CBW+0)
MOVT	R0, #hi_addr(_CBW+0)
LDR	R1, [R0, #0]
MOVW	R0, #21333
MOVT	R0, #17218
CMP	R1, R0
IT	EQ
BEQ	L_Mass_Storage_ClearFeature1
;usb_prop.c,126 :: 		Bot_Abort(BOTH_DIR);
MOVS	R0, #2
BL	_Bot_Abort+0
L_Mass_Storage_ClearFeature1:
;usb_prop.c,127 :: 		}
L_end_Mass_Storage_ClearFeature:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Mass_Storage_ClearFeature
_MASS_init:
;usb_prop.c,136 :: 		void MASS_init()
SUB	SP, SP, #8
STR	LR, [SP, #0]
;usb_prop.c,138 :: 		pInformation->Current_Configuration = 0;
MOVW	R2, #lo_addr(_pInformation+0)
MOVT	R2, #hi_addr(_pInformation+0)
LDR	R0, [R2, #0]
ADDW	R1, R0, #10
MOVS	R0, #0
STRB	R0, [R1, #0]
;usb_prop.c,145 :: 		_SetISTR(0);
MOVS	R1, #0
MOVW	R0, 1073765444
MOVT	R0, 16384
STRH	R1, [R0, #0]
;usb_prop.c,146 :: 		wInterrupt_Mask = IMR_MSK;
MOVS	R1, #0
MOVW	R0, #lo_addr(_wInterrupt_Mask+0)
MOVT	R0, #hi_addr(_wInterrupt_Mask+0)
STRB	R1, [R0, #0]
;usb_prop.c,148 :: 		_SetCNTR(IMR_MSK);
MOVS	R1, #0
MOVW	R0, 1073765440
MOVT	R0, 16384
STRH	R1, [R0, #0]
;usb_prop.c,150 :: 		pInformation->Current_Feature = MASS_ConfigDescriptor[7];
MOV	R0, R2
LDR	R0, [R0, #0]
ADDW	R1, R0, #9
MOVW	R0, #lo_addr(_MASS_ConfigDescriptor+0)
MOVT	R0, #hi_addr(_MASS_ConfigDescriptor+0)
ADDS	R0, R0, #7
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;usb_prop.c,158 :: 		for(tmp=0;tmp<100000;++tmp) NOP_Process();//CXG:加上这段取代上面的死循环 12/08
; tmp start address is: 4 (R1)
MOVS	R1, #0
SXTH	R1, R1
; tmp end address is: 4 (R1)
L_MASS_init2:
; tmp start address is: 4 (R1)
MOVW	R0, #34464
MOVT	R0, #1
CMP	R1, R0
IT	GE
BGE	L_MASS_init3
STRH	R1, [SP, #4]
BL	_NOP_Process+0
LDRSH	R1, [SP, #4]
ADDS	R1, R1, #1
SXTH	R1, R1
; tmp end address is: 4 (R1)
IT	AL
BAL	L_MASS_init2
L_MASS_init3:
;usb_prop.c,160 :: 		bDeviceState = CONFIGURED;
MOVS	R1, #5
MOVW	R0, #lo_addr(_bDeviceState+0)
MOVT	R0, #hi_addr(_bDeviceState+0)
STRB	R1, [R0, #0]
;usb_prop.c,161 :: 		}
L_end_MASS_init:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _MASS_init
_MASS_Reset:
;usb_prop.c,170 :: 		void MASS_Reset()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;usb_prop.c,173 :: 		Device_Info.Current_Configuration = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Device_Info+10)
MOVT	R0, #hi_addr(_Device_Info+10)
STRB	R1, [R0, #0]
;usb_prop.c,175 :: 		SetBTABLE(BTABLE_ADDRESS);
MOVS	R0, #0
BL	_SetBTABLE+0
;usb_prop.c,178 :: 		SetEPType(ENDP0, EP_CONTROL);
MOVS	R1, #0
MOVS	R0, #0
BL	_SetEPType+0
;usb_prop.c,179 :: 		SetEPTxStatus(ENDP0, EP_TX_NAK);
MOVS	R1, #32
MOVS	R0, #0
BL	_SetEPTxStatus+0
;usb_prop.c,180 :: 		SetEPRxAddr(ENDP0, ENDP0_RXADDR);
MOVS	R1, #24
MOVS	R0, #0
BL	_SetEPRxAddr+0
;usb_prop.c,181 :: 		SetEPRxCount(ENDP0, Device_Property.MaxPacketSize);
MOVW	R0, #lo_addr(_Device_Property+44)
MOVT	R0, #hi_addr(_Device_Property+44)
LDRB	R0, [R0, #0]
UXTB	R1, R0
MOVS	R0, #0
BL	_SetEPRxCount+0
;usb_prop.c,182 :: 		SetEPTxAddr(ENDP0, ENDP0_TXADDR);
MOVS	R1, #88
MOVS	R0, #0
BL	_SetEPTxAddr+0
;usb_prop.c,183 :: 		Clear_Status_Out(ENDP0);
MOVS	R0, #0
BL	_Clear_Status_Out+0
;usb_prop.c,184 :: 		SetEPRxValid(ENDP0);
MOVS	R0, #0
BL	_SetEPRxValid+0
;usb_prop.c,187 :: 		SetEPType(ENDP1, EP_BULK);
MOVS	R1, #0
MOVS	R0, #1
BL	_SetEPType+0
;usb_prop.c,188 :: 		SetEPTxAddr(ENDP1, ENDP1_TXADDR);
MOVS	R1, #152
MOVS	R0, #1
BL	_SetEPTxAddr+0
;usb_prop.c,189 :: 		SetEPTxStatus(ENDP1, EP_TX_NAK);
MOVS	R1, #32
MOVS	R0, #1
BL	_SetEPTxStatus+0
;usb_prop.c,190 :: 		SetEPRxStatus(ENDP1, EP_RX_DIS);
MOVS	R1, #0
MOVS	R0, #1
BL	_SetEPRxStatus+0
;usb_prop.c,193 :: 		SetEPType(ENDP2, EP_BULK);
MOVS	R1, #0
MOVS	R0, #2
BL	_SetEPType+0
;usb_prop.c,194 :: 		SetEPRxAddr(ENDP2, ENDP2_RXADDR);
MOVS	R1, #216
MOVS	R0, #2
BL	_SetEPRxAddr+0
;usb_prop.c,195 :: 		SetEPRxCount(ENDP2, Device_Property.MaxPacketSize);
MOVW	R0, #lo_addr(_Device_Property+44)
MOVT	R0, #hi_addr(_Device_Property+44)
LDRB	R0, [R0, #0]
UXTB	R1, R0
MOVS	R0, #2
BL	_SetEPRxCount+0
;usb_prop.c,196 :: 		SetEPRxStatus(ENDP2, EP_RX_VALID);
MOVS	R1, #0
MOVS	R0, #2
BL	_SetEPRxStatus+0
;usb_prop.c,197 :: 		SetEPTxStatus(ENDP2, EP_TX_DIS);
MOVS	R1, #0
MOVS	R0, #2
BL	_SetEPTxStatus+0
;usb_prop.c,200 :: 		SetEPRxCount(ENDP0, Device_Property.MaxPacketSize);
MOVW	R0, #lo_addr(_Device_Property+44)
MOVT	R0, #hi_addr(_Device_Property+44)
LDRB	R0, [R0, #0]
UXTB	R1, R0
MOVS	R0, #0
BL	_SetEPRxCount+0
;usb_prop.c,201 :: 		SetEPRxValid(ENDP0);
MOVS	R0, #0
BL	_SetEPRxValid+0
;usb_prop.c,204 :: 		SetDeviceAddress(0);
MOVS	R0, #0
BL	_SetDeviceAddress+0
;usb_prop.c,205 :: 		CBW.dSignature = BOT_CBW_SIGNATURE;
MOVW	R1, #21333
MOVT	R1, #17218
MOVW	R0, #lo_addr(_CBW+0)
MOVT	R0, #hi_addr(_CBW+0)
STR	R1, [R0, #0]
;usb_prop.c,206 :: 		Bot_State = BOT_IDLE;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Bot_State+0)
MOVT	R0, #hi_addr(_Bot_State+0)
STRB	R1, [R0, #0]
;usb_prop.c,207 :: 		}
L_end_MASS_Reset:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _MASS_Reset
_MASS_Status_In:
;usb_prop.c,216 :: 		void MASS_Status_In(void)
SUB	SP, SP, #4
;usb_prop.c,218 :: 		return;
;usb_prop.c,219 :: 		}
L_end_MASS_Status_In:
ADD	SP, SP, #4
BX	LR
; end of _MASS_Status_In
_MASS_Status_Out:
;usb_prop.c,228 :: 		void MASS_Status_Out(void)
SUB	SP, SP, #4
;usb_prop.c,230 :: 		return;
;usb_prop.c,231 :: 		}
L_end_MASS_Status_Out:
ADD	SP, SP, #4
BX	LR
; end of _MASS_Status_Out
_MASS_Data_Setup:
;usb_prop.c,240 :: 		RESULT MASS_Data_Setup(u8 RequestNo)
SUB	SP, SP, #8
STR	LR, [SP, #0]
;usb_prop.c,245 :: 		if ((Type_Recipient == (CLASS_REQUEST | INTERFACE_RECIPIENT))
MOVW	R1, #lo_addr(_pInformation+0)
MOVT	R1, #hi_addr(_pInformation+0)
LDR	R1, [R1, #0]
LDRB	R1, [R1, #0]
AND	R1, R1, #127
UXTB	R1, R1
;usb_prop.c,246 :: 		&& (RequestNo == GET_MAX_LUN) && (pInformation->USBwValue == 0)
CMP	R1, #33
IT	NE
BNE	L__MASS_Data_Setup23
CMP	R0, #254
IT	NE
BNE	L__MASS_Data_Setup22
MOVW	R1, #lo_addr(_pInformation+0)
MOVT	R1, #hi_addr(_pInformation+0)
LDR	R1, [R1, #0]
ADDS	R1, R1, #2
LDRB	R1, [R1, #0]
CMP	R1, #0
IT	NE
BNE	L__MASS_Data_Setup21
;usb_prop.c,247 :: 		&& (pInformation->USBwIndex == 0) && (pInformation->USBwLength == 0x01))
MOVW	R1, #lo_addr(_pInformation+0)
MOVT	R1, #hi_addr(_pInformation+0)
LDR	R1, [R1, #0]
ADDS	R1, R1, #4
LDRB	R1, [R1, #0]
CMP	R1, #0
IT	NE
BNE	L__MASS_Data_Setup20
MOVW	R1, #lo_addr(_pInformation+0)
MOVT	R1, #hi_addr(_pInformation+0)
LDR	R1, [R1, #0]
ADDS	R1, R1, #6
LDRB	R1, [R1, #0]
CMP	R1, #1
IT	NE
BNE	L__MASS_Data_Setup19
L__MASS_Data_Setup18:
;usb_prop.c,249 :: 		CopyRoutine = Get_Max_Lun;
MOVW	R0, #lo_addr(_Get_Max_Lun+0)
MOVT	R0, #hi_addr(_Get_Max_Lun+0)
;usb_prop.c,250 :: 		}
IT	AL
BAL	L_MASS_Data_Setup8
;usb_prop.c,246 :: 		&& (RequestNo == GET_MAX_LUN) && (pInformation->USBwValue == 0)
L__MASS_Data_Setup23:
L__MASS_Data_Setup22:
L__MASS_Data_Setup21:
;usb_prop.c,247 :: 		&& (pInformation->USBwIndex == 0) && (pInformation->USBwLength == 0x01))
L__MASS_Data_Setup20:
L__MASS_Data_Setup19:
;usb_prop.c,253 :: 		return USB_UNSUPPORT;
MOVS	R0, #2
IT	AL
BAL	L_end_MASS_Data_Setup
;usb_prop.c,254 :: 		}
L_MASS_Data_Setup8:
;usb_prop.c,256 :: 		if (CopyRoutine == NULL)
CMP	R0, #0
IT	NE
BNE	L_MASS_Data_Setup9
;usb_prop.c,258 :: 		return USB_UNSUPPORT;
MOVS	R0, #2
IT	AL
BAL	L_end_MASS_Data_Setup
;usb_prop.c,259 :: 		}
L_MASS_Data_Setup9:
;usb_prop.c,261 :: 		pInformation->Ctrl_Info.CopyData = CopyRoutine;
MOVW	R2, #lo_addr(_pInformation+0)
MOVT	R2, #hi_addr(_pInformation+0)
LDR	R1, [R2, #0]
ADDS	R1, #16
ADDS	R1, R1, #4
STR	R0, [R1, #0]
;usb_prop.c,262 :: 		pInformation->Ctrl_Info.Usb_wOffset = 0;
MOV	R1, R2
LDR	R1, [R1, #0]
ADDS	R1, #16
ADDS	R2, R1, #1
MOVS	R1, #0
STRB	R1, [R2, #0]
;usb_prop.c,263 :: 		(*CopyRoutine)(0);
STR	R0, [SP, #4]
MOVS	R0, #0
LDR	R12, [SP, #4]
BLX	R12
;usb_prop.c,265 :: 		return USB_SUCCESS;
MOVS	R0, #0
;usb_prop.c,267 :: 		}
L_end_MASS_Data_Setup:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _MASS_Data_Setup
_MASS_NoData_Setup:
;usb_prop.c,276 :: 		RESULT MASS_NoData_Setup(u8 RequestNo)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;usb_prop.c,278 :: 		if ((Type_Recipient == (CLASS_REQUEST | INTERFACE_RECIPIENT))
MOVW	R1, #lo_addr(_pInformation+0)
MOVT	R1, #hi_addr(_pInformation+0)
LDR	R1, [R1, #0]
LDRB	R1, [R1, #0]
AND	R1, R1, #127
UXTB	R1, R1
;usb_prop.c,279 :: 		&& (RequestNo == MASS_STORAGE_RESET) && (pInformation->USBwValue == 0)
CMP	R1, #33
IT	NE
BNE	L__MASS_NoData_Setup29
CMP	R0, #255
IT	NE
BNE	L__MASS_NoData_Setup28
MOVW	R1, #lo_addr(_pInformation+0)
MOVT	R1, #hi_addr(_pInformation+0)
LDR	R1, [R1, #0]
ADDS	R1, R1, #2
LDRB	R1, [R1, #0]
CMP	R1, #0
IT	NE
BNE	L__MASS_NoData_Setup27
;usb_prop.c,280 :: 		&& (pInformation->USBwIndex == 0) && (pInformation->USBwLength == 0x00))
MOVW	R1, #lo_addr(_pInformation+0)
MOVT	R1, #hi_addr(_pInformation+0)
LDR	R1, [R1, #0]
ADDS	R1, R1, #4
LDRB	R1, [R1, #0]
CMP	R1, #0
IT	NE
BNE	L__MASS_NoData_Setup26
MOVW	R1, #lo_addr(_pInformation+0)
MOVT	R1, #hi_addr(_pInformation+0)
LDR	R1, [R1, #0]
ADDS	R1, R1, #6
LDRB	R1, [R1, #0]
CMP	R1, #0
IT	NE
BNE	L__MASS_NoData_Setup25
L__MASS_NoData_Setup24:
;usb_prop.c,283 :: 		ClearDTOG_TX(ENDP1);
MOVS	R0, #1
BL	_ClearDTOG_TX+0
;usb_prop.c,286 :: 		ClearDTOG_RX(ENDP2);
MOVS	R0, #2
BL	_ClearDTOG_RX+0
;usb_prop.c,289 :: 		CBW.dSignature = BOT_CBW_SIGNATURE;
MOVW	R2, #21333
MOVT	R2, #17218
MOVW	R1, #lo_addr(_CBW+0)
MOVT	R1, #hi_addr(_CBW+0)
STR	R2, [R1, #0]
;usb_prop.c,290 :: 		Bot_State = BOT_IDLE;
MOVS	R2, #0
MOVW	R1, #lo_addr(_Bot_State+0)
MOVT	R1, #hi_addr(_Bot_State+0)
STRB	R2, [R1, #0]
;usb_prop.c,292 :: 		return USB_SUCCESS;
MOVS	R0, #0
IT	AL
BAL	L_end_MASS_NoData_Setup
;usb_prop.c,279 :: 		&& (RequestNo == MASS_STORAGE_RESET) && (pInformation->USBwValue == 0)
L__MASS_NoData_Setup29:
L__MASS_NoData_Setup28:
L__MASS_NoData_Setup27:
;usb_prop.c,280 :: 		&& (pInformation->USBwIndex == 0) && (pInformation->USBwLength == 0x00))
L__MASS_NoData_Setup26:
L__MASS_NoData_Setup25:
;usb_prop.c,294 :: 		return USB_UNSUPPORT;
MOVS	R0, #2
;usb_prop.c,295 :: 		}
L_end_MASS_NoData_Setup:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _MASS_NoData_Setup
_MASS_Get_Interface_Setting:
;usb_prop.c,305 :: 		RESULT MASS_Get_Interface_Setting(u8 Interface, u8 AlternateSetting)
; AlternateSetting start address is: 4 (R1)
SUB	SP, SP, #4
; AlternateSetting end address is: 4 (R1)
; AlternateSetting start address is: 4 (R1)
;usb_prop.c,307 :: 		if (AlternateSetting > 0)
CMP	R1, #0
IT	LS
BLS	L_MASS_Get_Interface_Setting13
; AlternateSetting end address is: 4 (R1)
;usb_prop.c,309 :: 		return USB_UNSUPPORT;/* in this application we don't have AlternateSetting*/
MOVS	R0, #2
IT	AL
BAL	L_end_MASS_Get_Interface_Setting
;usb_prop.c,310 :: 		}
L_MASS_Get_Interface_Setting13:
;usb_prop.c,311 :: 		else if (Interface > 0)
CMP	R0, #0
IT	LS
BLS	L_MASS_Get_Interface_Setting15
;usb_prop.c,313 :: 		return USB_UNSUPPORT;/*in this application we have only 1 interfaces*/
MOVS	R0, #2
IT	AL
BAL	L_end_MASS_Get_Interface_Setting
;usb_prop.c,314 :: 		}
L_MASS_Get_Interface_Setting15:
;usb_prop.c,315 :: 		return USB_SUCCESS;
MOVS	R0, #0
;usb_prop.c,316 :: 		}
L_end_MASS_Get_Interface_Setting:
ADD	SP, SP, #4
BX	LR
; end of _MASS_Get_Interface_Setting
_MASS_GetDeviceDescriptor:
;usb_prop.c,325 :: 		u8 *MASS_GetDeviceDescriptor(u16 Length)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;usb_prop.c,327 :: 		return Standard_GetDescriptorData(Length, &Device_Descriptor );
MOVW	R1, #lo_addr(_Device_Descriptor+0)
MOVT	R1, #hi_addr(_Device_Descriptor+0)
BL	_Standard_GetDescriptorData+0
;usb_prop.c,328 :: 		}
L_end_MASS_GetDeviceDescriptor:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _MASS_GetDeviceDescriptor
_MASS_GetConfigDescriptor:
;usb_prop.c,337 :: 		u8 *MASS_GetConfigDescriptor(u16 Length)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;usb_prop.c,339 :: 		return Standard_GetDescriptorData(Length, &Config_Descriptor );
MOVW	R1, #lo_addr(_Config_Descriptor+0)
MOVT	R1, #hi_addr(_Config_Descriptor+0)
BL	_Standard_GetDescriptorData+0
;usb_prop.c,340 :: 		}
L_end_MASS_GetConfigDescriptor:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _MASS_GetConfigDescriptor
_MASS_GetStringDescriptor:
;usb_prop.c,349 :: 		u8 *MASS_GetStringDescriptor(u16 Length)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;usb_prop.c,351 :: 		u8 wValue0 = pInformation->USBwValue0;
MOVW	R1, #lo_addr(_pInformation+0)
MOVT	R1, #hi_addr(_pInformation+0)
LDR	R1, [R1, #0]
ADDS	R1, R1, #2
ADDS	R1, R1, #1
LDRB	R1, [R1, #0]
;usb_prop.c,352 :: 		return Standard_GetDescriptorData( Length, &String_Descriptor[wValue0] );
LSLS	R2, R1, #3
MOVW	R1, #lo_addr(_String_Descriptor+0)
MOVT	R1, #hi_addr(_String_Descriptor+0)
ADDS	R1, R1, R2
BL	_Standard_GetDescriptorData+0
;usb_prop.c,353 :: 		}
L_end_MASS_GetStringDescriptor:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _MASS_GetStringDescriptor
_Get_Max_Lun:
;usb_prop.c,362 :: 		u8 *Get_Max_Lun(u16 Length)
SUB	SP, SP, #4
;usb_prop.c,364 :: 		if (Length == 0)
CMP	R0, #0
IT	NE
BNE	L_Get_Max_Lun16
;usb_prop.c,366 :: 		pInformation->Ctrl_Info.Usb_wLength = LUN_DATA_LENGTH;
MOVW	R1, #lo_addr(_pInformation+0)
MOVT	R1, #hi_addr(_pInformation+0)
LDR	R1, [R1, #0]
ADDW	R2, R1, #16
MOVS	R1, #1
STRB	R1, [R2, #0]
;usb_prop.c,367 :: 		return 0;
MOVS	R0, #0
IT	AL
BAL	L_end_Get_Max_Lun
;usb_prop.c,368 :: 		}
L_Get_Max_Lun16:
;usb_prop.c,371 :: 		return((u8*)(&Max_Lun));
MOVW	R0, #lo_addr(_Max_Lun+0)
MOVT	R0, #hi_addr(_Max_Lun+0)
;usb_prop.c,373 :: 		}
L_end_Get_Max_Lun:
ADD	SP, SP, #4
BX	LR
; end of _Get_Max_Lun
usb_prop____?ag:
SUB	SP, SP, #4
L_end_usb_prop___?ag:
ADD	SP, SP, #4
BX	LR
; end of usb_prop____?ag
