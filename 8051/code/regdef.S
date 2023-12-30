$NOMOD51

; Port RAM Address - bit addressable
P0 DATA 080H
P1 DATA 090H
P2 DATA 0A0H
P3 DATA 0B0H

; Timer SFRs
TCON DATA 088H ; timer control - bit addressable
TMOD DATA 089H ; timer mode control
TL0  DATA 08AH ; low and high timer bytes
TL1  DATA 08BH ;
TH0  DATA 08CH ;
TH1  DATA 08DH ;
TL2  DATA 0CCH ;
TH2  DATA 0CDH ;

; Interrupt SFRs
IE DATA 0A8H ; interrupt enable - bit addressable
IP DATA 0B8H ; interrupt priority - bit addressable

; Serial Port SFRs
SCON DATA 098H ; Serial port control
SBUF DATA 099H ; Serial buffer

; Other Special Function Registers
ACC  DATA 0E0H ; accumulator
PCON  DATA 087H ; power control

; Bit Addressables
;; IE Register
EX0 BIT 0A8H    ; external 0
ET0 BIT 0A9H    ; timer 0
EX1 BIT 0AAH    ; external 1
ET1 BIT 0ABH    ; timer 1
ES  BIT 0ACH    ; serial
ET2 BIT 0ADH    ; timer 2
EA  BIT 0AFH    ; global enable
;; IP Register
PX0 BIT 0B8H    ; external 0 priority
PT0 BIT 0B9H    ; timer 0 priority
PX1 BIT 0BAH    ; external 1 priority
PT1 BIT 0BBH    ; timer 1 priority
PS  BIT 0BCH    ; serial priority
PT2 BIT 0BDH    ; timer 2 priority
;; TCON Register
IT0 BIT 088H    ; external 0 type s/w controlled
IE0 BIT 089H    ; external 0 status h/w controlled
IT1 BIT 08AH    ; external 1 type s/w controlled
IE1 BIT 08BH    ; external 1 status h/w controlled
TR0 BIT 08CH    ; timer 0 run control s/w controlled
TF0 BIT 08DH    ; timer 0 overflow bit h/w controlled
TR1 BIT 08EH    ; timer 1 run control s/w controlled
TF1 BIT 08FH    ; timer 1 overflow bit h/w controlled
;; SCON Register
RI BIT 098H     ; Receive interrupt flag h/w controlled
TI BIT 099H     ; Transmit interrupt flag h/w controlled
RB8 BIT 09AH    ; 9th recieved bit
TB8 BIT 09BH    ; 9th trasmitted bit
REN BIT 09CH    ; reception bit s/w controlled
SM2 BIT 09DH    ; multiprocessor communication bit
SM1 BIT 09EH    ; serial mode bit 1
SM0 BIT 09FH    ; serial mode bit 0
;; Other
INT0 BIT 0B2H
INT1 BIT 0B3H

; Interrupt Vector Table
RESET  CODE  000H
EXTI0  CODE  003H
TIMER0 CODE  00BH
EXTI1  CODE  013H
TIMER1 CODE  01BH
SINT   CODE  023H
TIMER2 CODE  02BH

; Other
START CODE 030H
