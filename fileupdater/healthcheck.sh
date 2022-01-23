# Health Checker for File Updater
# Copyright © 2022 Stewart Cossey

pgrep -f update.sh > /dev/null
SCRIPT=$?

if [ $SCRIPT -eq 0 ]
then
    echo "OK"
    exit 0
else
    echo "SCRIPT NOT RUNNING"
    exit 1
fi