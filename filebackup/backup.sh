# Backup Tool
# Copyright © 2023 Stewart Cossey
# Version: 1.0

. ./library.sh

file_env "INTERVAL" 0

file_env "PATH1"
file_env "OUTPUTPATH" "/output"
file_env "OUTPUTFILE" "backup.tar.gz"
file_env "POSTSCRIPT"
file_env "TEMPPATH" "/temp"
file_env "BEGIN" dfmt=%H%M

validate_env "PATH1" req

log "Output path is $OUTPUTPATH"

CPARA=""
if [ ! -d "$TEMPPATH" ]; then
	log "Creating temp path $TEMPPATH"
	mkdir -p "$TEMPPATH"
fi
cd $TEMPPATH
if [ ! -d "$OUTPUTPATH" ]; then
	log "Creating output path $OUTPUTPATH"
	mkdir -p "$OUTPUTPATH"
fi

if [ -z "$BEGIN" ]; then
  log "Waiting to begin, Start at $BEGIN"
  while [ "$(date +"%H%M")" != "$BEGIN" ]; do
    sleep "5s"
  done
fi
log "-----------------------------------"
while :; do
	log "Starting"
	time {
		TIMEFORMAT=$(log "Completed in %R seconds")
		c=1
		while :; do
			PATHVAL=PATH$c
			DESTVAL=DEST$c
			file_env $PATHVAL
			file_env $DESTVAL

			if [ -z "${!PATHVAL}" ]; then
				break
			fi

			log "Copy ${!PATHVAL}"
			time {
				if [ -z "${!DESTVAL}" ]; then
					cp -R ${!PATHVAL} .
				else
					mkdir -p "${!DESTVAL}"
					cp -R ${!PATHVAL} ${!DESTVAL}
				fi
			}

			((c++))
		done
		log "-----------------------------------"
		TIMEFORMAT=$(log "Completed in %R seconds")
	}
	if [ -f "$OUTPUTPATH/$OUTPUTFILE" ]; then
		log "Deleting old backup"
		rm $OUTPUTPATH/$OUTPUTFILE
	fi 
	log "Compressing to file" 
	tar -zcf $OUTPUTPATH/$OUTPUTFILE *
	log "Cleaning temp folder"
	rm -rf *

	if [ -n "$POSTSCRIPT" ]; then
		log "Running post script"
		export OUTPUTPATH
		export OUTPUTFILE
		source $POSTSCRIPT
	fi

	if [ $INTERVAL -eq 0 ]; then
		break
	else
		log "Waiting for ${INTERVAL} minutes..."
		log "-----------------------------------"
		sleep "${INTERVAL}m"
	fi

done
