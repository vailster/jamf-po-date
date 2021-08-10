#!/bin/bash

########################################################
#Login details for your API account with write access
########################################################
API_USER=$(changeme)
API_PASS=$(changeme)

########################################################
#Grab the serial number of the computer
########################################################
serial=$(system_profiler SPHardwareDataType | awk '/Serial/{print $4}')

########################################################
#Replace YOURURL with the URL of your Jamf instance
########################################################

initialEntry=$(curl -su $API_USER:$API_PASS -H "accept: text/xml" https://YOURURL.jamfcloud.com/JSSResource/computers/serialnumber/$serial -X GET | xmllint --xpath 'computer/general/initial_entry_date/text()' -)

curl -sS -k -i -u $API_USER:$API_PASS -X PUT -H "Content-Type: text/xml" -d "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?> <computer><purchasing><po_date>$initialEntry</po_date></purchasing></computer>"  "https://YOURURL.jamfcloud.com/JSSResource/computers/serialnumber/$serial"