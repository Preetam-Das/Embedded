## UART - interrupt echo

This program writes a string "Hello cruel world!!" to the serial port through
UART, in regular intervals. The interval is timed by using a timer-0 interrupt.

## Working

A new thing here is the use of DB assembler directive. It is used to put bytes
of data in the program memory, in this case the internal ROM. When timer
overflows we call the `transmit_loop` subroutine which loads one character at a
time to the `SBUF` register and sends it over serial port.

We use `DPTR` to store the address of the string we want to transmit. `DPTR`
is a 16-bit register used to point to memory locations.

We need to use the Accumulator `A` along with the `MOVC` instruction because
apparantly the opcodes are designed in such a way that simple `MOVC Rn,@DPTR`
does not work. Idk 🤷

## Instructions used

- `MOVC`: used to mov data bytes from and to code memory
- `INC`: increment 
- `JNZ`: Jump if Accumulator not equal to 0
