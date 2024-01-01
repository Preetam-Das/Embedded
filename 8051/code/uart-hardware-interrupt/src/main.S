$INCLUDE (../regdef.S)  ; Include Register definitions

CNT EQU R0             ; Counting register
VAL EQU 0              ; Initial value

ORG EXTI0
JMP handle_button

ORG RESET               ; Put code to 00H - default behaviour
JMP init                ; Jump to init label

ORG START               ; Put code to 030H from here onwards

init_pormpt: DB 13,10,"-------- Button Counter -------- ",13,10,13,10,0     ; Prompt to print
msg_prompt: DB "Clicks: ",0                                                 ; Prompt to print

init:

    MOV DPTR, #msg_prompt   ; Load dptr

    MOV SCON, #040H         ; Serial port mode 1 + No Reception
    MOV TMOD, #020H         ; Timer 1 auto-reload
    MOV TH1, #0FDH          ; Auto-reload value (253) for 9600 bps
    MOV TL1, #0FDH          ; Auto-reload value (253) for 9600 bps
    MOV CNT, #VAL           ; Load Counter

    MOV IE, #081H           ; global + external 0 enable
    MOV TCON, #041H         ; external 0 falling edge-trigger + start timer 0

    MOV DPTR, #init_pormpt
    ACALL transmit_prompt   ; send init prompt

main:
    JMP main                ; loop

transmit_prompt:
    CLR A                   ; Clear Accumulator
    MOVC A, @A+DPTR         ; Load character to accumulator
    INC DPTR                ; Increment dptr
    ACALL handle_tx         ; send
    JNZ transmit_prompt     ; send next character
    RET                     ; return

handle_tx:
    MOV SBUF, A             ; Load serial buffer with character from accumulator
    JNB TI, $               ; Wait till transmission is complete
    CLR TI                  ; Clear transmit flag
    RET                     ; return

handle_button:
    CLR ET0                 ; disable interrupt
    INC CNT                 ; increment counter
    MOV DPTR, #msg_prompt   ; Reload dptr
    CALL send_counter       ; send counter to serial
    SETB ET0                ; restart interrupt
    RETI                    ; reenable interrupt

send_counter:
    MOV A, #0                   ; -
    PUSH ACC                    ; -
    MOV A, #10                  ; -
    PUSH ACC                    ; -
    MOV A, #13                  ; -
    PUSH ACC                    ; push delimiters to stack
    MOV A, CNT                  ; Move counter to A as temp counter
again:
    MOV B, #10                  ; Move 10 to B for division
    DIV AB                      ; Quotient to A, Remainder to B
    PUSH ACC                    ; temporary store quotient to stack
    MOV A, B                    ; Mov remainder to Acc
    ADD A, #'0'                 ; Convert remainder to ascii-code
    MOV B, A                    ; Store back converted ascii to B
    POP ACC                     ; Restore original quotient value
    PUSH B                      ; Store character to send in stack
    JNZ again                   ; loop until Acc is 0
    ACALL transmit_prompt       ; transmit prompt
transmit_counter:
    POP ACC                     ; pop to acc
    ACALL handle_tx             ; send character
    JNZ transmit_counter        ; continue sending until null(0) is found
    RET                         ; return

END     ; End
