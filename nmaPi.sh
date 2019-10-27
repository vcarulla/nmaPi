#!/bin/bash

#----------------------------------------------
#Network Interface: eth0, wlan0 
IFC=wlan0 
#Turn Macchanger ON/OFF:
MAC=false
#Define the range of network: .1/24, .1/16, .*
RANGE=".1/24" 
#---------------------------------------------

function powerUpLeds() {
	echo 17 > /sys/class/gpio/export
	echo 27 > /sys/class/gpio/export
	echo 22 > /sys/class/gpio/export

	echo out > /sys/class/gpio/gpio17/direction
	echo out > /sys/class/gpio/gpio27/direction
	echo out > /sys/class/gpio/gpio22/direction
	
	return
}

function blinkLeds() {
	echo 1 > /sys/class/gpio/gpio27/value
	echo 1 > /sys/class/gpio/gpio17/value
	echo 1 > /sys/class/gpio/gpio22/value
	sleep 1

	echo 0 > /sys/class/gpio/gpio17/value
	echo 0 > /sys/class/gpio/gpio22/value
	echo 0 > /sys/class/gpio/gpio27/value
	sleep 1

	return
}

function checkDependecies() {
	if hash ifconfig 2>/dev/null; then
			echo "ifconfig found"
	else
			echo "ifconfig not found"
	fi
	if hash macchanger 2>/dev/null; then
			echo "macchanger found"
	else
			echo "macchanger not found"
	fi
	if hash nmap 2>/dev/null; then
			echo "nmap found"
	else
			echo "nmap not found"
	fi

	exit
}

function macChanger() {
	if [ $MAC ] 
	then
		echo "- Macchanger ON  :) - "
		ifconfig $IFC down
		sleep 5
		macchanger -a $IFC
		sleep 5
		ifconfig $IFC up
		sleep 5
	else
		echo "- Macchanger OFF :( - "
	fi

	return
}

function showIpInfo() {
	ip1=$(ip -f inet addr show dev ${IFC} | sed -n 's/^ *inet *\([.0-9]*\).*/\1/p' | awk -F. ' {print $1"."$2"."$3"."} ' )
	ip2=${ip1}${RANGE}
	echo ""
	echo "- The IP The network ip is: ${ip2} -"
	echo ""
	echo 1 > /sys/class/gpio/gpio27/value

	return
}

function init () {
	cat logo; 
	powerUpLeds; 
	blinkLeds; 
	macChanger; 
	showIpInfo;

	return
}

function quickScan() {
	init
	echo "Making a quick scanning"
	echo 0 > /sys/class/gpio/gpio17/value
	nmap -T4 -F "$ip2" -oN /tmp/out_scan
	echo 1 > /sys/class/gpio/gpio17/value
	sleep 4
	echo "End Scan"
	loginScan

	return
}

function deepScan() {
	init
	echo "Making a deep scanning"
	echo 0 > /sys/class/gpio/gpio17/value
	nmap -T4 -A -V -PE -PS22,25,80,3389 "$ip2" -oN /tmp/out_scan2
	echo 1 > /sys/class/gpio/gpio17/value
	sleep 4
	echo "End Scan"
	loginScan

	return
}

function silentScan() {
	init
	echo "Making a silent scanning"
	echo 0 > /sys/class/gpio/gpio17/value
	nmap -sS -sU -T4 -A -v -PE -PP -PS80,443 -PA3389 -PU40125 -PY -g 53 "$ip2" -oN /tmp/out_scan3
	echo 1 > /sys/class/gpio/gpio17/value
	sleep 4
	echo "End Scan"
	loginScan

	return
}

function help() {
	echo "
	Automatic Nmap for Raspberry Pi
	-------------------------------
			by Pimux & ImBittor

	Use ./nmapi.sh [option]
	-f - Fast Scan.
	-d - Deep Scan {Default Option}.
	-q - Quiet Scan.
	-c - Check dependencies"
	exit
}

function loginScan() {
	echo "Generating log..."
	touch ./map.txt
	date > map.txt
	cat /tmp/out_scan* >> ./map.txt
	rm /tmp/out_scan*

	echo 1 > /sys/class/gpio/gpio22/value

	echo "			----Happy Hacking----  :)"
	sleep 1

	counter=1
	while [ $counter -le 4 ]
	do
	blinkLeds
	((counter++))
	done

	exit
}

case "$1" in
	'-f')	quickScan; loginScan;;
	'-d')	deepScan; loginScan;;
	'-q')	silentScan; loginScan;;
	'-c')	checkDependecies;;
	*		)	help;;
esac
