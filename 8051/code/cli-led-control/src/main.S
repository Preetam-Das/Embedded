$include (../regdef.S)

LED EQU P1.0        ; define LED PIN
BUFSIZE EQU 8       ; cli buffer size
LF EQU 10           ; Line feed
CR EQU 13           ; Carriage return
NULL EQU 0          ; Null character
CNUM EQU 3          ; Number of commands

BSEG

run_flag: DBIT 1            ; flag set to run commands

ISEG AT URAM                ; Indirect RAM segment NOTE: 8052 only

buffer_ind: DS 1            ; buffer index
buffer    : DS BUFSIZE      ; cli buffer

CSEG                        ; Code Segment

ORG RESET                   ; Reset vector
JMP init                    ; jump to init

ORG SINT                    ; serial interrupt vector
JMP handle_rx               ; serial interrupt ISR

ORG START                   ; Code starts here

init_str:  DB  13,10,"WELCOME",13,10,0   ; welcome string
prompt_str: DB  "> ",0                   ; prompt string

; Table to store command along
; with its address
cmd_ind: DS 1
command_table:
    DB cmd_clr,0            ; clr command index 0
    DB cmd_set,0            ; set command index 1
    DB cmd_tog,0            ; tog command index 2

init:

    ; set up timer-1
    MOV TMOD, #020H         ; Timer-1 8-bit auto-reload mode
    MOV TH1, #0FDH          ; Load 253 to TH1 for 9600 bps
    MOV TL1, #0FDH          ; Load 253 to TL1 for 9600 bps
    ; set up serial port
    MOV SCON, #050H         ; serial port 8-bit uart mode with reception

    MOV R0, #buffer_ind     ; -
    MOV @R0, #0             ; Initialize buffer index

    MOV R0, #cmd_ind        ; -
    MOV @R0, #CNUM          ; Initialize number of commands

    CLR run_flag            ; Initialize flag

    ; start
    SETB TR1                ; start serial port

    ; print welcome msg
    MOV DPTR, #init_str     ; load dptr
    ACALL transmit          ; transmit

    ; print prompt
    MOV DPTR, #prompt_str   ; load dptr
    ACALL transmit          ; transmit

    ; start interrupts
    MOV IE, #090H           ; global interrupt + serial interrupt

main:
    ; Interpret and run - Non interrupt context
    JNB run_flag, continue          ; continue if command not received
    CLR EA                          ; stop serial interrupt
    ACALL parse_input               ; parse input print output
    SETB EA                         ; restart serial interrupt
continue:
    SJMP main                       ; loop

; Handle serial - interrupt context
handle_rx:
    CLR ES                  ; stop serial interrupt
    JNB RI, exit_isr        ; exit if not receiving
    CLR RI                  ; clear receive flag
    MOV A, SBUF             ; read char
    ACALL handle_input      ; handle input
    JNB run_flag,exit_isr   ; disable global interrupt stopped extra protecc
    CLR EA
exit_isr:
    SETB ES                 ; restart serial interrupt
    RETI                    ; return from isr

handle_input:
    ACALL echo                      ; echo back character
    CJNE A, #CR, load_buffer        ; load buffer until enter is pressed
    ; CPL P1.0

    ; Put delimeter
    MOV A, #buffer                  ; load buffer adddr to Acc
    MOV R1, #buffer_ind             ; load displacement to R1
    ADD A, @R1                      ; Add displacement to get EOB
    MOV R0, A                       ; load EOB to R0
    MOV @R0, #NULL                  ; Store NULL at EOB

    ; Reset displacement
    MOV @R1, #buffer_ind            ; load displacement to R1
    MOV @R1, #0                     ; Reset displacement to 0

    SETB run_flag                   ; set flag to run command

    RET                             ; return
load_buffer:
    ; CPL P1.0
    MOV R0, A                   ; Move char to R0
    MOV R1, #buffer_ind         ; Move index to R1
    MOV A, #buffer              ; Store buf base address to acc
    ADD A, @R1                  ; Add displacement index to base
    XCH A, R0                   ; Exchange A(address) with R0(char)
    ; ADD A, #224                 ; Convert to upper case - not work cuz non alpha char
    MOV @R0, A                  ; Store char in correct address
    INC @R1                     ; Increment displacement index
    RET                         ; return

parse_input:
    ; Print newline
    MOV A, #CR                      ; -
    ACALL handle_tx                 ; -
    MOV A, #LF                      ; -
    ACALL handle_tx                 ; print newline

    MOV R0, #buffer             ; load buffer addr to R0
parse_loop:
    MOV A, @R0                  ; load character from buffer to ACC
    INC R0                      ; Point to next character
    JZ exit_parse               ; exit if NULL found
    ACALL handle_tx             ; else transmit char
    ; CPL P1.0
    SJMP parse_loop             ; again
exit_parse:
    ; Print prompt
    MOV A, #CR                      ; -
    ACALL handle_tx                 ; -
    MOV A, #LF                      ; -
    ACALL handle_tx                 ; -
    MOV A, #'>'                     ; -
    ACALL handle_tx                 ; -
    MOV A, #' '                     ; -
    ACALL handle_tx                 ; print prompt

    CLR run_flag                ; clear flag
    RET                         ; return

cmd_clr:
cmd_set:
cmd_tog:
    RET

transmit:
    CLR A                   ; Clear accumulator
    MOVC A, @A+DPTR         ; Load char to accumulator
    INC DPTR                ; Point to next char
    ACALL handle_tx         ; transmit
    JNZ transmit            ; again if acc not zero
    RET                     ; return

echo:
handle_tx:
    MOV SBUF, A             ; transmit char
    JNB TI, $               ; wait till transmission is complete
    CLR TI                  ; clear transmit flag
    RET                     ; return

END                         ; END :D
