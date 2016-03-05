#include <avr/io.h>
// F_CPU available from commandline
#include <util/delay.h>

#define PIN_ACC PB3 // Reading ACC-status (High == on, Low == off)
#define PIN_IN  PB4 // RPi says goodnight (High == on, Low == off)
#define PIN_OUT PB5 // Tell RPi goodnight (High == dead, Low == wake)
#define PIN_SW  PB2 // Power-Switch (High == on, Low == off) (IIRC...)

#define DELAY_MS 5000

#define DIGIWRITE_H(prt, pn) prt |= (1<<pn)
#define DIGIWRITE_L(prt, pn) prt &= ~(1<<pn)
#define DIGIREAD(prt, pn) (prt | (1<<pn))

void long_delay_ms(uint16_t ms) {
  for(ms /= 10; ms>0; ms--) _delay_ms(10);
}

void long_delay_s(uint16_t s) {
	uint16_t i;
	for( i = 0; i < s; i++ ) {
		long_delay_ms(1000);
	}
}

int main(void) {
	// Setup pins...
  DDRB |= (1 << PIN_OUT) | (0 << PIN_IN) | (0 << PIN_ACC);

  // initially set the pins to "low"
  DIGIWRITE_L(PORTB, PIN_OUT);

	uint8_t is_dead = 0;

  for(;;){
		// Read ACC-status
		if(is_dead == 0 && DIGIREAD(PINB, PIN_ACC) == 1) {   // ACC is on
			DIGIWRITE_H(PORTB, PIN_SW);        // Turn on Power-Switch and
			DIGIWRITE_L(PORTB, PIN_OUT);       // Tell RPi it's okey to stay on ;)
			long_delay_s(60);                  // Wait 1 minute before checking again
			                                   // to allow the RPi to fully boot

		} else {                             // ACC is off
			long_delay_s(15);                  // Wait for engine to start xD
			if(DIGIREAD(PINB, PIN_ACC) == 0) { // ACC is still off
				DIGIWRITE_H(PORTB, PIN_OUT);     // Tell RPi to shutdown
				long_delay_s(60);                // wait 1 minute before
				DIGIWRITE_L(PORTB, PIN_SW);      // Cutting the Power-Switch
				is_dead = 0;
			}
		}
		// Read RPi-status
		if(DIGIREAD(PINB, PIN_IN) == 0) {    // RPi is off
			long_delay_s(60);                  // Waiting a minute for the RPi to
			                                   // fully shutdown and then
			DIGIWRITE_L(PORTB, PIN_SW);        // Cut the Power-Switch
			is_dead = 1;
		}
  }

  return 0;   /* never reached */
}
