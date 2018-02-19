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
Sheet 1 3
Title "RPi Car Stereo Motherboard"
Date "11 mar 2016"
Rev ""
Comp "Fulkod"
Comment1 "https://fulkod.se"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Sheet
S 1200 1100 550  400 
U 56E0E56D
F0 "3.3v Regulator" 50
F1 "3_3v_regulator.sch" 50
F2 "+12V" I L 1200 1200 60 
F3 "GND" B L 1200 1300 60 
F4 "+3.3V" O L 1200 1400 60 
$EndSheet
$Sheet
S 2500 1750 1050 650 
U 56E22A60
F0 "Power Control" 50
F1 "pwrctl.sch" 50
F2 "ACC" I L 2500 1950 60 
F3 "GND" O L 2500 2050 60 
F4 "SW_GND" I R 3550 2050 60 
F5 "PI_IN" I R 3550 2150 60 
F6 "PI_OUT" I R 3550 1850 60 
F7 "PWR_SW" I R 3550 1950 60 
F8 "+3.3V" I L 2500 1850 60 
$EndSheet
Wire Wire Line
	2500 2050 1000 2050
Wire Wire Line
	1000 2050 1000 1300
Wire Wire Line
	700  1300 1200 1300
Wire Wire Line
	1200 1400 1100 1400
Wire Wire Line
	1100 1400 1100 1850
Wire Wire Line
	1100 1850 2500 1850
$Comp
L CONN_3 K1
U 1 1 56E23D1E
P 700 650
F 0 "K1" V 650 650 50  0000 C CNN
F 1 "CONN_3" V 750 650 40  0000 C CNN
F 2 "~" H 700 650 60  0000 C CNN
F 3 "~" H 700 650 60  0000 C CNN
	1    700  650 
	0    -1   -1   0   
$EndComp
Wire Wire Line
	800  1000 800  1200
Wire Wire Line
	800  1200 1200 1200
Wire Wire Line
	700  1000 700  1300
Connection ~ 1000 1300
Wire Wire Line
	600  1000 600  1950
Wire Wire Line
	600  1950 2500 1950
$Comp
L CONN_4 P1
U 1 1 56E23DA2
P 4650 2000
F 0 "P1" V 4600 2000 50  0000 C CNN
F 1 "CONN_4" V 4700 2000 50  0000 C CNN
F 2 "~" H 4650 2000 60  0000 C CNN
F 3 "~" H 4650 2000 60  0000 C CNN
	1    4650 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	3550 2150 4300 2150
Wire Wire Line
	3550 2050 4300 2050
Wire Wire Line
	3550 1950 4300 1950
Wire Wire Line
	3550 1850 4300 1850
$EndSCHEMATC