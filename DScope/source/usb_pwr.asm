_Suspend:
;usb_pwr.c,39 :: 		void Suspend(void)
SUB	SP, SP, #4
;usb_pwr.c,46 :: 		wCNTR = _GetCNTR();
MOVW	R0, 1073765440
MOVT	R0, 16384
LDRH	R0, [R0, #0]
;usb_pwr.c,47 :: 		wCNTR |= CNTR_FSUSP;
ORR	R1, R0, #8
UXTB	R1, R1
;usb_pwr.c,48 :: 		_SetCNTR(wCNTR);
MOVW	R0, 1073765440
MOVT	R0, 16384
STRH	R1, [R0, #0]
;usb_pwr.c,56 :: 		wCNTR = _GetCNTR();
MOVW	R0, 1073765440
MOVT	R0, 16384
LDRH	R0, [R0, #0]
;usb_pwr.c,57 :: 		wCNTR |= CNTR_LPMODE;
ORR	R1, R0, #4
UXTB	R1, R1
;usb_pwr.c,58 :: 		_SetCNTR(wCNTR);
MOVW	R0, 1073765440
MOVT	R0, 16384
STRH	R1, [R0, #0]
;usb_pwr.c,64 :: 		}
L_end_Suspend:
ADD	SP, SP, #4
BX	LR
; end of _Suspend
_Resume_Init:
;usb_pwr.c,73 :: 		void Resume_Init(void)
SUB	SP, SP, #4
;usb_pwr.c,81 :: 		wCNTR = _GetCNTR();
MOVW	R0, 1073765440
MOVT	R0, 16384
LDRH	R1, [R0, #0]
;usb_pwr.c,82 :: 		wCNTR &= (~CNTR_LPMODE);
MOVW	R0, #65531
SXTH	R0, R0
AND	R0, R1, R0, LSL #0
;usb_pwr.c,83 :: 		_SetCNTR(wCNTR);
UXTB	R1, R0
MOVW	R0, 1073765440
MOVT	R0, 16384
STRH	R1, [R0, #0]
;usb_pwr.c,90 :: 		_SetCNTR(IMR_MSK);
MOVS	R1, #0
MOVW	R0, 1073765440
MOVT	R0, 16384
STRH	R1, [R0, #0]
;usb_pwr.c,95 :: 		}
L_end_Resume_Init:
ADD	SP, SP, #4
BX	LR
; end of _Resume_Init
_Resume:
;usb_pwr.c,109 :: 		void Resume(RESUME_STATE eResumeSetVal)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;usb_pwr.c,113 :: 		if (eResumeSetVal != RESUME_ESOF)
CMP	R0, #7
IT	EQ
BEQ	L_Resume0
;usb_pwr.c,114 :: 		ResumeS.eState = eResumeSetVal;
MOVW	R1, #lo_addr(_ResumeS+0)
MOVT	R1, #hi_addr(_ResumeS+0)
STRB	R0, [R1, #0]
L_Resume0:
;usb_pwr.c,116 :: 		switch (ResumeS.eState)
IT	AL
BAL	L_Resume1
;usb_pwr.c,118 :: 		case RESUME_EXTERNAL:
L_Resume3:
;usb_pwr.c,119 :: 		Resume_Init();
BL	_Resume_Init+0
;usb_pwr.c,120 :: 		ResumeS.eState = RESUME_OFF;
MOVS	R2, #6
MOVW	R1, #lo_addr(_ResumeS+0)
MOVT	R1, #hi_addr(_ResumeS+0)
STRB	R2, [R1, #0]
;usb_pwr.c,121 :: 		break;
IT	AL
BAL	L_Resume2
;usb_pwr.c,122 :: 		case RESUME_INTERNAL:
L_Resume4:
;usb_pwr.c,123 :: 		Resume_Init();
BL	_Resume_Init+0
;usb_pwr.c,124 :: 		ResumeS.eState = RESUME_START;
MOVS	R2, #4
MOVW	R1, #lo_addr(_ResumeS+0)
MOVT	R1, #hi_addr(_ResumeS+0)
STRB	R2, [R1, #0]
;usb_pwr.c,125 :: 		break;
IT	AL
BAL	L_Resume2
;usb_pwr.c,126 :: 		case RESUME_LATER:
L_Resume5:
;usb_pwr.c,127 :: 		ResumeS.bESOFcnt = 2;
MOVS	R2, #2
MOVW	R1, #lo_addr(_ResumeS+1)
MOVT	R1, #hi_addr(_ResumeS+1)
STRB	R2, [R1, #0]
;usb_pwr.c,128 :: 		ResumeS.eState = RESUME_WAIT;
MOVS	R2, #3
MOVW	R1, #lo_addr(_ResumeS+0)
MOVT	R1, #hi_addr(_ResumeS+0)
STRB	R2, [R1, #0]
;usb_pwr.c,129 :: 		break;
IT	AL
BAL	L_Resume2
;usb_pwr.c,130 :: 		case RESUME_WAIT:
L_Resume6:
;usb_pwr.c,131 :: 		ResumeS.bESOFcnt--;
MOVW	R2, #lo_addr(_ResumeS+1)
MOVT	R2, #hi_addr(_ResumeS+1)
LDRB	R1, [R2, #0]
SUBS	R1, R1, #1
UXTB	R1, R1
STRB	R1, [R2, #0]
;usb_pwr.c,132 :: 		if (ResumeS.bESOFcnt == 0)
CMP	R1, #0
IT	NE
BNE	L_Resume7
;usb_pwr.c,133 :: 		ResumeS.eState = RESUME_START;
MOVS	R2, #4
MOVW	R1, #lo_addr(_ResumeS+0)
MOVT	R1, #hi_addr(_ResumeS+0)
STRB	R2, [R1, #0]
L_Resume7:
;usb_pwr.c,134 :: 		break;
IT	AL
BAL	L_Resume2
;usb_pwr.c,135 :: 		case RESUME_START:
L_Resume8:
;usb_pwr.c,136 :: 		wCNTR = _GetCNTR();
MOVW	R1, 1073765440
MOVT	R1, 16384
LDRH	R1, [R1, #0]
;usb_pwr.c,137 :: 		wCNTR |= CNTR_RESUME;
ORR	R2, R1, #16
UXTB	R2, R2
;usb_pwr.c,138 :: 		_SetCNTR(wCNTR);
MOVW	R1, 1073765440
MOVT	R1, 16384
STRH	R2, [R1, #0]
;usb_pwr.c,139 :: 		ResumeS.eState = RESUME_ON;
MOVS	R2, #5
MOVW	R1, #lo_addr(_ResumeS+0)
MOVT	R1, #hi_addr(_ResumeS+0)
STRB	R2, [R1, #0]
;usb_pwr.c,140 :: 		ResumeS.bESOFcnt = 10;
MOVS	R2, #10
MOVW	R1, #lo_addr(_ResumeS+1)
MOVT	R1, #hi_addr(_ResumeS+1)
STRB	R2, [R1, #0]
;usb_pwr.c,141 :: 		break;
IT	AL
BAL	L_Resume2
;usb_pwr.c,142 :: 		case RESUME_ON:
L_Resume9:
;usb_pwr.c,143 :: 		ResumeS.bESOFcnt--;
MOVW	R2, #lo_addr(_ResumeS+1)
MOVT	R2, #hi_addr(_ResumeS+1)
LDRB	R1, [R2, #0]
SUBS	R1, R1, #1
UXTB	R1, R1
STRB	R1, [R2, #0]
;usb_pwr.c,144 :: 		if (ResumeS.bESOFcnt == 0)
CMP	R1, #0
IT	NE
BNE	L_Resume10
;usb_pwr.c,146 :: 		wCNTR = _GetCNTR();
MOVW	R1, 1073765440
MOVT	R1, 16384
LDRH	R2, [R1, #0]
;usb_pwr.c,147 :: 		wCNTR &= (~CNTR_RESUME);
MOVW	R1, #65519
SXTH	R1, R1
AND	R1, R2, R1, LSL #0
;usb_pwr.c,148 :: 		_SetCNTR(wCNTR);
UXTB	R2, R1
MOVW	R1, 1073765440
MOVT	R1, 16384
STRH	R2, [R1, #0]
;usb_pwr.c,149 :: 		ResumeS.eState = RESUME_OFF;
MOVS	R2, #6
MOVW	R1, #lo_addr(_ResumeS+0)
MOVT	R1, #hi_addr(_ResumeS+0)
STRB	R2, [R1, #0]
;usb_pwr.c,150 :: 		}
L_Resume10:
;usb_pwr.c,151 :: 		break;
IT	AL
BAL	L_Resume2
;usb_pwr.c,152 :: 		case RESUME_OFF:
L_Resume11:
;usb_pwr.c,153 :: 		case RESUME_ESOF:
L_Resume12:
;usb_pwr.c,154 :: 		default:
L_Resume13:
;usb_pwr.c,155 :: 		ResumeS.eState = RESUME_OFF;
MOVS	R2, #6
MOVW	R1, #lo_addr(_ResumeS+0)
MOVT	R1, #hi_addr(_ResumeS+0)
STRB	R2, [R1, #0]
;usb_pwr.c,156 :: 		break;
IT	AL
BAL	L_Resume2
;usb_pwr.c,157 :: 		}
L_Resume1:
MOVW	R1, #lo_addr(_ResumeS+0)
MOVT	R1, #hi_addr(_ResumeS+0)
LDRB	R1, [R1, #0]
CMP	R1, #0
IT	EQ
BEQ	L_Resume3
MOVW	R1, #lo_addr(_ResumeS+0)
MOVT	R1, #hi_addr(_ResumeS+0)
LDRB	R1, [R1, #0]
CMP	R1, #1
IT	EQ
BEQ	L_Resume4
MOVW	R1, #lo_addr(_ResumeS+0)
MOVT	R1, #hi_addr(_ResumeS+0)
LDRB	R1, [R1, #0]
CMP	R1, #2
IT	EQ
BEQ	L_Resume5
MOVW	R1, #lo_addr(_ResumeS+0)
MOVT	R1, #hi_addr(_ResumeS+0)
LDRB	R1, [R1, #0]
CMP	R1, #3
IT	EQ
BEQ	L_Resume6
MOVW	R1, #lo_addr(_ResumeS+0)
MOVT	R1, #hi_addr(_ResumeS+0)
LDRB	R1, [R1, #0]
CMP	R1, #4
IT	EQ
BEQ	L_Resume8
MOVW	R1, #lo_addr(_ResumeS+0)
MOVT	R1, #hi_addr(_ResumeS+0)
LDRB	R1, [R1, #0]
CMP	R1, #5
IT	EQ
BEQ	L_Resume9
MOVW	R1, #lo_addr(_ResumeS+0)
MOVT	R1, #hi_addr(_ResumeS+0)
LDRB	R1, [R1, #0]
CMP	R1, #6
IT	EQ
BEQ	L_Resume11
MOVW	R1, #lo_addr(_ResumeS+0)
MOVT	R1, #hi_addr(_ResumeS+0)
LDRB	R1, [R1, #0]
CMP	R1, #7
IT	EQ
BEQ	L_Resume12
IT	AL
BAL	L_Resume13
L_Resume2:
;usb_pwr.c,158 :: 		}
L_end_Resume:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Resume
