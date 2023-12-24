## UART - polled echo

Echo back what was received from console.

## Working

This program echoes back characters as they were recieved from the serial
console. RI sfr is used to check if something was recieved. Then the receieved
byte is stored in the accumulator and is transmitted back by writing it to the
SBUF sfr.
