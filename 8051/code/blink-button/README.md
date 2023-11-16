## Blink (Polled Button)

Program to blink LED when button is pressed. Button press is checked using
polled logic.

## Working

In the main loop we continuously check for the button if it is pressed or not.
One end of the button is connected to ground and the other end is connected to
the mcu pin. So when the button is pressed the value of the pin becomes logic-0
and otherwise the pin value remains logic-1.

When the button is pressed we jump to the `btn_press` label which services the
button press. It performs a blink operation by turning on and off the LED
manually with delay in between them. We did not use the `CPL` instruction
because if we have used it the LED could have left turned on even after we
release the button.

## Instructions used

- `SETB bit`    : Set direct bit to 1
- `CLR bit`   : clear direct bit to 0
- `JNB bit,label` : Jump to label if bit is not set.
