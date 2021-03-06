;*****************************************************************************
;* TITLE	:Acc Scanner program
;* PATTERN	:0
;* REVISION	:0
;* BUILD	:0
;* AUTHOR	:Andrew
;* COMPANY	:Forwell
;* DATE		:2016/03/10
;* CHIP		:8PA76  SOP8
;* CONFIG	:Fosc:IRC4M, LVDT:default, SUT:default, OSCO:IOB4, RSTBIN:IOB3, WDT:Disable, PROTECT: on, OSCD:2T, PMOD:default, RDPORT:default, SCHMITT:default, IOB3OD:default
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
;---------------Include files Segment-----------------------------------------
#include        AT8B71.H
;---------------Custom define segment-----------Using segment-----------Share(y/n)
RG_INT_ACCTMP		REG	0x20			;INTERRUPT ACC TEMP	;N
RG_INT_STATMP		REG	0x21			;INTERRUPT STATUS TEMP	;N

;-------
RG_STAT1_WORD   	REG     0x22
STAT1_INPUT2_B		EQU	0x0
STAT1_INPUT_CAN_B	EQU	0x1
STAT1_MODE_B		EQU	0x2
STAT1_INPUT7_B		EQU	0x3
STAT1_10MS_B		EQU	0x4
STAT1_135MS_B		EQU	0x5
STAT1_START_B		EQU	0x6
STAT1_ON_B		EQU	0x7

RG_STAT2_WORD   	REG     0x23
STAT2_CAN_TRI_B		EQU	0x0
STAT2_POW_ON_B		EQU	0x1
STAT2_WAVE_B		EQU	0x2
STAT2_CAN_SYS_B		EQU	0x3
STAT2_CAN_ON_B		EQU	0x4

STAT2_LOW3MIN_B		EQU	0x5	;LOW 3 Min Over

STAT2_TOGGLE_B		EQU	0x6

STAT2_11V_LOW_B		EQU	0x7



RG_JIFFIES		REG     0x24

RG_INPUT2_CNT		REG     0x25
RG_INPUT4_CNT		REG     0x26
RG_MODE_CNT		REG     0x27
RG_INPUT7_CNT		REG     0x28

RG_INT_CNT		REG     0x29

RG_INPUT7_CNTH		REG     0x2A

RG_CAN_DEB		REG     0x2B

RG_TICKS_L		REG     0x2C
RG_TICKS_H		REG     0x2D
RG_CAN_CNTL		REG     0x2E
RG_CAN_CNTH		REG     0x2F

RG_COUNT_CNT		REG     0x30




RG_STAT3_WORD   	REG     0x31
STAT3_ISTATE_A1_B	EQU	0x0
STAT3_ISTATE_A2_B	EQU	0x1
STAT3_ISTATE_CAN_B	EQU	0x2
STAT3_VOLTAGE_115_B	EQU	0x3
STAT3_VOLTAGE_117_B	EQU	0x4
STAT3_VOLTAGE_126_B	EQU	0x5
STAT3_2S_B		EQU	0x6
STAT3_ISTATE_B0_B	EQU	0x7


RG_2S_CNT		REG     0x32

RG_SLEEP_CNT		REG     0x33


RG_STAT4_WORD   	REG     0x34
STAT4_VOLTAGE_122_B	EQU	0x0
STAT4_VOLTAGE_128_B	EQU	0x1
STAT4_HAVE_CANH_B	EQU	0x2


RG_TOGGLE_CNT		REG     0x38
RG_PORT_TEMP		REG     0x39
RG_5VPOW_CNT		REG     0x3A

RG_128V_CNT		REG     0x3B

;---------------
RG_VOL_INDEX   		REG     0x40
RG_VOL_H		REG     0x41
RG_VOL_L    		REG     0x42
RG_V_CNTH    		REG     0x43
RG_V_CNTL    		REG     0x44




RG_VOL1_ADH		REG     0x50
RG_VOL2_ADH    		REG     0x51
RG_VOL3_ADH		REG     0x52
RG_VOL4_ADH    		REG     0x53
RG_VOL5_ADH		REG     0x54
RG_VOL6_ADH    		REG     0x55
RG_VOL7_ADH		REG     0x56
RG_VOL8_ADH    		REG     0x57
RG_VOL9_ADH		REG     0x58
RG_VOL10_ADH    	REG     0x59
RG_VOL11_ADH		REG     0x5A
RG_VOL12_ADH    	REG     0x5B
RG_VOL13_ADH		REG     0x5C
RG_VOL14_ADH    	REG     0x5D
RG_VOL15_ADH		REG     0x5E
RG_VOL16_ADH    	REG     0x5F
;---------------





;---------------vaule segment-------------------Using segment-----------------

EQ_PORTA_SET      	EQU  	11111010B	;PORTA input and output set (ALL Is Intput expect PA2 PA0)
EQ_PORTB_SET      	EQU  	11111111B	;PORTB input and output set (ALL Is Intput)


EQ_ACCPOW_B		EQU	0x02
EQ_5VPOW_B		EQU	0x00
EQ_INPUT_CAN_B		EQU	0x05
EQ_VOL_BUFFER		EQU     0x50



;---------------MCU Boot/Reset Vector segment---------------------------------
                ORG     0x000
                LGOTO   START
;-----------------------------------------------------------------------------
;---------------Hardware Interrupt segment--------------------
		ORG	0x008
		MOVAR	RG_INT_ACCTMP
		MOVR	STATUS,A
		MOVAR	RG_INT_STATMP					;Backup ACC & STATUS register code
		
		;-------
		BTRSC	INTFLAG,PAIF_B					;External interrupt
		LGOTO	INTPIN
		
		;-------
;		BTRSC	INTFLAG,T0IF_B					;TMR0 interrupt
;		LGOTO	TMR0INT
		
		;-------
		BTRSC   INTFLAG,T1_PWM1IF_B
                LGOTO   TMR1INT  
		NOP
		
		;CLRR	INTFLAG						;error, undefine interrupt
EXIT_INTSRV:
		MOVR    RG_INT_STATMP,A
                MOVAR   STATUS
                MOVR    RG_INT_ACCTMP,A				;Restore ACC & STATUS register code
		RETFIE
;-------------------------------

INTPIN:
		MOVR    INTFLAG,A					;Note: BCR instruction is NOT recommended for Clear interrupt flag(INTFLAG register)
		ANDIA	0xDF						;Clear INTIF Flag
		MOVAR	INTFLAG

		
    INTPIN_12V:
		MOVR	PORTA,A
		MOVAR	RG_PORT_TEMP
		BTRSC   RG_PORT_TEMP,IOA1_B
		;BTRSC   PORTA,IOA1_B
		LGOTO	INTPIN_A1_HIGH
	INTPIN_A1_LOW:
		
		BTRSS	RG_STAT3_WORD,STAT3_ISTATE_A1_B
		LGOTO	EXIT_INTSRV
		;---
		BCR	RG_STAT3_WORD,STAT3_ISTATE_A1_B
		;---
		CLRR	RG_TICKS_L
		CLRR	RG_TICKS_H
		;---
		;BTRSS   RG_STAT2_WORD,STAT2_POW_ON_B
		BSR	RG_STAT1_WORD,STAT1_START_B
		;---
		LGOTO	EXIT_INTSRV

	INTPIN_A1_HIGH:
		BSR	RG_STAT3_WORD,STAT3_ISTATE_A1_B
		LGOTO	EXIT_INTSRV

;-----------------------------------------------------------------------------
;1S timer
;TMR0INT:
;               MOVR    INTFLAG,A
;		ANDIA	0xFE
;		MOVAR	INTFLAG

;		BSR	RG_STAT1_WORD,STAT1_1S_B

                ;---
                ;-----
;TMR0INT_EXIT:
;                LGOTO   EXIT_INTSRV


;-------------------------------
;8.48MS timer
TMR1INT:
		MOVR    INTFLAG,A					;Note: BCR instruction is NOT recommended for Clear interrupt flag(INTFLAG register)
		ANDIA	0xFD						;Clear T0IF Flag
		MOVAR	INTFLAG		
		
		INCR    RG_JIFFIES,R          ;Add 1 to jiffies(8.48ms)
		BSR	RG_STAT1_WORD,STAT1_10MS_B
		BTRSS	RG_JIFFIES,4
		LGOTO   EXIT_INTSRV


		BSR	RG_STAT1_WORD,STAT1_135MS_B
		MOVIA	0X10
		ADDAR	RG_JIFFIES,R

		BTRSS   STATUS,Z_B
		LGOTO	EXIT_INTSRV

		INCR    RG_CAN_DEB,R

		

		INCR    RG_TICKS_L,R		;1085MS counter
		BTRSC   STATUS,Z_B
		INCR    RG_TICKS_H,R

		INCR    RG_2S_CNT,R
		BTRSC   RG_2S_CNT,0
		LGOTO	EXIT_INTSRV

		BSR	RG_STAT3_WORD,STAT3_2S_B

		BCR	RG_STAT2_WORD,STAT2_TOGGLE_B
		MOVIA   0x03
		SUBAR	RG_TOGGLE_CNT,A
		BTRSC   STATUS,C_B
		BSR	RG_STAT2_WORD,STAT2_TOGGLE_B
		CLRR	RG_TOGGLE_CNT


		;---
TMR1INT_EXIT:
		LGOTO	EXIT_INTSRV

;-----------------------------------------------------------------------------

;-----------------------------------------------------------------------------

;-----------------------------------------------------------------------------
;Called In a circle
;135MS Cycle Task
ADC_VOLTAGE:
;		BTRSC	RG_STAT1_WORD,STAT1_AD_NUM_B
;		RETURN
		CLRWDT

VOLTAGE_START:
;		BSR	RG_STAT1_WORD,STAT1_AD_NUM_B


		BTRSC	AD_CTL1,ADCEN_B
		LGOTO	$-1			;Make Sure no adc is processing
		MOVR    INTFLAG,A
		ANDIA	0xBF
		MOVAR	INTFLAG			;Clear ADCIF flag
		MOVIA	0x00
		MOVAR	AD_CTL1			;Select ADC Channel 0 (IOA0) conversion
		MOVIA	0x01
		MOVAR	AD_CTL2			;Set AD conversion rate:System clock/128
		MOVIA	0x01
		MOVAR	AD_CTL3			;Set ANO analog input
		BSR	AD_CTL1,ADCEN_B		;AD conversion start
		BTRSS	INTFLAG,ADCIF_B
		LGOTO	$-1			;Wait AD end of conversion
		
		MOVR	RG_VOL_INDEX,A
		BTRSS	RG_VOL_INDEX,5
		MOVIA   EQ_VOL_BUFFER
		MOVAR   FSR
		MOVR	AD_DATH,A
		MOVAR	INDF
		INCR    FSR,R
		MOVR	AD_DATL,A
		MOVAR	RG_V_CNTL
		MOVR	FSR,A
		MOVAR   RG_VOL_INDEX
		RETURN

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
		BTRSC	FSR,5
		LGOTO   VOLTAGE_ADD
		
		ANDIA	0xF0
		MOVAR   RG_VOL_L
		SWAPR	RG_VOL_L,R
		SWAPR	RG_VOL_H,A
		ADDAR	RG_VOL_L,A	
		MOVAR   RG_V_CNTH	;the last value getted in RG_VOL_CNTH

		MOVAR   RG_VOL_L

VOLTAGE_CHECK_SYS:


;	CHECK_12V_SYS:

		BCR	RG_STAT3_WORD,STAT3_VOLTAGE_115_B
		MOVIA   0x0C4		;11.5V Value(0XC44)
		SUBAR	RG_VOL_L,A
		BTRSC   STATUS,C_B
		BSR	RG_STAT3_WORD,STAT3_VOLTAGE_115_B


		BCR	RG_STAT3_WORD,STAT3_VOLTAGE_117_B
		MOVIA   0x0C7		;11.7V Value(0XC7A)
		SUBAR	RG_VOL_L,A
		BTRSC   STATUS,C_B
		BSR	RG_STAT3_WORD,STAT3_VOLTAGE_117_B


		BCR	RG_STAT4_WORD,STAT4_VOLTAGE_122_B
		MOVIA   0x0D0		;12.2V Value(0XD03)
		SUBAR	RG_VOL_L,A
		BTRSC   STATUS,C_B
		BSR	RG_STAT4_WORD,STAT4_VOLTAGE_122_B



		BCR	RG_STAT3_WORD,STAT3_VOLTAGE_126_B
		MOVIA   0x0D8		;12.7V Value(0XD8B)
		SUBAR	RG_VOL_L,A
		BTRSC   STATUS,C_B
		BSR	RG_STAT3_WORD,STAT3_VOLTAGE_126_B

		BCR	RG_STAT4_WORD,STAT4_VOLTAGE_128_B
		MOVIA   0x0DA		;12.8V Value(0XDA7)
		SUBAR	RG_VOL_L,A
		BTRSC   STATUS,C_B
		BSR	RG_STAT4_WORD,STAT4_VOLTAGE_128_B
		RETURN


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
		
		RETURN



INT_CHECK_START:

		
;CHECK_START_A1:
		MOVR	PORTA,A
		MOVAR	RG_PORT_TEMP
		BTRSC   RG_PORT_TEMP,IOA1_B
		;BTRSC   PORTA,IOA1_B
		LGOTO	NOW_A1_HIGH


	NOW_A1_LOW:
		
		BTRSS	RG_INT_CNT,3 			;DEBOUNCE = 80MS  
		RETURN
		
		BCR	RG_STAT1_WORD,STAT1_START_B
		BSR	RG_STAT1_WORD,STAT1_ON_B
		CLRR	RG_INT_CNT
		CLRR	RG_COUNT_CNT
		RETURN


	NOW_A1_HIGH:
		BTRSS	RG_COUNT_CNT,3 			;DEBOUNCE = 80MS  
		RETURN

		BCR	RG_STAT1_WORD,STAT1_START_B
		CLRR	RG_INT_CNT
		CLRR	RG_COUNT_CNT
		RETURN


;-----------------------------------------------------------------------------
;Called In a circle
;135MS Cycle Task
;12.6v(12V)   25V(24V)Check
INPUT2_CHECK:
		CLRWDT
		BTRSC	RG_STAT3_WORD,STAT3_VOLTAGE_126_B
		LGOTO	NOW_INPUT2_HIGH

NOW_INPUT2_LOW:
		BTRSC	RG_STAT1_WORD,STAT1_INPUT2_B
		LGOTO	INPUT2_LOW_CHECK

		CLRR	RG_INPUT2_CNT
		RETURN

INPUT2_LOW_CHECK:
		INCR	RG_INPUT2_CNT,R
		BTRSS	RG_INPUT2_CNT,3			;DEBOUNCE = 1080MS
		RETURN
		BCR	RG_STAT1_WORD,STAT1_INPUT2_B
		CLRR	RG_INPUT2_CNT
		RETURN



NOW_INPUT2_HIGH:
		CLRR	RG_TICKS_L
		BTRSS	RG_STAT1_WORD,STAT1_INPUT2_B
		LGOTO	INPUT2_HIGH_CHECK

		BSR	PORTA,EQ_5VPOW_B
		CLRR	RG_INPUT2_CNT
		RETURN

INPUT2_HIGH_CHECK:
		INCR	RG_INPUT2_CNT,R
		BTRSS	RG_INPUT2_CNT,3			;DEBOUNCE = 1080MS
		RETURN
		BSR	RG_STAT1_WORD,STAT1_INPUT2_B
		CLRR	RG_INPUT2_CNT
		RETURN


;-----------------------------------------------------------------------------
;Called In a circle
;135MS Cycle Task
;Mode  Check
MODE_CHECK:
		CLRWDT
		MOVR	PORTB,A
		MOVAR	RG_PORT_TEMP
		BTRSC   RG_PORT_TEMP,IOB0_B

;		BTRSC   PORTB,IOB0_B
		LGOTO	NOW_MODE_HIGH

NOW_MODE_LOW:
		BTRSC	RG_STAT1_WORD,STAT1_MODE_B
		LGOTO	MODE_LOW_CHECK

		CLRR	RG_MODE_CNT
		RETURN

    MODE_LOW_CHECK:
		INCR	RG_MODE_CNT,R
		BTRSS	RG_MODE_CNT,2			;DEBOUNCE = 540MS
		RETURN
		BCR	RG_STAT1_WORD,STAT1_MODE_B
		CLRR	RG_MODE_CNT
		RETURN



NOW_MODE_HIGH:

		BTRSS	RG_STAT1_WORD,STAT1_MODE_B
		LGOTO	MODE_HIGH_CHECK

		CLRR	RG_MODE_CNT
		RETURN

MODE_HIGH_CHECK:
		INCR	RG_MODE_CNT,R
		BTRSS	RG_MODE_CNT,2			;DEBOUNCE = 540MS
		RETURN
		BSR	RG_STAT1_WORD,STAT1_MODE_B
		CLRR	RG_MODE_CNT
		RETURN

;-----------------------------------------------------------------------------
		ORG     0x100
;Called In a circle
;135MS Cycle Task
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
		RETURN

INPUT7_LOW_CHECK:
		INCR	RG_INPUT7_CNT,R
		BTRSC   STATUS,Z_B
		INCR    RG_INPUT7_CNTH,R

		BTRSS	RG_INPUT7_CNTH,2			;DEBOUNCE = 2.3MIN (0x400  1280*135ms=172800ms)
		RETURN
		;BTRSS	RG_INPUT7_CNT,3			
		;RETURN
		BCR	RG_STAT1_WORD,STAT1_INPUT7_B

		CLRR	RG_INPUT7_CNT
;		CLRR	RG_INPUT7_CNTH

		RETURN



NOW_INPUT7_HIGH:

		BTRSS	RG_STAT1_WORD,STAT1_INPUT7_B
		LGOTO	INPUT7_HIGH_CHECK

		CLRR	RG_INPUT7_CNT
		CLRR	RG_INPUT7_CNTH

		RETURN

INPUT7_HIGH_CHECK:
		INCR	RG_INPUT7_CNT,R
		BTRSS	RG_INPUT7_CNT,3			;DEBOUNCE = 1080MS
		RETURN
		BSR	RG_STAT1_WORD,STAT1_INPUT7_B
;		BCR	RG_STAT2_WORD,STAT2_15MIN_B
;		CLRR	RG_INPUT7_CNT
		CLRR	RG_INPUT7_CNTH

		RETURN

;-----------------------------------------------------------------------------
		
;Called In a circle
;135MS Cycle Task
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
		MOVR	PORTB,A
		MOVAR	RG_PORT_TEMP
		BTRSC   RG_PORT_TEMP,IOB2_B
;		BTRSC   PORTB,IOB2_B
		LGOTO	NOW_INPUT4_HIGH

	NOW_INPUT4_LOW:
		BTRSS	RG_STAT1_WORD,STAT1_INPUT_CAN_B
		LGOTO	INPUT4_LOW_CHECK

		CLRR	RG_INPUT4_CNT
		LGOTO	NOW_NO_WAVE_STEP1
		
	INPUT4_LOW_CHECK:
		INCR	RG_INPUT4_CNT,R		
		BTRSS	RG_INPUT4_CNT,4			;DEBOUNCE = 2160MS
		LGOTO	NOW_NO_WAVE_STEP1
		BSR	RG_STAT1_WORD,STAT1_INPUT_CAN_B
		BSR	RG_STAT4_WORD,STAT4_HAVE_CANH_B
		BTRSS	RG_STAT2_WORD,STAT2_POW_ON_B
		BSR	RG_STAT2_WORD,STAT2_CAN_TRI_B
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
		BCR	RG_STAT1_WORD,STAT1_INPUT_CAN_B

		;BCR	RG_STAT2_WORD,STAT2_POW_ON_B
		;BCR	RG_STAT1_WORD,STAT1_ON_B
		;BCR	RG_STAT2_WORD,STAT2_CAN_ON_B
;		BCR	RG_STAT2_WORD,STAT2_CAN_SYS_B
		CLRR	RG_INPUT4_CNT
	NOW_NO_WAVE_STEP1:
		
		;CLRR	RG_TOGGLE_CNT
		BTRSC	RG_STAT2_WORD,STAT2_CAN_ON_B
		LGOTO	CAN_LOW_CHECK

		CLRR	RG_CAN_DEB
		CLRR	RG_CAN_CNTL
		CLRR	RG_CAN_CNTH
		RETURN
		
	CAN_LOW_CHECK:
		INCR	RG_CAN_CNTL,R	
		BTRSC   STATUS,Z_B
		INCR    RG_CAN_CNTH,R

	
		BTRSS	RG_CAN_CNTH,0			;DEBOUNCE = 34560MS(135*256)
		RETURN
		;BTRSS	RG_CAN_CNTL,6			
		;RETURN
		BCR	RG_STAT2_WORD,STAT2_CAN_ON_B
;		BCR	RG_STAT2_WORD,STAT2_CAN_TRI_B	; STAT2_CAN_TRI_B = STAT2_CAN_ON_B && !STAT2_CAN_ON_B_BAK
;		BCR	RG_STAT2_WORD,STAT2_CAN_SYS_B
		CLRR	RG_CAN_CNTL
		CLRR	RG_CAN_CNTH
		RETURN



NOW_CAN_HAVE_WAVE:
		;BTRSC	RG_STAT1_WORD,STAT1_INPUT_CAN_B
		;LGOTO	NOW_HAVE_WAVE_STEP1
		;BCR	RG_STAT2_WORD,STAT2_POW_ON_B
		;BCR	RG_STAT1_WORD,STAT1_ON_B
		;BCR	RG_STAT2_WORD,STAT2_CAN_ON_B
;		BCR	RG_STAT2_WORD,STAT2_CAN_SYS_B

	NOW_HAVE_WAVE_STEP1:
		;CLRR	RG_TOGGLE_CNT
		BSR	RG_STAT1_WORD,STAT1_INPUT_CAN_B
		BSR	RG_STAT2_WORD,STAT2_WAVE_B
		CLRR	RG_TICKS_L
		CLRR	RG_TICKS_H
		BTRSS	RG_STAT2_WORD,STAT2_CAN_ON_B
		LGOTO	CAN_HIGH_CHECK

		CLRR	RG_CAN_CNTL
		CLRR	RG_CAN_CNTH
		BTRSC	RG_CAN_DEB,7
		BSR	RG_STAT2_WORD,STAT2_CAN_SYS_B		;DEBOUNCE = 163840MS(1280*128)
		RETURN

CAN_HIGH_CHECK:
		INCR	RG_CAN_CNTL,R
		BTRSC   STATUS,Z_B
		INCR    RG_CAN_CNTH,R

		;BTRSS	RG_CAN_CNTH,0			;DEBOUNCE = 2160MS(135*16)
		;RETURN
		BTRSS	RG_CAN_CNTL,4			
		RETURN

		BSR	RG_STAT2_WORD,STAT2_CAN_ON_B
		BSR	RG_STAT4_WORD,STAT4_HAVE_CANH_B
;		BSR	RG_STAT2_WORD,STAT2_CAN_TRI_B
;		BSR	RG_STAT2_WORD,STAT2_CAN_SYS_B
		CLRR	RG_CAN_CNTL
		CLRR	RG_CAN_CNTH
		RETURN



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


		BCR	RG_STAT2_WORD,STAT2_CAN_SYS_B

		BTRSC   RG_STAT1_WORD,STAT1_ON_B
		BSR	RG_STAT2_WORD,STAT2_POW_ON_B

	CHECK_CAN_MODLE:
		BTRSC   RG_STAT2_WORD,STAT2_CAN_ON_B
		BSR	RG_STAT2_WORD,STAT2_POW_ON_B

		BTRSC	RG_STAT2_WORD,STAT2_WAVE_B
		RETURN
		
		BTRSC	RG_STAT2_WORD,STAT2_CAN_TRI_B
		BSR	RG_STAT2_WORD,STAT2_POW_ON_B

		BTRSC	RG_STAT4_WORD,STAT4_HAVE_CANH_B
		RETURN
		BTRSC	RG_STAT2_WORD,STAT2_LOW3MIN_B
		BSR	RG_STAT2_WORD,STAT2_POW_ON_B
		RETURN


NOW_POW_ON:
		BCR	RG_STAT2_WORD,STAT2_LOW3MIN_B
	NOW_POW_ON_CHECKTIME:	

		;IF(P2 = 1) CLR   RG_TICK_L RG_TICK_H
		BTRSC	RG_STAT1_WORD,STAT1_INPUT2_B
		CLRR	RG_TICKS_L

		;IF(STAT2_TOGGLE_B = 1) CLR   RG_TICK_L RG_TICK_H
		BTRSC	RG_STAT2_WORD,STAT2_TOGGLE_B
		CLRR	RG_TICKS_L

 		;If RG_TICK_H RG_TICK_L > 0x90   144*1085MS = 2.605 Min
		BTRSS	RG_TICKS_L,7
		LGOTO	NOW_CAN_CHECK
		BTRSC	RG_TICKS_L,4
		LGOTO	CLEAR_POW_ON		
	
	NOW_CAN_CHECK:
		BTRSC	RG_STAT2_WORD,STAT2_WAVE_B
		LGOTO	NOW_CAN_WAVE_CHECK
	  NOW_CAN_POWER_CHECK:
		BTRSS	RG_STAT2_WORD,STAT2_CAN_TRI_B
		RETURN
		BTRSS	RG_STAT1_WORD,STAT1_INPUT_CAN_B
		LGOTO	CLEAR_POW_ON
		RETURN


	  NOW_CAN_WAVE_CHECK:
		BTRSC   RG_STAT2_WORD,STAT2_CAN_SYS_B
		LGOTO	CAN_WAVE_AND_SYS
		BTRSC  	RG_STAT1_WORD,STAT1_ON_B
		RETURN

	    CAN_WAVE_AND_SYS:
		BTRSC   RG_STAT2_WORD,STAT2_CAN_ON_B
		RETURN

	CLEAR_POW_ON:
		BCR	RG_STAT2_WORD,STAT2_POW_ON_B
		BCR	RG_STAT2_WORD,STAT2_CAN_TRI_B
		BCR	RG_STAT1_WORD,STAT1_ON_B
		RETURN

	

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

		BSR	RG_STAT2_WORD,STAT2_11V_LOW_B
		LGOTO	DISABLE_POW
		

  ACC_MODE:
		BCR	RG_STAT2_WORD,STAT2_11V_LOW_B
		BTRSS	RG_STAT2_WORD,STAT2_POW_ON_B
		LGOTO	DISABLE_POW
;		GOTO	ENABLE_POW


    ENABLE_POW:
		BTRSS	RG_STAT2_WORD,STAT2_11V_LOW_B
		LGOTO	ENABLE_POW_STEP1

		BTRSS	RG_STAT4_WORD,STAT4_VOLTAGE_122_B
		LGOTO	DISABLE_POW
		BCR	RG_STAT2_WORD,STAT2_11V_LOW_B
		
	ENABLE_POW_STEP1:
		BSR	PORTB,EQ_ACCPOW_B
		RETURN

    DISABLE_POW:	
		BCR	PORTB,EQ_ACCPOW_B

		RETURN





;-----------------------------------------------------------------------------

;Called In a circle
;1MS Cycle Task
TOGGLE_CHECK:
		CLRWDT
		BTRSC   PORTB,IOB2_B
		LGOTO	INTPIN_CAN_HIGH
	INTPIN_CAN_LOW:
		BTRSS	RG_STAT3_WORD,STAT3_ISTATE_CAN_B
		RETURN
		;---
		BCR	RG_STAT3_WORD,STAT3_ISTATE_CAN_B
		INCR	RG_TOGGLE_CNT,R
		RETURN
	INTPIN_CAN_HIGH:
;		BTRSC	RG_STAT3_WORD,STAT3_ISTATE_CAN_B
;		LGOTO	EXIT_CAN_CHECK
		;---
		BSR	RG_STAT3_WORD,STAT3_ISTATE_CAN_B
		RETURN

		;-------------







;-----------------------------------------------------------------------------
		ORG     0x200

START:
		CLRA
		MOVAR	PA
		MOVAR	PB


		MOVIA	EQ_PORTA_SET
		IOST	PA
		MOVIA	EQ_PORTB_SET
		IOST	PB						;Configure Port B
		;---
		MOVIA	0x7F
		IOST	APHCON						;Enable PA7 pull-high
		;---
		BSR	PA,EQ_5VPOW_B

		;---
		MOVIA		0x80					;; 设定为 WDT(B7)=1:EN/0:DIS, LVDEN(B5)=1:EN/0:DIS, LVREN(B3)=1:EN/0:DIS
		MOVAR		PCON


		;timer1 init( 8.48ms timer)
		MOVIA	0x67						;Enable latch buffer auto & internal 4M RC & 1:128


		MOVAR	TMR1_CTL1
		CLRR	TMR1_CTL2
		CLRR	TMR1_LA
		BSR	TMR1_CTL1,T1EN_B


		;====================================================================
		; T=（1/intruction clk)*分频*(TMR[9:8]:TMR1[7:0]+1)
		;  = ((1/4MHz)*4)*2*(1ffh+1)
		;  = 1024us
		MOVIA		0x00
		SFUN		T1CR1			;; Disale Timer1
		
		MOVIA		0xF7
		MOVAR		INTF			;; Clr Timer1 Flag
		
		MOVIA		0x10			;; Timer1 Data Bit[9:8] = 1
		MOVAR		TMRH
		MOVIA		0xff			;; Timer1 Data Byte Data[7:0]
		SFUN		TMR1


		MOVIA		0x00
		SFUN		T1CR2			;; P1SEl(B2:B0), PS1EN(B3):0(EN)/1(Dis), T1CE(B4):0:Low->Hi/1:hi->Low, T1CS(B5):0:Instruction CLK/1:Ext CLK
;
		MOVIA		0x03			;; TIMER1(B0):1:EN/0:Dis, AUTO ReLoad(B1):1:En/0:Dis, PWM1OAL(b6):1:PWM1 Out Low / 0: PWM1 Our Hi, PWM1oEN(B7):1:P3 is PWM1 Out / 0:P3 is GPIO
		SFUN		T1CR1




		;---


		MOVIA	0xA2
		MOVAR	INTEN						;Enable global & Enable PAIE &  Timer1 interrupt
		MOVIA	0x0
		MOVAR	INTFLAG						;Clear All Flag

		;---

		MOVIA	0x02
		MOVAR	INT_PA

		;---


		CLRWDT
		MOVIA	0xE5
		MOVAR	WDT_CTL						;Watchdog circle:2.56S(1:128)

		;---


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

;		BTRSS   PORTB,IOB0_B
;		BSR	RG_STAT1_WORD,STAT1_START_B
		BSR	RG_STAT3_WORD,STAT3_ISTATE_A1_B
		BSR	RG_STAT3_WORD,STAT3_ISTATE_A2_B
		

INIT_VOLTAGE_BUF:
		MOVIA   EQ_VOL_BUFFER
		MOVAR   FSR


  INIT_BUF_NEXT:	;Cyclic accumulation
		MOVIA   0x72
		MOVAR	INDF
		INCR    FSR,R
		BTRSC	FSR,5
		LGOTO   INIT_BUF_NEXT

;		LGOTO    MAIN

;-----------------------------------------------------------------------------
;Main program
;-----------------------------------------------------------------------------
MAIN:
		LCALL	TOGGLE_CHECK
		;---
		;10MS Cycle Task 
		BTRSS	RG_STAT1_WORD,STAT1_10MS_B
		LGOTO   MAIN		
		BCR	RG_STAT1_WORD,STAT1_10MS_B


		BTRSC	RG_STAT1_WORD,STAT1_START_B
		INCR	RG_INT_CNT,R
		BTRSC	RG_STAT1_WORD,STAT1_START_B
		INCR	RG_COUNT_CNT,R

		LCALL	TOGGLE_CHECK
		LCALL	EX_INT_CHECK
		LCALL	TOGGLE_CHECK
		;---
		;135MS Cycle Task
		BTRSS	RG_STAT1_WORD,STAT1_135MS_B
		LGOTO   MAIN_2S_TASK
		BCR	RG_STAT1_WORD,STAT1_135MS_B
		
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
		BTRSC	RG_128V_CNT,3			;DEBOUNCE = 1.1S (0x08  8*135Ms=1104Ms)
		BSR	RG_STAT2_WORD,STAT2_LOW3MIN_B


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
		INCR	RG_5VPOW_CNT,R
		BTRSC	RG_5VPOW_CNT,6			;DEBOUNCE = 2MIN (0x40  64*2s=128s)
		BCR	PORTA,EQ_5VPOW_B

		LGOTO   MAIN



		CLRR	RG_SLEEP_CNT

		BCR	RG_STAT3_WORD,STAT3_ISTATE_B0_B
		MOVR	PORTB,A
		MOVAR	RG_PORT_TEMP
		BTRSC   RG_PORT_TEMP,IOB0_B
		;BTRSC   PORTB,IOB0_B
		BSR	RG_STAT3_WORD,STAT3_ISTATE_B0_B
		
		CLRWDT
SLEEP_CYCLE:
		MOVR	PORTB,A
		MOVAR	RG_PORT_TEMP
		BTRSC   RG_PORT_TEMP,EQ_ACCPOW_B
		;BTRSC	PORTB,EQ_ACCPOW_B
		LGOTO   MAIN
		BTRSC	RG_STAT1_WORD,STAT1_INPUT_CAN_B
		LGOTO   MAIN

		MOVR	PORTB,A
		MOVAR	RG_PORT_TEMP
		BTRSS   RG_PORT_TEMP,EQ_INPUT_CAN_B
		;BTRSS	PORTB,EQ_INPUT_CAN_B
		LGOTO   MAIN



		SLEEP




CHECK_MODE_PIN:
		MOVR	PORTB,A
		MOVAR	RG_PORT_TEMP
		BTRSC   RG_PORT_TEMP,IOB0_B
		;BTRSC   PORTB,IOB0_B
		LGOTO   MODE_PIN_HIGH
	MODE_PIN_LOW:
		BTRSC	RG_STAT3_WORD,STAT3_ISTATE_B0_B
		LGOTO   MAIN
		LGOTO   MODE_PIN_OVER
	MODE_PIN_HIGH:
		BTRSS	RG_STAT3_WORD,STAT3_ISTATE_B0_B
		LGOTO   MAIN
	MODE_PIN_OVER:



		MOVR	PORTA,A
		MOVAR	RG_PORT_TEMP
		BTRSC   RG_PORT_TEMP,IOA1_B
		LGOTO   MAIN

SLEEP_CHECK_OVER:
		INCR	RG_SLEEP_CNT,R
		BTRSS	RG_SLEEP_CNT,7
		LGOTO   SLEEP_CYCLE

		LGOTO   MAIN









		