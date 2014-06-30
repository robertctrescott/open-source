_USB_Istr:
;usb_istr.c,63 :: 		void USB_Istr(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;usb_istr.c,66 :: 		wIstr = _GetISTR();
MOVW	R0, 1073765444
MOVT	R0, 16384
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_wIstr+0)
MOVT	R0, #hi_addr(_wIstr+0)
STRB	R1, [R0, #0]
;usb_istr.c,69 :: 		if (wIstr & ISTR_RESET & wInterrupt_Mask)
MOVW	R0, #lo_addr(_wIstr+0)
MOVT	R0, #hi_addr(_wIstr+0)
LDRB	R0, [R0, #0]
AND	R5, R0, #1024
SXTH	R5, R5
MOVW	R4, #lo_addr(_wInterrupt_Mask+0)
MOVT	R4, #hi_addr(_wInterrupt_Mask+0)
LDRB	R4, [R4, #0]
AND	R4, R5, R4, LSL #0
SXTH	R4, R4
CMP	R4, #0
IT	EQ
BEQ	L_USB_Istr0
;usb_istr.c,71 :: 		_SetISTR((u16)CLR_RESET);
MOVS	R4, #255
MOVW	R0, 1073765444
MOVT	R0, 16384
STRH	R4, [R0, #0]
;usb_istr.c,72 :: 		Device_Property.Reset();
MOVW	R4, #lo_addr(_Device_Property+4)
MOVT	R4, #hi_addr(_Device_Property+4)
LDR	R4, [R4, #0]
BLX	R4
;usb_istr.c,76 :: 		}
L_USB_Istr0:
;usb_istr.c,158 :: 		if (wIstr & ISTR_CTR & wInterrupt_Mask)
MOVW	R0, #lo_addr(_wIstr+0)
MOVT	R0, #hi_addr(_wIstr+0)
LDRB	R0, [R0, #0]
AND	R1, R0, #32768
UXTH	R1, R1
MOVW	R0, #lo_addr(_wInterrupt_Mask+0)
MOVT	R0, #hi_addr(_wInterrupt_Mask+0)
LDRB	R0, [R0, #0]
AND	R0, R1, R0, LSL #0
UXTH	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_USB_Istr1
;usb_istr.c,162 :: 		CTR_LP();
BL	_CTR_LP+0
;usb_istr.c,166 :: 		}
L_USB_Istr1:
;usb_istr.c,168 :: 		} /* USB_Istr */
L_end_USB_Istr:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _USB_Istr
