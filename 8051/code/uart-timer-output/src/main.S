$INCLUDE (../regdef.S)  ; Include Register definitions

TCNT EQU R0             ; Counting register
CNT EQU 15              ; Counts no. of time Timer ISR ran

ORG RESET               ; Put code to 00H - default behaviour
SJMP init               ; Jump to init label

ORG TIMER0              ; Timer 0 interrupt
SJMP timer_isr          ; jump to timer isr

ORG START               ; Put code to 030H from here onwards

; Constant string to send
msg: DB "Hello cruel world!!",13,10,0     ; Terminated with LF,CR,NULL

init:
    MOV SCON, #040H     ; Serial port mode 1 + No Reception
    MOV TMOD, #021H     ; Timer 1 auto-reload + Timer 0 16-bit mode
    MOV TH1, #0FDH      ; Auto-reload value (253) for 9600 bps
    MOV TL1, #0FDH      ; Auto-reload value (253) for 9600 bps
    MOV TCNT, #CNT      ; Load Counter

    MOV DPTR, #msg      ; Load DPTR

    MOV IE, #092H       ; global + serial + timer 0 interrupt enable
    MOV TCON, #050H     ; start timer 0 and timer 1

main:
    SJMP main           ; loop

timer_isr:
    CLR ET0                 ; Stop timer-0 interrupt
    CLR TR0                 ; Stop timer-0
    DJNZ TCNT, exit_timer   ; Continue if TCNT not 0
    MOV TCNT, #CNT          ; Reload TCNT
    ACALL transmit_loop     ; Jump to transmit_loop subroutine
exit_timer:
    SETB ET0                ; Restart timer-0 interrupt
    SETB TR0                ; Restart timer-0
    RETI                    ; Return from ISR

transmit_loop:
    CLR A                   ; Clear Accumulator
    MOVC A, @A+DPTR         ; Load character to accumulator
    INC DPTR                ; Increment dptr
    JNZ transmit            ; transmit character if accumulator not zero
    MOV DPTR, #msg          ; Reload Dptr
    RET                     ; Return from subroutine
transmit:
    MOV SBUF, A             ; Load serial buffer with character from accumulator
    JNB TI, $               ; Wait till transmission is complete
    CLR TI                  ; Clear transmit flag
    SJMP transmit_loop      ; loop to send next character

END                         ; End
