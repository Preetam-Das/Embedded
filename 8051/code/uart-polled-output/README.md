## UART - polled transmission

Sending 'Hello' over serial port using 8051 UART.

## Working

This program sends 'Hello' text over the serial port using serial port mode 1.
In mode 1 serial port acts as a variable buad rate whose value is determined by
timer-1 or timer-2(8052) overflow rate. Timer-1 is used in auto-reload mode(mode
2) to provide a baud rate of 9200bps. To get this baud rate we use this formula:

    TH1 = 256 - ((K * Osc. Freq)/(384 * baud rate))

Here K = 1, when SMOD = 0 and K = 2 when SMOD = 1. SMOD = 1 is used for doubling
the baud rate. Putting baud rate as 9600 into the formula we get TH1 = 253. We
use this value in TH1 and TL1 to get the correct baud rate.

Putting value in the SBUF sfr starts the transmission. The transmission ends
when the value of TI sfr becomes 1. After that we can clear that register and
start the transmission once again.
