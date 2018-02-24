#!/bin/bash
#
#Sets up the firewall
#
# **Note**: This bash script was meant for a cyber security competition setting.
#	In real life, this file should NOT be used to secure accounts
#
# What this file does:
#	*Set logging to high
#	*Allow certain TCP/UDP ports
#	*Opens ufw
clear

ufw logging high

echo ' '
touch ~/Desktop/ufwRules.txt
echo 'Before we open the firewall, what TCP ports do you want open?' > ~/Desktop/ufwRules.txt
echo 'List numbers one per line. When finished, delete these two lines' >> ~/Desktop/ufwRules.txt

nano ~/Desktop/ufwRules.txt

while read -r line
do
	num=$line
	ufw allow $num/tcp
done < ~/Desktop/ufwRules.txt

echo ' '
echo 'Before we open the firewall, what UDP ports do you want open?' > ~/Desktop/ufwRules.txt
echo 'List numbers one per line. When finished, delete these two lines' >> ~/Desktop/ufwRules.txt

nano ~/Desktop/ufwRules.txt

while read -r line
do
	num=$line
	ufw allow $num/udp
done < ~/Desktop/ufwRules.txt

ufw enable

echo 'Done.'

rm ~/Desktop/ufwRules.txt