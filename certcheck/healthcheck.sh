
pgrep -f check-certs.sh > /dev/null
SCRIPT=$?


if [ $SCRIPT -eq 0 ]
then
    echo "OK"
    exit 0
else
    if [ $SCRIPT -eq 1 ]
    then
        echo "SCRIPT NOT RUNNING"
        exit 1
    fi
fi