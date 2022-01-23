# File Updater
# Copyright © 2022 Stewart Cossey
# Version: 1.3

. ./library.sh

file_env "INTERVAL" 0

file_env "URL1"
file_env "OUTPUTPATH" "/fileoutput"
file_env "IGNORESSL"
file_env "CACERT"
file_env "BEGIN" dfmt=%H%M

validate_env "URL1" req
validate_env "IGNORESSL" bool

log "Output path is $OUTPUTPATH"

CPARA=""
if [ "$IGNORESSL" = "true" ]; then
	CPARA=(-k)
	log "Ignore invalid SSL certificates"
else
	if [ -n "$CACERT" ]; then
		log "Use certificate authority ${CACERT}"
		CPARA=(--cacert ${CACERT})
	fi
fi

if [ ! -d "$OUTPUTPATH" ]; then
	mkdir -p "$OUTPUTPATH"
fi
cd $OUTPUTPATH

if [ -z "$BEGIN" ]; then
  log "Waiting to begin, Start at $BEGIN"
  while [ "$(date +"%H%M")" != "$BEGIN" ]; do
    sleep "5s"
  done
fi
log "-----------------------------------"
while :; do
	
	time {
		TIMEFORMAT=$(log "Completed in %R seconds")
		c=1
		while :; do
			URLVAL=URL$c
			NAMEVAL=NAME$c
			file_env $URLVAL
			file_env $NAMEVAL

			if [ -z "${!URLVAL}" ]; then
				break
			fi

			log "Download ${!URLVAL}"
			time {
				if [ -z "${!NAMEVAL}" ]; then
					curl -sS ${CPARA[@]} "${!URLVAL}" --remote-name
				else
					curl -sS ${CPARA[@]} "${!URLVAL}" --output ${!NAMEVAL}
				fi
			}

			((c++))
		done
		log "-----------------------------------"
		TIMEFORMAT=$(log "Cycle took %R seconds to complete")
	}

	log "-----------------------------------"
	if [ $INTERVAL -eq 0 ]; then
		break
	else
		sleep "${INTERVAL}m"
	fi
done
