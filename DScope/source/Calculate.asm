_Int32String_sign:
;Calculate.c,10 :: 		void Int32String_sign(I32STR_RES *r, int n, int e)
; e start address is: 8 (R2)
; n start address is: 4 (R1)
SUB	SP, SP, #4
SXTH	R4, R1
; e end address is: 8 (R2)
; n end address is: 4 (R1)
; n start address is: 16 (R4)
; e start address is: 8 (R2)
;Calculate.c,13 :: 		char *p = r->str;
ADDS	R5, R0, #2
; p start address is: 20 (R5)
;Calculate.c,14 :: 		fixlen=e+2;
ADDS	R3, R2, #2
; fixlen start address is: 4 (R1)
SXTH	R1, R3
;Calculate.c,15 :: 		if ( n == 0 ) {
CMP	R4, #0
IT	NE
BNE	L_Int32String_sign0
; fixlen end address is: 4 (R1)
; e end address is: 8 (R2)
; n end address is: 16 (R4)
;Calculate.c,16 :: 		*p++ = ' ';
MOVS	R3, #32
STRB	R3, [R5, #0]
ADDS	R4, R5, #1
; p end address is: 20 (R5)
; p start address is: 4 (R1)
MOV	R1, R4
;Calculate.c,17 :: 		*p++ = '0';
MOVS	R3, #48
STRB	R3, [R4, #0]
ADDS	R4, R1, #1
MOV	R1, R4
;Calculate.c,18 :: 		*p++ = '.';
MOVS	R3, #46
STRB	R3, [R4, #0]
ADDS	R4, R1, #1
MOV	R1, R4
;Calculate.c,19 :: 		*p++ = '0';
MOVS	R3, #48
STRB	R3, [R4, #0]
ADDS	R4, R1, #1
MOV	R1, R4
;Calculate.c,20 :: 		*p++ = '0';
MOVS	R3, #48
STRB	R3, [R4, #0]
ADDS	R4, R1, #1
MOV	R1, R4
;Calculate.c,21 :: 		*p = 0;
MOVS	R3, #0
STRB	R3, [R4, #0]
;Calculate.c,22 :: 		r->decPos = 0;
MOVS	R3, #0
STRB	R3, [R0, #0]
;Calculate.c,23 :: 		r->len = p-r->str;
ADDS	R4, R0, #1
ADDS	R3, R0, #2
SUB	R3, R1, R3
; p end address is: 4 (R1)
STRB	R3, [R4, #0]
;Calculate.c,24 :: 		return;
IT	AL
BAL	L_end_Int32String_sign
;Calculate.c,25 :: 		}
L_Int32String_sign0:
;Calculate.c,26 :: 		if ( n > 0 )
; n start address is: 16 (R4)
; p start address is: 20 (R5)
; e start address is: 8 (R2)
; fixlen start address is: 4 (R1)
CMP	R4, #0
IT	LE
BLE	L_Int32String_sign1
;Calculate.c,27 :: 		*p++ = ' ';
MOVS	R3, #32
STRB	R3, [R5, #0]
ADDS	R3, R5, #1
; p end address is: 20 (R5)
; p start address is: 12 (R3)
; p end address is: 12 (R3)
SXTH	R7, R4
IT	AL
BAL	L_Int32String_sign2
L_Int32String_sign1:
;Calculate.c,29 :: 		*p++ = '-';
; p start address is: 20 (R5)
MOVS	R3, #45
STRB	R3, [R5, #0]
ADDS	R5, R5, #1
;Calculate.c,30 :: 		n = -n;
RSBS	R7, R4, #0
SXTH	R7, R7
; n end address is: 16 (R4)
; n start address is: 28 (R7)
; n end address is: 28 (R7)
; p end address is: 20 (R5)
MOV	R3, R5
;Calculate.c,31 :: 		}
L_Int32String_sign2:
;Calculate.c,32 :: 		m = n;
; n start address is: 28 (R7)
; p start address is: 12 (R3)
; m start address is: 16 (R4)
SXTH	R4, R7
;Calculate.c,33 :: 		i = 0;
; i start address is: 24 (R6)
MOVS	R6, #0
SXTH	R6, R6
;Calculate.c,34 :: 		c = 5;
; c start address is: 32 (R8)
MOVW	R8, #5
SXTH	R8, R8
; fixlen end address is: 4 (R1)
; m end address is: 16 (R4)
; c end address is: 32 (R8)
; i end address is: 24 (R6)
; n end address is: 28 (R7)
; e end address is: 8 (R2)
; p end address is: 12 (R3)
STRH	R1, [SP, #0]
MOV	R1, R0
SXTH	R5, R2
MOV	R2, R3
LDRSH	R0, [SP, #0]
;Calculate.c,35 :: 		while ( m >= 10 ) {
L_Int32String_sign3:
; c start address is: 32 (R8)
; i start address is: 24 (R6)
; m start address is: 16 (R4)
; p start address is: 8 (R2)
; n start address is: 28 (R7)
; e start address is: 20 (R5)
; r start address is: 4 (R1)
CMP	R4, #10
IT	LT
BLT	L_Int32String_sign4
;Calculate.c,36 :: 		m /= 10;
MOVS	R3, #10
SXTH	R3, R3
SDIV	R4, R4, R3
SXTH	R4, R4
;Calculate.c,37 :: 		if ( ++i > e ) c *= 10;
ADDS	R3, R6, #1
SXTH	R3, R3
SXTH	R6, R3
CMP	R3, R5
IT	LE
BLE	L__Int32String_sign66
MOVS	R3, #10
SXTH	R3, R3
MUL	R8, R3, R8
SXTH	R8, R8
; c end address is: 32 (R8)
IT	AL
BAL	L_Int32String_sign5
L__Int32String_sign66:
L_Int32String_sign5:
;Calculate.c,38 :: 		}
; c start address is: 32 (R8)
; m end address is: 16 (R4)
IT	AL
BAL	L_Int32String_sign3
L_Int32String_sign4:
;Calculate.c,39 :: 		r->decPos = i/3;
MOV	R4, R1
MOVS	R3, #3
SXTH	R3, R3
SDIV	R3, R6, R3
STRB	R3, [R4, #0]
;Calculate.c,40 :: 		if ( i >= e ) n += c;
CMP	R6, R5
IT	LT
BLT	L__Int32String_sign67
ADD	R7, R7, R8, LSL #0
SXTH	R7, R7
; c end address is: 32 (R8)
; n end address is: 28 (R7)
IT	AL
BAL	L_Int32String_sign6
L__Int32String_sign67:
L_Int32String_sign6:
;Calculate.c,41 :: 		switch ( i ) {
; n start address is: 28 (R7)
IT	AL
BAL	L_Int32String_sign7
; i end address is: 24 (R6)
;Calculate.c,42 :: 		case 9:
L_Int32String_sign9:
;Calculate.c,43 :: 		*p++ = '0'+n/1000000000;
MOVW	R3, #51712
MOVT	R3, #15258
SDIV	R3, R7, R3
ADDS	R3, #48
STRB	R3, [R2, #0]
ADDS	R6, R2, #1
; p end address is: 8 (R2)
; p start address is: 24 (R6)
;Calculate.c,44 :: 		if ( --e == 0 ) break;
SUBS	R3, R5, #1
SXTH	R3, R3
CMP	R3, #0
IT	NE
BNE	L_Int32String_sign10
; e end address is: 20 (R5)
; n end address is: 28 (R7)
MOV	R2, R6
IT	AL
BAL	L_Int32String_sign8
L_Int32String_sign10:
;Calculate.c,45 :: 		n %= 1000000000;
; n start address is: 28 (R7)
; e start address is: 20 (R5)
MOVW	R4, #51712
MOVT	R4, #15258
SDIV	R3, R7, R4
MLS	R3, R4, R3, R7
; n end address is: 28 (R7)
; n start address is: 8 (R2)
SXTH	R2, R3
;Calculate.c,46 :: 		*p++ = '.', i = 0;
MOVS	R3, #46
STRB	R3, [R6, #0]
ADDS	R4, R6, #1
; p end address is: 24 (R6)
; p start address is: 16 (R4)
; i start address is: 24 (R6)
MOVS	R6, #0
SXTH	R6, R6
; i end address is: 24 (R6)
; p end address is: 16 (R4)
; n end address is: 8 (R2)
;Calculate.c,47 :: 		case 8:
IT	AL
BAL	L_Int32String_sign11
L__Int32String_sign68:
;Calculate.c,83 :: 		}
MOV	R4, R2
SXTH	R2, R7
;Calculate.c,47 :: 		case 8:
L_Int32String_sign11:
;Calculate.c,48 :: 		*p++ = '0'+n/100000000;
; i start address is: 24 (R6)
; p start address is: 16 (R4)
; n start address is: 8 (R2)
MOVW	R3, #57600
MOVT	R3, #1525
SDIV	R3, R2, R3
ADDS	R3, #48
STRB	R3, [R4, #0]
ADDS	R3, R4, #1
; p end address is: 16 (R4)
; p start address is: 28 (R7)
MOV	R7, R3
;Calculate.c,49 :: 		if ( --e == 0 ) break;
SUBS	R3, R5, #1
SXTH	R3, R3
SXTH	R5, R3
CMP	R3, #0
IT	NE
BNE	L_Int32String_sign12
; i end address is: 24 (R6)
; e end address is: 20 (R5)
; n end address is: 8 (R2)
MOV	R2, R7
IT	AL
BAL	L_Int32String_sign8
L_Int32String_sign12:
;Calculate.c,50 :: 		n %= 100000000;
; n start address is: 8 (R2)
; e start address is: 20 (R5)
; i start address is: 24 (R6)
MOVW	R4, #57600
MOVT	R4, #1525
SDIV	R3, R2, R4
MLS	R3, R4, R3, R2
SXTH	R2, R3
; i end address is: 24 (R6)
; p end address is: 28 (R7)
; e end address is: 20 (R5)
; n end address is: 8 (R2)
SXTH	R4, R5
MOV	R5, R7
SXTH	R7, R2
SXTH	R2, R6
;Calculate.c,51 :: 		case 7:
IT	AL
BAL	L_Int32String_sign13
L__Int32String_sign69:
;Calculate.c,83 :: 		}
SXTH	R4, R5
MOV	R5, R2
SXTH	R2, R6
;Calculate.c,51 :: 		case 7:
L_Int32String_sign13:
;Calculate.c,52 :: 		*p++ = '0'+n/10000000;
; n start address is: 28 (R7)
; e start address is: 16 (R4)
; p start address is: 20 (R5)
; i start address is: 8 (R2)
MOVW	R3, #38528
MOVT	R3, #152
SDIV	R3, R7, R3
ADDS	R3, #48
STRB	R3, [R5, #0]
ADDS	R5, R5, #1
;Calculate.c,53 :: 		if ( --e == 0 ) break;
SUBS	R3, R4, #1
SXTH	R3, R3
; e end address is: 16 (R4)
; e start address is: 24 (R6)
SXTH	R6, R3
CMP	R3, #0
IT	NE
BNE	L_Int32String_sign14
; i end address is: 8 (R2)
; n end address is: 28 (R7)
; e end address is: 24 (R6)
MOV	R2, R5
IT	AL
BAL	L_Int32String_sign8
L_Int32String_sign14:
;Calculate.c,54 :: 		n %= 10000000;
; e start address is: 24 (R6)
; n start address is: 28 (R7)
; i start address is: 8 (R2)
MOVW	R4, #38528
MOVT	R4, #152
SDIV	R3, R7, R4
MLS	R3, R4, R3, R7
SXTH	R7, R3
; i end address is: 8 (R2)
; n end address is: 28 (R7)
; e end address is: 24 (R6)
; p end address is: 20 (R5)
STR	R5, [SP, #0]
SXTH	R5, R2
SXTH	R4, R6
LDR	R2, [SP, #0]
;Calculate.c,55 :: 		case 6:
IT	AL
BAL	L_Int32String_sign15
L__Int32String_sign70:
;Calculate.c,83 :: 		}
SXTH	R4, R5
SXTH	R5, R6
;Calculate.c,55 :: 		case 6:
L_Int32String_sign15:
;Calculate.c,56 :: 		*p++ = '0'+n/1000000;
; n start address is: 28 (R7)
; e start address is: 16 (R4)
; p start address is: 8 (R2)
; i start address is: 20 (R5)
MOVW	R3, #16960
MOVT	R3, #15
SDIV	R3, R7, R3
ADDS	R3, #48
STRB	R3, [R2, #0]
ADDS	R6, R2, #1
; p end address is: 8 (R2)
; p start address is: 24 (R6)
;Calculate.c,57 :: 		if ( --e == 0 ) break;
SUBS	R3, R4, #1
SXTH	R3, R3
; e end address is: 16 (R4)
; e start address is: 8 (R2)
SXTH	R2, R3
CMP	R3, #0
IT	NE
BNE	L_Int32String_sign16
; n end address is: 28 (R7)
; i end address is: 20 (R5)
; e end address is: 8 (R2)
MOV	R2, R6
IT	AL
BAL	L_Int32String_sign8
L_Int32String_sign16:
;Calculate.c,58 :: 		n %= 1000000;
; e start address is: 8 (R2)
; i start address is: 20 (R5)
; n start address is: 28 (R7)
MOVW	R4, #16960
MOVT	R4, #15
SDIV	R3, R7, R4
MLS	R3, R4, R3, R7
; n end address is: 28 (R7)
; n start address is: 16 (R4)
SXTH	R4, R3
;Calculate.c,59 :: 		if ( i ) *p++ = '.', i = 0;
CMP	R5, #0
IT	EQ
BEQ	L__Int32String_sign71
; i end address is: 20 (R5)
MOVS	R3, #46
STRB	R3, [R6, #0]
ADDS	R5, R6, #1
; p end address is: 24 (R6)
; p start address is: 20 (R5)
; i start address is: 12 (R3)
MOVS	R3, #0
SXTH	R3, R3
; i end address is: 12 (R3)
; p end address is: 20 (R5)
STRH	R3, [SP, #0]
MOV	R3, R5
LDRSH	R5, [SP, #0]
IT	AL
BAL	L_Int32String_sign17
L__Int32String_sign71:
MOV	R3, R6
L_Int32String_sign17:
;Calculate.c,60 :: 		case 5:
; i start address is: 20 (R5)
; p start address is: 12 (R3)
SXTH	R7, R2
; i end address is: 20 (R5)
; e end address is: 8 (R2)
; p end address is: 12 (R3)
; n end address is: 16 (R4)
SXTH	R2, R5
SXTH	R6, R4
MOV	R4, R3
IT	AL
BAL	L_Int32String_sign18
L__Int32String_sign72:
;Calculate.c,83 :: 		}
MOV	R4, R2
SXTH	R2, R6
SXTH	R6, R7
SXTH	R7, R5
;Calculate.c,60 :: 		case 5:
L_Int32String_sign18:
;Calculate.c,61 :: 		*p++ = '0'+n/100000;
; p start address is: 16 (R4)
; i start address is: 8 (R2)
; n start address is: 24 (R6)
; e start address is: 28 (R7)
MOVW	R3, #34464
MOVT	R3, #1
SDIV	R3, R6, R3
ADDS	R3, #48
STRB	R3, [R4, #0]
ADDS	R5, R4, #1
; p end address is: 16 (R4)
; p start address is: 20 (R5)
;Calculate.c,62 :: 		if ( --e == 0 ) break;
SUBS	R3, R7, #1
SXTH	R3, R3
SXTH	R7, R3
CMP	R3, #0
IT	NE
BNE	L_Int32String_sign19
; e end address is: 28 (R7)
; i end address is: 8 (R2)
; n end address is: 24 (R6)
MOV	R2, R5
IT	AL
BAL	L_Int32String_sign8
L_Int32String_sign19:
;Calculate.c,63 :: 		n %= 100000;
; n start address is: 24 (R6)
; i start address is: 8 (R2)
; e start address is: 28 (R7)
MOVW	R4, #34464
MOVT	R4, #1
SDIV	R3, R6, R4
MLS	R3, R4, R3, R6
; n end address is: 24 (R6)
; n start address is: 16 (R4)
SXTH	R4, R3
; e end address is: 28 (R7)
; i end address is: 8 (R2)
; p end address is: 20 (R5)
; n end address is: 16 (R4)
STRH	R4, [SP, #0]
SXTH	R4, R7
LDRSH	R7, [SP, #0]
;Calculate.c,64 :: 		case 4:
IT	AL
BAL	L_Int32String_sign20
L__Int32String_sign73:
;Calculate.c,83 :: 		}
SXTH	R4, R5
MOV	R5, R2
SXTH	R2, R6
;Calculate.c,64 :: 		case 4:
L_Int32String_sign20:
;Calculate.c,65 :: 		*p++ = '0'+n/10000;
; n start address is: 28 (R7)
; e start address is: 16 (R4)
; p start address is: 20 (R5)
; i start address is: 8 (R2)
MOVW	R3, #10000
SXTH	R3, R3
SDIV	R3, R7, R3
SXTH	R3, R3
ADDS	R3, #48
STRB	R3, [R5, #0]
ADDS	R5, R5, #1
;Calculate.c,66 :: 		if ( --e == 0 ) break;
SUBS	R3, R4, #1
SXTH	R3, R3
; e end address is: 16 (R4)
; e start address is: 24 (R6)
SXTH	R6, R3
CMP	R3, #0
IT	NE
BNE	L_Int32String_sign21
; i end address is: 8 (R2)
; n end address is: 28 (R7)
; e end address is: 24 (R6)
MOV	R2, R5
IT	AL
BAL	L_Int32String_sign8
L_Int32String_sign21:
;Calculate.c,67 :: 		n %= 10000;
; e start address is: 24 (R6)
; n start address is: 28 (R7)
; i start address is: 8 (R2)
MOVW	R4, #10000
SXTH	R4, R4
SDIV	R7, R7, R4
MLS	R7, R4, R7, R7
SXTH	R7, R7
; i end address is: 8 (R2)
; n end address is: 28 (R7)
; e end address is: 24 (R6)
; p end address is: 20 (R5)
STR	R5, [SP, #0]
SXTH	R5, R2
SXTH	R4, R6
LDR	R2, [SP, #0]
;Calculate.c,68 :: 		case 3:
IT	AL
BAL	L_Int32String_sign22
L__Int32String_sign74:
;Calculate.c,83 :: 		}
SXTH	R4, R5
SXTH	R5, R6
;Calculate.c,68 :: 		case 3:
L_Int32String_sign22:
;Calculate.c,69 :: 		*p++ = '0'+n/1000;
; n start address is: 28 (R7)
; e start address is: 16 (R4)
; p start address is: 8 (R2)
; i start address is: 20 (R5)
MOVW	R3, #1000
SXTH	R3, R3
SDIV	R3, R7, R3
SXTH	R3, R3
ADDS	R3, #48
STRB	R3, [R2, #0]
ADDS	R3, R2, #1
; p end address is: 8 (R2)
; p start address is: 24 (R6)
MOV	R6, R3
;Calculate.c,70 :: 		if ( --e == 0 ) break;
SUBS	R3, R4, #1
SXTH	R3, R3
; e end address is: 16 (R4)
; e start address is: 8 (R2)
SXTH	R2, R3
CMP	R3, #0
IT	NE
BNE	L_Int32String_sign23
; n end address is: 28 (R7)
; i end address is: 20 (R5)
; e end address is: 8 (R2)
MOV	R2, R6
IT	AL
BAL	L_Int32String_sign8
L_Int32String_sign23:
;Calculate.c,71 :: 		n %= 1000;
; e start address is: 8 (R2)
; i start address is: 20 (R5)
; n start address is: 28 (R7)
MOVW	R4, #1000
SXTH	R4, R4
SDIV	R4, R7, R4
MLS	R4, R4, R4, R7
SXTH	R4, R4
; n end address is: 28 (R7)
; n start address is: 16 (R4)
;Calculate.c,72 :: 		if ( i ) *p++ = '.', i = 0;
CMP	R5, #0
IT	EQ
BEQ	L__Int32String_sign75
; i end address is: 20 (R5)
MOVS	R3, #46
STRB	R3, [R6, #0]
ADDS	R5, R6, #1
; p end address is: 24 (R6)
; p start address is: 20 (R5)
; p end address is: 20 (R5)
MOV	R3, R5
IT	AL
BAL	L_Int32String_sign24
L__Int32String_sign75:
MOV	R3, R6
L_Int32String_sign24:
;Calculate.c,73 :: 		case 2:
; p start address is: 12 (R3)
SXTH	R6, R2
; e end address is: 8 (R2)
; p end address is: 12 (R3)
; n end address is: 16 (R4)
SXTH	R2, R4
MOV	R4, R3
IT	AL
BAL	L_Int32String_sign25
L__Int32String_sign76:
;Calculate.c,83 :: 		}
MOV	R4, R2
SXTH	R2, R7
SXTH	R6, R5
;Calculate.c,73 :: 		case 2:
L_Int32String_sign25:
;Calculate.c,74 :: 		*p++ = '0'+n/100;
; p start address is: 16 (R4)
; n start address is: 8 (R2)
; e start address is: 24 (R6)
MOVS	R3, #100
SXTH	R3, R3
SDIV	R3, R2, R3
SXTH	R3, R3
ADDS	R3, #48
STRB	R3, [R4, #0]
ADDS	R5, R4, #1
; p end address is: 16 (R4)
; p start address is: 20 (R5)
;Calculate.c,75 :: 		if ( --e == 0 ) break;
SUBS	R3, R6, #1
SXTH	R3, R3
SXTH	R6, R3
CMP	R3, #0
IT	NE
BNE	L_Int32String_sign26
; e end address is: 24 (R6)
; n end address is: 8 (R2)
MOV	R2, R5
IT	AL
BAL	L_Int32String_sign8
L_Int32String_sign26:
;Calculate.c,76 :: 		n %= 100;
; n start address is: 8 (R2)
; e start address is: 24 (R6)
MOVS	R4, #100
SXTH	R4, R4
SDIV	R3, R2, R4
MLS	R3, R4, R3, R2
SXTH	R2, R3
; e end address is: 24 (R6)
; n end address is: 8 (R2)
; p end address is: 20 (R5)
SXTH	R4, R6
SXTH	R6, R2
MOV	R2, R5
;Calculate.c,77 :: 		case 1:
IT	AL
BAL	L_Int32String_sign27
L__Int32String_sign77:
;Calculate.c,83 :: 		}
SXTH	R6, R7
SXTH	R4, R5
;Calculate.c,77 :: 		case 1:
L_Int32String_sign27:
;Calculate.c,78 :: 		*p++ = '0'+n/10;
; n start address is: 24 (R6)
; e start address is: 16 (R4)
; p start address is: 8 (R2)
MOVS	R3, #10
SXTH	R3, R3
SDIV	R3, R6, R3
SXTH	R3, R3
ADDS	R3, #48
STRB	R3, [R2, #0]
ADDS	R3, R2, #1
; p end address is: 8 (R2)
; p start address is: 20 (R5)
MOV	R5, R3
;Calculate.c,79 :: 		if ( --e == 0 ) break;
SUBS	R3, R4, #1
SXTH	R3, R3
; e end address is: 16 (R4)
CMP	R3, #0
IT	NE
BNE	L_Int32String_sign28
; n end address is: 24 (R6)
MOV	R2, R5
IT	AL
BAL	L_Int32String_sign8
L_Int32String_sign28:
;Calculate.c,80 :: 		n %= 10;
; n start address is: 24 (R6)
MOVS	R4, #10
SXTH	R4, R4
SDIV	R4, R6, R4
MLS	R4, R4, R4, R6
SXTH	R4, R4
; n end address is: 24 (R6)
; n start address is: 16 (R4)
; p end address is: 20 (R5)
; n end address is: 16 (R4)
MOV	R2, R5
;Calculate.c,81 :: 		case 0:
IT	AL
BAL	L_Int32String_sign29
L__Int32String_sign78:
;Calculate.c,83 :: 		}
SXTH	R4, R7
;Calculate.c,81 :: 		case 0:
L_Int32String_sign29:
;Calculate.c,82 :: 		*p++ = '0'+n;
; n start address is: 16 (R4)
; p start address is: 8 (R2)
ADDW	R3, R4, #48
; n end address is: 16 (R4)
STRB	R3, [R2, #0]
ADDS	R2, R2, #1
;Calculate.c,83 :: 		}
IT	AL
BAL	L_Int32String_sign8
L_Int32String_sign7:
; n start address is: 28 (R7)
; e start address is: 20 (R5)
; i start address is: 24 (R6)
CMP	R6, #9
IT	EQ
BEQ	L_Int32String_sign9
CMP	R6, #8
IT	EQ
BEQ	L__Int32String_sign68
CMP	R6, #7
IT	EQ
BEQ	L__Int32String_sign69
CMP	R6, #6
IT	EQ
BEQ	L__Int32String_sign70
CMP	R6, #5
IT	EQ
BEQ	L__Int32String_sign72
CMP	R6, #4
IT	EQ
BEQ	L__Int32String_sign73
CMP	R6, #3
IT	EQ
BEQ	L__Int32String_sign74
CMP	R6, #2
IT	EQ
BEQ	L__Int32String_sign76
CMP	R6, #1
IT	EQ
BEQ	L__Int32String_sign77
; e end address is: 20 (R5)
CMP	R6, #0
IT	EQ
BEQ	L__Int32String_sign78
; i end address is: 24 (R6)
; n end address is: 28 (R7)
; p end address is: 8 (R2)
L_Int32String_sign8:
;Calculate.c,84 :: 		while ( p < r->str+fixlen )
; p start address is: 8 (R2)
STR	R1, [SP, #0]
; r end address is: 4 (R1)
; p end address is: 8 (R2)
MOV	R1, R2
SXTH	R2, R0
LDR	R0, [SP, #0]
L_Int32String_sign30:
; p start address is: 4 (R1)
; fixlen start address is: 8 (R2)
ADDS	R3, R0, #2
ADDS	R3, R3, R2
CMP	R1, R3
IT	CS
BCS	L_Int32String_sign31
;Calculate.c,85 :: 		*p++ = ' ';
MOVS	R3, #32
STRB	R3, [R1, #0]
ADDS	R1, R1, #1
; fixlen end address is: 8 (R2)
IT	AL
BAL	L_Int32String_sign30
L_Int32String_sign31:
;Calculate.c,86 :: 		*p = 0;
MOVS	R3, #0
STRB	R3, [R1, #0]
;Calculate.c,87 :: 		r->len = p-r->str;
ADDS	R4, R0, #1
ADDS	R3, R0, #2
SUB	R3, R1, R3
; p end address is: 4 (R1)
STRB	R3, [R4, #0]
;Calculate.c,88 :: 		}
L_end_Int32String_sign:
ADD	SP, SP, #4
BX	LR
; end of _Int32String_sign
_Int32String:
;Calculate.c,92 :: 		void Int32String(I32STR_RES *r, int n, int e)
; e start address is: 8 (R2)
; n start address is: 4 (R1)
SUB	SP, SP, #4
SXTH	R4, R2
; e end address is: 8 (R2)
; n end address is: 4 (R1)
; n start address is: 4 (R1)
; e start address is: 16 (R4)
;Calculate.c,95 :: 		char *p = r->str;
ADDS	R2, R0, #2
; p start address is: 8 (R2)
;Calculate.c,96 :: 		fixlen=e+2;
ADDS	R3, R4, #2
; fixlen start address is: 12 (R3)
;Calculate.c,97 :: 		if ( n == 0 ) {
CMP	R1, #0
IT	NE
BNE	L_Int32String32
; n end address is: 4 (R1)
; fixlen end address is: 12 (R3)
; e end address is: 16 (R4)
;Calculate.c,98 :: 		*p++ = '0';
MOVS	R3, #48
STRB	R3, [R2, #0]
ADDS	R4, R2, #1
; p end address is: 8 (R2)
; p start address is: 4 (R1)
MOV	R1, R4
;Calculate.c,99 :: 		*p++ = '.';
MOVS	R3, #46
STRB	R3, [R4, #0]
ADDS	R4, R1, #1
MOV	R1, R4
;Calculate.c,100 :: 		*p++ = '0';
MOVS	R3, #48
STRB	R3, [R4, #0]
ADDS	R4, R1, #1
MOV	R1, R4
;Calculate.c,101 :: 		*p++ = '0';
MOVS	R3, #48
STRB	R3, [R4, #0]
ADDS	R4, R1, #1
MOV	R1, R4
;Calculate.c,102 :: 		*p++ = '0';
MOVS	R3, #48
STRB	R3, [R4, #0]
ADDS	R4, R1, #1
MOV	R1, R4
;Calculate.c,103 :: 		*p = 0;
MOVS	R3, #0
STRB	R3, [R4, #0]
;Calculate.c,104 :: 		r->decPos = 0;
MOVS	R3, #0
STRB	R3, [R0, #0]
;Calculate.c,105 :: 		r->len = p-r->str;
ADDS	R4, R0, #1
ADDS	R3, R0, #2
SUB	R3, R1, R3
; p end address is: 4 (R1)
STRB	R3, [R4, #0]
;Calculate.c,106 :: 		return;
IT	AL
BAL	L_end_Int32String
;Calculate.c,107 :: 		}
L_Int32String32:
;Calculate.c,114 :: 		m = n;
; p start address is: 8 (R2)
; e start address is: 16 (R4)
; m start address is: 20 (R5)
; fixlen start address is: 12 (R3)
; n start address is: 4 (R1)
SXTH	R5, R1
;Calculate.c,115 :: 		i = 0;
; i start address is: 24 (R6)
MOVS	R6, #0
SXTH	R6, R6
;Calculate.c,116 :: 		c = 5;
; c start address is: 32 (R8)
MOVW	R8, #5
SXTH	R8, R8
; n end address is: 4 (R1)
; fixlen end address is: 12 (R3)
; m end address is: 20 (R5)
; c end address is: 32 (R8)
; i end address is: 24 (R6)
; e end address is: 16 (R4)
; p end address is: 8 (R2)
STRH	R5, [SP, #0]
SXTH	R7, R1
MOV	R1, R0
SXTH	R0, R3
SXTH	R5, R4
LDRSH	R4, [SP, #0]
;Calculate.c,117 :: 		while ( m >= 10 ) {
L_Int32String33:
; c start address is: 32 (R8)
; i start address is: 24 (R6)
; m start address is: 16 (R4)
; p start address is: 8 (R2)
; e start address is: 20 (R5)
; n start address is: 28 (R7)
; r start address is: 4 (R1)
CMP	R4, #10
IT	LT
BLT	L_Int32String34
;Calculate.c,118 :: 		m /= 10;
MOVS	R3, #10
SXTH	R3, R3
SDIV	R4, R4, R3
SXTH	R4, R4
;Calculate.c,119 :: 		if ( ++i > e ) c *= 10;
ADDS	R3, R6, #1
SXTH	R3, R3
SXTH	R6, R3
CMP	R3, R5
IT	LE
BLE	L__Int32String79
MOVS	R3, #10
SXTH	R3, R3
MUL	R8, R3, R8
SXTH	R8, R8
; c end address is: 32 (R8)
IT	AL
BAL	L_Int32String35
L__Int32String79:
L_Int32String35:
;Calculate.c,120 :: 		}
; c start address is: 32 (R8)
; m end address is: 16 (R4)
IT	AL
BAL	L_Int32String33
L_Int32String34:
;Calculate.c,121 :: 		r->decPos = i/3;
MOV	R4, R1
MOVS	R3, #3
SXTH	R3, R3
SDIV	R3, R6, R3
STRB	R3, [R4, #0]
;Calculate.c,122 :: 		if ( i >= e ) n += c;
CMP	R6, R5
IT	LT
BLT	L__Int32String80
ADD	R7, R7, R8, LSL #0
SXTH	R7, R7
; c end address is: 32 (R8)
; n end address is: 28 (R7)
IT	AL
BAL	L_Int32String36
L__Int32String80:
L_Int32String36:
;Calculate.c,123 :: 		switch ( i ) {
; n start address is: 28 (R7)
IT	AL
BAL	L_Int32String37
; i end address is: 24 (R6)
;Calculate.c,124 :: 		case 9:
L_Int32String39:
;Calculate.c,125 :: 		*p++ = '0'+n/1000000000;
MOVW	R3, #51712
MOVT	R3, #15258
SDIV	R3, R7, R3
ADDS	R3, #48
STRB	R3, [R2, #0]
ADDS	R6, R2, #1
; p end address is: 8 (R2)
; p start address is: 24 (R6)
;Calculate.c,126 :: 		if ( --e == 0 ) break;
SUBS	R3, R5, #1
SXTH	R3, R3
CMP	R3, #0
IT	NE
BNE	L_Int32String40
; e end address is: 20 (R5)
; n end address is: 28 (R7)
MOV	R2, R6
IT	AL
BAL	L_Int32String38
L_Int32String40:
;Calculate.c,127 :: 		n %= 1000000000;
; n start address is: 28 (R7)
; e start address is: 20 (R5)
MOVW	R4, #51712
MOVT	R4, #15258
SDIV	R3, R7, R4
MLS	R3, R4, R3, R7
; n end address is: 28 (R7)
; n start address is: 8 (R2)
SXTH	R2, R3
;Calculate.c,128 :: 		*p++ = '.', i = 0;
MOVS	R3, #46
STRB	R3, [R6, #0]
ADDS	R4, R6, #1
; p end address is: 24 (R6)
; p start address is: 16 (R4)
; i start address is: 24 (R6)
MOVS	R6, #0
SXTH	R6, R6
; i end address is: 24 (R6)
; p end address is: 16 (R4)
; n end address is: 8 (R2)
;Calculate.c,129 :: 		case 8:
IT	AL
BAL	L_Int32String41
L__Int32String81:
;Calculate.c,165 :: 		}
MOV	R4, R2
SXTH	R2, R7
;Calculate.c,129 :: 		case 8:
L_Int32String41:
;Calculate.c,130 :: 		*p++ = '0'+n/100000000;
; i start address is: 24 (R6)
; p start address is: 16 (R4)
; n start address is: 8 (R2)
MOVW	R3, #57600
MOVT	R3, #1525
SDIV	R3, R2, R3
ADDS	R3, #48
STRB	R3, [R4, #0]
ADDS	R3, R4, #1
; p end address is: 16 (R4)
; p start address is: 28 (R7)
MOV	R7, R3
;Calculate.c,131 :: 		if ( --e == 0 ) break;
SUBS	R3, R5, #1
SXTH	R3, R3
SXTH	R5, R3
CMP	R3, #0
IT	NE
BNE	L_Int32String42
; i end address is: 24 (R6)
; e end address is: 20 (R5)
; n end address is: 8 (R2)
MOV	R2, R7
IT	AL
BAL	L_Int32String38
L_Int32String42:
;Calculate.c,132 :: 		n %= 100000000;
; n start address is: 8 (R2)
; e start address is: 20 (R5)
; i start address is: 24 (R6)
MOVW	R4, #57600
MOVT	R4, #1525
SDIV	R3, R2, R4
MLS	R3, R4, R3, R2
SXTH	R2, R3
; i end address is: 24 (R6)
; p end address is: 28 (R7)
; e end address is: 20 (R5)
; n end address is: 8 (R2)
SXTH	R4, R5
MOV	R5, R7
SXTH	R7, R2
SXTH	R2, R6
;Calculate.c,133 :: 		case 7:
IT	AL
BAL	L_Int32String43
L__Int32String82:
;Calculate.c,165 :: 		}
SXTH	R4, R5
MOV	R5, R2
SXTH	R2, R6
;Calculate.c,133 :: 		case 7:
L_Int32String43:
;Calculate.c,134 :: 		*p++ = '0'+n/10000000;
; n start address is: 28 (R7)
; e start address is: 16 (R4)
; p start address is: 20 (R5)
; i start address is: 8 (R2)
MOVW	R3, #38528
MOVT	R3, #152
SDIV	R3, R7, R3
ADDS	R3, #48
STRB	R3, [R5, #0]
ADDS	R5, R5, #1
;Calculate.c,135 :: 		if ( --e == 0 ) break;
SUBS	R3, R4, #1
SXTH	R3, R3
; e end address is: 16 (R4)
; e start address is: 24 (R6)
SXTH	R6, R3
CMP	R3, #0
IT	NE
BNE	L_Int32String44
; i end address is: 8 (R2)
; n end address is: 28 (R7)
; e end address is: 24 (R6)
MOV	R2, R5
IT	AL
BAL	L_Int32String38
L_Int32String44:
;Calculate.c,136 :: 		n %= 10000000;
; e start address is: 24 (R6)
; n start address is: 28 (R7)
; i start address is: 8 (R2)
MOVW	R4, #38528
MOVT	R4, #152
SDIV	R3, R7, R4
MLS	R3, R4, R3, R7
SXTH	R7, R3
; i end address is: 8 (R2)
; n end address is: 28 (R7)
; e end address is: 24 (R6)
; p end address is: 20 (R5)
STR	R5, [SP, #0]
SXTH	R5, R2
SXTH	R4, R6
LDR	R2, [SP, #0]
;Calculate.c,137 :: 		case 6:
IT	AL
BAL	L_Int32String45
L__Int32String83:
;Calculate.c,165 :: 		}
SXTH	R4, R5
SXTH	R5, R6
;Calculate.c,137 :: 		case 6:
L_Int32String45:
;Calculate.c,138 :: 		*p++ = '0'+n/1000000;
; n start address is: 28 (R7)
; e start address is: 16 (R4)
; p start address is: 8 (R2)
; i start address is: 20 (R5)
MOVW	R3, #16960
MOVT	R3, #15
SDIV	R3, R7, R3
ADDS	R3, #48
STRB	R3, [R2, #0]
ADDS	R6, R2, #1
; p end address is: 8 (R2)
; p start address is: 24 (R6)
;Calculate.c,139 :: 		if ( --e == 0 ) break;
SUBS	R3, R4, #1
SXTH	R3, R3
; e end address is: 16 (R4)
; e start address is: 8 (R2)
SXTH	R2, R3
CMP	R3, #0
IT	NE
BNE	L_Int32String46
; n end address is: 28 (R7)
; i end address is: 20 (R5)
; e end address is: 8 (R2)
MOV	R2, R6
IT	AL
BAL	L_Int32String38
L_Int32String46:
;Calculate.c,140 :: 		n %= 1000000;
; e start address is: 8 (R2)
; i start address is: 20 (R5)
; n start address is: 28 (R7)
MOVW	R4, #16960
MOVT	R4, #15
SDIV	R3, R7, R4
MLS	R3, R4, R3, R7
; n end address is: 28 (R7)
; n start address is: 16 (R4)
SXTH	R4, R3
;Calculate.c,141 :: 		if ( i ) *p++ = '.', i = 0;
CMP	R5, #0
IT	EQ
BEQ	L__Int32String84
; i end address is: 20 (R5)
MOVS	R3, #46
STRB	R3, [R6, #0]
ADDS	R5, R6, #1
; p end address is: 24 (R6)
; p start address is: 20 (R5)
; i start address is: 12 (R3)
MOVS	R3, #0
SXTH	R3, R3
; i end address is: 12 (R3)
; p end address is: 20 (R5)
STRH	R3, [SP, #0]
MOV	R3, R5
LDRSH	R5, [SP, #0]
IT	AL
BAL	L_Int32String47
L__Int32String84:
MOV	R3, R6
L_Int32String47:
;Calculate.c,142 :: 		case 5:
; i start address is: 20 (R5)
; p start address is: 12 (R3)
SXTH	R7, R2
; i end address is: 20 (R5)
; e end address is: 8 (R2)
; p end address is: 12 (R3)
; n end address is: 16 (R4)
SXTH	R2, R5
SXTH	R6, R4
MOV	R4, R3
IT	AL
BAL	L_Int32String48
L__Int32String85:
;Calculate.c,165 :: 		}
MOV	R4, R2
SXTH	R2, R6
SXTH	R6, R7
SXTH	R7, R5
;Calculate.c,142 :: 		case 5:
L_Int32String48:
;Calculate.c,143 :: 		*p++ = '0'+n/100000;
; p start address is: 16 (R4)
; i start address is: 8 (R2)
; n start address is: 24 (R6)
; e start address is: 28 (R7)
MOVW	R3, #34464
MOVT	R3, #1
SDIV	R3, R6, R3
ADDS	R3, #48
STRB	R3, [R4, #0]
ADDS	R5, R4, #1
; p end address is: 16 (R4)
; p start address is: 20 (R5)
;Calculate.c,144 :: 		if ( --e == 0 ) break;
SUBS	R3, R7, #1
SXTH	R3, R3
SXTH	R7, R3
CMP	R3, #0
IT	NE
BNE	L_Int32String49
; e end address is: 28 (R7)
; i end address is: 8 (R2)
; n end address is: 24 (R6)
MOV	R2, R5
IT	AL
BAL	L_Int32String38
L_Int32String49:
;Calculate.c,145 :: 		n %= 100000;
; n start address is: 24 (R6)
; i start address is: 8 (R2)
; e start address is: 28 (R7)
MOVW	R4, #34464
MOVT	R4, #1
SDIV	R3, R6, R4
MLS	R3, R4, R3, R6
; n end address is: 24 (R6)
; n start address is: 16 (R4)
SXTH	R4, R3
; e end address is: 28 (R7)
; i end address is: 8 (R2)
; p end address is: 20 (R5)
; n end address is: 16 (R4)
STRH	R4, [SP, #0]
SXTH	R4, R7
LDRSH	R7, [SP, #0]
;Calculate.c,146 :: 		case 4:
IT	AL
BAL	L_Int32String50
L__Int32String86:
;Calculate.c,165 :: 		}
SXTH	R4, R5
MOV	R5, R2
SXTH	R2, R6
;Calculate.c,146 :: 		case 4:
L_Int32String50:
;Calculate.c,147 :: 		*p++ = '0'+n/10000;
; n start address is: 28 (R7)
; e start address is: 16 (R4)
; p start address is: 20 (R5)
; i start address is: 8 (R2)
MOVW	R3, #10000
SXTH	R3, R3
SDIV	R3, R7, R3
SXTH	R3, R3
ADDS	R3, #48
STRB	R3, [R5, #0]
ADDS	R5, R5, #1
;Calculate.c,148 :: 		if ( --e == 0 ) break;
SUBS	R3, R4, #1
SXTH	R3, R3
; e end address is: 16 (R4)
; e start address is: 24 (R6)
SXTH	R6, R3
CMP	R3, #0
IT	NE
BNE	L_Int32String51
; i end address is: 8 (R2)
; n end address is: 28 (R7)
; e end address is: 24 (R6)
MOV	R2, R5
IT	AL
BAL	L_Int32String38
L_Int32String51:
;Calculate.c,149 :: 		n %= 10000;
; e start address is: 24 (R6)
; n start address is: 28 (R7)
; i start address is: 8 (R2)
MOVW	R4, #10000
SXTH	R4, R4
SDIV	R7, R7, R4
MLS	R7, R4, R7, R7
SXTH	R7, R7
; i end address is: 8 (R2)
; n end address is: 28 (R7)
; e end address is: 24 (R6)
; p end address is: 20 (R5)
STR	R5, [SP, #0]
SXTH	R5, R2
SXTH	R4, R6
LDR	R2, [SP, #0]
;Calculate.c,150 :: 		case 3:
IT	AL
BAL	L_Int32String52
L__Int32String87:
;Calculate.c,165 :: 		}
SXTH	R4, R5
SXTH	R5, R6
;Calculate.c,150 :: 		case 3:
L_Int32String52:
;Calculate.c,151 :: 		*p++ = '0'+n/1000;
; n start address is: 28 (R7)
; e start address is: 16 (R4)
; p start address is: 8 (R2)
; i start address is: 20 (R5)
MOVW	R3, #1000
SXTH	R3, R3
SDIV	R3, R7, R3
SXTH	R3, R3
ADDS	R3, #48
STRB	R3, [R2, #0]
ADDS	R3, R2, #1
; p end address is: 8 (R2)
; p start address is: 24 (R6)
MOV	R6, R3
;Calculate.c,152 :: 		if ( --e == 0 ) break;
SUBS	R3, R4, #1
SXTH	R3, R3
; e end address is: 16 (R4)
; e start address is: 8 (R2)
SXTH	R2, R3
CMP	R3, #0
IT	NE
BNE	L_Int32String53
; n end address is: 28 (R7)
; i end address is: 20 (R5)
; e end address is: 8 (R2)
MOV	R2, R6
IT	AL
BAL	L_Int32String38
L_Int32String53:
;Calculate.c,153 :: 		n %= 1000;
; e start address is: 8 (R2)
; i start address is: 20 (R5)
; n start address is: 28 (R7)
MOVW	R4, #1000
SXTH	R4, R4
SDIV	R4, R7, R4
MLS	R4, R4, R4, R7
SXTH	R4, R4
; n end address is: 28 (R7)
; n start address is: 16 (R4)
;Calculate.c,154 :: 		if ( i ) *p++ = '.', i = 0;
CMP	R5, #0
IT	EQ
BEQ	L__Int32String88
; i end address is: 20 (R5)
MOVS	R3, #46
STRB	R3, [R6, #0]
ADDS	R5, R6, #1
; p end address is: 24 (R6)
; p start address is: 20 (R5)
; p end address is: 20 (R5)
MOV	R3, R5
IT	AL
BAL	L_Int32String54
L__Int32String88:
MOV	R3, R6
L_Int32String54:
;Calculate.c,155 :: 		case 2:
; p start address is: 12 (R3)
SXTH	R6, R2
; e end address is: 8 (R2)
; p end address is: 12 (R3)
; n end address is: 16 (R4)
SXTH	R2, R4
MOV	R4, R3
IT	AL
BAL	L_Int32String55
L__Int32String89:
;Calculate.c,165 :: 		}
MOV	R4, R2
SXTH	R2, R7
SXTH	R6, R5
;Calculate.c,155 :: 		case 2:
L_Int32String55:
;Calculate.c,156 :: 		*p++ = '0'+n/100;
; p start address is: 16 (R4)
; n start address is: 8 (R2)
; e start address is: 24 (R6)
MOVS	R3, #100
SXTH	R3, R3
SDIV	R3, R2, R3
SXTH	R3, R3
ADDS	R3, #48
STRB	R3, [R4, #0]
ADDS	R5, R4, #1
; p end address is: 16 (R4)
; p start address is: 20 (R5)
;Calculate.c,157 :: 		if ( --e == 0 ) break;
SUBS	R3, R6, #1
SXTH	R3, R3
SXTH	R6, R3
CMP	R3, #0
IT	NE
BNE	L_Int32String56
; e end address is: 24 (R6)
; n end address is: 8 (R2)
MOV	R2, R5
IT	AL
BAL	L_Int32String38
L_Int32String56:
;Calculate.c,158 :: 		n %= 100;
; n start address is: 8 (R2)
; e start address is: 24 (R6)
MOVS	R4, #100
SXTH	R4, R4
SDIV	R3, R2, R4
MLS	R3, R4, R3, R2
SXTH	R2, R3
; e end address is: 24 (R6)
; n end address is: 8 (R2)
; p end address is: 20 (R5)
SXTH	R4, R6
SXTH	R6, R2
MOV	R2, R5
;Calculate.c,159 :: 		case 1:
IT	AL
BAL	L_Int32String57
L__Int32String90:
;Calculate.c,165 :: 		}
SXTH	R6, R7
SXTH	R4, R5
;Calculate.c,159 :: 		case 1:
L_Int32String57:
;Calculate.c,160 :: 		*p++ = '0'+n/10;
; n start address is: 24 (R6)
; e start address is: 16 (R4)
; p start address is: 8 (R2)
MOVS	R3, #10
SXTH	R3, R3
SDIV	R3, R6, R3
SXTH	R3, R3
ADDS	R3, #48
STRB	R3, [R2, #0]
ADDS	R3, R2, #1
; p end address is: 8 (R2)
; p start address is: 20 (R5)
MOV	R5, R3
;Calculate.c,161 :: 		if ( --e == 0 ) break;
SUBS	R3, R4, #1
SXTH	R3, R3
; e end address is: 16 (R4)
CMP	R3, #0
IT	NE
BNE	L_Int32String58
; n end address is: 24 (R6)
MOV	R2, R5
IT	AL
BAL	L_Int32String38
L_Int32String58:
;Calculate.c,162 :: 		n %= 10;
; n start address is: 24 (R6)
MOVS	R4, #10
SXTH	R4, R4
SDIV	R4, R6, R4
MLS	R4, R4, R4, R6
SXTH	R4, R4
; n end address is: 24 (R6)
; n start address is: 16 (R4)
; p end address is: 20 (R5)
; n end address is: 16 (R4)
MOV	R2, R5
;Calculate.c,163 :: 		case 0:
IT	AL
BAL	L_Int32String59
L__Int32String91:
;Calculate.c,165 :: 		}
SXTH	R4, R7
;Calculate.c,163 :: 		case 0:
L_Int32String59:
;Calculate.c,164 :: 		*p++ = '0'+n;
; n start address is: 16 (R4)
; p start address is: 8 (R2)
ADDW	R3, R4, #48
; n end address is: 16 (R4)
STRB	R3, [R2, #0]
ADDS	R2, R2, #1
;Calculate.c,165 :: 		}
IT	AL
BAL	L_Int32String38
L_Int32String37:
; n start address is: 28 (R7)
; e start address is: 20 (R5)
; i start address is: 24 (R6)
CMP	R6, #9
IT	EQ
BEQ	L_Int32String39
CMP	R6, #8
IT	EQ
BEQ	L__Int32String81
CMP	R6, #7
IT	EQ
BEQ	L__Int32String82
CMP	R6, #6
IT	EQ
BEQ	L__Int32String83
CMP	R6, #5
IT	EQ
BEQ	L__Int32String85
CMP	R6, #4
IT	EQ
BEQ	L__Int32String86
CMP	R6, #3
IT	EQ
BEQ	L__Int32String87
CMP	R6, #2
IT	EQ
BEQ	L__Int32String89
CMP	R6, #1
IT	EQ
BEQ	L__Int32String90
; e end address is: 20 (R5)
CMP	R6, #0
IT	EQ
BEQ	L__Int32String91
; i end address is: 24 (R6)
; n end address is: 28 (R7)
; p end address is: 8 (R2)
L_Int32String38:
;Calculate.c,166 :: 		while ( p < r->str+fixlen )
; p start address is: 8 (R2)
STR	R1, [SP, #0]
; r end address is: 4 (R1)
; p end address is: 8 (R2)
MOV	R1, R2
SXTH	R2, R0
LDR	R0, [SP, #0]
L_Int32String60:
; p start address is: 4 (R1)
; fixlen start address is: 8 (R2)
ADDS	R3, R0, #2
ADDS	R3, R3, R2
CMP	R1, R3
IT	CS
BCS	L_Int32String61
;Calculate.c,167 :: 		*p++ = ' ';
MOVS	R3, #32
STRB	R3, [R1, #0]
ADDS	R1, R1, #1
; fixlen end address is: 8 (R2)
IT	AL
BAL	L_Int32String60
L_Int32String61:
;Calculate.c,168 :: 		*p = 0;
MOVS	R3, #0
STRB	R3, [R1, #0]
;Calculate.c,169 :: 		r->len = p-r->str;
ADDS	R4, R0, #1
ADDS	R3, R0, #2
SUB	R3, R1, R3
; p end address is: 4 (R1)
STRB	R3, [R4, #0]
;Calculate.c,170 :: 		}
L_end_Int32String:
ADD	SP, SP, #4
BX	LR
; end of _Int32String
_Char_to_Str:
;Calculate.c,174 :: 		void Char_to_Str(unsigned char *p, unsigned char n)
; n start address is: 4 (R1)
SUB	SP, SP, #4
; n end address is: 4 (R1)
; n start address is: 4 (R1)
;Calculate.c,176 :: 		*p++ = '0'+n/100;
MOVS	R2, #100
UDIV	R2, R1, R2
UXTB	R2, R2
ADDS	R2, #48
STRB	R2, [R0, #0]
ADDS	R2, R0, #1
; p start address is: 16 (R4)
MOV	R4, R2
;Calculate.c,177 :: 		n %= 100;
MOVS	R2, #100
UDIV	R3, R1, R2
MLS	R3, R2, R3, R1
UXTB	R3, R3
; n end address is: 4 (R1)
UXTB	R0, R3
;Calculate.c,178 :: 		*p++ = '0'+n/10;
MOVS	R2, #10
UDIV	R2, R3, R2
UXTB	R2, R2
ADDS	R2, #48
STRB	R2, [R4, #0]
ADDS	R2, R4, #1
; p end address is: 16 (R4)
; p start address is: 4 (R1)
MOV	R1, R2
;Calculate.c,179 :: 		n %= 10;
MOVS	R3, #10
UDIV	R2, R0, R3
MLS	R2, R3, R2, R0
UXTB	R2, R2
;Calculate.c,180 :: 		*p++ = '0'+n;
ADDS	R2, #48
STRB	R2, [R1, #0]
ADDS	R3, R1, #1
; p end address is: 4 (R1)
;Calculate.c,181 :: 		*p = 0;
MOVS	R2, #0
STRB	R2, [R3, #0]
;Calculate.c,182 :: 		}
L_end_Char_to_Str:
ADD	SP, SP, #4
BX	LR
; end of _Char_to_Str
_Char_to_Hex:
;Calculate.c,186 :: 		void Char_to_Hex(unsigned char *p, unsigned char n)
; n start address is: 4 (R1)
SUB	SP, SP, #4
; n end address is: 4 (R1)
; n start address is: 4 (R1)
;Calculate.c,188 :: 		if(n/16>9)
LSRS	R2, R1, #4
UXTB	R2, R2
CMP	R2, #9
IT	LS
BLS	L_Char_to_Hex62
;Calculate.c,189 :: 		*p++ = 'A'+(n/16-10);
LSRS	R2, R1, #4
UXTB	R2, R2
SUBS	R2, #10
SXTH	R2, R2
ADDS	R2, #65
STRB	R2, [R0, #0]
ADDS	R0, R0, #1
IT	AL
BAL	L_Char_to_Hex63
L_Char_to_Hex62:
;Calculate.c,191 :: 		*p++ = '0'+n/16;
LSRS	R2, R1, #4
UXTB	R2, R2
ADDS	R2, #48
STRB	R2, [R0, #0]
ADDS	R0, R0, #1
L_Char_to_Hex63:
;Calculate.c,192 :: 		n %= 16;
AND	R2, R1, #15
UXTB	R2, R2
UXTB	R1, R2
;Calculate.c,193 :: 		if(n>9)
CMP	R2, #9
IT	LS
BLS	L_Char_to_Hex64
;Calculate.c,194 :: 		*p++ = 'A'+(n-10);
SUBW	R2, R1, #10
SXTH	R2, R2
; n end address is: 4 (R1)
ADDS	R2, #65
STRB	R2, [R0, #0]
ADDS	R0, R0, #1
IT	AL
BAL	L_Char_to_Hex65
L_Char_to_Hex64:
;Calculate.c,196 :: 		*p++ = '0'+n;
; n start address is: 4 (R1)
ADDW	R2, R1, #48
; n end address is: 4 (R1)
STRB	R2, [R0, #0]
ADDS	R0, R0, #1
L_Char_to_Hex65:
;Calculate.c,197 :: 		*p++ = ' ';
MOVS	R2, #32
STRB	R2, [R0, #0]
ADDS	R3, R0, #1
;Calculate.c,198 :: 		*p = 0;
MOVS	R2, #0
STRB	R2, [R3, #0]
;Calculate.c,199 :: 		}
L_end_Char_to_Hex:
ADD	SP, SP, #4
BX	LR
; end of _Char_to_Hex
