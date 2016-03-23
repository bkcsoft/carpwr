EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:LM2575
LIBS:rpi-mb-cache
EELAYER 27 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 3
Title "RPi Car Stereo Motherboard"
Date "11 mar 2016"
Rev ""
Comp "Fulkod"
Comment1 "https://fulkod.se"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L LM2575 U1
U 1 1 56E0E663
P 2700 1900
F 0 "U1" H 2700 1800 50  0000 C CNN
F 1 "LM2575" H 2700 2000 50  0000 C CNN
F 2 "" H 2700 1900 60  0000 C CNN
F 3 "" H 2700 1900 60  0000 C CNN
	1    2700 1900
	1    0    0    -1  
$EndComp
Wire Wire Line
	1900 1800 1350 1800
$Comp
L C C1
U 1 1 56E0E664
P 1650 2150
F 0 "C1" H 1650 2250 40  0000 L CNN
F 1 "100µF" H 1656 2065 40  0000 L CNN
F 2 "~" H 1688 2000 30  0000 C CNN
F 3 "~" H 1650 2150 60  0000 C CNN
	1    1650 2150
	1    0    0    -1  
$EndComp
Wire Wire Line
	1300 2500 5650 2500
Wire Wire Line
	1650 2350 1650 2500
Connection ~ 1650 2500
Wire Wire Line
	1650 1950 1650 1800
Connection ~ 1650 1800
Wire Wire Line
	3500 1800 3800 1800
Connection ~ 2700 2500
$Comp
L INDUCTOR L1
U 1 1 56E0E665
P 4200 2000
F 0 "L1" V 4150 2000 40  0000 C CNN
F 1 "330µH" V 4300 2000 40  0000 C CNN
F 2 "~" H 4200 2000 60  0000 C CNN
F 3 "~" H 4200 2000 60  0000 C CNN
	1    4200 2000
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3500 2000 3900 2000
$Comp
L C C2
U 1 1 56E0E666
P 4700 2250
F 0 "C2" H 4700 2350 40  0000 L CNN
F 1 "220µF" H 4706 2165 40  0000 L CNN
F 2 "~" H 4738 2100 30  0000 C CNN
F 3 "~" H 4700 2250 60  0000 C CNN
	1    4700 2250
	1    0    0    -1  
$EndComp
Wire Wire Line
	4500 2000 4700 2000
Wire Wire Line
	4700 1400 4700 2050
Wire Wire Line
	4700 2500 4700 2450
Wire Wire Line
	3800 1800 3800 2500
Connection ~ 3800 2500
$Comp
L R R1
U 1 1 56E0E667
P 5100 1650
F 0 "R1" V 5180 1650 40  0000 C CNN
F 1 "5k" V 5107 1651 40  0000 C CNN
F 2 "~" V 5030 1650 30  0000 C CNN
F 3 "~" H 5100 1650 30  0000 C CNN
	1    5100 1650
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 56E0E668
P 5100 2150
F 0 "R2" V 5180 2150 40  0000 C CNN
F 1 "3k" V 5107 2151 40  0000 C CNN
F 2 "~" V 5030 2150 30  0000 C CNN
F 3 "~" H 5100 2150 30  0000 C CNN
	1    5100 2150
	1    0    0    -1  
$EndComp
Wire Wire Line
	3500 1900 5100 1900
Wire Wire Line
	5100 2500 5100 2400
Connection ~ 4700 2500
Wire Wire Line
	4700 1400 5600 1400
Connection ~ 4700 2000
Connection ~ 5100 2500
Connection ~ 5100 1400
Text HLabel 1350 1800 0    60   Input ~ 0
+12V
Text HLabel 1300 2500 0    60   Output ~ 0
GND
Text HLabel 5650 2500 2    60   Input ~ 0
GND
Text HLabel 5600 1400 2    60   Output ~ 0
+3.3V
$EndSCHEMATC
