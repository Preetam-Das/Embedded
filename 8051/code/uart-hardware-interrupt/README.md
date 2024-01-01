## UART - interrupt echo

This program counts the number of button clicks using hardware interrupts and
prints the number in serial console through UART. Number of clicks gets reset at
255 because 8-bit registers.

## Working

Similar to the previous program this uses the `DB` assembler directive.Since we
are only transmitting and not receiving hecne we are not using serial console
interrupts.

Hardware interrupts can be set up in two ways using the bits in TCON register.
One is low level-triggered which keeps triggering the interrupt when the
interrupt pin is low, and the other is low edge-triggered which only triggers
the interrupt when the interrupt pin goes from high level to low level.

Also, this is first day of 2024 lol :D
