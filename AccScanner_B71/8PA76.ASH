;// FM8PA76 General Head Ver:1.01,build:0 credit:1 lastedit:20150511
;// Header Author:hu_cy; hu_cy@feeling-tech.com.tw
;// CHIP Version:N/A(General)
;---------------HEAD Credit History-------------------------------------------
;2015/05/11	Adjust to compatible spec V1.30.003
;2012/03/22	modify some register name
;2012/03/12	Compiler HEAD Release
;---------------Common define Segment-----------------------------------------
A		EQU	0x0
R		EQU	0x1
;---------------Operation Registers Maps--------------------------------------
INDF		REG	0x00
PCL		REG	0x01
PCH		REG	0x02		;compatible old	name, this name	is not longer
PCHBUF		REG	0x02
;-------------------------------
STATUS		REG	0x03
C_B		EQU	0x0
DC_B		EQU	0x1
Z_B		EQU	0x2
PD_B		EQU	0x3
TO_B		EQU	0x4
;-------------------------------
FSR		REG	0x04
;-------------------------------
IOSTA		REG	0x05
IOSTA0_B	EQU	0x0
IOSTA1_B	EQU	0x1
IOSTA2_B	EQU	0x2
IOSTA3_B	EQU	0x3
IOSTA4_B	EQU	0x4
IOSTA5_B	EQU	0x5
IOSTA6_B	EQU	0x6
IOSTA7_B	EQU	0x7
;-------------------------------
PORTA		REG	0x06
IOA0_B		EQU	0x0
IOA1_B		EQU	0x1
IOA2_B		EQU	0x2
IOA3_B		EQU	0x3
IOA4_B		EQU	0x4
IOA5_B		EQU	0x5
IOA6_B		EQU	0x6
IOA7_B		EQU	0x7
;-------------------------------
IOSTB		REG	0x07
IOSTB0_B	EQU	0x0
IOSTB1_B	EQU	0x1
;-------------------------------
PORTB		REG	0x08
IOB0_B		EQU	0x0
IOB1_B		EQU	0x1
IOB2_B		EQU	0x2
;-------------------------------
IOSTC		REG	0x09
IOSTC1_B	EQU	0x1
IOSTC2_B	EQU	0x2
IOSTC3_B	EQU	0x3
IOSTC4_B	EQU	0x4
IOSTC5_B	EQU	0x5
IOSTC6_B	EQU	0x6
IOSTC7_B	EQU	0x7
;-------------------------------
PORTC		REG	0x0A
IOC1_B		EQU	0x1
IOC2_B		EQU	0x2
IOC3_B		EQU	0x3
IOC4_B		EQU	0x4
IOC5_B		EQU	0x5
IOC6_B		EQU	0x6
IOC7_B		EQU	0x7
;-------------------------------
TMR0_CTL	REG	0x10
T0PS0_B		EQU	0x0
T0PS1_B		EQU	0x1
T0PS2_B		EQU	0x2
T0EDGE_B	EQU	0x3
T0SO0_B		EQU	0x4
T0SO1_B		EQU	0x5
T0LOAD_B	EQU	0x6
T0EN_B		EQU	0x7
;-------------------------------
TMR0L_LA	REG	0x11
TMR0H_LA	REG	0x12
TMR0L_CNT	REG	0x13
TMR0H_CNT	REG	0x14
;-------------------------------
TMR1_CTL1	REG	0x15
T1PS0_B		EQU	0x0
T1PS1_B		EQU	0x1
T1PS2_B		EQU	0x2
T1EDGE_B	EQU	0x3
T1SO0_B		EQU	0x4
T1SO1_B		EQU	0x5
T1LOAD_B	EQU	0x6
T1EN_B		EQU	0x7
;-------------------------------
TMR1_CTL2	REG	0x16
PWM1R0_B	EQU	0x0
PWM1R1_B	EQU	0x1
PWM1R2_B	EQU	0x2
PWM1R3_B	EQU	0x3
PWM1_INI_B	EQU	0x6
T12MOD_B	EQU	0x7
;-------------------------------
TMR1_LA		REG	0x17
TMR1_CNT	REG	0x18
;-------------------------------
TMR2_CTL1	REG	0x19
T2PS0_B		EQU	0x0
T2PS1_B		EQU	0x1
T2PS2_B		EQU	0x2
T2EDGE_B	EQU	0x3
T2SO0_B		EQU	0x4
T2SO1_B		EQU	0x5
T2LOAD_B	EQU	0x6
T2EN_B		EQU	0x7
;-------------------------------
TMR2_LA		REG	0x1A
TMR2_CNT	REG	0x1B
;-------------------------------
TMR3_CTL1	REG	0x1C
T3PS0_B		EQU	0x0
T3PS1_B		EQU	0x1
T3PS2_B		EQU	0x2
T3EDGE_B	EQU	0x3
T3SO0_B		EQU	0x4
T3SO1_B		EQU	0x5
T3LOAD_B	EQU	0x6
T3EN_B		EQU	0x7
;-------------------------------
TMR3_CTL2	REG	0x1D
PWM2R0_B	EQU	0x0
PWM2R1_B	EQU	0x1
PWM2R2_B	EQU	0x2
PWM2R3_B	EQU	0x3
PWM2_INI_B	EQU	0x6
T34MOD_B	EQU	0x7
;-------------------------------
TMR3_LA		REG	0x1E
TMR3_CNT	REG	0x1F
;-------------------------------
TMR4_CTL1	REG	0x20
T4PS0_B		EQU	0x0
T4PS1_B		EQU	0x1
T4PS2_B		EQU	0x2
T4EDGE_B	EQU	0x3
T4SO0_B		EQU	0x4
T4SO1_B		EQU	0x5
T4LOAD_B	EQU	0x6
T4EN_B		EQU	0x7
;-------------------------------
TMR4_LA		REG	0x21
TMR4_CNT	REG	0x22
;-------------------------------
INTEN		REG	0x25
T0IE_B		EQU	0x0
T1_PWM1IE_B	EQU	0x1
T2IE_B		EQU	0x2
T3_PWM2IE_B	EQU	0x3
T4IE_B		EQU	0x4
PAIE_B		EQU	0x5
ADCIE_B		EQU	0x6
GIE_B		EQU	0x7
;-------------------------------
INTFLAG		REG	0x26
T0IF_B		EQU	0x0
T1_PWM1IF_B	EQU	0x1
T2IF_B		EQU	0x2
T3_PWM2IF_B	EQU	0x3
T4IF_B		EQU	0x4
PAIF_B		EQU	0x5
ADCIF_B		EQU	0x6
;-------------------------------
AD_CTL1		REG	0x29
CHSL0_B		EQU	0x0
CHSL1_B		EQU	0x1
CHSL2_B		EQU	0x2
CHSL3_B		EQU	0x3
MODE_B		EQU	0x5
ADCEN_B		EQU	0x7
;-------------------------------
AD_CTL2		REG	0x2A
CLKSL0_B	EQU	0x0
CLKSL1_B	EQU	0x1
CLKSL2_B	EQU	0x2
CMP_D_B		EQU	0x7
;-------------------------------
AD_CTL3		REG	0x2B
ANISL0_B	EQU	0x0
ANISL1_B	EQU	0x1
ANISL2_B	EQU	0x2
ANISL3_B	EQU	0x3
;-------------------------------
AD_DATL		REG	0x2C
D0_B		EQU	0x4
D1_B		EQU	0x5
D2_B		EQU	0x6
D3_B		EQU	0x7
;-------------------------------
AD_DATH		REG	0x2D
D4_B		EQU	0x0
D5_B		EQU	0x1
D6_B		EQU	0x2
D7_B		EQU	0x3
D8_B		EQU	0x4
D9_B		EQU	0x5
D10_B		EQU	0x6
D11_B		EQU	0x7
;-------------------------------
SYS_CLK		REG	0x2F
ECLKPD_B	EQU	0x0
IRCPD_B		EQU	0x1
CLKS_B		EQU	0x7
;-------------------------------
CLO_CTL		REG	0x30
TO_E_B		EQU	0x0
CLO1_E_B	EQU	0x1
CLO2_E_B	EQU	0x2
EXT_CLK_B	EQU	0x3
CLO2PS0_B	EQU	0x5
CLO2PS1_B	EQU	0x6
CLO2SO_B	EQU	0x7
;-------------------------------
APHCON		REG	0x31
PHA0_B		EQU	0x0
PHA1_B		EQU	0x1
PHA2_B		EQU	0x2
PHA3_B		EQU	0x3
PHA4_B		EQU	0x4
PHA5_B		EQU	0x5
PHA6_B		EQU	0x6
PHA7_B		EQU	0x7
;-------------------------------
BPHCON		REG	0x32
PHB0_B		EQU	0x0
PHB1_B		EQU	0x1
;-------------------------------
CPHCON		REG	0x33
PHC1_B		EQU	0x1
PHC2_B		EQU	0x2
PHC3_B		EQU	0x3
PHC4_B		EQU	0x4
PHC5_B		EQU	0x5
PHC6_B		EQU	0x6
PHC7_B		EQU	0x7
;-------------------------------
INT_PA		REG	0x3A
PA0IEN_B	EQU	0x0
PA1IEN_B	EQU	0x1
PA2IEN_B	EQU	0x2
PA3IEN_B	EQU	0x3
PA4IEN_B	EQU	0x4
PA5IEN_B	EQU	0x5
PA6IEN_B	EQU	0x6
PA7IEN_B	EQU	0x7
;-------------------------------
WDT_CTL		REG	0x3D
WDTPS0_B	EQU	0x0
WDTPS1_B	EQU	0x1
WDTPS2_B	EQU	0x2
I_TWDT_B	EQU	0x5
I_WDT_B		EQU	0x6
WDTEN_B		EQU	0x7
;-------------------------------
TB_BNK		REG	0x3E
BNK0_B		EQU	0x0
BNK1_B		EQU	0x1
BNK2_B		EQU	0x2