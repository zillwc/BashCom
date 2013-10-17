#!/bin/bash

#################################################
#
#	BashCom
#	Deletes individual contacts from address book
#
#	Zill Christian
#	MIT License
#
#################################################

clear
echo -e "=== Delete contact ===\n"

# Ask user which line to delete
echo -n "Which entry number do you want to delete: "
read number

# Display the entry selected
awk -v var=$number -F ":" 'NR ~ var {printf "\nEntry %d:\n%s\n%s\n\n", NR, $1, $2}' $BOOK

# Verify deletion
echo -n "Is this the correct record to delete? (y/n): "
read answer

if [[ ("$answer" = "y") || ("$answer" = "Y") ]]
then
	sed "${number}d" $BOOK > file.tmp && mv file.tmp $BOOK
    echo -e "Contact has been deleted..."
    sleep 2
else
    echo -e "\nContact not deleted..."
    sleep 2
fi