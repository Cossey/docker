#!/bin/bash

. /library.sh

file_env "USERNAME"
file_env "PASSWORD"
file_env "SESSION"
file_env "INTERVAL"
file_env "MEGACMD"
file_env "BEGIN"

# validate input
validate_env "INTERVAL" int
validate_env "BEGIN" int,dfmt=%H%M

# set interval to one day if begin delay set and interval not set
if [ -n "$BEGIN" ] && [ -z "$INTERVAL" ]; then
  INTERVAL=1440
fi

# require username and password OR session
if [ -z "$SESSION" ]; then
  validate_env "USERNAME" req
  validate_env "PASSWORD" req
else
  validate_env "SESSION" req
fi

validate_env "MEGACMD" req

bash -c "nohup tail -f /root/.megaCmd/megacmdserver.log >&0 2>1" &

# wait for the begin time
if [ -n "$BEGIN" ]; then
  echo "Waiting to begin, Start at $BEGIN, currently $(date +"%H%M")"
  while [ "$(date +"%H%M")" != "$BEGIN" ]; do
    sleep "5s"
  done
fi

# login with username and password or session
if [ -z "$SESSION" ]; then
  mega-login $USERNAME $PASSWORD
else
  mega-login $SESSION
fi

#add mega- prefix if not provided
if [[ ! $MEGACMD =~ ^mega ]]; then
  MEGACMD="mega-$MEGACMD"
fi

while :; do
  echo "Running $(date)"
  if [[ "$MEGACMD" == *"mega-sync"* ]]; then
    # specific to mega-cmd because not interactive ...
    echo "specific actions for mega-sync"
    not_sync="false"
    $MEGACMD
    sleep 10
    while [ $not_sync == "false" ]; do
      mega-sync
      if mega-sync | grep -iq "Synced"; then
        not_sync="true"
        echo "Sync end"
      fi
      echo "$not_sync"
      sleep 2
    done
  else
    $MEGACMD
  fi

  # run delete versions if DV set
  if [[ -n "$DV" ]]; then
    echo "Running delete versions..."
    mega-deleteversions -f $DV
  fi

  if [[ -z "$INTERVAL" ]] || [ $INTERVAL -eq 0 ]; then
    exit $?
  else
    echo "Waiting for $INTERVAL minutes..."
    sleep "${INTERVAL}m"
  fi

done
/bin/bash $@
