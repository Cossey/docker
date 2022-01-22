#!/bin/bash 

# DuckDNS API Updater
# Copyright © 2022 Stewart Cossey
# Version: 1.1

. ./library.sh

file_env "TOKEN"
file_env "DOMAINS"
file_env "INTERVAL"
file_env "IP"
file_env "IP6"

validate_env "TOKEN" "req"
validate_env "DOMAINS" "req"
validate_env "INTERVAL" "int"
validate_env "IP" "ip4"

if [ -n "$DOMAINS" ]
then
	DDNSURL="${DDNSURL}domains=${DOMAINS}&"
fi

USERAGENT="--user-agent=\"duckdns shell script/1.1 mail@mail.com\""
IP6DETECTURL="http://ip6only.me/api/"
DDNSURL="https://www.duckdns.org/update?"
DDNSURL="${DDNSURL}token=$TOKEN&domains=$DOMAINS&"

log "Started"

if [ -n "$INTERVAL" ] && [ "$INTERVAL" -ne 0 ]
then
	log "Update interval ${INTERVAL}m"
fi

while :
do

	IPANDURL="$DDNSURL"

	if [ -n "$IP" ]
	then
		IPANDURL="${IPANDURL}ip=$IP&"
	fi

	if [ -n "$IP6" ]
	then
		IPANDURL="${IPANDURL}ipv6=$IP6&"
	else
		# Get IPv6
		AUTOIP6=$(wget -T 5 -t 2 -qO- $USERAGENT $IP6DETECTURL)

		if [ -n "$AUTOIP6" ]
		then
			readarray -d ',' -t <<<$AUTOIP6
			IPANDURL="${IPANDURL}ipv6=${MAPFILE[1]}&"
		else
			log "Cannot get IPv6 address"
		fi
	fi

	IPANDURL="${IPANDURL}verbose=true&"
	IPANDURL=${IPANDURL%?}


	WGETRESULT=$(wget -t 2 -qO- $USERAGENT $IPANDURL)

	readarray -t <<<$WGETRESULT

	if [ "${MAPFILE[0]}" == "OK" ]
	then
		if [ "${MAPFILE[3]}" == "NOCHANGE" ]
		then
			log "No change to IP address"
		else
			log "IP address updated"
		fi
	else
		log "Error updating, check settings"
		exit 1
	fi

	if [ -z "$INTERVAL" ] || [ "$INTERVAL" -eq 0 ]
	then
		break
	else
		sleep "${INTERVAL}m" 
	fi

done

exit 0
