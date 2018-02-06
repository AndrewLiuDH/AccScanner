﻿; =========================================================================      
; Project:       
; File:          main.asm
; Description:   
;                 
; Author:        
; Version:       
; Date:         
;*****************************************************************************
;---------------Program Credit History----------------------------------------
;2013/12/10	Start
;-----------------------------------------------------------------------------
;	Pin define
;	1	VDD		Power
;	2	PA7		Input for SW
;	3	PA5		Input for CANL check
;	4	PB3		Input for 12V Start pulse check(INT)
;	5	PA0		Output for +5V Power
;	6	PA2		Output for ACC Power
;	7	PA4		ADC Input for Voltage(ADC)
;	8	VSS		Ground
;--------------- File Include ---------------------------------------------
;--------------------------------------------------------------------------
#include		AT8B.H						; The Header File for AT8B71A 

;--------------- Variable Defination --------------------------------------
;--------------------------------------------------------------------------
;---------------Custom define segment-----------Using segment-----------Share(y/n)
RG_INT_ACCTMP		EQU		0x20			;INTERRUPT ACC TEMP	;N
RG_INT_STATMP		EQU		0x21			;INTERRUPT STATUS TEMP	;N

;-------
RG_STAT1_WORD   	EQU     0x22
STAT1_INPUT2_B		=	0x0
STAT1_INPUT_CAN_B	=	0x1
STAT1_MODE_B		=	0x2
STAT1_INPUT7_B		=	0x3
STAT1_10MS_B		=	0x4
STAT1_131MS_B		=	0x5
STAT1_START_B		=	0x6
STAT1_ON_B		=	0x7

RG_STAT2_WORD   	EQU     0x23
STAT2_CAN_TRI_B		=	0x0
STAT2_POW_ON_B		=	0x1
STAT2_WAVE_B		=	0x2
STAT2_CAN_SYS_B		=	0x3
STAT2_CAN_ON_B		=	0x4

STAT2_UP13V_B		=	0x5	;

STAT2_TOGGLE_B		=	0x6

STAT2_11V_LOW_B		=	0x7



RG_JIFFIES			EQU     0x24

RG_INPUT2_CNT		EQU     0x25
RG_INPUT4_CNT		EQU     0x26
RG_MODE_CNT			EQU     0x27
RG_INPUT7_CNT		EQU     0x28

RG_INT_CNT			EQU     0x29

RG_INPUT7_CNTH		EQU     0x2A

RG_CAN_DEB			EQU     0x2B

RG_TICKS_L			EQU     0x2C
RG_TICKS_H			EQU     0x2D
RG_CAN_CNTL			EQU     0x2E
RG_CAN_CNTH			EQU     0x2F

RG_COUNT_CNT		EQU     0x30




RG_STAT3_WORD   	EQU     0x31
STAT3_ISTATE_A1_B	=	0x0
STAT3_ISTATE_A2_B	=	0x1
STAT3_ISTATE_CAN_B	=	0x2
STAT3_VOLTAGE_115_B	=	0x3
STAT3_VOLTAGE_117_B	=	0x4
STAT3_VOLTAGE_126_B	=	0x5
STAT3_2S_B		=	0x6
STAT3_ISTATE_B0_B	=	0x7


RG_2S_CNT			EQU     0x32

RG_SLEEP_CNT		EQU     0x33


RG_STAT4_WORD   	EQU     0x34
STAT4_VOLTAGE_122_B	=	0x0
STAT4_VOLTAGE_128_B	=	0x1
STAT4_CANH_134S_B	=	0x2
STAT4_CANW_134S_B	=	0x3
STAT4_UP13V_TRI_B	=	0x4

RG_TOGGLE_CNT		EQU     0x38
RG_PORT_TEMP		EQU     0x39
RG_5VPOW_CNT		EQU     0x3A

RG_128V_CNT		EQU     0x3B

;---------------
RG_VOL_INDEX   		EQU     0x40
RG_VOL_H		EQU     0x41
RG_VOL_L    		EQU     0x42
RG_V_CNTH    		EQU     0x43
RG_V_CNTL    		EQU     0x44




RG_VOL1_ADH		EQU     0x70
RG_VOL2_ADH    		EQU     0x71
RG_VOL3_ADH		EQU     0x72
RG_VOL4_ADH    		EQU     0x73
RG_VOL5_ADH		EQU     0x74
RG_VOL6_ADH    		EQU     0x75
RG_VOL7_ADH		EQU     0x76
RG_VOL8_ADH    		EQU     0x77
RG_VOL9_ADH		EQU     0x78
RG_VOL10_ADH    	EQU     0x79
RG_VOL11_ADH		EQU     0x7A
RG_VOL12_ADH    	EQU     0x7B
RG_VOL13_ADH		EQU     0x7C
RG_VOL14_ADH    	EQU     0x7D
RG_VOL15_ADH		EQU     0x7E
RG_VOL16_ADH    	EQU     0x7F
;---------------





;---------------vaule segment-------------------Using segment-----------------

EQ_PORTA_SET      	=  	11111010B	;PORTA input and output set (ALL Is Intput expect PA2 PA0)
EQ_PORTB_SET      	=  	11111111B	;PORTB input and output set (ALL Is Intput)


EQ_ACCPOW_B		=	0x02
EQ_5VPOW_B		=	0x00
EQ_INPUT_CAN_B		=	0x05
EQ_VOL_BUFFER		=     	0x70

f	= 1
R	= 1
W	= 0
A	= 0

IOB3_B		=	3
Z_B		=	C_Status_Z_Bit
C_B		=	C_Status_C_Bit
;--------------- Constant Defination --------------------------------------
;--------------------------------------------------------------------------
;		C_Temp		EQU		0xFF			; Example



;--------------- Vector Defination ----------------------------------------
;--------------------------------------------------------------------------
		ORG		0x000		
		LGOTO	V_Main                
		
		ORG		0x008
		LGOTO	V_INT
		
;--------------- Code Start -----------------------------------------------
;--------------------------------------------------------------------------
		ORG		0x010
;--------------- Interrupt Service Routine --------------------------------
;--------------------------------------------------------------------------
V_INT:
		; Interrupt Service - User program area
		MOVAR	RG_INT_ACCTMP
		MOVR	STATUS,A
		MOVAR	RG_INT_STATMP					;Backup ACC & STATUS register code
		
		BTRSC	INTF,C_INT_PABKey_Bit			;External interrupt
		GOTO	INTPIN
		BTRSC   INTF,C_INT_TMR1_Bit
		GOTO   	TMR1INT

	

EXIT_INTSRV:

		MOVR    RG_INT_STATMP,A
		MOVAR   STATUS
		MOVR    RG_INT_ACCTMP,A				;Restore ACC & STATUS register code
		; Clear Interrupt Flag
		RETIE								; Return from interrupt and enable interrupt globally		


		
INTPIN:
		MOVR    INTF,A					;Note: BCR instruction is NOT recommended for Clear interrupt flag(INTFLAG register)
		ANDIA	0xFD						;Clear INTIF Flag
		MOVAR	INTF

		
    INTPIN_12V:
		MOVR	PORTB,A
		MOVAR	RG_PORT_TEMP
		BTRSC   RG_PORT_TEMP,IOB3_B
		GOTO	INTPIN_B3_HIGH
	INTPIN_B3_LOW:
		
		BTRSS	RG_STAT3_WORD,STAT3_ISTATE_A1_B
		GOTO	EXIT_INTSRV
		;---
		BCR		RG_STAT3_WORD,STAT3_ISTATE_A1_B
		;---
		CLRR	RG_TICKS_L
		CLRR	RG_TICKS_H
		;---
		BSR		RG_STAT1_WORD,STAT1_START_B
		;---
		GOTO	EXIT_INTSRV

	INTPIN_B3_HIGH:
		BSR		RG_STAT3_WORD,STAT3_ISTATE_A1_B
		GOTO	EXIT_INTSRV		
		
	
;8.48MS timer
TMR1INT:
		MOVR    INTF,A					;Note: BCR instruction is NOT recommended for Clear interrupt flag(INTFLAG register)
		ANDIA	0xF7						;Clear T0IF Flag
		MOVAR	INTF		
		
		INCR    RG_JIFFIES,R          		;Add 1 to jiffies(8.19ms)
		BSR		RG_STAT1_WORD,STAT1_10MS_B
		BTRSS	RG_JIFFIES,4
		GOTO   EXIT_INTSRV


		BSR		RG_STAT1_WORD,STAT1_131MS_B
		MOVIA	0X10
		ADDAR	RG_JIFFIES,R

		BTRSS   STATUS,Z_B
		GOTO	EXIT_INTSRV

		INCR    RG_CAN_DEB,R

		

		INCR    RG_TICKS_L,R		;1048MS counter
		BTRSC   STATUS,Z_B
		INCR    RG_TICKS_H,R

		INCR    RG_2S_CNT,R
		BTRSC   RG_2S_CNT,0
		GOTO	EXIT_INTSRV

		BSR		RG_STAT3_WORD,STAT3_2S_B

		BCR		RG_STAT2_WORD,STAT2_TOGGLE_B
		MOVIA   0x03
		SUBAR	RG_TOGGLE_CNT,A
		BTRSC   STATUS,C_B
		BSR		RG_STAT2_WORD,STAT2_TOGGLE_B
		CLRR	RG_TOGGLE_CNT


		;---
TMR1INT_EXIT:
		GOTO	EXIT_INTSRV	
	
	
	
;-----------------------------------------------------------------------------

;-----------------------------------------------------------------------------

;-----------------------------------------------------------------------------
;Called In a circle
;135MS Cycle Task
ADC_VOLTAGE:
		CLRWDT

VOLTAGE_START:


		BTRSS	ADMD,C_Finish_Bit
		GOTO	$-1					;Make Sure no adc is processing
		BSR		ADMD,C_Start_Bit	;AD conversion start
		BTRSS	ADMD,C_Finish_Bit
		GOTO	$-1					;Wait AD end of conversion
		
		MOVR	RG_VOL_INDEX,A
		BTRSS	RG_VOL_INDEX,4
		MOVIA   EQ_VOL_BUFFER
		MOVAR   FSR
		MOVR	ADD,A
		MOVAR	INDF
		INCR    FSR,R
;		MOVR	ADR,A
;		MOVAR	RG_V_CNTL
		MOVR	FSR,A
		MOVAR   RG_VOL_INDEX
		RET
	
	
	
;-----------------------------------------------------------------------------
;Called In a circle
;135MS Cycle Task
CACULATE_VOLTAGE_CNT:
		CLRWDT
		CLRR 	RG_VOL_H
		CLRR 	RG_VOL_L
		MOVIA   EQ_VOL_BUFFER
		MOVAR   FSR
		CLRA
VOLTAGE_ADD:	;Cyclic accumulation
		CLRWDT
		ADDAR	INDF,A
		BTRSC   STATUS,C_B
		INCR    RG_VOL_H,R 

		INCR    FSR,R
		BTRSC	FSR,4
		GOTO   VOLTAGE_ADD
		
		ANDIA	0xF0
		MOVAR   RG_VOL_L
		SWAPR	RG_VOL_L,R
		SWAPR	RG_VOL_H,A
		ADDAR	RG_VOL_L,A	
		MOVAR   RG_V_CNTH	;the last value getted in RG_VOL_CNTH

		MOVAR   RG_VOL_L

VOLTAGE_CHECK_SYS:

		BCR		RG_STAT3_WORD,STAT3_VOLTAGE_115_B
		MOVIA   0x0C4		;11.5V Value(0XC44) 11.48V
		SUBAR	RG_VOL_L,A
		BTRSC   STATUS,C_B
		BSR		RG_STAT3_WORD,STAT3_VOLTAGE_115_B


		BCR		RG_STAT3_WORD,STAT3_VOLTAGE_117_B
		MOVIA   0x0C7		;11.7V Value(0XC7A) 11.66V
		SUBAR	RG_VOL_L,A
		BTRSC   STATUS,C_B
		BSR		RG_STAT3_WORD,STAT3_VOLTAGE_117_B


		BCR		RG_STAT4_WORD,STAT4_VOLTAGE_122_B
		MOVIA   0x0D0		;12.2V Value(0XD03) 12.18V
		SUBAR	RG_VOL_L,A
		BTRSC   STATUS,C_B
		BSR		RG_STAT4_WORD,STAT4_VOLTAGE_122_B



		BCR		RG_STAT3_WORD,STAT3_VOLTAGE_126_B
		MOVIA   0x0D8		;12.656V Value(0XD80)
		SUBAR	RG_VOL_L,A
		BTRSC   STATUS,C_B
		BSR		RG_STAT3_WORD,STAT3_VOLTAGE_126_B

		BCR		RG_STAT4_WORD,STAT4_VOLTAGE_128_B
		MOVIA   0x0DE		;13.0078V Value(0XDE0)
		SUBAR	RG_VOL_L,A
		BTRSC   STATUS,C_B
		BSR		RG_STAT4_WORD,STAT4_VOLTAGE_128_B
		RET

	
	















;-----------------------------------------------------------------------------

;Called In a circle
;ALL Cycle Task
;10MS Cycle Task
EX_INT_CHECK:
		CLRWDT
		BTRSC	RG_STAT1_WORD,STAT1_START_B
		LGOTO	INT_CHECK_START
		CLRR	RG_INT_CNT
		CLRR	RG_COUNT_CNT
		RET
INT_CHECK_START:
;CHECK_START_A1:
		MOVR	PORTB,A
		MOVAR	RG_PORT_TEMP
		BTRSC   RG_PORT_TEMP,IOB3_B
		LGOTO	NOW_A1_HIGH


	NOW_A1_LOW:
		
		BTRSS	RG_INT_CNT,3 			;DEBOUNCE = 80MS  
		RET
		
		BCR		RG_STAT1_WORD,STAT1_START_B
		BSR		RG_STAT1_WORD,STAT1_ON_B
		CLRR	RG_INT_CNT
		CLRR	RG_COUNT_CNT
		RET


	NOW_A1_HIGH:
		BTRSS	RG_COUNT_CNT,3 			;DEBOUNCE = 80MS  
		RET

		BCR		RG_STAT1_WORD,STAT1_START_B
		CLRR	RG_INT_CNT
		CLRR	RG_COUNT_CNT
		RET


;-----------------------------------------------------------------------------
;Called In a circle
;131MS Cycle Task
;12.6v(12V)   25V(24V)Check
INPUT2_CHECK:
		CLRWDT
		BTRSC	RG_STAT3_WORD,STAT3_VOLTAGE_126_B
		LGOTO	NOW_INPUT2_HIGH

NOW_INPUT2_LOW:
		BTRSC	RG_STAT1_WORD,STAT1_INPUT2_B
		LGOTO	INPUT2_LOW_CHECK

		CLRR	RG_INPUT2_CNT
		RET

INPUT2_LOW_CHECK:
		INCR	RG_INPUT2_CNT,R
		BTRSS	RG_INPUT2_CNT,3			;DEBOUNCE = 1080MS
		RET
		BCR		RG_STAT1_WORD,STAT1_INPUT2_B
		CLRR	RG_INPUT2_CNT
		RET



NOW_INPUT2_HIGH:
		CLRR	RG_TICKS_L
		BTRSS	RG_STAT1_WORD,STAT1_INPUT2_B
		LGOTO	INPUT2_HIGH_CHECK

;		BSR		PORTA,EQ_5VPOW_B
		CLRR	RG_INPUT2_CNT
		RET

INPUT2_HIGH_CHECK:
		INCR	RG_INPUT2_CNT,R
		BTRSS	RG_INPUT2_CNT,3			;DEBOUNCE = 1080MS
		RET
		BSR		RG_STAT1_WORD,STAT1_INPUT2_B
		CLRR	RG_INPUT2_CNT
		RET


;-----------------------------------------------------------------------------
;Called In a circle
;131MS Cycle Task
;Mode  Check
MODE_CHECK:
		CLRWDT
		MOVR	PORTA,A
		MOVAR	RG_PORT_TEMP
		BTRSC   RG_PORT_TEMP,7

;		BTRSC   PORTB,IOB0_B
		LGOTO	NOW_MODE_HIGH

NOW_MODE_LOW:
		BTRSC	RG_STAT1_WORD,STAT1_MODE_B
		LGOTO	MODE_LOW_CHECK

		CLRR	RG_MODE_CNT
		RET

    MODE_LOW_CHECK:
		INCR	RG_MODE_CNT,R
		BTRSS	RG_MODE_CNT,2			;DEBOUNCE = 540MS
		RET
		BCR		RG_STAT1_WORD,STAT1_MODE_B
		CLRR	RG_MODE_CNT
		RET



NOW_MODE_HIGH:

		BTRSS	RG_STAT1_WORD,STAT1_MODE_B
		LGOTO	MODE_HIGH_CHECK

		CLRR	RG_MODE_CNT
		RET

MODE_HIGH_CHECK:
		INCR	RG_MODE_CNT,R
		BTRSS	RG_MODE_CNT,2			;DEBOUNCE = 540MS
		RET
		BSR		RG_STAT1_WORD,STAT1_MODE_B
		CLRR	RG_MODE_CNT
		RET

;-----------------------------------------------------------------------------
		ORG     0x100
;Called In a circle
;131MS Cycle Task
;11.7v(12V)  22V(24V) Check
INPUT7_CHECK:
		CLRWDT
		BTRSC	RG_STAT3_WORD,STAT3_VOLTAGE_117_B
		LGOTO	NOW_INPUT7_HIGH

NOW_INPUT7_LOW:
		BTRSC	RG_STAT1_WORD,STAT1_INPUT7_B
		LGOTO	INPUT7_LOW_CHECK

		CLRR	RG_INPUT7_CNT
		CLRR	RG_INPUT7_CNTH
		RET

INPUT7_LOW_CHECK:
		INCR	RG_INPUT7_CNT,R
		BTRSC   STATUS,Z_B
		INCR    RG_INPUT7_CNTH,R

		BTRSS	RG_INPUT7_CNTH,2			;DEBOUNCE = 2.2MIN (0x400  1280*131ms=134144ms)
		RET
		;BTRSS	RG_INPUT7_CNT,3			
		;RETURN
		BCR		RG_STAT1_WORD,STAT1_INPUT7_B

		CLRR	RG_INPUT7_CNT
;		CLRR	RG_INPUT7_CNTH

		RET



NOW_INPUT7_HIGH:

		BTRSS	RG_STAT1_WORD,STAT1_INPUT7_B
		LGOTO	INPUT7_HIGH_CHECK

		CLRR	RG_INPUT7_CNT
		CLRR	RG_INPUT7_CNTH

		RET

INPUT7_HIGH_CHECK:
		INCR	RG_INPUT7_CNT,R
		BTRSS	RG_INPUT7_CNT,3			;DEBOUNCE = 1080MS
		RET
		BSR		RG_STAT1_WORD,STAT1_INPUT7_B
;		BCR	RG_STAT2_WORD,STAT2_15MIN_B
;		CLRR	RG_INPUT7_CNT
		CLRR	RG_INPUT7_CNTH

		RET

;-----------------------------------------------------------------------------
		
;Called In a circle
;131MS Cycle Task
;CAN Input Check
CAN_CHECK:
;		MOVIA   0x08
;		SUBAR	RG_TOGGLE_CNT,A
;		BTRSC   STATUS,C_B

		;BTRSC	RG_TOGGLE_CNT,2
		CLRWDT
		BTRSC	RG_STAT2_WORD,STAT2_TOGGLE_B
		LGOTO	NOW_CAN_HAVE_WAVE

NOW_CAN_NO_WAVE:
		MOVR	PORTA,A
		MOVAR	RG_PORT_TEMP
		BTRSC   RG_PORT_TEMP,5
;		BTRSC   PORTB,IOB2_B
		LGOTO	NOW_INPUT4_HIGH

	NOW_INPUT4_LOW:
		BTRSS	RG_STAT1_WORD,STAT1_INPUT_CAN_B
		LGOTO	INPUT4_LOW_CHECK

		BTRSC	RG_CAN_DEB,7
		BSR		RG_STAT4_WORD,STAT4_CANH_134S_B
		
		CLRR	RG_INPUT4_CNT
		LGOTO	NOW_NO_WAVE_STEP1
		
	INPUT4_LOW_CHECK:
		INCR	RG_INPUT4_CNT,R		
		BTRSS	RG_INPUT4_CNT,4			;DEBOUNCE = 2160MS
		LGOTO	NOW_NO_WAVE_STEP1
		BSR		RG_STAT1_WORD,STAT1_INPUT_CAN_B
		BSR		PORTA,EQ_5VPOW_B
		CLRR	RG_CAN_DEB
		BTRSS	RG_STAT2_WORD,STAT2_POW_ON_B
		BSR		RG_STAT2_WORD,STAT2_CAN_TRI_B
		CLRR	RG_INPUT4_CNT
		LGOTO	NOW_NO_WAVE_STEP1

	NOW_INPUT4_HIGH:

		BTRSC	RG_STAT1_WORD,STAT1_INPUT_CAN_B
		LGOTO	INPUT4_HIGH_CHECK

		CLRR	RG_INPUT4_CNT
		LGOTO	NOW_NO_WAVE_STEP1

	INPUT4_HIGH_CHECK:
		INCR	RG_INPUT4_CNT,R
		BTRSS	RG_INPUT4_CNT,4			;DEBOUNCE = 2160MS
		LGOTO	NOW_NO_WAVE_STEP1
		BCR		RG_STAT1_WORD,STAT1_INPUT_CAN_B

		BCR		PORTA,EQ_5VPOW_B
		;BCR	RG_STAT2_WORD,STAT2_POW_ON_B
		;BCR	RG_STAT1_WORD,STAT1_ON_B
		;BCR	RG_STAT2_WORD,STAT2_CAN_ON_B
;		BCR	RG_STAT2_WORD,STAT2_CAN_SYS_B
		CLRR	RG_INPUT4_CNT
	NOW_NO_WAVE_STEP1:
		
		;CLRR	RG_TOGGLE_CNT
		BTRSC	RG_STAT2_WORD,STAT2_CAN_ON_B
		LGOTO	CAN_LOW_CHECK

		
		CLRR	RG_CAN_CNTL
		CLRR	RG_CAN_CNTH
		RET
		
	CAN_LOW_CHECK:
		INCR	RG_CAN_CNTL,R	
		BTRSC   STATUS,Z_B
		INCR    RG_CAN_CNTH,R

	
		;BTRSS	RG_CAN_CNTH,0			;DEBOUNCE = 33536MS(131*256)
		;RET
		BTRSS	RG_CAN_CNTL,4			
		RET
		BCR		RG_STAT2_WORD,STAT2_CAN_ON_B
;		BCR	RG_STAT2_WORD,STAT2_CAN_TRI_B	; STAT2_CAN_TRI_B = STAT2_CAN_ON_B && !STAT2_CAN_ON_B_BAK
;		BCR	RG_STAT2_WORD,STAT2_CAN_SYS_B
		CLRR	RG_CAN_CNTL
		CLRR	RG_CAN_CNTH
		RET



NOW_CAN_HAVE_WAVE:
		;BTRSC	RG_STAT1_WORD,STAT1_INPUT_CAN_B
		;LGOTO	NOW_HAVE_WAVE_STEP1
		;BCR	RG_STAT2_WORD,STAT2_POW_ON_B
		;BCR	RG_STAT1_WORD,STAT1_ON_B
		;BCR	RG_STAT2_WORD,STAT2_CAN_ON_B
;		BCR	RG_STAT2_WORD,STAT2_CAN_SYS_B

	NOW_HAVE_WAVE_STEP1:
		;CLRR	RG_TOGGLE_CNT
		BSR		RG_STAT2_WORD,STAT2_WAVE_B
		CLRR	RG_TICKS_L
		CLRR	RG_TICKS_H
		BTRSS	RG_STAT2_WORD,STAT2_CAN_ON_B
		LGOTO	CAN_HIGH_CHECK

		CLRR	RG_CAN_CNTL
		CLRR	RG_CAN_CNTH
		BTRSS	RG_CAN_DEB,7
		RET
		BSR		RG_STAT4_WORD,STAT4_CANW_134S_B
		BSR		RG_STAT2_WORD,STAT2_CAN_SYS_B		;DEBOUNCE = 134144MS(1048*128)
		RET

CAN_HIGH_CHECK:
		INCR	RG_CAN_CNTL,R
		BTRSC   STATUS,Z_B
		INCR    RG_CAN_CNTH,R

		;BTRSS	RG_CAN_CNTH,0			;DEBOUNCE = 2096MS(131*16)
		;RETURN
		BTRSS	RG_CAN_CNTL,4			
		RET

		BSR		RG_STAT2_WORD,STAT2_CAN_ON_B
		BCR		PORTA,EQ_5VPOW_B
		CLRR	RG_CAN_DEB
;		BSR	RG_STAT2_WORD,STAT2_CAN_TRI_B
;		BSR	RG_STAT2_WORD,STAT2_CAN_SYS_B
		CLRR	RG_CAN_CNTL
		CLRR	RG_CAN_CNTH
		RET



;-----------------------------------------------------------------------------

;Called In a circle
;135MS Cycle Task

POW_ON_CHECK:
		CLRWDT
		BTRSC   RG_STAT2_WORD,STAT2_POW_ON_B
		LGOTO	NOW_POW_ON
NOW_POW_OFF:	
		CLRR	RG_TICKS_L
		CLRR	RG_TICKS_H


		BCR		RG_STAT2_WORD,STAT2_CAN_SYS_B

		BTRSC   RG_STAT1_WORD,STAT1_ON_B
		BSR		RG_STAT2_WORD,STAT2_POW_ON_B

	CHECK_CAN_MODLE:

	CAN_W_CHECK:
		BTRSC   RG_STAT2_WORD,STAT2_CAN_ON_B
		BSR		RG_STAT2_WORD,STAT2_POW_ON_B


		BTRSC	RG_STAT4_WORD,STAT4_CANW_134S_B
		RET
		
	CAN_H_CHECK:	
		BTRSC	RG_STAT2_WORD,STAT2_CAN_TRI_B
		BSR		RG_STAT2_WORD,STAT2_POW_ON_B

		BTRSC	RG_STAT4_WORD,STAT4_CANH_134S_B
		RET
	UP_13V_START:
		BTRSS	RG_STAT2_WORD,STAT2_UP13V_B
		RET
		BTRSS		RG_STAT2_WORD,STAT2_POW_ON_B
		BSR		RG_STAT4_WORD,STAT4_UP13V_TRI_B
		BSR		RG_STAT2_WORD,STAT2_POW_ON_B
		RET


NOW_POW_ON:
		BCR		RG_STAT2_WORD,STAT2_UP13V_B
	NOW_POW_ON_CHECKTIME:	

		;IF(P2 = 1) CLR   RG_TICK_L RG_TICK_H
		BTRSC	RG_STAT1_WORD,STAT1_INPUT2_B
		CLRR	RG_TICKS_L

		;IF(STAT2_TOGGLE_B = 1) CLR   RG_TICK_L RG_TICK_H
		BTRSC	RG_STAT2_WORD,STAT2_TOGGLE_B
		CLRR	RG_TICKS_L

 		;If RG_TICK_H RG_TICK_L > 0x90   192*1048MS =201 Sec =  3.35 Min
		BTRSS	RG_TICKS_L,7
		LGOTO	NOW_CAN_CHECK
		BTRSC	RG_TICKS_L,6
		LGOTO	CLEAR_POW_ON		
	
	NOW_CAN_CHECK:
		BTRSC	RG_STAT4_WORD,STAT4_CANW_134S_B
		LGOTO	NOW_CAN_WAVE_CHECK
	  NOW_CAN_POWER_CHECK:
		BTRSS	RG_STAT2_WORD,STAT2_CAN_TRI_B
		RET
		BTRSS	RG_STAT1_WORD,STAT1_INPUT_CAN_B
		LGOTO	CLEAR_POW_ON
		RET


	  NOW_CAN_WAVE_CHECK:
		BTRSC   RG_STAT2_WORD,STAT2_CAN_SYS_B
		LGOTO	CAN_WAVE_AND_SYS
		BTRSC  	RG_STAT1_WORD,STAT1_ON_B
		RET
;		BTRSC  	RG_STAT4_WORD,STAT4_UP13V_TRI_B
;		RET

	    CAN_WAVE_AND_SYS:
		BTRSC   RG_STAT2_WORD,STAT2_CAN_ON_B
		RET

	CLEAR_POW_ON:
		BCR	RG_STAT2_WORD,STAT2_POW_ON_B
		BCR	RG_STAT2_WORD,STAT2_CAN_TRI_B
		BCR	RG_STAT4_WORD,STAT4_UP13V_TRI_B
		BCR	RG_STAT1_WORD,STAT1_ON_B
		RET

	

;-----------------------------------------------------------------------------

;Called In a circle
;135MS Cycle Task

POW_CONTROL:
		CLRWDT
		BTRSC	RG_STAT1_WORD,STAT1_MODE_B	;1:ACC MODE    0:VOLTAGE_MODE
		LGOTO	ACC_MODE
  VOLTAGE_MODE:


		BTRSC	RG_STAT1_WORD,STAT1_INPUT7_B
		LGOTO	ENABLE_POW

		BSR		RG_STAT2_WORD,STAT2_11V_LOW_B
		LGOTO	DISABLE_POW
		

  ACC_MODE:
		BCR		RG_STAT2_WORD,STAT2_11V_LOW_B
		BTRSS   RG_STAT2_WORD,STAT2_CAN_ON_B
		LGOTO	DISABLE_POW
;		GOTO	ENABLE_POW


    ENABLE_POW:
		BTRSS	RG_STAT2_WORD,STAT2_11V_LOW_B
		LGOTO	ENABLE_POW_STEP1

;		BTRSS	RG_STAT4_WORD,STAT4_VOLTAGE_122_B
		BTRSS	RG_STAT1_WORD,STAT1_INPUT2_B
		LGOTO	DISABLE_POW
		BCR		RG_STAT2_WORD,STAT2_11V_LOW_B
		
	ENABLE_POW_STEP1:
		BSR		PORTA,EQ_ACCPOW_B
		RET

    DISABLE_POW:	
		BCR		PORTA,EQ_ACCPOW_B

		RET





;-----------------------------------------------------------------------------

;Called In a circle
;1MS Cycle Task
TOGGLE_CHECK:
		CLRWDT
		BTRSC   PORTA,5
		LGOTO	INTPIN_CAN_HIGH
	INTPIN_CAN_LOW:
		BTRSS	RG_STAT3_WORD,STAT3_ISTATE_CAN_B
		RET
		;---
		BCR		RG_STAT3_WORD,STAT3_ISTATE_CAN_B
		INCR	RG_TOGGLE_CNT,R
		RET
	INTPIN_CAN_HIGH:
;		BTRSC	RG_STAT3_WORD,STAT3_ISTATE_CAN_B
;		LGOTO	EXIT_CAN_CHECK
		;---
		BSR		RG_STAT3_WORD,STAT3_ISTATE_CAN_B
		RET

		;-------------







;-----------------------------------------------------------------------------













	
	
	
	
	
	
	
	
	
	
	
	
		
        ORG		0x200         
V_Main:
		; Power ON initial - User program area 
		;---
		MOVIA	0x80					;; 设定为 WDT(B7)=1:EN/0:DIS, LVDEN(B5)=1:EN/0:DIS, LVREN(B3)=1:EN/0:DIS
		MOVAR	PCON
		MOVIA	0x0C
		T0MD						;Watchdog circle:250MS*16=4S(1:16)

CLR_RAM:
		MOVIA   0x20
		MOVAR   FSR
	CLR_RAMLOP:
		CLRR    INDF
		INCR    FSR,R

		BTRSS	FSR, 7
		LGOTO	CLR_RAMLOP
		;---

		BSR	RG_STAT1_WORD,STAT1_INPUT7_B
		BSR	RG_STAT3_WORD,STAT3_ISTATE_A1_B
		BSR	RG_STAT3_WORD,STAT3_ISTATE_A2_B
		

INIT_VOLTAGE_BUF:
		MOVIA   EQ_VOL_BUFFER
		MOVAR   FSR


	INIT_BUF_NEXT:	;Cyclic accumulation
		MOVIA   0x72
		MOVAR	INDF
		INCR    FSR,R
		BTRSC	FSR,4
		LGOTO   INIT_BUF_NEXT
		
		
		CLRA
		MOVAR	PORTA
		MOVAR	PORTB
		MOVIA	EQ_PORTA_SET
		IOST	IOSTA
		MOVIA	EQ_PORTB_SET
		IOST	IOSTB						;Configure Port B
		;---
		MOVIA	0x7F
		IOST	APHCON						;Enable PA7 pull-high
		;---
		MOVIA	0x08
		MOVAR	BWUCON						;Enable PB3 change INT
		;---
		BCR		PORTA,EQ_5VPOW_B

		

		;ADC init
		MOVIA		0x10			;; Set PA4 is ADC  Pin
		MOVAR		PACON
		
		MOVIA		0x00		;; Set ADC Clock <00:Fcpu/16>;;  0:Dis ADC Int / 1:En ADC Int
		MOVAR		ADR
		
		MOVIA		0x0F
		MOVAR		ADCR
		
		MOVIA		0x03
		MOVAR		ADVREFH
		
		BCR		ADT, C_CAL_En_Bit		;; Disale ADC Calibration

		MOVIA		0x94
		MOVAR		ADMD

		;timer1 init( 8.48ms timer)
		; T=（1/intruction clk)*分频*(TMR[9:8]:TMR1[7:0]+1)
		;  = ((1/2MHz))*64*(ffh+1)
		;  = 8192us
		
		MOVIA		0x00			;; Timer1 Data Bit[9:8] = 1
		MOVAR		TMRH
		MOVIA		0xFF			;; Timer1 Data Byte Data[7:0]
		SFUN		TMR1
		MOVIA		0x05
		SFUN		T1CR2			;; P1SEl(B2:B0), PS1EN(B3):0(EN)/1(Dis), T1CE(B4):0:Low->Hi/1:hi->Low, T1CS(B5):0:Instruction CLK/1:Ext CLK
		MOVIA		0x03			;; TIMER1(B0):1:EN/0:Dis, AUTO ReLoad(B1):1:En/0:Dis, PWM1OAL(b6):1:PWM1 Out Low / 0: PWM1 Our Hi, PWM1oEN(B7):1:P3 is PWM1 Out / 0:P3 is GPIO
		SFUN		T1CR1
    
    
    	MOVIA	0x0A
		MOVAR	INTE						;Enable PBIE &  Timer1 interrupt
		MOVIA	0x0
		MOVAR	INTF						;Clear All Flag



		
		;---

		ENI					;; Enable Goble Interrupt
		
  
MAIN:
		LCALL	TOGGLE_CHECK
		;---
		;10MS Cycle Task 
		BTRSS	RG_STAT1_WORD,STAT1_10MS_B
		LGOTO   MAIN		
		BCR		RG_STAT1_WORD,STAT1_10MS_B


		BTRSC	RG_STAT1_WORD,STAT1_START_B
		INCR	RG_INT_CNT,R
		BTRSC	RG_STAT1_WORD,STAT1_START_B
		INCR	RG_COUNT_CNT,R

		LCALL	TOGGLE_CHECK
		LCALL	EX_INT_CHECK
		LCALL	TOGGLE_CHECK
		;---
		;135MS Cycle Task
		BTRSS	RG_STAT1_WORD,STAT1_131MS_B
		LGOTO   MAIN_2S_TASK
		BCR		RG_STAT1_WORD,STAT1_131MS_B
		
		LCALL	TOGGLE_CHECK
		LCALL	ADC_VOLTAGE
		LCALL	TOGGLE_CHECK
		LCALL	CACULATE_VOLTAGE_CNT
		LCALL	TOGGLE_CHECK
		LCALL	MODE_CHECK
		LCALL	TOGGLE_CHECK
		LCALL	INPUT2_CHECK
		LCALL	TOGGLE_CHECK
		LCALL	INPUT7_CHECK
		LCALL	TOGGLE_CHECK
		LCALL	CAN_CHECK
		LCALL	TOGGLE_CHECK
		LCALL	POW_ON_CHECK
		LCALL	TOGGLE_CHECK
		LCALL	POW_CONTROL
		LCALL	TOGGLE_CHECK


		BTRSS	RG_STAT4_WORD,STAT4_VOLTAGE_128_B
		CLRR	RG_128V_CNT
		BTRSS	RG_STAT4_WORD,STAT4_VOLTAGE_128_B
		LGOTO   MAIN_2S_TASK

	VOLTAGE_128_UP:
		INCR	RG_128V_CNT,R
		BTRSC	RG_128V_CNT,3			;DEBOUNCE = 1.1S (0x08  8*131Ms=1048Ms)
		BSR		RG_STAT2_WORD,STAT2_UP13V_B


		;---
		;1S Cycle Task
MAIN_2S_TASK:
		BTRSS	RG_STAT3_WORD,STAT3_2S_B
		LGOTO   MAIN
		BCR	RG_STAT3_WORD,STAT3_2S_B
		

		BTRSS	RG_STAT3_WORD,STAT3_VOLTAGE_115_B
		LGOTO   VOLTAGE_110_LOW


		CLRR	RG_5VPOW_CNT

		LGOTO   MAIN


	VOLTAGE_110_LOW:
;		INCR	RG_5VPOW_CNT,R
;		BTRSC	RG_5VPOW_CNT,6			;DEBOUNCE = 2MIN (0x40  64*2s=128s)
;		BCR	PORTA,EQ_5VPOW_B

		LGOTO   MAIN

	
END											; End of Code
		