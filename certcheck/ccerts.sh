#!/bin/sh

# Check Certs Standalone Example
# Copyright 2024 Stewart Cossey

# Include the check certs library
. ./cclib.sh

#Set the Pushover App Token and User/Group Key
APP_TOKEN='Pushover App Token'
USER_TOKEN='Pushover User or Group Token'

#The name of the host system
HOST_SYSTEM='Nameofhostsystem'

#How many days ahead to warn of certificate expiry in days.
WARNDAYS=7

#The certificates to check
check_cert "/path/to/cert.pem" "Cert"
check_cert "/another/path/another/cert.pem" "Another Cert"

#Complete the checks and send notifications
complete