_NMIException:
;stm32f10x_it.c,11 :: 		void NMIException(void)
SUB	SP, SP, #4
;stm32f10x_it.c,12 :: 		{}
L_end_NMIException:
ADD	SP, SP, #4
BX	LR
; end of _NMIException
_HardFaultException:
;stm32f10x_it.c,14 :: 		void HardFaultException(void)
SUB	SP, SP, #4
;stm32f10x_it.c,16 :: 		while (1) {}
L_HardFaultException0:
IT	AL
BAL	L_HardFaultException0
;stm32f10x_it.c,17 :: 		}
L_end_HardFaultException:
ADD	SP, SP, #4
BX	LR
; end of _HardFaultException
_MemManageException:
;stm32f10x_it.c,19 :: 		void MemManageException(void)
SUB	SP, SP, #4
;stm32f10x_it.c,21 :: 		while (1) {}
L_MemManageException2:
IT	AL
BAL	L_MemManageException2
;stm32f10x_it.c,22 :: 		}
L_end_MemManageException:
ADD	SP, SP, #4
BX	LR
; end of _MemManageException
_BusFaultException:
;stm32f10x_it.c,24 :: 		void BusFaultException(void)
SUB	SP, SP, #4
;stm32f10x_it.c,26 :: 		while (1) {}
L_BusFaultException4:
IT	AL
BAL	L_BusFaultException4
;stm32f10x_it.c,27 :: 		}
L_end_BusFaultException:
ADD	SP, SP, #4
BX	LR
; end of _BusFaultException
_UsageFaultException:
;stm32f10x_it.c,28 :: 		void UsageFaultException(void)
SUB	SP, SP, #4
;stm32f10x_it.c,30 :: 		while (1) {}
L_UsageFaultException6:
IT	AL
BAL	L_UsageFaultException6
;stm32f10x_it.c,31 :: 		}
L_end_UsageFaultException:
ADD	SP, SP, #4
BX	LR
; end of _UsageFaultException
_DebugMonitor:
;stm32f10x_it.c,33 :: 		void DebugMonitor(void)
SUB	SP, SP, #4
;stm32f10x_it.c,34 :: 		{}
L_end_DebugMonitor:
ADD	SP, SP, #4
BX	LR
; end of _DebugMonitor
_SVCHandler:
;stm32f10x_it.c,36 :: 		void SVCHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,37 :: 		{}
L_end_SVCHandler:
ADD	SP, SP, #4
BX	LR
; end of _SVCHandler
_PendSVC:
;stm32f10x_it.c,39 :: 		void PendSVC(void)
SUB	SP, SP, #4
;stm32f10x_it.c,40 :: 		{}
L_end_PendSVC:
ADD	SP, SP, #4
BX	LR
; end of _PendSVC
_SysTickHandler:
;stm32f10x_it.c,42 :: 		void SysTickHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,43 :: 		{}
L_end_SysTickHandler:
ADD	SP, SP, #4
BX	LR
; end of _SysTickHandler
_WWDG_IRQHandler:
;stm32f10x_it.c,45 :: 		void WWDG_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,46 :: 		{}
L_end_WWDG_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _WWDG_IRQHandler
_PVD_IRQHandler:
;stm32f10x_it.c,48 :: 		void PVD_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,49 :: 		{}
L_end_PVD_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _PVD_IRQHandler
_TAMPER_IRQHandler:
;stm32f10x_it.c,51 :: 		void TAMPER_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,52 :: 		{}
L_end_TAMPER_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _TAMPER_IRQHandler
_RTC_IRQHandler:
;stm32f10x_it.c,54 :: 		void RTC_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,55 :: 		{}
L_end_RTC_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _RTC_IRQHandler
_FLASH_IRQHandler:
;stm32f10x_it.c,57 :: 		void FLASH_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,58 :: 		{}
L_end_FLASH_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _FLASH_IRQHandler
_RCC_IRQHandler:
;stm32f10x_it.c,60 :: 		void RCC_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,61 :: 		{}
L_end_RCC_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _RCC_IRQHandler
_EXTI0_IRQHandler:
;stm32f10x_it.c,63 :: 		void EXTI0_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,64 :: 		{}
L_end_EXTI0_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _EXTI0_IRQHandler
_EXTI1_IRQHandler:
;stm32f10x_it.c,66 :: 		void EXTI1_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,67 :: 		{}
L_end_EXTI1_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _EXTI1_IRQHandler
_EXTI2_IRQHandler:
;stm32f10x_it.c,69 :: 		void EXTI2_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,70 :: 		{}
L_end_EXTI2_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _EXTI2_IRQHandler
_EXTI3_IRQHandler:
;stm32f10x_it.c,72 :: 		void EXTI3_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,73 :: 		{}
L_end_EXTI3_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _EXTI3_IRQHandler
_EXTI4_IRQHandler:
;stm32f10x_it.c,75 :: 		void EXTI4_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,76 :: 		{}
L_end_EXTI4_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _EXTI4_IRQHandler
_DMAChannel1_IRQHandler:
;stm32f10x_it.c,78 :: 		void DMAChannel1_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,79 :: 		{}
L_end_DMAChannel1_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _DMAChannel1_IRQHandler
_DMAChannel2_IRQHandler:
;stm32f10x_it.c,81 :: 		void DMAChannel2_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,82 :: 		{}
L_end_DMAChannel2_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _DMAChannel2_IRQHandler
_DMAChannel3_IRQHandler:
;stm32f10x_it.c,84 :: 		void DMAChannel3_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,85 :: 		{}
L_end_DMAChannel3_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _DMAChannel3_IRQHandler
_DMAChannel4_IRQHandler:
;stm32f10x_it.c,87 :: 		void DMAChannel4_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,88 :: 		{}
L_end_DMAChannel4_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _DMAChannel4_IRQHandler
_DMAChannel5_IRQHandler:
;stm32f10x_it.c,90 :: 		void DMAChannel5_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,91 :: 		{}
L_end_DMAChannel5_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _DMAChannel5_IRQHandler
_DMAChannel6_IRQHandler:
;stm32f10x_it.c,93 :: 		void DMAChannel6_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,94 :: 		{}
L_end_DMAChannel6_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _DMAChannel6_IRQHandler
_DMAChannel7_IRQHandler:
;stm32f10x_it.c,96 :: 		void DMAChannel7_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,97 :: 		{}
L_end_DMAChannel7_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _DMAChannel7_IRQHandler
_ADC_IRQHandler:
;stm32f10x_it.c,99 :: 		void ADC_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,100 :: 		{}
L_end_ADC_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _ADC_IRQHandler
_USB_HP_CAN_TX_IRQHandler:
;stm32f10x_it.c,102 :: 		void USB_HP_CAN_TX_IRQHandler(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;stm32f10x_it.c,104 :: 		CTR_HP();
BL	_CTR_HP+0
;stm32f10x_it.c,105 :: 		}
L_end_USB_HP_CAN_TX_IRQHandler:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _USB_HP_CAN_TX_IRQHandler
_USB_LP_CAN_RX0_IRQHandler:
;stm32f10x_it.c,107 :: 		void USB_LP_CAN_RX0_IRQHandler(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;stm32f10x_it.c,109 :: 		USB_Istr();
BL	_USB_Istr+0
;stm32f10x_it.c,110 :: 		}
L_end_USB_LP_CAN_RX0_IRQHandler:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _USB_LP_CAN_RX0_IRQHandler
_CAN_RX1_IRQHandler:
;stm32f10x_it.c,112 :: 		void CAN_RX1_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,113 :: 		{}
L_end_CAN_RX1_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _CAN_RX1_IRQHandler
_CAN_SCE_IRQHandler:
;stm32f10x_it.c,115 :: 		void CAN_SCE_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,116 :: 		{}
L_end_CAN_SCE_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _CAN_SCE_IRQHandler
_EXTI9_5_IRQHandler:
;stm32f10x_it.c,118 :: 		void EXTI9_5_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,119 :: 		{}
L_end_EXTI9_5_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _EXTI9_5_IRQHandler
_TIM1_BRK_IRQHandler:
;stm32f10x_it.c,121 :: 		void TIM1_BRK_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,122 :: 		{}
L_end_TIM1_BRK_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _TIM1_BRK_IRQHandler
_TIM1_UP_IRQHandler:
;stm32f10x_it.c,124 :: 		void TIM1_UP_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,125 :: 		{}
L_end_TIM1_UP_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _TIM1_UP_IRQHandler
_TIM1_TRG_COM_IRQHandler:
;stm32f10x_it.c,127 :: 		void TIM1_TRG_COM_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,128 :: 		{}
L_end_TIM1_TRG_COM_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _TIM1_TRG_COM_IRQHandler
_TIM1_CC_IRQHandler:
;stm32f10x_it.c,130 :: 		void TIM1_CC_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,131 :: 		{}
L_end_TIM1_CC_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _TIM1_CC_IRQHandler
_TIM2_IRQHandler:
;stm32f10x_it.c,133 :: 		void TIM2_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,134 :: 		{}
L_end_TIM2_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _TIM2_IRQHandler
_TIM3_IRQHandler:
;stm32f10x_it.c,136 :: 		void TIM3_IRQHandler(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;stm32f10x_it.c,139 :: 		TIM3_SR = 0;
MOVS	R1, #0
MOVW	R0, 1073742864
MOVT	R0, 16384
STR	R1, [R0, #0]
;stm32f10x_it.c,140 :: 		if(Delay_Counter)  Delay_Counter--;
MOVW	R0, #lo_addr(_Delay_Counter+0)
MOVT	R0, #hi_addr(_Delay_Counter+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_TIM3_IRQHandler8
MOVW	R1, #lo_addr(_Delay_Counter+0)
MOVT	R1, #hi_addr(_Delay_Counter+0)
LDRB	R0, [R1, #0]
SUBS	R0, R0, #1
STRB	R0, [R1, #0]
L_TIM3_IRQHandler8:
;stm32f10x_it.c,141 :: 		if(Counter_20mS>0)  Counter_20mS--;
MOVW	R0, #lo_addr(_Counter_20mS+0)
MOVT	R0, #hi_addr(_Counter_20mS+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	LS
BLS	L_TIM3_IRQHandler9
MOVW	R1, #lo_addr(_Counter_20mS+0)
MOVT	R1, #hi_addr(_Counter_20mS+0)
LDRB	R0, [R1, #0]
SUBS	R0, R0, #1
STRB	R0, [R1, #0]
IT	AL
BAL	L_TIM3_IRQHandler10
L_TIM3_IRQHandler9:
;stm32f10x_it.c,143 :: 		Cursor_Counter++;
MOVW	R1, #lo_addr(_Cursor_Counter+0)
MOVT	R1, #hi_addr(_Cursor_Counter+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
UXTB	R0, R0
STRB	R0, [R1, #0]
;stm32f10x_it.c,144 :: 		if(Cursor_Counter>24) {               //25*20mS=500mS
CMP	R0, #24
IT	LS
BLS	L_TIM3_IRQHandler11
;stm32f10x_it.c,145 :: 		Cursor_Counter=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Cursor_Counter+0)
MOVT	R0, #hi_addr(_Cursor_Counter+0)
STRB	R1, [R0, #0]
;stm32f10x_it.c,146 :: 		Update[Item]=1;
MOVW	R0, #lo_addr(_Item+0)
MOVT	R0, #hi_addr(_Item+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_Update+0)
MOVT	R0, #hi_addr(_Update+0)
ADDS	R1, R0, R1
MOVS	R0, #1
STRB	R0, [R1, #0]
;stm32f10x_it.c,147 :: 		Type=1-Type;
MOVW	R1, #lo_addr(_Type+0)
MOVT	R1, #hi_addr(_Type+0)
LDRB	R0, [R1, #0]
RSB	R0, R0, #1
STRB	R0, [R1, #0]
;stm32f10x_it.c,148 :: 		}
L_TIM3_IRQHandler11:
;stm32f10x_it.c,149 :: 		Counter_20mS =20;
MOVS	R1, #20
MOVW	R0, #lo_addr(_Counter_20mS+0)
MOVT	R0, #hi_addr(_Counter_20mS+0)
STRB	R1, [R0, #0]
;stm32f10x_it.c,150 :: 		if(Key_Wait_Counter)    Key_Wait_Counter--;
MOVW	R0, #lo_addr(_Key_Wait_Counter+0)
MOVT	R0, #hi_addr(_Key_Wait_Counter+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_TIM3_IRQHandler12
MOVW	R1, #lo_addr(_Key_Wait_Counter+0)
MOVT	R1, #hi_addr(_Key_Wait_Counter+0)
LDRB	R0, [R1, #0]
SUBS	R0, R0, #1
STRB	R0, [R1, #0]
L_TIM3_IRQHandler12:
;stm32f10x_it.c,151 :: 		if(Key_Repeat_Counter)  Key_Repeat_Counter--;
MOVW	R0, #lo_addr(_Key_Repeat_Counter+0)
MOVT	R0, #hi_addr(_Key_Repeat_Counter+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_TIM3_IRQHandler13
MOVW	R1, #lo_addr(_Key_Repeat_Counter+0)
MOVT	R1, #hi_addr(_Key_Repeat_Counter+0)
LDRB	R0, [R1, #0]
SUBS	R0, R0, #1
STRB	R0, [R1, #0]
L_TIM3_IRQHandler13:
;stm32f10x_it.c,152 :: 		KeyCode=KeyScan();
BL	_KeyScan+0
; KeyCode start address is: 4 (R1)
UXTB	R1, R0
;stm32f10x_it.c,153 :: 		if(KeyCode !=0) Key_Buffer = KeyCode;
CMP	R0, #0
IT	EQ
BEQ	L_TIM3_IRQHandler14
MOVW	R0, #lo_addr(_Key_Buffer+0)
MOVT	R0, #hi_addr(_Key_Buffer+0)
STRB	R1, [R0, #0]
; KeyCode end address is: 4 (R1)
L_TIM3_IRQHandler14:
;stm32f10x_it.c,154 :: 		}
L_TIM3_IRQHandler10:
;stm32f10x_it.c,155 :: 		}
L_end_TIM3_IRQHandler:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _TIM3_IRQHandler
_TIM4_IRQHandler:
;stm32f10x_it.c,157 :: 		void TIM4_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,158 :: 		{}
L_end_TIM4_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _TIM4_IRQHandler
_I2C1_EV_IRQHandler:
;stm32f10x_it.c,160 :: 		void I2C1_EV_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,161 :: 		{}
L_end_I2C1_EV_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _I2C1_EV_IRQHandler
_I2C1_ER_IRQHandler:
;stm32f10x_it.c,163 :: 		void I2C1_ER_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,164 :: 		{}
L_end_I2C1_ER_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _I2C1_ER_IRQHandler
_I2C2_EV_IRQHandler:
;stm32f10x_it.c,166 :: 		void I2C2_EV_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,167 :: 		{}
L_end_I2C2_EV_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _I2C2_EV_IRQHandler
_I2C2_ER_IRQHandler:
;stm32f10x_it.c,169 :: 		void I2C2_ER_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,170 :: 		{}
L_end_I2C2_ER_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _I2C2_ER_IRQHandler
_SPI1_IRQHandler:
;stm32f10x_it.c,172 :: 		void SPI1_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,173 :: 		{}
L_end_SPI1_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _SPI1_IRQHandler
_SPI2_IRQHandler:
;stm32f10x_it.c,175 :: 		void SPI2_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,176 :: 		{}
L_end_SPI2_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _SPI2_IRQHandler
_USART1_IRQHandler:
;stm32f10x_it.c,178 :: 		void USART1_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,179 :: 		{}
L_end_USART1_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _USART1_IRQHandler
_USART2_IRQHandler:
;stm32f10x_it.c,181 :: 		void USART2_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,182 :: 		{}
L_end_USART2_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _USART2_IRQHandler
_USART3_IRQHandler:
;stm32f10x_it.c,184 :: 		void USART3_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,185 :: 		{}
L_end_USART3_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _USART3_IRQHandler
_EXTI15_10_IRQHandler:
;stm32f10x_it.c,187 :: 		void EXTI15_10_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,188 :: 		{}
L_end_EXTI15_10_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _EXTI15_10_IRQHandler
_RTCAlarm_IRQHandler:
;stm32f10x_it.c,190 :: 		void RTCAlarm_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,191 :: 		{}
L_end_RTCAlarm_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _RTCAlarm_IRQHandler
_USBWakeUp_IRQHandler:
;stm32f10x_it.c,193 :: 		void USBWakeUp_IRQHandler(void)
SUB	SP, SP, #4
;stm32f10x_it.c,194 :: 		{}
L_end_USBWakeUp_IRQHandler:
ADD	SP, SP, #4
BX	LR
; end of _USBWakeUp_IRQHandler
