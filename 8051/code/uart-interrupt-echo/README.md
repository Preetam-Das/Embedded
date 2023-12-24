## UART - interrupt echo

Echo back what was received from console using serial port interrupt.

## Working

Like the previous program but based on serial port interrupts. Whenever RI or TI
is set by hardware it generates an interrupt. Whethere it was RI or TI is to be
checked by the ISR. The ISR is similar to the previous program.
