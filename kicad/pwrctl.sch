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
Sheet 3 3
Title ""
Date "11 mar 2016"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text HLabel 950  1900 0    60   Input ~ 0
+3.3v
Text HLabel 6800 1600 2    60   Input ~ 0
ACC
Text HLabel 900  1400 0    60   Output ~ 0
GND
Text HLabel 6700 1950 2    60   Input ~ 0
SW_GND
$Comp
L ATTINY85-P IC1
U 1 1 56E22A79
P 3550 1650
F 0 "IC1" H 2400 2050 40  0000 C CNN
F 1 "ATTINY85-P" H 4550 1250 40  0000 C CNN
F 2 "DIP8" H 4550 1650 35  0000 C CIN
F 3 "~" H 3550 1650 60  0000 C CNN
	1    3550 1650
	-1   0    0    1   
$EndComp
Wire Wire Line
	900  1400 2200 1400
$Comp
L R R4
U 1 1 56E22AD8
P 5900 1350
F 0 "R4" V 5980 1350 40  0000 C CNN
F 1 "2k" V 5907 1351 40  0000 C CNN
F 2 "~" V 5830 1350 30  0000 C CNN
F 3 "~" H 5900 1350 30  0000 C CNN
	1    5900 1350
	1    0    0    -1  
$EndComp
Wire Wire Line
	4900 1600 5900 1600
$Comp
L R R5
U 1 1 56E22B06
P 6150 1600
F 0 "R5" V 6230 1600 40  0000 C CNN
F 1 "10k" V 6157 1601 40  0000 C CNN
F 2 "~" V 6080 1600 30  0000 C CNN
F 3 "~" H 6150 1600 30  0000 C CNN
	1    6150 1600
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1600 1100 5900 1100
Connection ~ 1850 1400
Wire Wire Line
	6400 1600 6800 1600
Text HLabel 5150 1500 2    60   Input ~ 0
PI_IN
Text HLabel 5150 1400 2    60   Output ~ 0
PI_OUT
Text HLabel 5150 1700 2    60   Input ~ 0
PWR_SW
Wire Wire Line
	5150 1700 4900 1700
$Comp
L BD139 Q1
U 1 1 56E22BE9
P 6000 2200
F 0 "Q1" H 6000 2050 40  0000 R CNN
F 1 "BD139" H 6000 2350 40  0000 R CNN
F 2 "TO126" H 5880 2300 29  0001 C CNN
F 3 "~" H 6000 2200 60  0000 C CNN
	1    6000 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	5800 2200 5800 1800
Wire Wire Line
	6700 1950 6100 1950
Wire Wire Line
	6100 1950 6100 2000
Wire Wire Line
	6100 2400 6100 2550
Wire Wire Line
	6100 2550 1850 2550
$Comp
L R R3
U 1 1 56E22C30
P 5350 1800
F 0 "R3" V 5430 1800 40  0000 C CNN
F 1 "R" V 5357 1801 40  0000 C CNN
F 2 "~" V 5280 1800 30  0000 C CNN
F 3 "~" H 5350 1800 30  0000 C CNN
	1    5350 1800
	0    1    1    0   
$EndComp
Wire Wire Line
	4900 1800 5100 1800
Wire Wire Line
	5800 1800 5600 1800
Wire Wire Line
	5150 1500 4900 1500
Wire Wire Line
	5150 1400 4900 1400
Wire Wire Line
	2200 1900 950  1900
Wire Wire Line
	1600 1100 1600 1400
Connection ~ 1600 1400
Wire Wire Line
	1850 2550 1850 1400
$EndSCHEMATC
