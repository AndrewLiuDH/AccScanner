;=======================================================================================================================
;=======================================================================================================================
;File:			AT8B.h
;Description:	The Header File for AT8B71A
;Author:		JasonLee
;Date:			2017/02/15
;=======================================================================================================================
;=======================================================================================================================
;-----------------------------------------------------------------------------------------------------------------------
;MOVR and MOVAR instrutions for access R-page Register (General Purpose Register)
;-----------------------------------------------------------------------------------------------------------------------
;R-page sregisters				;	bit7	|	bit6	|	bit5	|	bit4	|	bit3	|	bit2	|	bit1	|	bit0
;-----------------------------------------------------------------------------------------------------------------------	
; 00H --------- Indirect Addressing Register
INDF				EQU		00H
Pr_Indir_Addr		EQU		00H
; 01H --------- Timer0 Data Register	
TMR0				EQU		01H
Pr_TMR0_Data		EQU		01H
; 02H --------- Low Byte of Program Counter
PCL					EQU		02H
Pr_PCLow_Data		EQU		02H
; 03H --------- Status Register
STATUS				EQU		03H
Pr_Status			EQU		03H	;	BK[1]		BK[0]		-			/WDT_TO		/Sleep		Z			Half_C		C	
; 04H --------- File Selection Register (Include SRAM Bank Select)
FSR					EQU		04H
Pr_File_Sel			EQU		04H	;	-			FSR[6]		FSR[5]		FSR[4]		FSR[3]		FSR[2]		FSR[1]		FSR[0]	         
; 05H --------- PortA Data Register
PORTA				EQU		05H
Pr_PA_Data			EQU		05H
; 06H --------- PortB Data Register
PORTB				EQU		06H
Pr_PB_Data			EQU		06H
; 07H --------- Reserved
; 08H --------- Power Control Register (WatchDog,LVD and LVR Control)
PCON				EQU		08H
Pr_PWR_Ctrl			EQU		08H	;	WDTEn		-			LVDEN		-			LVREn		-			-			-	
; 09H --------- PortB Wakeup Control Register
BWUCON				EQU		09H
Pr_PB_WakeUp_Ctrl	EQU		09H	;	-			-			-			-			PB[3]		PB[2]		PB[1]		PB[0]
; 0AH --------- High Byte of Program Counter (B'xxxxDDDD')
PCHBUF				EQU		0AH
Pr_PCHigh_Data		EQU		0AH	;	DCMEN		XSPD_STP	-			-			PCHBUF[3]	PCHBUF[2]	PCHBUF[1]	PCHBUF[0]
; 0BH --------- PortA/B Pull-Low Control Register
ABPLCON				EQU		0BH
Pr_PAB_PL_Ctrl		EQU		0BH	;	/PB[3]		/PB[2]		/PB[1]		/PB[0]		/PA[3]		/PA[2]		/PA[1]		/PA[0]		
; 0CH --------- PortB Pull-High Control Register
BPHCON				EQU		0CH
Pr_PB_PH_Ctrl		EQU		0CH	;	-			-			-			-			/PB[3]	    /PB[2]		/PB[1]		/PB[0]	
; 0DH --------- Reserved
; 0EH --------- Interrupt Enable Register
INTE				EQU		0EH
Pr_INT_Ctrl			EQU		0EH	;	ExtINT1		WDT			TMR2		LVDIE		TMR1		ExtINT0		PBKey		TMR0	
; 0FH --------- Interrupt Flag	(Write '0' to Clear Flag)
INTF				EQU		0FH
Pr_INT_Flag			EQU		0FH	;	ExtINT1		WDT			TMR2		LVDIF		TMR1		ExtINT0		PBKey		TMR0	
; 10H --------- ADC mode Register
ADMD				EQU		10H
Pr_ADC_ADMD			EQU		10H	;	ADEN		ADC_START	ADC_EOC		ADC_CHEN	-			AD_CHSel[2] AD_CHSel[1] AD_CHSel[0]		
; 11H --------- ADC clock, ADC interrupt flag and ADC low 4-bit data output Register
ADR					EQU		11H
Pr_ADC_ADR			EQU		11H	;	ADIF		ADIE		AD_ClK[1]	AD_ClK[0]	AD_Data[3]	AD_Data[2] 	AD_Data[1] 	AD_Data[0]
; 12H --------- ADC output data Register  (ADC high 8-bit data output Register)
ADD					EQU		12H
Pr_ADC_Data			EQU		12H	;	AD_Data[11]	AD_Data[10]	AD_Data[9]	AD_Data[8]	AD_Data[7]	AD_Data[6] 	AD_Data[5] 	AD_Data[4]
; 13H --------- ADC high reference voltage Register
ADVREFH				EQU		13H
Pr_ADC_Vrefh		EQU		13H	;	AD_VREFH	-			-			-			-			- 			AD_VSel[1] 	AD_VSel[0]
; 14H --------- ADC Sampling pulse width and ADC conversion bit Register
ADCR				EQU		14H
Pr_ADC_ADCR			EQU		14H	;	-			-			-			-			AD_SAMP[1]	AD_SAMP[0] 	AD_BIT[1] 	AD_BIT[0]
; 15H --------- PortA Wakeup Control Register
AWUCON				EQU		15H
Pr_PA_WakeUp_Ctrl	EQU		15H	;	PA[7]		PA[6]		PA[5]		PA[3]		PA[3]		PA[2]		PA[1]		PA[0]
; 16H --------- AIN pin control Register
PACON				EQU		16H
Pr_AIN_Ctrl			EQU		16H	;	-			-			-			AIN4		AIN3 		AIN2 		AIN1		AIN0
; 17H --------- ADC calibration Register
ADT					EQU		17H
Pr_ADC_Calib_Ctrl	EQU		17H	;	AD_CalStart	AD_CalEn	AD_Sign		ADT[4]		ADT[3] 		ADT[2] 		ADT[1]		ADT[0]
; 18H --------- External Interrupt Contorl Register
INTEDG 				EQU		18H
Pr_EXINT_Ctrl		EQU		18H	;	-			-			ExINT1En	ExINT0En	INT1_Edg[1]	INT1_Edg[0]	INT0_Edg[1]	INT0_Edg[0]	
; 19H --------- TIMER1/2 Data and PWMDUTY1/2 msb 2 bits Register
TMRH  				EQU		19H
Pr_TMR_Data_PWM  	EQU		19H	;	TMR2_DATA9	TMR2_DATA8	TMR1_DATA9	TMR1_DATA8	PWM2_DUTY9	PWM2_DUTY8	PWM1_DUTY9	PWM1_DUTY8	
; 1AH --------- Voltage comparator Control Register
ANAEN  				EQU		1AH
Pr_CMP_PWR_Ctrl		EQU		1AH	;	CMPEN		-			-			-			-			-			-			-	
; 1BH --------- Resistor to Frequency Converter Control Register
RFC 				EQU		1BH	;		
Pr_RFC_Ctrl			EQU		1BH	;	RFCEN		-			-			-			PADSel[3]	PADSel[2]	PADSel[1]	PADSel[0]
; 1CH --------- TIMER3 Data and PWMDUTY3 msb 2 bits Register
TM3RH  				EQU		1CH	
Pr_TMR3_Data_PWM  	EQU		1CH	;	-			-			TMR3_DATA9	TMR3_DATA8	-			-			PWM3_DUTY9	PWM3_DUTY8	
; 1DH --------- Reserved
; 1EH --------- Reserved
; 1FH --------- Interrupt2 Enable Register
INTE2 				EQU		1FH			
Pr_INT2_Ctrl		EQU		1FH	;	-			-			-			T3IF			-			-			-			T3IE			
;-----------------------------------------------------------------------------------------------------------------------
;T0MD and T0MDR instrutions for access T0MD Register
;-----------------------------------------------------------------------------------------------------------------------
; xxH --------- Timer0 Control Register (Only Accessed by Instruction T0MD / T0MDR)
;T0MD				EQU		xxH	;	LClkSrc		-			ClkSel		EdgeSel		PS0WDT		PS0Div[2]	PS0Div[1]	PS0Div[0]	
;P_TMR0_Ctrl

;-----------------------------------------------------------------------------------------------------------------------
;IOST and IOSTR instrution for access F-page Register (IO Configuration Register)
;-----------------------------------------------------------------------------------------------------------------------
;F-page registers				;	bit7	|	bit6	|	bit5	|	bit4	|	bit3	|	bit2	|	bit1	|	bit0
;-----------------------------------------------------------------------------------------------------------------------	
; 05H --------- PortA Direction(1:Input/0:Output) Control Register
IOSTA				EQU		05H
Pf_PA_Dir_Ctrl		EQU		05H
; 06H --------- PortB Direction(1:Input/0:Output) Control Register
IOSTB				EQU		06H
Pf_PB_Dir_Ctrl		EQU		06H
; 09H --------- PortA Pull-High Control Register (/PA[5]: Pull-Low)
APHCON				EQU		09H
Pr_PA_PH_Ctrl		EQU		09H ;	/PA[7]		/PA[6]		/PA[5]		/PA[4]		/PA[3]		/PA[2]		/PA[1]		/PA[0]	
; 0AH --------- Prescaler0 Counter Value Register
PS0CV				EQU		0AH
Pf_PS0_Cnt			EQU		0AH
; 0CH --------- PortB Open-Drain Control Register
BODCON				EQU		0CH
Pf_PB_OD_Ctrl		EQU		0CH	;	-			-			-			-			PB[3]  		PB[2]		PB[1]		PB[0]		
; 0EH --------- Comparator voltage select Control Register
CMPCR				EQU		0EH
Pf_CMP_Ctrl			EQU		0EH	;	PS3  		PS2	 		PS1			PS0			VS3			VS2			VS1			VS0	
; 0FH --------- Power Control Register 1
PCON1				EQU		0FH
Pf_PWR_Ctrl1		EQU		0FH	;	GIE			LVDOUT		-			LVDS2		LVDS1		LVDS0		-			TMR0En	

;-----------------------------------------------------------------------------------------------------------------------
;SFUN and SFUNR instrution for access S-page Register (Special Function Register)
;-----------------------------------------------------------------------------------------------------------------------
;S-page registers				;	bit7	|	bit6	|	bit5	|	bit4	|	bit3	|	bit2	|	bit1	|	bit0
;-----------------------------------------------------------------------------------------------------------------------											
; 00H --------- Timer1 Data Register	
TMR1				EQU		00H
Ps_TMR1_Data		EQU		00H
; 01H --------- Timer1 Control Register	1
T1CR1				EQU		01H
Ps_TMR1_Ctrl1		EQU		01H	;	PWM1En		PWM1ActB	-			-			-			OneShot		Reload		TMR1En	
; 02H --------- Timer1 Control Register	2
T1CR2				EQU		02H
Ps_TMR1_Ctrl2		EQU		02H	;	-			-			ClkSel		EdgeSel		/PS1En		PS1Div[2]	PS1Div[1]	PS1Div[0]	
; 03H --------- PWM1 Duty Register
PWM1DUTY			EQU		03H
Ps_PWM1_Duty		EQU		03H
; 04H --------- Prescaler1 Counter Value Register
PS1CV				EQU		04H
Ps_PS1_Cnt			EQU		04H
; 05H --------- Buzzer1 Control Register
BZ1CR				EQU		05H
Ps_BZ1_Ctrl			EQU		05H	;	BZ1En		-			-			-			FSel[3]		FSel[2]		FSel[1]		FSel[0]	
; 06H --------- IR Control Register
IRCR				EQU		06H
Ps_IR_Ctrl			EQU		06H	;	IROSC358M   -			-			-			-			PolSel  	IRF57K		IREn	
; 07H --------- Table Access High Byte Address Pointer Register
TBHP				EQU		07H
Ps_TbHigh_Addr		EQU		07H	;	-			-			-			HPoint[4]	HPoint[3]	HPoint[2]	HPoint[1]	HPoint[0]	
; 08H --------- Table Access High Byte Data Register
TBHD				EQU		08H
Ps_TbHigh_Data		EQU		08H	;	-			-			HData[5]	HData[4]	HData[3]	HData[2]	HData[1]	HData[0]	
; 09H --------- Timer2 Data Register	
TMR2				EQU		09H
Ps_TMR2_Data		EQU		09H
; 0AH --------- Timer2 Control Register	1
T2CR1				EQU		0AH
Ps_TMR2_Ctrl1		EQU		0AH	;	PWM2En		PWM2ActB	-			-			-			OneShot		Reload		TMR2En	
; 0BH --------- Timer2 Control Register	2
T2CR2				EQU		0BH
Ps_TMR2_Ctrl2		EQU		0BH	;	-			-			ClkSel		EdgeSel		/PS2En		PS2Div[2]	PS2Div[1]	PS2Div[0]	
; 0CH --------- PWM2 Duty Register
PWM2DUTY			EQU		0CH
Ps_PWM2_Duty		EQU		0CH
; 0DH --------- Prescaler2 Counter Value Register
PS2CV				EQU		0DH
Ps_PS2_Cnt			EQU		0DH
; 0EH --------- Buzzer2 Control Register
BZ2CR				EQU		0EH
Ps_BZ2_Ctrl			EQU		0EH	;	BZ2En		-			-			-			FSel[3]		FSel[2]		FSel[1]		FSel[0]	
; 0FH --------- Oscillation Control Register (Include Switch Working Mode)
OSCCR				EQU		0FH
Ps_SYS_Ctrl			EQU		0FH	;	CMPOUT		CMPOE		CMPIF		CMPIE		Mode[1]		Mode[0]		HOSC_Stop	HOSC_Sel
; 10H --------- Timer3 Data Register	
TMR3				EQU		10H
Ps_TMR3_Data		EQU		10H
; 11H --------- Timer3 Control Register	1
T3CR1				EQU		11H
Ps_TMR3_Ctrl1		EQU		11H	;	PWM3En		PWM3ActB	-			-			-			OneShot		Reload		TMR3En	
; 12H --------- Timer3 Control Register	2
T3CR2				EQU		12H
Ps_TMR3_Ctrl2		EQU		12H	;	-			-			ClkSel		EdgeSel		/PS3En		PS3Div[2]	PS3Div[1]	PS3Div[0]	
; 13H --------- PWM3 Duty Register
PWM3DUTY			EQU		13H
Ps_PWM3_Duty		EQU		13H
; 14H --------- Prescaler3 Counter Value Register
PS3CV				EQU		14H
Ps_PS3_Cnt			EQU		14H
; 15H --------- Buzzer3 Control Register
BZ3CR				EQU		15H
Ps_BZ3_Ctrl			EQU		15H	;	BZ3En		-			-			-			FSel[3]		FSel[2]		FSel[1]		FSel[0]	

;=======================================================================================================================
;=======================================================================================================================
;-----------------------------------------------------------------------------------------------------------------------
; R-page Special Function Register (General Purpose Register)
;-----------------------------------------------------------------------------------------------------------------------
;------------------------------------------------------------
; Pr_Indir_Addr (00H)	--------- Indirect Addressing Register
;------------------------------------------------------------
;Bit[7:0] : Indirect Address
	C_Indir_Addr		EQU		FFH

;------------------------------------------------------------
; Pr_TMR0_Data (01H)	--------- Timer0 Data Register	
;------------------------------------------------------------
;Bit[7:0] : Timer0 Data
	C_TMR0_Data			EQU		FFH

;------------------------------------------------------------
; Pr_PCLow_Data (02H)	--------- Low Byte of Program Counter
;------------------------------------------------------------
;Bit[7:0] : Low Byte of Program Counter
	C_PCLow_Data		EQU		FFH

;------------------------------------------------------------
; Pr_Status (03H)		--------- Status Register (Include RAM Bank Select)
;------------------------------------------------------------
;Bit[7:6] : RAM Bank Selection
	C_RAM_Bank			EQU		C0H			; Select Ram Bank
	C_RAM_Bank0			EQU		00H			; Select Ram Bank0
	C_RAM_Bank1			EQU		40H			; Select Ram Bank1
	C_RAM_Bank2			EQU		80H			; Select Ram Bank2
	C_RAM_Bank3			EQU		C0H			; Select Ram Bank3	
;Bit[4:0] : System Status
	C_Status_WDT		EQU		10H			; WatchDog Overflow Flag
	C_Status_Slp		EQU		08H			; Sleep (Power Down) Flag
	C_Status_Z			EQU		04H			; Zero Flag
	C_Status_HalfC		EQU		02H			; Half Carry/Half Borrow Flag
	C_Status_C			EQU		01H			; Carry/Borrow Flag
	
	C_Status_WDT_Bit	EQU		4
	C_Status_Slp_Bit	EQU		3
	C_Status_Z_Bit		EQU		2
	C_Status_HalfC_Bit	EQU		1
	C_Status_C_Bit		EQU		0

;------------------------------------------------------------ 
; Pr_File_Sel (04H)		--------- File Selection Register       
;------------------------------------------------------------
;Bit[7] : Reserved	
;Bit[6:0] : Select one Register out of 128 registers of specific Bank.
	C_SFR_RAM_Addr		EQU		7FH			; RAM Address Bit[6:0] 

;------------------------------------------------------------	 
; Pr_PA_Data (05H)		--------- PortA Data Register
;------------------------------------------------------------ 
;Bit[7:0] : PORTA Data Bit Define	
	C_PA_Data			EQU		FFH			; PA  Data
	C_PA7_Data			EQU		80H			; PA7 Data
	C_PA6_Data			EQU		40H			; PA6 Data
	C_PA5_Data			EQU		20H			; PA5 Data
	C_PA4_Data			EQU		10H			; PA4 Data	
	C_PA3_Data			EQU		08H			; PA3 Data
	C_PA2_Data			EQU		04H			; PA2 Data
	C_PA1_Data			EQU		02H			; PA1 Data
	C_PA0_Data			EQU		01H			; PA0 Data
	
;------------------------------------------------------------
; Pr_PB_Data (06H)		--------- PortB Data Register
;------------------------------------------------------------
;Bit[7:4] : Reserved	
;Bit[3:0] : PORTB Data Bit Define	
	C_PB_Data			EQU		0FH			; PB  Data
	C_PB3_Data			EQU		08H			; PB3 Data
	C_PB2_Data			EQU		04H			; PB2 Data
	C_PB1_Data			EQU		02H			; PB1 Data
	C_PB0_Data			EQU		01H			; PB0 Data

;------------------------------------------------------------	
; Pr_PWR_Ctrl (08H)		--------- Power Control Register (WatchDog,LVD and LVR Control) 
;------------------------------------------------------------
;Bit[7] : WatchDog Eanble
	C_WDT_En			EQU		80H			; WatchDog Enable
;Bit[6] : Reserved
;Bit[5] : LVD Eanble
	C_LVD_En			EQU		20H			; LVD Enable	
;Bit[4] : Reserved
;Bit[3] : LVR Enable
	C_LVR_En			EQU		08H			; LVR Enable
;Bit[2:0] : Reserved

	C_WDT_En_Bit		EQU		7	
	C_LVD_En_Bit		EQU		5	
	C_LVR_En_Bit		EQU		3
	
;------------------------------------------------------------	
; Pr_PB_WakeUp_Ctrl (09H)	--------- PortB Wakeup Control Register
;------------------------------------------------------------
;Bit[7:4] : Reserved
;Bit[3:0] : BWUCON Bit Define
	C_PB_Wakeup			EQU		0FH			; PortB Wakeup Enable	
	C_PB3_Wakeup		EQU		08H			; PB3 Wakeup Enable
	C_PB2_Wakeup		EQU		04H			; PB2 Wakeup Enable 
	C_PB1_Wakeup		EQU		02H			; PB1 Wakeup Enable
	C_PB0_Wakeup		EQU		01H			; PB0 Wakeup Enable
		
;------------------------------------------------------------	
; Pr_PCHigh_Data (0AH) --------- High Byte of Program Counter
;------------------------------------------------------------
;Bit[7] : Constant Sink Current Contorl Bit	(1:Enable, 0:Disable)
	C_Const_Sink			EQU		80H
;Bit[6] : E_LXT Buckup Contorl Bit	(1:Disable, 0:Enable)
	C_ELXT_Backup_Dis		EQU		40H	
;Bit[5] : Reserved
;Bit[3:0] : High Byte of Program Counter
	C_PCHigh_Data			EQU		0FH
	
	C_Const_Sink_Bit		EQU		7
	C_ELXT_Backup_Dis_Bit	EQU		6
		
;------------------------------------------------------------		
; Pr_PAB_PL_Ctrl (0BH)	--------- PortA/B Pull-Low Control Register
;------------------------------------------------------------
;Bit[7:4] : PortB Pull-Low Control Register (1:Disable, 0:Pull-High)
    C_PB_PLB			EQU		F0H			; PortB Pull-Low Control bit
    C_PB3_PLB			EQU		80H			; PB3 Pull-Low Control bit
    C_PB2_PLB			EQU		40H			; PB2 Pull-Low Control bit	
    C_PB1_PLB			EQU		20H			; PB1 Pull-Low Control bit 	
    C_PB0_PLB			EQU		10H			; PB0 Pull-Low Control bit
;Bit[3:0] : PortA Pull-Low Control Register
    C_PA_PLB			EQU		0FH			; PortA Pull-Low Control bit
    C_PA3_PLB			EQU		08H			; PA3 Pull-Low Control bit
    C_PA2_PLB			EQU		04H			; PA2 Pull-Low Control bit	
    C_PA1_PLB			EQU		02H			; PA1 Pull-Low Control bit	
    C_PA0_PLB			EQU		01H			; PA0 Pull-Low Control bit

;------------------------------------------------------------	
; Pr_PB_PH_Ctrl (0CH)	--------- PortB Pull-High Control Register
;------------------------------------------------------------
;Bit[7:0] : PortB Pull-High Control Register (1:Disable, 0:Pull-High)
	C_PB_PHB			EQU		0FH			; PortB Pull-High Control bit 
	C_PB3_PHB			EQU		08H			; PB3 Pull-High Control bit	
	C_PB2_PHB			EQU		04H			; PB2 Pull-High Control bit
	C_PB1_PHB			EQU		02H			; PB1 Pull-High Control bit
	C_PB0_PHB			EQU		01H			; PB0 Pull-High Control bit

;------------------------------------------------------------	
; Pr_INT_Ctrl (0EH)		--------- Interrupt Enable Register
; Pr_INT_Flag (0FH)		--------- Interrupt Flag
;------------------------------------------------------------
;Bit[7:0] : Interrupt Source
	C_INT_EXT1			EQU		80H			; EX_INT1 interrupt enable bit
	C_INT_WDT			EQU		40H			; WDT timeout interrupt enable bit
	C_INT_TMR2			EQU		20H			; Timer2 underfolw interrupt enable bit
	C_INT_LVD			EQU		10H			; LVD interrupt enable bit	
	C_INT_TMR1			EQU		08H			; Timer1 underflow interrupt enable bit
	C_INT_EXT0			EQU		04H			; EX_INT0 interrupt enable bit
	C_INT_PABKey		EQU		02H			; PortA/B input change interrupt enable bit
	C_INT_TMR0			EQU		01H			; Timer0 overflow interrupt enable bit 

	C_INT_EXT1_Bit		EQU		7
	C_INT_WDT_Bit		EQU		6	
	C_INT_TMR2_Bit		EQU		5
	C_INT_LVD_Bit		EQU		4	
	C_INT_TMR1_Bit		EQU		3
	C_INT_EXT0_Bit		EQU		2
	C_INT_PABKey_Bit	EQU		1
	C_INT_TMR0_Bit		EQU		0

;------------------------------------------------------------	
; Pr_ADC_ADMD (10H) --------- ADC mode Register
;------------------------------------------------------------			
;Bit[7] : Enable/Disable ADC bit
	C_ADC_En			EQU		80H			; Enable ADC
	C_ADC_Dis			EQU		00H			; Disable ADC	
;Bit[6] : Start a ADC conversion session 
	C_ADC_Start			EQU		40H			; Write 1 to this bit, start ADC converting
;Bit[5] : ADC is end-of-convert
	C_ADC_Finish		EQU		20H			; (1:ADC is Finish, 0:ADC is in procession) Read-only
;Bit[4] : Enable/Disable All ADC input channel bit
	C_ADC_CH_En			EQU		10H			; Enable ADC input channel
	C_ADC_CH_Dis		EQU		00H			; Disable all ADC input channel
;Bit[3] : Reserved
;Bit[2:0] : Select ADC input channel
	C_Quarter_VDD		EQU		05H			; 1/4 VDD as ADC input
	C_ADC_PA4			EQU		04H			; PA4(AIN4) pad as ADC input channel	
	C_ADC_PA3			EQU		03H			; PA3(AIN3) pad as ADC input channel	
	C_ADC_PA2			EQU		02H			; PA2(AIN2) pad as ADC input channel	
	C_ADC_PA1			EQU		01H			; PA1(AIN1) pad as ADC input channel		
	C_ADC_PA0			EQU		00H			; PA0(AIN0) pad as ADC input channel

	C_ADC_En_Bit		EQU		7
	C_Start_Bit			EQU		6	
	C_Finish_Bit		EQU		5
	C_ADC_CH_En_Bit		EQU		4	
	
;------------------------------------------------------------	
; Pr_ADC_ADR (11H) 	--------- ADC clock, ADC interrupt control and ADC low 4-bit data output Register
;------------------------------------------------------------	
;Bit[7] : ADC interrupt flag
	C_INF_ADC			EQU		00H			; clear ADC interrupt flag
;Bit[6] : Enable/Disable of ADC interrupt
	C_INT_ADC			EQU		40H			; Enable ADC interrupt	
;Bit[5:4] : Select one of the 4 ADC clock
	C_Ckl_Div2			EQU		30H			; ADC clock is Fcpu/2
	C_Ckl_Div1			EQU		20H			; ADC clock is Fcpu/1	
	C_Ckl_Div8			EQU		10H			; ADC clock is Fcpu/8
	C_Ckl_Div16			EQU		00H			; ADC clock is Fcpu/16	
;Bit[3:0] : ADC low 4-bit data output Register.
	C_ADC_Data_L		EQU		0FH			; AD3 ~ AD0 ,Read-only	
	
	C_INF_ADC_Bit		EQU		7
	C_INT_ADC_Bit		EQU		6	
	
;------------------------------------------------------------	
; Pr_ADC_Data (12H) 	--------- ADC high 8-bit data output Register 
;------------------------------------------------------------		
;Bit[7:0] : High 8-bit of ADC data buffer
	C_ADC_Data_H		EQU		FFH			; AD11 ~ AD4 , Read-only	

;------------------------------------------------------------	
; Pr_ADC_Vrefh (13H) 	--------- ADC high reference voltage Register
;------------------------------------------------------------		
;Bit[7] : ADC reference high voltage (VREFH) select control bit	
	C_Vrefh_External			EQU		80H		; ADC reference high voltage is supplied by external pin PA0
	C_Vrefh_Internal			EQU		00H		; ADC reference high voltage is internal generated, the voltage selected depends on VHS1~0.
;Bit[6:2] : Reserved
;Bit[1:0] : Select ADC internal high reference voltage
	C_Vrefh_VDD			EQU		03H			; ADC reference high voltage is VDD
	C_Vrefh_4V			EQU		02H			; ADC reference high voltage is 4V	
	C_Vrefh_3V			EQU		01H			; ADC reference high voltage is 3V	
	C_Vrefh_2V			EQU		00H			; ADC reference high voltage is 2V

;------------------------------------------------------------	
; Pr_ADC_ADCR (14H) 	--------- ADC Sampling pulse width and select ADC conversion bit Register
;------------------------------------------------------------
;Bit[7:4] : Reserved
;Bit[3:2] : Select ADC sampling pulse width
	C_Sample_8clk		EQU		0CH			; ADC Sampling pulse width is 8 ADC clock
	C_Sample_4clk		EQU		08H			; ADC Sampling pulse width is 4 ADC clock
	C_Sample_2clk		EQU		04H			; ADC Sampling pulse width is 2 ADC clock
	C_Sample_1clk		EQU		00H			; ADC Sampling pulse width is 1 ADC clock
;Bit[1:0] : Select ADC conversion bit numbers   
	C_12BIT				EQU		03H			; 12-bit ADC
	C_10BIT				EQU		01H			; 10-bit ADC
	C_8BIT				EQU		00H			;  8-bit ADC
	
;------------------------------------------------------------	
; Pr_PA_WakeUp_Ctrl (15H) 	--------- PortA Wakeup Control Register
;------------------------------------------------------------	
;Bit[7:0] : AWUCON Bit Define
	C_PA_Wakeup			EQU		FFH			; Port A Wakeup Enable		
	C_PA7_Wakeup		EQU		80H			; PA7 Wakeup Enable
	C_PA6_Wakeup		EQU		40H			; PA6 Wakeup Enable 
	C_PA5_Wakeup		EQU		20H			; PA5 Wakeup Enable
	C_PA4_Wakeup		EQU		10H			; PA4 Wakeup Enable	
	C_PA3_Wakeup		EQU		08H			; PA3 Wakeup Enable
	C_PA2_Wakeup		EQU		04H			; PA2 Wakeup Enable 
	C_PA1_Wakeup		EQU		02H			; PA1 Wakeup Enable
	C_PA0_Wakeup		EQU		01H			; PA0 Wakeup Enable

;------------------------------------------------------------	
; Pr_AIN_Ctrl (16H) 	--------- AIN pin control Register
;------------------------------------------------------------	
;Bit[7:5] : Reserved
;Bit[4:0] : Select PortA as pure AIN or GPIO pin
	C_PA_AIN 			EQU		FFH			; Select Port A as pure AIN pin for power-saving
	C_PA_GPIO 			EQU		00H			; Select Port A as GPIO pin 
	
	C_PA4_AIN4 			EQU		10H			; Select PA4 as pure AIN4 pin 
	C_PA3_AIN3 			EQU		08H			; Select PA3 as pure AIN3 pin 
	C_PA2_AIN2 			EQU		04H			; Select PA2 as pure AIN2 pin 
	C_PA1_AIN1 			EQU		02H			; Select PA1 as pure AIN1 pin 	
	C_PA0_AIN0 			EQU		01H			; Select PA0 as pure AIN0 pin 	
	
	C_PA4_AIN4_Bit		EQU		4
	C_PA3_AIN3_Bit		EQU		3
	C_PA2_AIN2_Bit		EQU		2
	C_PA1_AIN1_Bit		EQU		1	
	C_PA0_AIN0_Bit		EQU		0	
	
;------------------------------------------------------------	
; Pr_ADC_Calib_Ctrl (17H) 	--------- ADC calibration Register
;------------------------------------------------------------		
;Bit[7] : Calibration session start bit		
	C_CAL_Start			EQU		80H			; Write 1 to this bit, start ADC calibration session	
;Bit[6] : Enable/Disable calibration bit		
	C_CAL_En			EQU		40H			; Enable ADC calibration
	C_CAL_Dis			EQU		00H			; Disable ADC calibration
;Bit[5] : The significant bit of calibration result
	C_CAL_SIGN			EQU		20H			; Read-only		
;Bit[4:0] : The data of calibration result
	C_CAL_Data			EQU		1FH			; Read-only	

	C_CAL_Start_Bit		EQU		7
	C_CAL_En_Bit		EQU		6	

;------------------------------------------------------------	
; Pr_EXINT_Ctrl (18H) 	--------- External Interrupt Contorl Register
;------------------------------------------------------------	
;Bit[7:6] : Reserved	
;Bit[5] : External INT1 Eanble
	C_INT1_En			EQU		20H			; PB1 set as INT1 input
;Bit[4] : External INT0 Eanble	
	C_INT0_En			EQU		10H			; PB0 set as INT0 input
;Bit[3:2] : INT1 edge trigger select 
    C_INT1_Edge			EQU		0CH			; INT1 trigger edge  --- 11b: Rising & Falling Edge, 10b:Falling Edge, 01b:Rising Edge    
	C_INT1_TwoEdge		EQU		0CH			; Rising & Falling edge trigger
	C_INT1_FallingEdge	EQU		08H			; Falling edge trigger	
	C_INT1_RisingEdge	EQU		04H			; Rising edge trigger			
;Bit[1:0] : INT0 edge trigger select 
    C_INT0_Edge			EQU		03H			; INT0 trigger edge  --- 11b: Rising & Falling Edge, 10b:Falling Edge, 01b:Rising Edge  
	C_INT0_TwoEdge		EQU		03H			; Rising & Falling edge trigger
	C_INT0_FallingEdge	EQU		02H			; Falling edge trigger	
	C_INT0_RisingEdge	EQU		01H			; Rising edge trigger	

	C_INT1_En_Bit		EQU		5
	C_INT0_En_Bit		EQU		4
	
;------------------------------------------------------------	
; Pr_TMR_Data_PWM (19H) 	--------- TIMER1/2 Data and PWMDUTY1/2 msb 2 bits Register
;------------------------------------------------------------	
;Bit[7] : Timer2 Data Bit9	
	C_TMR2_Data_b9		EQU		80H			; Timer2 data bit9 
;Bit[6] : Timer2 Data Bit8	
	C_TMR2_Data_b8		EQU		40H			; Timer2 data bit8
;Bit[5] : Timer1 Data Bit9	
	C_TMR1_Data_b9		EQU		20H			; Timer1 data bit9 
;Bit[4] : Timer1 Data Bit8	
	C_TMR1_Data_b8		EQU		10H			; Timer1 data bit8		
;Bit[3] : Timer2 PWM Duty Bit9	
	C_PWM2_Duty_b9		EQU		08H			; PWM2 Duty bit9 
;Bit[2] : Timer2 PWM Duty Bit8	
	C_PWM2_Duty_b8		EQU		04H			; PWM2 Duty bit8
;Bit[1] : Timer1 PWM Duty Bit9	
	C_PWM1_Duty_b9		EQU		02H			; PWM1 Duty bit9 
;Bit[0] : Timer1 PWM Duty Bit8	
	C_PWM1_Duty_b8		EQU		01H			; PWM1 Duty bit8	

	C_TMR2_Data_b9_Bit	EQU		7
	C_TMR2_Data_b8_Bit	EQU		6	
	C_TMR1_Data_b9_Bit	EQU		5
	C_TMR1_Data_b8_Bit	EQU		4
	C_PWM2_Duty_b9_Bit	EQU		3
	C_PWM2_Duty_b8_Bit	EQU		2	
	C_PWM1_Duty_b9_Bit	EQU		1
	C_PWM1_Duty_b8_Bit	EQU		0	
	
;------------------------------------------------------------	
; Pr_CMP_PWR_Ctrl (1AH) 	--------- Voltage comparator Control Register
;------------------------------------------------------------		
;Bit[7] : Enable/disable voltage comparator
	C_CMP_En			EQU		80H			; Enable voltage comparator 
	C_CMP_Dis			EQU		00H			; Disable voltage comparator 	
;Bit[6:0] : Reserved

	C_CMP_En_Bit		EQU		7
	
;------------------------------------------------------------	
; Pr_RFC_Ctrl (1BH) 	--------- Resistor to Frequency Converter Control Register
;------------------------------------------------------------		
;Bit[7] : Enable/disable RFC function
	C_RFC_En			EQU		80H			; Enable RFC function
	C_RFC_Dis			EQU		00H			; Disable RFC function	
;Bit[6:4] : Reserved	
;Bit[3:0] : Select one of the RFC pad
	C_RFC_PB3			EQU		0BH			; Select PB3 as RFC pad
	C_RFC_PB2			EQU		0AH			; Select PB2 as RFC pad	
	C_RFC_PB1			EQU		09H			; Select PB1 as RFC pad	
	C_RFC_PB0			EQU		08H			; Select PB0 as RFC pad	
	C_RFC_PA7			EQU		07H			; Select PA7 as RFC pad
	C_RFC_PA6			EQU		06H			; Select PA6 as RFC pad
	C_RFC_PA5			EQU		05H			; Select PA5 as RFC pad
	C_RFC_PA4			EQU		04H			; Select PA4 as RFC pad
	C_RFC_PA3			EQU		03H			; Select PA3 as RFC pad
	C_RFC_PA2			EQU		02H			; Select PA2 as RFC pad	
	C_RFC_PA1			EQU		01H			; Select PA1 as RFC pad
	C_RFC_PA0			EQU		00H			; Select PA0 as RFC pad	
		
	C_RFC_En_Bit		EQU		7
	C_PSEL3_Bit			EQU		3
	C_PSEL2_Bit			EQU		2
	C_PSEL1_Bit			EQU		1
	C_PSEL0_Bit			EQU		0	
				
;------------------------------------------------------------	
; Pr_TMR3_Data_PWM (1CH) 	--------- TIMER3 Data and PWMDUTY3 msb 2 bits Register
;------------------------------------------------------------	
;Bit[7:6] : Reserved
;Bit[5] : Timer3 Data Bit9	
	C_TMR3_Data_b9		EQU		20H			; Timer3 data bit9 
;Bit[4] : Timer3 Data Bit8	
	C_TMR3_Data_b8		EQU		10H			; Timer3 data bit8		
;Bit[3:2] : Reserved
;Bit[1] : Timer3 PWM Duty Bit9	
	C_PWM3_Duty_b9		EQU		02H			; PWM3 Duty bit9 
;Bit[0] : Timer3 PWM Duty Bit8	
	C_PWM3_Duty_b8		EQU		01H			; PWM3 Duty bit8	

	C_TMR3_Data_b9_Bit	EQU		5
	C_TMR3_Data_b8_Bit	EQU		4
	C_PWM3_Duty_b9_Bit	EQU		1
	C_PWM3_Duty_b8_Bit	EQU		0					
				
;------------------------------------------------------------	
; Pr_INT2_Ctrl (1FH)		--------- Interrupt2 Enable Register
;------------------------------------------------------------
;Bit[7:5] : Reserved
;Bit[4] : Timer3 underfolw Interrupt flag bit
	C_INF_TMR3			EQU		10H			; Timer3 underfolw interrupt flag bit
;Bit[3:1] : Reserved
;Bit[0] : Timer3 underfolw Interrupt enable bit
	C_INE_TMR3			EQU		01H			; Timer3 underfolw interrupt enable bit 

	C_INF_TMR3_Bit		EQU		4	
	C_INE_TMR3_Bit		EQU		0				
																
;------------------------------------------------------------	
; P_TMR0_Ctrl (xxH)		--------- T0MD Register
;------------------------------------------------------------
;		C_TMR0_Clk		C_TMR0_LowClk	|	Timer 0 Clock Source
;------------------------------------------------------------
;		0				x				|	From Instruction Clock
;		1				0				|	From External Pin
;		1				1				|	From Low Oscillator Frequency (I_LRC or E_LXT)
;------------------------------------------------------------
;Bit[7,5:4] : Timer0 Clock Source Selection
	C_TMR0_LowClk		EQU		80H			; Same as LCKTM0	
	C_TMR0_Clk			EQU		20H			; Same as T0CS
	C_TMR0_ExtClk_Edge	EQU		10H			; Timer0 External Clock Edge Select --- 1:Falling Edge, 0:Rising Edge
;Bit[6] : Reserved
;Bit[3] : Watchdog Interrupt Source Selection / Timer0 Prescaler0 Selection
	C_PS0_WDT			EQU		08H			; Prescaler0 is assigned to WDT
	C_PS0_TMR0			EQU		00H			; Prescaler0 is assigned to TMR0
;Bit[2:0] : Prescaler0 Dividing Rate Selection
	C_PS0_Div			EQU		07H			; Prescaler0 Dividing Rate Selection
	C_PS0_Div2			EQU		00H
	C_PS0_Div4			EQU		01H
	C_PS0_Div8			EQU		02H
	C_PS0_Div16			EQU		03H
	C_PS0_Div32			EQU		04H
	C_PS0_Div64			EQU		05H
	C_PS0_Div128		EQU		06H
	C_PS0_Div256		EQU		07H

;=======================================================================================================================
;=======================================================================================================================
;-----------------------------------------------------------------------------------------------------------------------
; F-page Special Function Register (IO Configuration Register)
;-----------------------------------------------------------------------------------------------------------------------	
;------------------------------------------------------------
; Pf_PA_Dir_Ctrl (05H)	--------- PortA Direction(Input/Output) Control Register
;------------------------------------------------------------
;Bit[7:0] : Port A Input/Output Mode Selection (1:Input, 0:Output)
	C_PA_Input			EQU		FFH			; Port A Input Mode Control
	C_PA_Output			EQU		00H			; Port A Output Mode Control

	C_PA7_Input			EQU		80H			; PA7 I/O mode Control bit
	C_PA6_Input			EQU		40H			; PA6 I/O mode Control bit
	C_PA5_Input			EQU		20H			; PA5 I/O mode Control bit
	C_PA4_Input			EQU		10H			; PA4 I/O mode Control bit 
	C_PA3_Input			EQU		08H			; PA3 I/O mode Control bit
	C_PA2_Input			EQU		04H			; PA2 I/O mode Control bit
	C_PA1_Input			EQU		02H			; PA1 I/O mode Control bit
	C_PA0_Input			EQU		01H			; PA0 I/O mode Control bit 
	C_PA7_Output		EQU		00H			; PA7 I/O mode Control bit
	C_PA6_Output		EQU		00H			; PA6 I/O mode Control bit
	C_PA5_Output		EQU		00H			; PA5 I/O mode Control bit
	C_PA4_Output		EQU		00H			; PA4 I/O mode Control bit 	
	C_PA3_Output		EQU		00H			; PA3 I/O mode Control bit
	C_PA2_Output		EQU		00H			; PA2 I/O mode Control bit
	C_PA1_Output		EQU		00H			; PA1 I/O mode Control bit
	C_PA0_Output		EQU		00H			; PA0 I/O mode Control bit 

;------------------------------------------------------------	
; Pf_PB_Dir_Ctrl (06H)	--------- PortB Direction(Input/Output) Control Register
;------------------------------------------------------------
;Bit[7:4] : Reserved
;Bit[3:0] : Port B Input/Output Mode Selection (1:Input, 0:Output)
	C_PB_Input			EQU		0FH			; Port B Input Mode Control
	C_PB_Output			EQU		00H			; Port B Output Mode Control

	C_PB3_Input			EQU		08H			; PB3 I/O mode Control bit
	C_PB2_Input			EQU		04H			; PB2 I/O mode Control bit
	C_PB1_Input			EQU		02H			; PB1 I/O mode Control bit
	C_PB0_Input			EQU		01H			; PB0 I/O mode Control bit
	C_PB3_Output		EQU		00H			; PB3 I/O mode Control bit
	C_PB2_Output		EQU		00H			; PB2 I/O mode Control bit
	C_PB1_Output		EQU		00H			; PB1 I/O mode Control bit
	C_PB0_Output		EQU		00H			; PB0 I/O mode Control bit

;------------------------------------------------------------	
; Pr_PA_PH_Ctrl (09H)	--------- PortA Pull-High Control Register
;------------------------------------------------------------
;Bit[7:0] : PortA Pull-High Control Register (1:Disable, 0:Pull-High)
	C_PA_PHB			EQU		FFH			; PortA Pull-High Control bit 
	C_PA7_PHB			EQU		80H			; PA7 Pull-High Control bit 
	C_PA6_PHB			EQU		40H			; PA6 Pull-High Control bit   
	C_PA5_PLB			EQU		20H			; PA5 Pull-Low  Control bit
	C_PA4_PHB			EQU		10H			; PA4 Pull-High Control bit
	C_PA3_PHB			EQU		08H			; PA3 Pull-High Control bit	
	C_PA2_PHB			EQU		04H			; PA2 Pull-High Control bit
	C_PA1_PHB			EQU		02H			; PA1 Pull-High Control bit
	C_PA0_PHB			EQU		01H			; PA0 Pull-High Control bit
		
;------------------------------------------------------------	
; Pf_PS0_Cnt (0AH)		--------- Prescaler0 Counter Value Register
;------------------------------------------------------------
;Bit[7:0] : Prescaler0 Counter Value
	C_PS0_Cnt			EQU		FFH			; Read-only	
	
;------------------------------------------------------------	
; Pf_PB_OD_Ctrl (0CH)	--------- PortB Open-Drain Control Register
;------------------------------------------------------------
;Bit[7:4] : Reserved
;Bit[3:0] : PortB Open-Drain Control (1:Open-Drain, 0:Disable)
	C_PB_OD				EQU		0FH			; Port B Open-Drain Control
	C_PB3_OD			EQU		08H			; PB3 Open-Drain Control bit	
	C_PB2_OD			EQU		04H			; PB2 Open-Drain Control bit
	C_PB1_OD			EQU		02H			; PB1 Open-Drain Control bit 
	C_PB0_OD			EQU		01H			; PB0 Open-Drain Control bit

;------------------------------------------------------------	
; Pf_CMP_Ctrl (0EH)	--------- Comparator voltage select Control Register
;------------------------------------------------------------
;Bit[7:4] : PS[3:0]
	C_CMP_PinSelect		EQU		F0H
;Bit[3:0] : VS[3:0]
	C_CMP_VolSelect		EQU		0FH
;P2V MODE
;VS[3:0]	V- of Comparator	PS[3:0]		Selected pad
;--------------------------------------------------------
;0000		P2P mode			0000		PA0
;0001		1 / 16 VDD			0001		PA1
;0010		2 / 16 VDD			0010		PA2
;0011		3 / 16 VDD			0011		PA3
;0100		4 / 16 VDD			0100		PA4
;0101		5 / 16 VDD			0101		NA
;0110		6 / 16 VDD			0110		PA6
;0111		7 / 16 VDD			0111		PA7
;1000		8 / 16 VDD			1000		PB0
;1001		9 / 16 VDD			1001		PB1
;1010		10 / 16 VDD			1010		PB2
;1011		11 / 16 VDD			1011		PB3
;1100		12 / 16 VDD			1100		NA
;1101		13 / 16 VDD			1101		NA
;1110		14 / 16 VDD			1110		NA
;1111		15 / 16 VDD			1111		NA
;P2P MODE
;PS[3:0]	Non-inverting input		Inverting input
;-------------------------------------------
;0000		PA0						PA1
;0001		PA1						PA0
;0010		PA2						PA3
;0011		PA3						PA2
;0100		PA0						PB3
;0101		PA1						PB2
;0110		NA						NA
;0111		NA						NA
;1000		PB2						PA1
;1001		PB3						PA0
;1010		NA						NA
;1011		NA						NA
;1100		PB2						PB3
;1101		PB3						PB2
;1110		NA						NA
;1111		NA						NA

;------------------------------------------------------------	
; Pf_PWR_Ctrl1 (0FH)	--------- Power Control Register 1
;------------------------------------------------------------
;Bit[7] : All Interrupt Enable (Set by instruction ENI, clear by instruction DISI)
	C_All_INT_En		EQU		80H			; Enable all unmasked interrupts
;Bit[6] : Low voltage detector output 
	C_LVDOUT			EQU		40H			; read-only
;Bit[5] : Reserved
;Bit[4:2] : Select one of the 8 LVD voltage
	C_LVD_4P3V			EQU		1CH			; LVD Voltage=4.3V
	C_LVD_3P6V			EQU		18H			; LVD Voltage=3.6V	
	C_LVD_3P3V			EQU		14H			; LVD Voltage=3.3V	
	C_LVD_3P0V			EQU		10H			; LVD Voltage=3.0V	
	C_LVD_2P7V			EQU		0CH			; LVD Voltage=2.7V	
	C_LVD_2P4V			EQU		08H			; LVD Voltage=2.4V	
	C_LVD_2P2V			EQU		04H			; LVD Voltage=2.2V	
	C_LVD_2P0V			EQU		00H			; LVD Voltage=2.0V		
;Bit[0] : Timer0 Enable
	C_TMR0_En			EQU		01H			; Enable Timer0
	C_TMR0_Dis			EQU		00H			; Disable Timer0
	
	C_LVDS2_bit			EQU		4
	C_LVDS1_bit			EQU		3
	C_LVDS0_bit			EQU		2
	C_TMR0_En_bit		EQU		0
;=======================================================================================================================
;=======================================================================================================================
;-----------------------------------------------------------------------------------------------------------------------
; S-page Special Function Register (Special Function Register)
;-----------------------------------------------------------------------------------------------------------------------		
;------------------------------------------------------------
; Ps_TMR1_Data (00H)	--------- Timer1 Data Register
;------------------------------------------------------------
;Bit[7:0] : Timer1 Data
	C_TMR1_Data			EQU		FFH	
	
;------------------------------------------------------------	
; Ps_TMR1_Ctrl1 (01H)	--------- Timer1 Control Register 1
;------------------------------------------------------------
;Bit[7:6] : PWM1 Control
	C_PWM1_En			EQU		80H 		; PWM1 output will be present on PB3
	C_PWM1_Active		EQU		40H 		; PWM1 output is active
	C_PWM1_Active_Lo	EQU		40H 		; PWM1 output is active low 
	C_PWM1_Active_Hi	EQU		00H 		; PWM1 output is active high 
;Bit[5:3] : Reserved
;Bit[2:0] : Timer1 Control
	C_TMR1_OneShot		EQU		04H 		; One-Shot mode. Timer1 will count once from the initial value to 0x00
	C_TMR1_Reload		EQU		02H 		; Initial value is reloaded from reload register TMR1(T1OS=0)

	C_TMR1_En			EQU		01H 		; Enable Timer1
	C_TMR1_Dis			EQU		00H 		; Disable Timer1

;------------------------------------------------------------	
; Ps_TMR1_Ctrl2 (02H)	--------- Timer1 Control Register 2
;------------------------------------------------------------
;Bit[7:6] : Reserved
;Bit[5] : Timer1 Clock Source Select
	C_TMR1_ClkSrc_Ext	EQU		20H			; Timer1 clock source from External Clock Input(EX_CKI0)
	C_TMR1_ClkSrc_Inst	EQU		00H			; Timer1 clock source from Internal Instruction Clock	
;Bit[4] : Timer1 external clock edge selection
    C_TMR1_ExtClk_Edge	EQU		10H			; Timer1 External Clock Edge Select --- 1:Falling Edge, 0:Rising Edge  
	C_TMR1_ExtFalling	EQU		10H			; Timer1 will decrease one while EX_CKI0 Falling Edge.
	C_TMR1_ExtRising	EQU		00H			; Timer1 will decrease one while EX_CKI0 Rising Edge.
;Bit[3] :  Disable/enable Prescaler1
    C_PS1_Dis           EQU		08H			; Disable Prescaler1
	C_PS1_EN			EQU		00H			; Enable Prescaler1
;Bit[2:0] : Prescaler 1 Dividing Rate Selection
	C_PS1_Div			EQU		07H			; Prescaler1 Dividing Rate Selection
	C_PS1_Div2			EQU		00H
	C_PS1_Div4			EQU		01H
	C_PS1_Div8			EQU		02H
	C_PS1_Div16			EQU		03H
	C_PS1_Div32			EQU		04H
	C_PS1_Div64			EQU		05H
	C_PS1_Div128		EQU		06H
	C_PS1_Div256		EQU		07H

;------------------------------------------------------------	
; Ps_PWM1_Duty (03H)	--------- PWM1 Duty Register
;------------------------------------------------------------
;Bit[7:0] : PWM1 Duty Value
	C_PWM1_Duty			EQU		FFH

;------------------------------------------------------------	
; Ps_PS1_Cnt (04H)		--------- Prescaler1 Counter Value Register
;------------------------------------------------------------
;Bit[7:0] : Prescaler1 Counter Value
	C_PS1_Cnt			EQU		FFH			; Read-only

;------------------------------------------------------------	
; Ps_BZ1_Ctrl (05H)		--------- Buzzer1 Control Register
;------------------------------------------------------------
;Bit[7] : BZ1 Enable
	C_BZ1_En			EQU		80H			; Enable BZ1 output
;Bit[6:4] : Reserved
;Bit[3:0] : BZ1 Frequency Selection
	C_BZ1_FSel			EQU		0FH			; BZ1 frequency selection

	C_BZ1_PS1Div2		EQU		00H			; Clock Soruce from Prescaler 1
	C_BZ1_PS1Div4		EQU		01H
	C_BZ1_PS1Div8		EQU		02H
	C_BZ1_PS1Div16		EQU		03H
	C_BZ1_PS1Div32		EQU		04H
	C_BZ1_PS1Div64		EQU		05H
	C_BZ1_PS1Div128		EQU		06H
	C_BZ1_PS1Div256		EQU		07H

	C_BZ1_TMR1B0		EQU		08H			; Clock Source from Timer 1
	C_BZ1_TMR1B1		EQU		09H
	C_BZ1_TMR1B2		EQU		0AH
	C_BZ1_TMR1B3		EQU		0BH
	C_BZ1_TMR1B4		EQU		0CH
	C_BZ1_TMR1B5		EQU		0DH
	C_BZ1_TMR1B6		EQU		0EH
	C_BZ1_TMR1B7		EQU		0FH

;------------------------------------------------------------	
; Ps_IR_Ctrl (06H)		--------- IR Control Register
;------------------------------------------------------------
;Bit[7] : IR Clock Source Selection (1:3.58MHz, 0:455KHz)
	C_IR_ClkSrc_358M	EQU		80H			; IRCR[7]=1 , external crystal is 3.58MHz (This bit is ignored if internal high frequency oscillation is used)
	C_IR_ClkSrc_455K	EQU		00H			; IRCR[7]=0 , external crystal is 455KHz
;Bit[6:3] : Reserved
;Bit[2] : IR Polarity Selection
	C_IR_Pol_Sel		EQU		04H
;Bit[1] : IR Carrier Frequency Selection (1:57KHz, 0:38KHz)
	C_IR_57K			EQU		02H			; IRCR[1]=1 , IR carrier frequency is 57KHz
	C_IR_38K			EQU		00H			; IRCR[1]=0 , IR carrier frequency is 38KHz
;Bit[0] : IR Enable
	C_IR_En				EQU		01H			; Enable IR carrier output

;------------------------------------------------------------	
; Ps_TbHigh_Addr (07H)	--------- Table Access High Byte Address Pointer Register
;------------------------------------------------------------
;Bit[7:4] : Reserved
;Bit[3:0] : Table Access High Byte Address Pointer
	C_TbHigh_Addr		EQU		0FH			; When instruction CALLA, GOTOA or TABLEA is executed TBHP[1:0] is PC[9:8] (AT8B71A)

;------------------------------------------------------------	
; Ps_TbHigh_Data (08H)	--------- Table Access High Byte Data Register
;------------------------------------------------------------
;Bit[7:6] : Reserved
;Bit[5:0] : Table Access High Byte Data
	C_TbHigh_Data		EQU		3FH
	
;------------------------------------------------------------
; Ps_TMR2_Data (09H)	--------- Timer2 Data Register
;------------------------------------------------------------
;Bit[7:0] : Timer2 Data
	C_TMR2_Data			EQU		FFH	
	
;------------------------------------------------------------	
; Ps_TMR2_Ctrl1 (0AH)	--------- Timer2 Control Register 1
;------------------------------------------------------------
;Bit[7:6] : PWM2 Control
	C_PWM2_En			EQU		80H 		; PWM2 output will be present on PB2
	C_PWM2_Active		EQU		40H 		; PWM2 output is active
	C_PWM2_Active_Lo	EQU		40H 		; PWM2 output is active low 
	C_PWM2_Active_Hi	EQU		00H 		; PWM2 output is active high 
;Bit[5:3] : Reserved
;Bit[2:0] : Timer2 Control
	C_TMR2_OneShot		EQU		04H 		; One-Shot mode. Timer2 will count once from the initial value to 0x00
	C_TMR2_Reload		EQU		02H 		; Initial value is reloaded from reload register TMR2(T2OS=0)
         
	C_TMR2_En			EQU		01H 		; Enable Timer2
	C_TMR2_Dis			EQU		00H 		; Disable Timer2

;------------------------------------------------------------	
; Ps_TMR2_Ctrl2 (0BH)	--------- Timer2 Control Register 2
;------------------------------------------------------------
;Bit[7:6] : Reserved
;Bit[5] : Timer2 Clock Source Select
	C_TMR2_ClkSrc_Ext	EQU		20H			; Timer2 clock source from External Clock Input
	C_TMR2_ClkSrc_Inst	EQU		00H			; Timer2 clock source from Internal Instruction Clock	
;Bit[4] : Timer2 external clock edge selection
    C_TMR2_ExtClk_Edge	EQU		10H			; Timer2 External Clock Edge Select --- 1:Falling Edge, 0:Rising Edge  
	C_TMR2_ExtFalling	EQU		10H			; Timer2 will decrease one while EX_CKI1 Falling Edge.
	C_TMR2_ExtRising	EQU		00H			; Timer2 will decrease one while EX_CKI1 Rising Edge.
;Bit[3] :  Disable/enable Prescaler2
    C_PS2_Dis           EQU		08H			; Disable Prescaler2
	C_PS2_EN			EQU		00H			; Enable Prescaler2
;Bit[2:0] : Prescaler 2 Dividing Rate Selection
	C_PS2_Div			EQU		07H			; Prescaler2 Dividing Rate Selection
	C_PS2_Div2			EQU		00H
	C_PS2_Div4			EQU		01H
	C_PS2_Div8			EQU		02H
	C_PS2_Div16			EQU		03H
	C_PS2_Div32			EQU		04H
	C_PS2_Div64			EQU		05H
	C_PS2_Div128		EQU		06H
	C_PS2_Div256		EQU		07H

;------------------------------------------------------------	
; Ps_PWM2_Duty (0CH)	--------- PWM2 Duty Register
;------------------------------------------------------------
;Bit[7:0] : PWM2 Duty Value
	C_PWM2_Duty			EQU		FFH

;------------------------------------------------------------	
; Ps_PS2_Cnt (0DH)		--------- Prescaler2 Counter Value Register
;------------------------------------------------------------
;Bit[7:0] : Prescaler2 Counter Value
	C_PS2_Cnt			EQU		FFH			; Read-only	

;------------------------------------------------------------	
; Ps_BZ2_Ctrl (0EH)		--------- Buzzer2 Control Register
;------------------------------------------------------------
;Bit[7] : BZ2 Enable
	C_BZ2_En			EQU		80H			; Enable BZ2 output 
;Bit[6:4] : Reserved
;Bit[3:0] : BZ2 Frequency Selection
	C_BZ2_FSel			EQU		0FH			; BZ2 frequency selection

	C_BZ2_PS2Div2		EQU		00H			; Clock Soruce from Prescaler 2
	C_BZ2_PS2Div4		EQU		01H
	C_BZ2_PS2Div8		EQU		02H
	C_BZ2_PS2Div16		EQU		03H
	C_BZ2_PS2Div32		EQU		04H
	C_BZ2_PS2Div64		EQU		05H
	C_BZ2_PS2Div128		EQU		06H
	C_BZ2_PS2Div256		EQU		07H

	C_BZ2_TMR2B0		EQU		08H			; Clock Source from Timer 2
	C_BZ2_TMR2B1		EQU		09H
	C_BZ2_TMR2B2		EQU		0AH
	C_BZ2_TMR2B3		EQU		0BH
	C_BZ2_TMR2B4		EQU		0CH
	C_BZ2_TMR2B5		EQU		0DH
	C_BZ2_TMR2B6		EQU		0EH
	C_BZ2_TMR2B7		EQU		0FH
	
;------------------------------------------------------------   
; Ps_SYS_Ctrl (0FH)	--------- Oscillation Control Register (Include Switch Working Mode)
;------------------------------------------------------------
;Bit[7] : Comparator output status
	C_CMPOUT			EQU		80H			; Read-only
;Bit[6] : Disable/enable comparator output to pad PB3
	C_CMPOPB3_Dis		EQU		00H			; Disable comparator output to pad PB3
	C_CMPOPB3_En		EQU		40H			; Enable comparator output to pad PB3
;Bit[5] : Comparator output change state interrupt flag
	C_INF_CMP			EQU		00H			; clear comparator interrupt flag
;Bit[4] : Enable/Disable of comparator interrupt
	C_INT_CMP			EQU		10H			; Enable comparator interrupt
;Bit[3:2] : System Mode Select
	C_Mode				EQU		0CH			; System Operating Mode Selection
	C_Normal_Mode		EQU		00H			; Enter Normal mode
	C_Halt_Mode			EQU		04H			; Enter Halt mode
	C_Standby_Mode		EQU		08H			; Enter Standby mode
;Bit[1] : Stop FHOSC
	C_FHOSC_Stop		EQU		02H			; Disable high-frequency oscillation (FHOSC)
;Bit[0] : FOSC Seletction
	C_FHOSC_Sel			EQU		01H			; OSCCR[0]=1 , FOSC is high-frequency oscillation (FHOSC)
	C_FLOSC_Sel			EQU		00H			; OSCCR[0]=0 , FOSC is Low-frequency oscillation (FLOSC)	

    C_CMPOUT_bit		EQU		7
	C_CMPOPB3_En_bit	EQU		6
	C_INF_CMP_bit		EQU		5
	C_INT_CMP_bit		EQU		4
	C_FHOSC_Stop_bit	EQU		1
	C_FHOSC_Sel_bit		EQU		0
	
;------------------------------------------------------------
; Ps_TMR3_Data (10H)	--------- Timer3 Data Register
;------------------------------------------------------------
;Bit[7:0] : Timer3 Data
	C_TMR3_Data			EQU		FFH	
	
;------------------------------------------------------------	
; Ps_TMR3_Ctrl1 (11H)	--------- Timer3 Control Register 1
;------------------------------------------------------------
;Bit[7:6] : PWM3 Control
	C_PWM3_En			EQU		80H 		; PWM3 output will be present on PA2
	C_PWM3_Active		EQU		40H 		; PWM3 output is active
	C_PWM3_Active_Lo	EQU		40H 		; PWM3 output is active low 
	C_PWM3_Active_Hi	EQU		00H 		; PWM3 output is active high 
;Bit[5:3] : Reserved
;Bit[2:0] : Timer3 Control
	C_TMR3_OneShot		EQU		04H 		; One-Shot mode. Timer3 will count once from the initial value to 0x00
	C_TMR3_Reload		EQU		02H 		; Initial value is reloaded from reload register TMR3(T3OS=0)
         
	C_TMR3_En			EQU		01H 		; Enable Timer3
	C_TMR3_Dis			EQU		00H 		; Disable Timer3

;------------------------------------------------------------	
; Ps_TMR3_Ctrl2 (12H)	--------- Timer3 Control Register 2
;------------------------------------------------------------
;Bit[7:6] : Reserved
;Bit[5] : Timer3 Clock Source Select
	C_TMR3_ClkSrc_Ext	EQU		20H			; Timer3 clock source from External Clock Input(EX_CKI1)
	C_TMR3_ClkSrc_Inst	EQU		00H			; Timer3 clock source from Internal Instruction Clock	
;Bit[4] : Timer3 external clock edge selection
    C_TMR3_ExtClk_Edge	EQU		10H			; Timer3 External Clock Edge Select --- 1:Falling Edge, 0:Rising Edge  
	C_TMR3_ExtFalling	EQU		10H			; Timer3 will decrease one while EX_CKI1 Falling Edge.
	C_TMR3_ExtRising	EQU		00H			; Timer3 will decrease one while EX_CKI1 Rising Edge.
;Bit[3] : Disable/enable Prescaler3
    C_PS3_Dis           EQU		08H			; Disable Prescaler3
	C_PS3_EN			EQU		00H			; Enable Prescaler3
;Bit[2:0] : Prescaler 3 Dividing Rate Selection
	C_PS3_Div			EQU		07H			; Prescaler3 Dividing Rate Selection
	C_PS3_Div2			EQU		00H
	C_PS3_Div4			EQU		01H
	C_PS3_Div8			EQU		02H
	C_PS3_Div16			EQU		03H
	C_PS3_Div32			EQU		04H
	C_PS3_Div64			EQU		05H
	C_PS3_Div128		EQU		06H
	C_PS3_Div256		EQU		07H

;------------------------------------------------------------	
; Ps_PWM3_Duty (13H)	--------- PWM3 Duty Register
;------------------------------------------------------------
;Bit[7:0] : PWM3 Duty Value
	C_PWM3_Duty			EQU		FFH

;------------------------------------------------------------	
; Ps_PS3_Cnt (14H)		--------- Prescaler3 Counter Value Register
;------------------------------------------------------------
;Bit[7:0] : Prescaler3 Counter Value
	C_PS3_Cnt			EQU		FFH			; Read-only	

;------------------------------------------------------------	
; Ps_BZ3_Ctrl (15H)		--------- Buzzer3 Control Register
;------------------------------------------------------------
;Bit[7] : BZ3 Enable
	C_BZ3_En			EQU		80H			; Enable BZ3 output
;Bit[6:4] : Reserved
;Bit[3:0] : BZ3 Frequency Selection
	C_BZ3_FSel			EQU		0FH			; BZ3 frequency selection

	C_BZ3_PS3Div2		EQU		00H			; Clock Soruce from Prescaler 3
	C_BZ3_PS3Div4		EQU		01H
	C_BZ3_PS3Div8		EQU		02H
	C_BZ3_PS3Div16		EQU		03H
	C_BZ3_PS3Div32		EQU		04H
	C_BZ3_PS3Div64		EQU		05H
	C_BZ3_PS3Div128		EQU		06H
	C_BZ3_PS3Div256		EQU		07H

	C_BZ3_TMR3B0		EQU		08H			; Clock Source from Timer 3
	C_BZ3_TMR3B1		EQU		09H
	C_BZ3_TMR3B2		EQU		0AH
	C_BZ3_TMR3B3		EQU		0BH
	C_BZ3_TMR3B4		EQU		0CH
	C_BZ3_TMR3B5		EQU		0DH
	C_BZ3_TMR3B6		EQU		0EH
	C_BZ3_TMR3B7		EQU		0FH	
;=======================================================================================================================
;=======================================================================================================================
;-----------------------------------------------------------------------------------------------------------------------
;General Constant Define
;-----------------------------------------------------------------------------------------------------------------------
	C_SaveToAcc			EQU		00H	
	C_SaveToReg			EQU		01H	

	C_Bit0				EQU		01H
	C_Bit1				EQU		02H
	C_Bit2				EQU		04H
	C_Bit3				EQU		08H
	C_Bit4				EQU		10H
	C_Bit5				EQU		20H
	C_Bit6				EQU		40H
	C_Bit7				EQU		80H

	C_Num0				EQU		0
	C_Num1				EQU		1
	C_Num2				EQU		2
	C_Num3				EQU		3
	C_Num4				EQU		4
	C_Num5				EQU		5
	C_Num6				EQU		6
	C_Num7				EQU		7
	