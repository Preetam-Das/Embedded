## Blink

Simple assembly program to blink an LED using polled delay loop. To build do `make`.
To upload do `make upload`.

## Working
In the code we turn on and off the led using the CPL instruction which
complements the value of a register in this case the LED Pin.

We use inverse logic, .i.e, writing logic-0 to the LED Pin turns it on and
writing logic-1 to turns it off.

Forward logic does not work because of the DC characteristics of the Port Pins
of the mcu. Check notes for dc-characteristics.

**NOTE**: The anode of the LED should be connected to 5v.

**NOTE**: Port 1-3 has internall pullup resistors and in my dev board Port 0 is
connected with external pullups so I am not worrying about them.

[^1]: Check the datasheet for different conditions for different voltage levels

## Instructions used

- `CPL` : Complement(0 to 1 and 1 to 0) direct bit
- `DJNZ bit,label` : Decrement bit and jump to label if it is not zero
