IFS="|";

if [ -z "$INTERVAL" ]
then
	INTERVAL=0
fi

if [ -z "$URL1" ]
then
	echo "No URLS Found!"
	exit 1
fi

if [ -z "$NAME1" ]
then
	echo "No Names Found!"
	exit 2
fi

if [ -z "$OUTPUTPATH" ] 
then
	OUTPUTPATH=/fileoutput
fi
echo "Output path: $OUTPUTPATH"
	
CPARA=""
if [ "$IGNORESSL" = "true" ]
then
	CPARA=(-k)
	echo "SSL: Ignore invalid certificates"
else 
	if [ ! -z "$CACERT" ] 
	then
		echo "SSL: Use certificate authority ${CACERT}"
		CPARA=(--cacert ${CACERT})
	fi
fi
echo "--------------------"
while :
do
	echo "$(date)"

	c=1
	while :
	do
		URLVAL=URL$c
        NAMEVAL=NAME$c
		if [ -z "${!URLVAL}" ]
		then
			break
		fi

		echo "Download ${!NAMEVAL}: ${!URLVAL}"
		curl -sS ${CPARA[@]} "${!URLVAL}" --output ${OUTPUTPATH}/${!NAMEVAL}

		((c++))
	done
	
	echo "--------------------"
	if [ $INTERVAL -eq 0 ]
	then
		break
	else
		sleep "${INTERVAL}m" 
	fi
done