# Code

A bunch of assembly language programs for interfacing the 8051 mcu with various
components and understanding its basic peripherals.

The `regdef.S` file is the common header file used by all the other programs.
It contains the various SFR memory locations and also the ISR addresses.

## Programs

- **blink** : Simple blinky
- **blink-button** : Blink led when button is pressed (polling)
- **blink-timer** : Blink led with timer interrupt
- **uart-polled-output** : Transmit 'Hello' over UART
- **uart-polled-echo** : Echo back what was recieved over UART
- **uart-interrupt-echo** : Same as above but using serial port interrupts

more coming soon ...
