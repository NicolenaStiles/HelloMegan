#!/bin/bash

# read in CSV file of MAC addresses and info
i=0
while IFS=, read col1 col2 col3 col4 col5
do
	name[$i]=$col1
	phone_mac[$i]=$col2
	brand[$i]=$col3
	phone_ip[$i]=$col4
	stat[$i]=$col5
	i=$(($i+1))
done < knownPhones.csv

# for each entry, ping and see if it responds
entries=$i
k=0
while [ "$k" -lt "$entries" ]
do
	echo $k
	if [ "${brand[$k]}" != "iphone" ] 
	then
		presence=`nmap -sP -n ${phone_ip[$k]} | awk '/MAC Address:/ {print $3}'`
		if [ "$presence" != "${phone_mac[$k]}" ]
		then
			`python leds.py ${name[$k]} 0` 
		else
			# python pass here
			`python leds.py ${name[$k]} 1`
		fi
	else
		try=0
		find_flag=0
		while [ "$try" -lt "16" ]
		do
			echo $try
			iphone_presence=`nmap -sP -n ${phone_ip[$k]} | awk '/MAC Address:/ {print $3}'`
			echo "found MAC: $iphone_presence"
			echo "known MAC: ${phone_mac[$k]}"
			if [ "$iphone_presence" == "${phone_mac[$k]}" ]
			then
				find_flag=1
				break
			else
				try=$((try+1))
			fi
		done
		if [ "$find_flag" -eq "1" ]
		then
			`python leds.py ${name[$k]} 1`
		else
			`python leds.py ${name[$k]} 0`
		fi
	fi
	k=$(($k+1))
done
