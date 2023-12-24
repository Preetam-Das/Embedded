$INCLUDE (../regdef.S)  ; Include Register definitions

ORG 000H                ; Put code to 00H - default behaviour
SJMP init               ; Jump to init label

ORG 030H                ; Put code to 030H from here onwards
init:
    MOV SCON, #050H     ; Serial port mode 1 + Reception
    MOV TMOD, #020H     ; Timer 1 auto-reload mode
    MOV TH1, #0FDH      ; Auto-reload value (253) for 9600 bps
    MOV TL1, #0FDH      ; Auto-reload value (253) for 9600 bps
    SETB TR1            ; start timer 1

main:
    JNB RI, $           ; Wait until new data is recieved
    MOV A, SBUF         ; Read SBUF to accumulator
    CLR RI              ; clear reception flag
    MOV SBUF, A         ; transmit what was recieved (echo)
    JNB TI, $           ; wait util transmission is complete
    CLR TI              ; clear transmit

    SJMP main           ; loop

END                     ; End
