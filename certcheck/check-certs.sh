#!/bin/sh

# Check Certs Docker
# Copyright 2024 Stewart Cossey
# Version 1.0

. ./library.sh
. ./cclib.sh

file_env "APP_TOKEN"
file_env "USER_TOKEN"
file_env "HOST_SYSTEM"

file_env "WARNDAYS" 7

file_env "INTERVAL" 0
file_env "BEGIN" dfmt=%H%M
file_env "FILE1"

validate_env "APP_TOKEN" "req"
validate_env "USER_TOKEN" "req"
validate_env "HOST_SYSTEM" "req"
validate_env "FILE1" req

log "Started"

if [ -n "$INTERVAL" ] && [ "$INTERVAL" -ne 0 ]
then
	log "Check interval ${INTERVAL}m"
fi

while :
do

    c=1
    while :; do
        FILEVAL=FILE$c
        NAMEVAL=NAME$c
        CRLVAL=CRL$c
        file_env $FILEVAL
        file_env $NAMEVAL
        file_env $CRLVAL

        if [ -z "${!FILEVAL}" ]; then
            break
        fi

        if [ -n "${!CRLVAL}"] && [ "${!CRLVAL}" = "Y" ]; then
            check_crl "${!FILEVAL}" "${!NAMEVAL}"
        else
            check_cert "${!FILEVAL}" "${!NAMEVAL}"
        fi
        
        ((c++))
    done

    complete

	if [ -z "$INTERVAL" ] || [ "$INTERVAL" -eq 0 ]
	then
		break
	else
		sleep "${INTERVAL}m" 
	fi
done

exit 0