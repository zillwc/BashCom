#!/bin/bash

#################################################
#
#	BashCom
#	Calls a contact or someone random
#
#	Zill Christian
#	MIT License
#
#################################################

# Function to encode the URL
rawurlencode() {
  local string="${1}"
  local strlen=${#string}
  local encoded=""

  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
     esac
     encoded+="${o}"
  done
  echo "${encoded}"
  REPLY="${encoded}"
}

clear
echo -e "=== Phone Call Message ===\n"

# Ask if we're searching through address book or not
echo -ne "Call someone from address book? (y/n)\n: "
read answer

if [[ ("$answer" = "y") || ("$answer" = "Y") ]]
then
	# Ask for the name or number of person to text
	echo -n "Enter name or number of person you want to call: "
    read find

    # Get the number of results with that string in the file
    results=$(cat $BOOK | grep -ci "$find")

    # Check if it's greater than 1 or not
    if [ "$results" -gt 1 ]
    then
    	echo -e "\n$results result(s) found in address book:\n"
    	cat $BOOK | grep -i $find > ./bashcom_lib/temp.txt
    	(awk -F ":" '{printf "Entry %d:\n%s\n%s\n==========================\n\n", NR, $1, $2}' ./bashcom_lib/temp.txt)

    	# Ask user to select the user they want to text
    	echo -ne "Enter entry number of the contact you want to call: "
    	read linenum

    	# Save the number to the phone variable
     	PHONE=$(cat ./bashcom_lib/temp.txt | awk "NR==$linenum" | awk -F':' '{print $2}')
     	rm ./BashText/temp.txt
    else
    	echo -e "\n$results result found in address book:"
    	# Display the entry selected
		cat $BOOK | grep -i $find

		echo -ne "\nCall this person? (y/n): "
		read isPerson

		if [[ ("$isPerson" = "y") || ("$isPerson" = "Y") ]]
		then
			# Save the number to the phone variable
			PHONE=$(cat $BOOK | grep -i "$find" | awk -F':' '{print $2}')
		else
			echo -n "Enter phone number: "
			read PHONE
		fi
    fi
else
	echo -n "Enter phone number: "
	read PHONE
fi


# Collect message
echo -n "Enter message: "
read MSG
MSG=$( rawurlencode "$MSG" )

# Verify MSG and PHONE
echo -e "\nNumber: $PHONE\nMessage: $MSG\n"
echo -n "Calling $PHONE from $CALLERID..."
sleep 2

# initiate a curl request to the Twilio REST API, to begin a phone call to that number
RESPONSE='curl -fSs -u "$ACCOUNTSID:$AUTHTOKEN" -d "Caller=$CALLERID" -d "Called=$PHONE" -d "Url=http://twimlets.com/message?Message=$MSG" "https://api.twilio.com/2008-08-01/Accounts/$ACCOUNTSID/Calls" 2>&1'
if [ $? -gt 0 ]; then echo "Failed to call $PHONE: $RESPONSE" ; sleep 4
else echo "done"
fi
if [ "$VERBOSE" -eq 1 ]; then echo $RESPONSE; fi