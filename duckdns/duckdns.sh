#!/bin/bash 

if [ -z "$TOKEN" ]
then
	echo "No TOKEN was set."
	exit 20
fi


if [ -z "$DOMAINS" ]
then
	echo "No domains set."
	exit 30
fi


if [ -n "$DETECTIP" ]
then
	IP=$(wget -qO- "http://myexternalip.com/raw")
fi


if [ -n "$DETECTIP" ] && [ -z $IP ]
then
	RESULT="Could not detect external IP."
fi


if [[ $INTERVAL != [0-9]* ]]
then
	echo "Interval is not an integer."
	exit 35
fi

USERAGENT="--user-agent=\"shell script/1.0 mail@mail.com\""

DDNSURL="https://www.duckdns.org/update?"

if [ -n "$DOMAINS" ]
then
	DDNSURL="${DDNSURL}domains=${DOMAINS}&"
fi

DDNSURL="${DDNSURL}token=$TOKEN&"

echo "Started $(date)"
echo "Update interval ${INTERVAL}m"

while :
do
	
	if [ -n "$DETECTIP" ]
	then
		IP=$(wget -qO- "http://myexternalip.com/raw")
	fi
	if [ -n "$DETECTIP" ] && [ -z $IP ]
	then
		RESULT="Could not detect external IP."
	fi
	
	if [ -n "$IP" ]
	then
		IPANDURL="${DDNSURL}ip=$IP&"
	fi
	
	IPANDURL=${IPANDURL%?}

	RESULT=$(wget --no-check-certificate -qO- $USERAGENT $IPANDURL)

	 
	echo "$(date): $RESULT"
	

	if [ $INTERVAL -eq 0 ]
	then
		break
	else
		sleep "${INTERVAL}m" 
	fi

done

exit 0
