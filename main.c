#include <avr/io.h>
// F_CPU available from commandline
#include <avr/interrupt.h>
#include <avr/wdt.h>
#include <avr/sleep.h>

#define PIN_ACC    PB3 // Reading ACC-status (High == on, Low == off)
#define PIN_PI_IN  PB4 // RPi says goodnight (High == on, Low == off)
#define PIN_PI_OUT PB5 // Tell RPi goodnight (High == dead, Low == wake)
#define PIN_SW     PB2 // Power-Switch (High == on, Low == off) (IIRC...)
#define PIN_PWR    PB1 // Power-button

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
	DDRB |= (1 << PIN_PI_OUT) | (0 << PIN_PI_IN) | (0 << PIN_ACC) | (1 << PIN_SW) | (0 << PIN_PWR);

	// initially set the pins to "low"
	PI_OFF(PORTB);             // RPi dead
	PS_OFF(PORTB);             // Power-Switch off

	// Enable Interrupts
	GIMSK = 1<<PCIE;               // Enable Pin Change Interrupt
	PCMSK = (1<<PIN_PI_IN) | (1<<PIN_ACC) | (1<<PIN_PWR); // Set PCI-Pins

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

	sei();
}

ISR(SIG_PIN_CHANGE) {
	cli();   // Turn off Interrupts (should be done by libc, but lets do it anyway... 1 cycle more or less ^.^)

	const uint8_t state_mask = (1 << PIN_PI_IN) | (1 << PIN_ACC) | (1 << PIN_PWR);

	static uint8_t old_state = 0;
	static uint8_t pwr_btn_dwn = 0;

	// Check mask and de-bounce
	if (PORTB & state_mask && !(PORTB & old_state)) {
		const uint8_t new_state = PORTB ^ old_state;
		// ACC turned off
		if (READ_ACC(new_state) == 0) {
			PI_OFF(PORTB);             // Tell the RPi that it should turn off...
		}
		// ACC turned on
		if (READ_ACC(new_state) == 1) {
			PS_ON(PORTB);
			PI_ON(PORTB);
		}

		// RPi turned off
		if (READ_PI(new_state) == 0) {
			PS_OFF(PORTB);             // Turn off Power-Supply
		}

		// Pressing the Power-button!
		if (READ_PWR(new_state) == 1) {
			WDTCR = (1<<WDIE) | (1<<WDE);  // Enable Watchdog Timer Interrupt
			wdt_enable(WDTO_4S);           // Enable WDT set to 4 seconds
		}
		// Released the Power-button!
		if (READ_PWR(new_state) == 0 && pwr_btn_dwn == 1) {
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
