#!/bin/bash

#################################################
#
#	BashCom
#	Texts a contact or someone random
#
#	Zill Christian
#	MIT License
#
#################################################

clear
echo -e "=== Text Message ===\n"

# Check to see if address book exists
if [ -f $BOOK ];
then
    # Ask if we're searching through address book or not
    echo -ne "Text someone from address book? (y/n)\n: "
    read answer

    if [[ ("$answer" = "y") || ("$answer" = "Y") ]]
    then
    	# Ask for the name or number of person to text
    	echo -n "Enter name or number of person you want to text: "
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
        	echo -ne "Enter entry number of the contact you want to text: "
        	read linenum

        	# Save the number to the phone variable
         	PHONE=$(cat ./bashcom_lib/temp.txt | awk "NR==$linenum" | awk -F':' '{print $2}')
         	rm ./BashText/temp.txt
        else
        	echo -e "\n$results result found in address book:"
        	# Display the entry selected
    		cat $BOOK | grep -i $find

    		echo -ne "\nText this person? (y/n): "
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
    fi
else
	echo -n "Enter phone number: "
	read PHONE
fi


# Collect message
echo -n "Enter message: "
read MSG

# Cut the message to 160 chars
MSG=${MSG:0:160}

# Verify MSG and PHONE
echo -e "\nNumber: $PHONE\nMessage: $MSG\n"
echo -n "Sending SMS to $PHONE from $CALLERID..."

# Initiate a curl request to the Twilio REST API
RESPONSE=`curl -fSs -u "$ACCOUNTSID:$AUTHTOKEN" -d "From=$CALLERID" -d "To=$PHONE" -d "Body=$MSG" "https://api.twilio.com/2010-04-01/Accounts/$ACCOUNTSID/SMS/Messages" 2>&1`
if [ $? -gt 0 ]; then echo "Failed to send SMS to $PHONE: $RESPONSE"
else echo "done.." ;
fi
if [ "$VERBOSE" -eq 1 ]; then echo $RESPONSE; fi
