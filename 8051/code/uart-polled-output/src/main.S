$INCLUDE (../regdef.S)  ; Include Register definitions

ORG 000H                ; Put code to 00H - default behaviour
SJMP init               ; Jump to init label

ORG 030H                ; Put code to 030H from here onwards
init:
    MOV SCON, #040H     ; Serial port mode 1
    MOV TMOD, #020H     ; Timer 1 auto-reload mode
    MOV TH1, #0FDH      ; Auto-reload value (253) for 9600 bps
    MOV TL1, #0FDH      ; Auto-reload value (253) for 9600 bps
    SETB TR1            ; start timer 1

main:
    MOV SBUF, #'H'      ; transmit 'H'
    JNB TI, $           ; wait util transmission is complete
    CLR TI              ; clear transmit
    MOV SBUF, #'e'      ; transmit 'e'
    JNB TI, $           ; wait util transmission is complete
    CLR TI              ; clear transmit
    MOV SBUF, #'l'      ; transmit 'l'
    JNB TI, $           ; wait util transmission is complete
    CLR TI              ; clear transmit
    MOV SBUF, #'l'      ; transmit 'l'
    JNB TI, $           ; wait util transmission is complete
    CLR TI              ; clear transmit
    MOV SBUF, #'o'      ; transmit 'o'
    JNB TI, $           ; wait util transmission is complete
    CLR TI              ; clear transmit

    SJMP $              ; loop

END                     ; End
