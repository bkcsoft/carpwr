DEVICE     = attiny85
CLOCK      = 1000000
PROGRAMMER = gpio
PORT       = gpio
BAUD       = 19200
FILENAME   = main
COMPILE    = avr-gcc -Wall -Os -DF_CPU=$(CLOCK) -mmcu=$(DEVICE)

default: build

$(FILENAME).o: $(FILENAME).c
	docker run --rm -t -v $(PWD):/tmp jcreekmore/avr-toolchain $(COMPILE) -c $(FILENAME).c -o $(FILENAME).o

$(FILENAME).elf: $(FILENAME).o
	docker run --rm -t -v $(PWD):/tmp jcreekmore/avr-toolchain $(COMPILE) -o $(FILENAME).elf $(FILENAME).o

$(FILENAME).hex: $(FILENAME).elf
	docker run --rm -t -v $(PWD):/tmp jcreekmore/avr-toolchain avr-objcopy -j .text -j .data -O ihex $(FILENAME).elf $(FILENAME).hex

build: $(FILENAME).hex
	docker run --rm -t -v $(PWD):/tmp jcreekmore/avr-toolchain avr-size --format=avr --mcu=$(DEVICE) $(FILENAME).elf

upload:
	scp $(FILENAME).hex pi@192.168.1.109:$(FILENAME).hex
	ssh pi@192.168.1.109 sudo avrdude -v -p $(DEVICE) -c $(PROGRAMMER) -P $(PORT) -U flash:w:$(FILENAME).hex:i

clean:
	-[ -f $(FILENAME).o ] && rm -f $(FILENAME).o
	-[ -f $(FILENAME).elf ] && rm -f $(FILENAME).elf
	-[ -f $(FILENAME).hex ] && rm -f $(FILENAME).hex
