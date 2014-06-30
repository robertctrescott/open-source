_EP1_IN_Callback:
;usb_endp.c,35 :: 		void EP1_IN_Callback(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;usb_endp.c,37 :: 		Mass_Storage_In();
BL	_Mass_Storage_In+0
;usb_endp.c,38 :: 		}
L_end_EP1_IN_Callback:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _EP1_IN_Callback
_EP2_OUT_Callback:
;usb_endp.c,47 :: 		void EP2_OUT_Callback(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;usb_endp.c,49 :: 		Mass_Storage_Out();
BL	_Mass_Storage_Out+0
;usb_endp.c,50 :: 		}
L_end_EP2_OUT_Callback:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _EP2_OUT_Callback
