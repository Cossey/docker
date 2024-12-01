#!/bin/sh

# Certificate Checker Library
# Copyright (C) 2022 Stewart Cossey
# Version 1.0

NEWLINE=$'\n'
INVALIDPATHS=""
EXPIRING=""


pushmail() {
    TITLE=$1
    MESSAGE=$2
    curl 'https://api.pushover.net/1/messages.json' -X POST -d "token=$APP_TOKEN&user=$USER_TOKEN&message=$MESSAGE&title=$TITLE"
}

complete() {
    if [ -n "$APP_TOKEN" ] && [ -n "$USER_TOKEN" ]; then
        echo "Sending Notifications..."
        
        if [ -z "$HOST_SYSTEM" ]; then
            HOST_SYSTEM=$(hostname)
        fi

        if [ -n "$INVALIDPATHS" ]; then
            
            pushmail "Certificates Missing: $HOST_SYSTEM" "$INVALIDPATHS"
        fi

        if [ -n "$EXPIRING" ]; then
            pushmail "Certificates Expiring: $HOST_SYSTEM" "$EXPIRING"
        fi
    else
        echo "Missing APP_TOKEN or USER_TOKEN - no notification will be sent"
    fi
}

check_cert() {

    #Convert days to seconds.
    CHECKENDRAW=$WARNDAYS*24*60*60

    if [ -e $1 ]; then
        RESULT=$(openssl x509 -enddate -noout -in "$1" -checkend $CHECKENDRAW)
        if [ $? -ne 0 ]; then
            echo "Nearing Expiry: $2"
            EXPIRING="$EXPIRING$2
"
        else
            echo "OK: $2"
        fi
    else
        INVALIDPATHS="$INVALIDPATHS$1
"
        echo "Invalid Path: $2 [$1]"
    fi

}

check_crl() {

    if [ -e $1 ]; then
        CRLExpires=`openssl crl -nextupdate -noout -in $1 | sed -e s/=/\ / | awk '{print $2, $3, $5, $4}'`
        ExpireEpoch=`date "+%s" -u -d "$CRLExpires" -D "%b %d %Y %H:%M:%S"`
        TodayEpoch=`date "+%s" -u`

        day=$((60*60*24))
        ExpireOffsetEpoch=$(($ExpireEpoch - $WARNDAYS*$day))

        if [ $TodayEpoch -gt $ExpireOffsetEpoch ]; then
            echo "Nearing Expiry: $2 [CRL]"
            EXPIRING="$EXPIRING$2 [CRL]
"
        else
            echo "OK: $2 [CRL]"
        fi
    else
        INVALIDPATHS="$INVALIDPATHS$1
"
        echo "Invalid Path: $2 [$1]"
    fi

}