$INCLUDE (../regdef.S)  ; Include Register definitions

LED EQU P1.0            ; Define LED Pin

ORG 000H                ; Put code to 00H - default behaviour
SJMP main               ; Jump to main label

ORG 030H                ; Put code to 030H from here onwards
main:
    CPL LED             ; Complement(toggle) the LED
    ACALL delay         ; Call delay subroutine
    SJMP main           ; Loop back to main so that it runs forever

delay:
    mov R0, #0FFH       ; Load Register 0 with 255
    loop:
        MOV R1, #0FFH   ; Load Register 1 with 255
        DJNZ R1, $      ; Decrement R1 and jump here($) if not zero
        DJNZ R0, loop   ; Decrement R0 and jump to loop label if not zero
    RET                 ; Return from subroutine

END                     ; End
