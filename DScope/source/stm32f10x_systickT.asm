_SysTick_CLKSourceConfig:
;stm32f10x_systickT.c,44 :: 		void SysTick_CLKSourceConfig(u32 SysTick_CLKSource)
SUB	SP, SP, #4
;stm32f10x_systickT.c,49 :: 		if (SysTick_CLKSource == SysTick_CLKSource_HCLK)
CMP	R0, #4
IT	NE
BNE	L_SysTick_CLKSourceConfig0
;stm32f10x_systickT.c,51 :: 		SysTick->CTRL |= SysTick_CLKSource_HCLK;
MOVW	R2, #57360
MOVT	R2, #57344
LDR	R1, [R2, #0]
ORR	R1, R1, #4
STR	R1, [R2, #0]
;stm32f10x_systickT.c,52 :: 		}
IT	AL
BAL	L_SysTick_CLKSourceConfig1
L_SysTick_CLKSourceConfig0:
;stm32f10x_systickT.c,55 :: 		SysTick->CTRL &= SysTick_CLKSource_HCLK_Div8;
MOVW	R3, #57360
MOVT	R3, #57344
LDR	R2, [R3, #0]
MVN	R1, #4
AND	R1, R2, R1, LSL #0
STR	R1, [R3, #0]
;stm32f10x_systickT.c,56 :: 		}
L_SysTick_CLKSourceConfig1:
;stm32f10x_systickT.c,57 :: 		}
L_end_SysTick_CLKSourceConfig:
ADD	SP, SP, #4
BX	LR
; end of _SysTick_CLKSourceConfig
_SysTick_SetReload:
;stm32f10x_systickT.c,67 :: 		void SysTick_SetReload(u32 Reload)
SUB	SP, SP, #4
;stm32f10x_systickT.c,72 :: 		SysTick->LOAD = Reload;
MOVW	R1, #57364
MOVT	R1, #57344
STR	R0, [R1, #0]
;stm32f10x_systickT.c,73 :: 		}
L_end_SysTick_SetReload:
ADD	SP, SP, #4
BX	LR
; end of _SysTick_SetReload
_SysTick_CounterCmd:
;stm32f10x_systickT.c,86 :: 		void SysTick_CounterCmd(u32 SysTick_Counter)
SUB	SP, SP, #4
;stm32f10x_systickT.c,91 :: 		if (SysTick_Counter == SysTick_Counter_Enable)
CMP	R0, #1
IT	NE
BNE	L_SysTick_CounterCmd2
;stm32f10x_systickT.c,93 :: 		SysTick->CTRL |= SysTick_Counter_Enable;
MOVW	R2, #57360
MOVT	R2, #57344
LDR	R1, [R2, #0]
ORR	R1, R1, #1
STR	R1, [R2, #0]
;stm32f10x_systickT.c,94 :: 		}
IT	AL
BAL	L_SysTick_CounterCmd3
L_SysTick_CounterCmd2:
;stm32f10x_systickT.c,95 :: 		else if (SysTick_Counter == SysTick_Counter_Disable)
MVN	R1, #1
CMP	R0, R1
IT	NE
BNE	L_SysTick_CounterCmd4
;stm32f10x_systickT.c,97 :: 		SysTick->CTRL &= SysTick_Counter_Disable;
MOVW	R3, #57360
MOVT	R3, #57344
LDR	R2, [R3, #0]
MVN	R1, #1
AND	R1, R2, R1, LSL #0
STR	R1, [R3, #0]
;stm32f10x_systickT.c,98 :: 		}
IT	AL
BAL	L_SysTick_CounterCmd5
L_SysTick_CounterCmd4:
;stm32f10x_systickT.c,101 :: 		SysTick->VAL = SysTick_Counter_Clear;
MOV	R2, #0
MOVW	R1, #57368
MOVT	R1, #57344
STR	R2, [R1, #0]
;stm32f10x_systickT.c,102 :: 		}
L_SysTick_CounterCmd5:
L_SysTick_CounterCmd3:
;stm32f10x_systickT.c,103 :: 		}
L_end_SysTick_CounterCmd:
ADD	SP, SP, #4
BX	LR
; end of _SysTick_CounterCmd
_SysTick_ITConfig:
;stm32f10x_systickT.c,113 :: 		void SysTick_ITConfig(FunctionalState NewState)
SUB	SP, SP, #4
;stm32f10x_systickT.c,118 :: 		if (NewState != DISABLE)
CMP	R0, #0
IT	EQ
BEQ	L_SysTick_ITConfig6
;stm32f10x_systickT.c,120 :: 		SysTick->CTRL |= CTRL_TICKINT_Set;
MOVW	R2, #57360
MOVT	R2, #57344
LDR	R1, [R2, #0]
ORR	R1, R1, #2
STR	R1, [R2, #0]
;stm32f10x_systickT.c,121 :: 		}
IT	AL
BAL	L_SysTick_ITConfig7
L_SysTick_ITConfig6:
;stm32f10x_systickT.c,124 :: 		SysTick->CTRL &= CTRL_TICKINT_Reset;
MOVW	R3, #57360
MOVT	R3, #57344
LDR	R2, [R3, #0]
MVN	R1, #2
AND	R1, R2, R1, LSL #0
STR	R1, [R3, #0]
;stm32f10x_systickT.c,125 :: 		}
L_SysTick_ITConfig7:
;stm32f10x_systickT.c,126 :: 		}
L_end_SysTick_ITConfig:
ADD	SP, SP, #4
BX	LR
; end of _SysTick_ITConfig
_SysTick_GetCounter:
;stm32f10x_systickT.c,135 :: 		u32 SysTick_GetCounter(void)
SUB	SP, SP, #4
;stm32f10x_systickT.c,137 :: 		return(SysTick->VAL);
MOVW	R0, #57368
MOVT	R0, #57344
LDR	R0, [R0, #0]
;stm32f10x_systickT.c,138 :: 		}
L_end_SysTick_GetCounter:
ADD	SP, SP, #4
BX	LR
; end of _SysTick_GetCounter
_SysTick_GetFlagStatus:
;stm32f10x_systickT.c,151 :: 		FlagStatus SysTick_GetFlagStatus(u8 SysTick_FLAG)
SUB	SP, SP, #4
;stm32f10x_systickT.c,153 :: 		u32 statusreg = 0, tmp = 0 ;
;stm32f10x_systickT.c,154 :: 		FlagStatus bitstatus = RESET;
;stm32f10x_systickT.c,160 :: 		tmp = SysTick_FLAG >> 3;
LSRS	R1, R0, #3
UXTB	R1, R1
; tmp start address is: 4 (R1)
;stm32f10x_systickT.c,162 :: 		if (tmp == 2) /* The flag to check is in CTRL register */
CMP	R1, #2
IT	NE
BNE	L_SysTick_GetFlagStatus8
; tmp end address is: 4 (R1)
;stm32f10x_systickT.c,164 :: 		statusreg = SysTick->CTRL;
MOVW	R1, #57360
MOVT	R1, #57344
; statusreg start address is: 8 (R2)
LDR	R2, [R1, #0]
;stm32f10x_systickT.c,165 :: 		}
; statusreg end address is: 8 (R2)
IT	AL
BAL	L_SysTick_GetFlagStatus9
L_SysTick_GetFlagStatus8:
;stm32f10x_systickT.c,168 :: 		statusreg = SysTick->CALIB;
MOVW	R1, #57372
MOVT	R1, #57344
; statusreg start address is: 8 (R2)
LDR	R2, [R1, #0]
; statusreg end address is: 8 (R2)
;stm32f10x_systickT.c,169 :: 		}
L_SysTick_GetFlagStatus9:
;stm32f10x_systickT.c,171 :: 		if ((statusreg & ((u32)1 << SysTick_FLAG)) != (u32)RESET)
; statusreg start address is: 8 (R2)
MOV	R1, #1
LSLS	R1, R0
AND	R1, R2, R1, LSL #0
; statusreg end address is: 8 (R2)
CMP	R1, #0
IT	EQ
BEQ	L_SysTick_GetFlagStatus10
;stm32f10x_systickT.c,173 :: 		bitstatus = SET;
MOVS	R0, #1
;stm32f10x_systickT.c,174 :: 		}
IT	AL
BAL	L_SysTick_GetFlagStatus11
L_SysTick_GetFlagStatus10:
;stm32f10x_systickT.c,177 :: 		bitstatus = RESET;
MOVS	R0, #0
;stm32f10x_systickT.c,178 :: 		}
L_SysTick_GetFlagStatus11:
;stm32f10x_systickT.c,179 :: 		return bitstatus;
;stm32f10x_systickT.c,180 :: 		}
L_end_SysTick_GetFlagStatus:
ADD	SP, SP, #4
BX	LR
; end of _SysTick_GetFlagStatus
