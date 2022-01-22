nslookup www.duckdns.org > /dev/null
NSLOOKUP=$?

pgrep -f duckdns.sh > /dev/null
SCRIPT=$?


if [ $NSLOOKUP -eq 0 ] && [ $SCRIPT -eq 0 ]
then
    echo "OK"
    exit 0
else
    if [ $NSLOOKUP -eq 1 ]
    then
        echo "CANNOT RESOLVE DUCKDNS"
        exit 1
    fi
    if [ $SCRIPT -eq 1 ]
    then
        echo "SCRIPT NOT RUNNING"
        exit 2
    fi
fi