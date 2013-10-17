#!/bin/bash

#################################################
#
#	BashCom
#	Adds a contact to the address book
#
#	Zill Christian
#	MIT License
#
#################################################

clear
echo -e "=== Add contact ===\n"

# Ask for name
echo -n "Name of contact: "
read name

# Ask for phone number
echo -n "Phone number: "
read phone

# Verify info
echo "Save this contact (y/n):"
echo -ne "\t$name\n\t$phone\n: "
read answer

if [[ ("$answer" = "y") || ("$answer" = "Y") ]]
then
	# Append the contact to addressbook
	echo "$name:$phone" >>$BOOK
	echo "Contact added to address book..."
	sleep 2
else
	echo "Contact not added to address book..."
	sleep 2
fi
exit 0