## Blink Timer

This time we blink the LED using a hardware timer. This means that our code is
not stuck in a delay loop. Whenever the timer overflows the correct number of
times we toggle the LED state. Using this, we can perform other task in the main
loop while the timer ineterrupt service routine is taking care of toggling the
LED.

## Working
We have used the timer in 16-bit mode. This means the timer runs from 0 to
65535. Once it reaches the maxm value it overflows and starts from 0. When the
timer overflows it automatically generates a overflow interrupt which calls a
interrupt service routine that we can use to do toggle the LED.

I tried to create a 1 second delay. The crystal oscillator used has a frequency
of 11.0592 Mhz. One machine cycle is equal to 12 oscialltor cycles. Using some
math magic, we require 921600 Machine cycles to generate 1 second delay.

Couting exactly 921600 machine cycles is somewhat diffcult due to jumps and
conditional statement in the code. To generate 921600 cycles, we set up the
timer to count to 61440 15 times (15 * 61440 = 921600). To count to 61440 we set
the timer bytes to 65536 - 61440 = 4096 (hex 0xf000).

Each time we hit a overflow we decrement a counter of 15 until it reaches 0,
when we do the led toggling.

This way we get an approx of 1 second delay. Due to various subroutine call
overheads we get an error of about 0.2 milisecond :( due to extra 227 machine
cycles (I calculated using uCsim_51). Nonetheless it works for my purpose.
