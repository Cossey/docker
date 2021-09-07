. ./library.sh

file_env "INTERVAL" 0

file_env "URL1"
file_env "OUTPUTPATH" "/fileoutput"
file_env "IGNORESSL"
file_env "CACERT"
file_env "BEGIN" dfmt=%H%M

validate_env "URL1" req
validate_env "IGNORESSL" bool

echo "Output path: $OUTPUTPATH"

CPARA=""
if [ "$IGNORESSL" = "true" ]; then
	CPARA=(-k)
	echo "Ignore invalid SSL certificates"
else
	if [ -n "$CACERT" ]; then
		echo "Use certificate authority ${CACERT}"
		CPARA=(--cacert ${CACERT})
	fi
fi

if [ ! -d "$OUTPUTPATH" ]; then
	mkdir -p "$OUTPUTPATH"
fi
cd $OUTPUTPATH

if [ -z "$BEGIN" ]; then
  echo "Waiting to begin, Start at $BEGIN, currently $(date +"%H%M")"
  while [ "$(date +"%H%M")" != "$BEGIN" ]; do
    sleep "5s"
  done
fi
echo "--------------------"
while :; do
	echo "$(date)"

	c=1
	while :; do
		URLVAL=URL$c
		NAMEVAL=NAME$c
		file_env $URLVAL
		file_env $NAMEVAL

		if [ -z "${!URLVAL}" ]; then
			break
		fi

		echo "Download ${!URLVAL}"
		if [ -z "${!NAMEVAL}" ]; then
			curl -sS ${CPARA[@]} "${!URLVAL}" --remote-name
		else
			curl -sS ${CPARA[@]} "${!URLVAL}" --output ${!NAMEVAL}
		fi

		((c++))
	done

	echo "--------------------"
	if [ $INTERVAL -eq 0 ]; then
		break
	else
		sleep "${INTERVAL}m"
	fi
done
