#include <avr/io.h>
// F_CPU available from commandline
#include <avr/interrupt.h>
#include <avr/wdt.h>
#include <avr/sleep.h>

#define PIN_ACC    PB3 // Reading ACC-status (High == on, Low == off)
#define PIN_PI_IN  PB4 // RPi says goodnight (High == on, Low == off)
#define PIN_PI_OUT PB5 // Tell RPi goodnight (High == dead, Low == wake)
#define PIN_SW     PB1 // Power-Supply (High == on, Low == off)
#define PIN_PWR    PB2 // Power-button

#define MASK_ACC    (1<<PIN_ACC)
#define MASK_PI_IN  (1<<PIN_PI_IN)
#define MASK_PI_OUT (1<<PIN_PI_OUT)
#define MASK_SW     (1<<PIN_SW)
#define MASK_PWR    (1<<PIN_PWR)

#define DIGIWRITE_H(prt, pn) prt |= (1<<pn)
#define DIGIWRITE_L(prt, pn) prt &= ~(1<<pn)
#define DIGIREAD(prt, pn) (prt | (1<<pn))

#define READ_ACC(x) DIGIREAD(x, PIN_ACC)

#define READ_PI(x) DIGIREAD(x, PIN_PI_IN)
#define PI_ON(x) DIGIWRITE_H(x, PIN_PI_OUT)
#define PI_OFF(x) DIGIWRITE_L(x, PIN_PI_OUT)

#define PS_ON(x) DIGIWRITE_H(x, PIN_SW)
#define PS_OFF(x) DIGIWRITE_L(x, PIN_SW)

#define READ_PWR(x) DIGIREAD(x, PIN_PWR)

void setup() {
	// Setup pins...
	DDRB = 0 | MASK_PI_OUT | MASK_SW;

	// initially set the pins to "low"
	PI_OFF(PORTB);             // RPi dead
	PS_OFF(PORTB);             // Power-Supply off

	// Enable Interrupts
	GIMSK = 1<<PCIE;               // Enable Pin Change Interrupt
	PCMSK = MASK_PI_IN | MASK_ACC | MASK_PWR; // Set PCI-Pins

	set_sleep_mode(SLEEP_MODE_PWR_DOWN);
	sleep_enable();

	sei();
}

// Watchdog Timer Interrupt
// - This function is used to forcibly kill the power
ISR(SIG_WATCHDOG_TIMEOUT) {
	cli();           // Disable Interrupts

	// Disable Watchdog Timer
	wdt_reset();     // Reset WDT
	wdt_disable();   // Disable WDT Completely

	// Turn off RPi and Power-Supply
	PI_OFF(PORTB);
	PS_OFF(PORTB);
}

ISR(SIG_PIN_CHANGE) {
	cli();   // Turn off Interrupts (should be done by libc, but lets do it anyway... 1 cycle more or less ^.^)

	const uint8_t state_mask = MASK_PI_IN | MASK_PWR | MASK_PWR;

	static uint8_t old_state = 0;

	uint8_t masked_state = (PORTB & state_mask);

	// Check mask and de-bounce
	if (masked_state && (masked_state ^ old_state)) {
		const uint8_t new_state = masked_state ^ old_state;
		// ACC turned off
		if (!READ_ACC(new_state)) {
			PI_OFF(PORTB);             // Tell the RPi that it should turn off...
		}
		// ACC turned on
		if (READ_ACC(new_state)) {
			PS_ON(PORTB);
			PI_ON(PORTB);
		}

		// RPi turned off
		if (!READ_PI(new_state)) {
			WDTCR = (1<<WDIE) | (1<<WDE);  // Enable Watchdog Timer Interrupt
			wdt_enable(WDTO_2S);           // Enable WDT set to 2 seconds
		}

		// Pressing the Power-button!
		if (READ_PWR(new_state)) {
			if(READ_PI(PORTB)) { // RPi is on...
				WDTCR = (1<<WDIE) | (1<<WDE);  // Enable Watchdog Timer Interrupt
				wdt_enable(WDTO_4S);           // Enable WDT set to 4 seconds
			} else { // Turn it on :D
				PI_ON(PORTB);          // Tell RPi it's okey to stay on
				PS_ON(PORTB);          // Turn on Power-Supply
			}
		}
		// Released the Power-button!
		if (!READ_PWR(new_state)) {
			wdt_disable();          // Disable the Watchdog Timer Interrupt
			PI_OFF(PORTB);          // Power-Off normally
		}

		old_state = old_state | new_state; // set new old state :D
	}
}


int main(void) {
	setup();

	for(;;){
		sei();
		sleep_cpu();
	}

	return 0;   /* never reached */
}
