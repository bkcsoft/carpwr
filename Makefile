DEVICE     = attiny85
CLOCK      = 1000000
PROGRAMMER = gpio
PORT       = gpio
BAUD       = 19200
FILENAME   = main
COMPILE    = avr-gcc -Wall -Os -DF_CPU=$(CLOCK) -mmcu=$(DEVICE)

default: build

obj:
	mkdir obj/

bin:
	mkdir bin/

obj/$(FILENAME).o: $(FILENAME).c obj
	docker run --rm -t -v $(PWD):/tmp jcreekmore/avr-toolchain $(COMPILE) -c $(FILENAME).c -o obj/$(FILENAME).o

bin/$(FILENAME).elf: obj/$(FILENAME).o bin
	docker run --rm -t -v $(PWD):/tmp jcreekmore/avr-toolchain $(COMPILE) -o bin/$(FILENAME).elf obj/$(FILENAME).o

bin/$(FILENAME).hex: bin/$(FILENAME).elf bin
	docker run --rm -t -v $(PWD):/tmp jcreekmore/avr-toolchain avr-objcopy -j .text -j .data -O ihex bin/$(FILENAME).elf bin/$(FILENAME).hex

build: bin/$(FILENAME).hex bin
	docker run --rm -t -v $(PWD):/tmp jcreekmore/avr-toolchain avr-size --format=avr --mcu=$(DEVICE) bin/$(FILENAME).elf

upload:
	scp bin/$(FILENAME).hex pi@192.168.1.109:$(FILENAME).hex
	ssh pi@192.168.1.109 sudo avrdude -v -p $(DEVICE) -c $(PROGRAMMER) -P $(PORT) -U flash:w:$(FILENAME).hex:i

clean:
	-[ -f obj/$(FILENAME).o ] && rm -f obj/$(FILENAME).o
	-[ -f bin/$(FILENAME).elf ] && rm -f bin/$(FILENAME).elf
	-[ -f bin/$(FILENAME).hex ] && rm -f bin/$(FILENAME).hex
