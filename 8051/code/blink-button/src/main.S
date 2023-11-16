$INCLUDE (../regdef.S)  ; Include Register definitions

LED EQU P2.0            ; Define Led Pin
BTN EQU P3.3            ; Define Button Pin

ORG 000H                ; Put code to 00H - default behaviour
SJMP main               ; Jump to main label

ORG 030H                ; Put code to 030H from here onwards
main:
    JNB BTN, btn_press  ; jump to button handler if button pressed
    SJMP main           ; Loop back to main so that it runs forever

btn_press:
    CLR LED             ; Turn on LED
    acall delay         ; call delay subroutine
    SETB LED            ; Turn off LED
    acall delay         ; call delay subroutine
    JB BTN, main        ; jump back to main if button released
    SJMP btn_press      ; else rerun btn_press

delay:
    mov R0, #0FFH       ; Load Register 0 with 255
    loop:
        MOV R1, #0FFH   ; Load Register 1 with 255
        DJNZ R1, $      ; Decrement R1 and jump here($) if not zero
        DJNZ R0, loop   ; Decrement R0 and jump to loop label if not zero
    RET                 ; Return from delay subroutine

END                     ; End
