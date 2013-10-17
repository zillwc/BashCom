#!/bin/bash

#################################################
#
#	BashCom
#	Lists all contacts from address book
#
#	Zill Christian
#	MIT License
#
#################################################

clear
echo -e "=== List contacts ===\n"

# Go thru every entry in address book and pretty print it all
(awk -F ":" '{printf "Entry %d:\n%s\n%s\n==========================\n\n", NR, $1, $2}' $BOOK ; echo "Press Q to Quit and return to the menu." ) | less
