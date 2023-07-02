# Health Checker for File Backup
# Copyright © 2023 Stewart Cossey

pgrep -f backup.sh > /dev/null
SCRIPT=$?

if [ $SCRIPT -eq 0 ]
then
    echo "OK"
    exit 0
else
    echo "SCRIPT NOT RUNNING"
    exit 1
fi