#!/bin/bash
#
#Manage Users
#
# **Note**: This bash script was meant for a cyber security competition setting.
#	In real life, this file should NOT be used to secure accounts
#	
# What this file does:
#	*Lock root account
#	*Asks for a list of valid users
#	*Sets a password for each user
#	*Change password policies for each user
#	*Directs you to /etc/group to check admin groups


passwd -l root
touch ~/Desktop/usersHere.txt
echo 'Please list all the users in the system. One per line' > ~/Desktop/usersHere.txt
echo 'When you are done, erase these two lines.' >> ~/Desktop/usersHere.txt

nano ~/Desktop/usersHere.txt

echo 'Changing passwords to each user...'

while read -r line
do
	name=$line
	echo "$name:ThunderCats!5" | chpasswd 
done < ~/Desktop/usersHere.txt
echo ' '
echo 'Done.'
echo ' '
echo "I also changed the password policies for each user... "
echo ' '

cat /etc/passwd | grep /bin/bash
echo ' '
echo 'Are there any users you want to delete?[y/n]'
read ans
if [ "$ans" = "y" ]
then
	touch ~/Desktop/deletedUsers.txt
	echo 'Please list the users you want to delete. One per line' > ~/Desktop/deletedUsers.txt
	echo 'When done, delete these two lines.' >> ~/Desktop/deletedUsers.txt
	nano ~/Desktop/deletedUsers.txt
	while read -r line
	do
		name=$line
		deluser --remove-home $name
	done < ~/Desktop/deletedUsers.txt
else
	echo 'Okay.'
fi
echo ' '
echo ' '
echo 'Are there any users you want to add?[y/n]'
read answ
if [ "$answ" = "y" ]
then
	touch ~/Desktop/addedUsers.txt
	echo 'Please list the users you want to add. One per line' > ~/Desktop/addedUsers.txt
	echo 'When done, delete these two lines.' >> ~/Desktop/addedUsers.txt
	nano ~/Desktop/addedUsers.txt
	while read -r line
	do
		name=$line
		adduser $name --gecos " , , , " --disabled-password
		passwd -x 30 -n 10 -w 7 $name
		echo "$name:ThunderCats!5" | chpasswd
	done < ~/Desktop/addedUsers.txt
else
	echo 'Okay.'
fi
nano /etc/group

rm ~/Desktop/addedUsers.txt
rm ~/Desktop/deletedUsers.txt
rm ~/Desktop/usersHere.txt

echo 'You are now done.'
