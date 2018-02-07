
		INDF		EQU	0x00
		TMR0		EQU	0x01
		PCL		EQU	0x02
		
		STATUS		EQU	0x03
			C_B	= 0
			DC_B	= 1
			Z_B	= 2
			PD_B	= 3
			TO_B	= 4
			
			BK0_B	= 6
			BK1_B	= 7
			
		FSR		EQU	0x04
			
		PA		EQU	0x05
			PA0_B	= 0
			PA1_B	= 1
			PA2_B	= 2
			PA3_B	= 3
			PA4_B	= 4
			PA5_B	= 5
			PA6_B	= 6
			PA7_B	= 7
			
		PB		EQU	0x06
			PB0_B	= 0
			PB1_B	= 1
			PB2_B	= 2
			PB3_B	= 3
		
		PCON		EQU	0x08
			LVREN_B	= 3
			LVDEN_B	= 5
			WDTEN_B	= 7
			
		BWUCON		EQU	0x09
		
		PCHBUF		EQU	0x0A
			XSPD_STP_B	= 6
			DCMEN_B		= 7
			
		ABPLCON		EQU	0x0B
		BPHCON		EQU	0x0C
		
		INTE		EQU	0x0E
			T0IE_B		= 0 
			PABIE_B		= 1
			INT0IE_B	= 2
			T1IE_B		= 3
			LVDTIE_B	= 4
			T2IE_B		= 5
			WDTIE_B		= 6
			INT1IE_B	= 7
			
		INTF		EQU	0x0f
			T0IF_B		= 0
			PABIF_B		= 1
			INT0IF_B	= 2
			T1IF_B		= 3
			LVDTIF_B	= 4
			T2IF_B		= 5
			WDTIF_B		= 6
			INT2IF_B	= 7
		
		ADMD		EQU	0x10
			CHS0_B		= 0
			CHS1_B		= 1
			CHS2_B		= 2
			
			GCHS_B		= 4
			EOC_B		= 5
			START_B		= 6
			ADEN_B		= 7
		
		ADR		EQU	0x11
			AD0_B		= 0
			AD1_B		= 1
			AD2_B		= 2
			AD3_B		= 3
			ADCK0_B		= 4
			ADCK1_B		= 5
			ADIE_B		= 6
			ADIF_B		= 7
		
		ADD		EQU	0x12
		
		ADVREFH		EQU	0x13
			VHS0_B		= 0
			VHS1_B		= 1
			
			EVHENB_B	= 7
		
		ADCR		EQU	0x14
			ADCR0_B		= 0
			ADCR1_B		= 1
			SHCK0_B		= 2
			SHCK1_B		= 3
		
		AWUCON		EQU	0x15
			WUPA0_B		= 0
			WUPA1_B		= 1
			WUPA2_B		= 2
			WUPA3_B		= 3		
			WUPA4_B		= 4
			WUPA5_B		= 5
			WUPA6_B		= 6
			WUPA7_B		= 7	
		
		PACON		EQU	0x16
			PACON0_B	= 0
			PACON1_B	= 1
			PACON2_B	= 2
			PACON3_B	= 3
			PACON4_B	= 4
		
		ADT		EQU	0x17
			ADT0_B		= 0	
			ADT1_B		= 1
			ADT2_B		= 2
			ADT3_B		= 3
			ADT4_B		= 4
			SIGN_B		= 5
			CALE_B		= 6
			CALS_B		= 7
		
		INTEDG		EQU	0x18
			INT0G0_B	= 0
			INT0G1_B	= 1
			INT1G0_B	= 2
			INT1G1_B	= 3
			EIS0_B		= 4
			EIS1_B		= 5
		
		TMRH		EQU	0x19
			PWM1DUTY8_B	= 0
			PWM1DUTY9_B	= 1
			PWM2DUTY8_B	= 2
			PWM2DUTY9_B	= 3
			TMR18_B		= 4
			TMR19_B		= 5
			TMR28_B		= 6
			TMR29_B		= 7
		
		ANAEN		EQU	0x1a
			CMPEN_B		= 7
		
		RFC		EQU	0x1b
			PSEL0_B		= 0
			PSEL1_B		= 1
			PSEL2_B		= 2
			PSEL3_B		= 3
		
			RFCEN_B		= 7
			
		TM3RH		EQU	0x1c
			PWM3D8_B	= 0
			PWM3D9_B	= 1
			
			TMR38_B		= 4
			TMR39_B		= 5
		
		INTE2		EQU	0x1f
			T3IE_B		= 0
			
			T3IF_B		= 4

;; T0MD Register
			PS0SEL0_B	= 0
			PS0SEL1_B	= 1
			PS0SEL2_B	= 2
			PS0WDT_B	= 3
			T0CE_B		= 4
			T0CS_B		= 5
			
			LCKTM0_B	= 7	
		

;; Register F
		IOSTA		EQU	0x05
		IOSTB		EQU	0x06
		APHCON		EQU	0x09
		
		PS0CV		EQU	0x0a
		BOBCON		EQU	0x0c
		
		CMPCR		EQU	0x0e
		
		PCON1		EQU	0x0f
			T0EN_B		= 0
			
			LVDS0_B		= 2
			LVDS1_B		= 3
			LVDS2_B		= 4
			
			LVDOUT_B	= 6
			GIE_B		= 7
		
;; Register S
		TMR1		EQU	0x00
		
		T1CR1		EQU	0x01
			T1EN_B		= 0
			T1RL_B		= 1
			T1OS_B		= 2
			
			PWM1OAL_B	= 6
			PWM1OEN_B	= 7
			
		T1CR2		EQU	0x02
			PS1SEL0_B	= 0
			PS1SEL1_B	= 1
			PS1SEl2_B	= 2
			PS1EN_B		= 3
			T1CE_B		= 4
			T1CS_B		= 5
			
		PWM1DUTY	EQU	0x03
		PS1CV		EQU	0x04
		BZ1CR		EQU	0x05
			BZ1FSEL0_B	= 0
			BZ1FSEL1_B	= 1
			BZ1FSEL2_B	= 2
			BZ1FSEL3_B	= 3
			
			BZ1EN_B		= 7
		
		IRCR		EQU	0x06
			IREN_B		= 0
			IRF57K_B	= 1
			IRCSEL_B	= 2
			
			IROSC358M_B	= 7
			
		TBHP		EQU	0x07
		TBHD		EQU	0x08

		TMR2		EQU	0x09
		
		T2CR1		EQU	0x0A
			T2EN_B		= 0
			T2RL_B		= 1
			T2OS_B		= 2
			
			PWM2OAL_B	= 6
			PWM2OEN_B	= 7
			
		T2CR2		EQU	0x0B
			PS2SEL0_B	= 0
			PS2SEL1_B	= 1
			PS2SEl2_B	= 2
			PS2EN_B		= 3
			T2CE_B		= 4
			T2CS_B		= 5

		PWM2DUTY	EQU	0x0C
		PS2CV		EQU	0x0D
		
		BZ2CR		EQU	0x0E
			BZ2FSEL0_B	= 0
			BZ2FSEL1_B	= 1
			BZ2FSEL2_B	= 2
			BZ2FSEL3_B	= 3
			
			BZ2EN_B		= 7
			
		OSCCR		EQU	0x0f
			SELHSC_B	= 0
			STPHOSC_B	= 1
			OPMD0_B		= 2
			OPMD1_B		= 3
			CMPIE_B		= 4
			CMPIF_B		= 5
			CMPOE_B		= 6
			CMPOUT_B	= 7
		
		TMR3		EQU	0x10
		
		T3CR1		EQU	0x11
			T3EN_B		= 0
			T3RL_B		= 1
			T3OS_B		= 2
			
			PWM3OAL_B	= 6
			PWM3OEN_B	= 7
		
		T3CR2		EQU	0x12
			PS3SEL0_B	= 0
			PS3SEL1_B	= 1
			PS3SEL2_B	= 2
			PS3EN_B		= 3
			T3CE_B		= 4
			T3CS_B		= 5
		
		PWM3DUTY	EQU	0x13
		
		PS3CV		EQU	0x14
		
		BZ3CR		EQU	0x15
			BZ3FSEL0_B	= 0
			BZ3FSEL1_B	= 1
			BZ3FSEL2_B	= 2
			BZ3FSEL3_B	= 3
			
			BZ3EN_B		= 7
		
		
	

		f	= 1
		R	= 1
		W	= 0
		A	= 0