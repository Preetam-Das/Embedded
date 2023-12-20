$INCLUDE (../regdef.S)  ; Include Register definitions

LED EQU P1.0            ; LED Pin
SEC_HB EQU 010H         ; high byte timer value (TH)
SEC_LB EQU 000H         ; low byte timer value (TL)
TCNT EQU R0             ; Counts no. of time Timer ISR ran

ORG 000H                ; Put code to 00H - default behaviour
SJMP main               ; Jump to main label

ORG TIMER0              ; Put code to timer 0 ISR
SJMP timer_isr

ORG 030H                ; Put code to 030H from here onwards
main:
    SETB EA             ; enable global interrupt bit
    SETB ET0            ; enable timer0 interrupt
    SETB PT0            ; set timer0 priority
    MOV TMOD, #001H     ; Timer0 16 bit mode
    ACALL reset_timer   ; Set appropiate TH and TL values for 1 sec delay
    MOV TCNT, #15       ; Run timer 15 times for 1 sec delay (15 * 61440 = 921600)
    SETB TR0            ; Start timer 0
main_loop:
    SJMP main_loop

timer_isr:
    CLR TR0             ; Stop timer
    DJNZ TCNT, exit_isr ; Decrement TCNT and exit ISR if not zero (1 sec has not passed)
    CPL LED             ; Toggle LED
    MOV TCNT, #15       ; Run timer 15 times for 1 sec delay (15 * 61440 = 921600)
exit_isr:
    ACALL reset_timer   ; resets timer to appropiate values
    SETB TR0            ; Restart Timer
    RETI                ; Exit from ISR

reset_timer:
    MOV TH0, #SEC_HB    ; Set TH0 for 1 sec delay
    MOV TL0, #SEC_LB    ; Set TL0 for 1 sec delay
    RET

END                     ; End
