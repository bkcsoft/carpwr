DEVICE     = attiny85
CLOCK      = 1000000
PROGRAMMER = gpio
PORT       = gpio
BAUD       = 19200
FILENAME   = main
COMPILE    = avr-gcc -Wall -Os -DF_CPU=$(CLOCK) -mmcu=$(DEVICE)
AVR_DOCKER_IMAGE = mkdryden/avr-toolchain

ifeq (, $(shell which avr-gcc 2> /dev/null))
	DOCKER = docker run --rm -t -v $(PWD):/tmp $(AVR_DOCKER_IMAGE)
else
	DOCKER = 
endif

default: build

obj:
	mkdir obj/

bin:
	mkdir bin/

obj/%.o: %.c obj
	$(DOCKER) $(COMPILE) -c $(FILENAME).c -o obj/$(FILENAME).o

bin/%.elf: obj/%.o bin
	$(DOCKER) $(COMPILE) -o bin/$(FILENAME).elf obj/$(FILENAME).o

bin/%.hex: bin/%.elf
	$(DOCKER) avr-objcopy -j .text -j .data -O ihex bin/$(FILENAME).elf bin/$(FILENAME).hex

build: bin/$(FILENAME).hex
	$(DOCKER) avr-size --format=avr --mcu=$(DEVICE) bin/$(FILENAME).elf

upload:
	scp bin/$(FILENAME).hex pi@192.168.1.109:$(FILENAME).hex
	ssh pi@192.168.1.109 sudo avrdude -v -p $(DEVICE) -c $(PROGRAMMER) -P $(PORT) -U flash:w:$(FILENAME).hex:i

clean:
	-[ -d obj/ ] && rm -rf obj/
	-[ -d bin/ ] && rm -rf bin/
