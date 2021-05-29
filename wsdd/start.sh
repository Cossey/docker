#!/bin/bash
params=""

if [ -n "$HOST_NAME" ]; then
    if [[ ! $HOST_NAME =~ ^[a-zA-Z0-9]([a-zA-Z0-9-]{0,62})?[a-zA-Z0-9]$ ]]; then
        echo "Invalid host name!"
        exit 10
    else
        params+="-n ${HOST_NAME} "
    fi
fi

if [ -n "$WORKGROUP" ]; then
    if [[ ! $WORKGROUP =~ ^[a-zA-Z0-9\ ]{1,15}$ ]]; then
        echo "Invalid workgroup name!"
        exit 15
    else
        params+="-w ${WORKGROUP} "
    fi
fi

if [ -n "$DOMAIN" ]; then
    if [[ ! $DOMAIN =~ ^[a-zA-Z0-9\ ]{1,15}$ ]]; then
        echo "Invalid domain name!"
        exit 15
    else
        params+="-d ${DOMAIN} "
    fi
fi

if [ -n "$PRESERVE_CASE" ]; then
    params+="-p "
fi

if [ -n "$NO_HTTP" ]; then
    params+="-t "
fi

if [ -n "$NO_SERVER" ]; then
    params+="-o "
fi

if [ -n "$IP4_ONLY" ]; then
    params+="-4 "
fi

if [ -n "$IP6_ONLY" ]; then
    params+="-6 "
fi

if [ -n "$HOP_LIMIT" ]; then
    if [[ ! $HOP_LIMIT =~ [0-9]* ]]; then
        echo "The Hop Limit is not an integer!"
        exit 20
    else
        params+="-H $HOP_LIMIT "
    fi
fi

if [ -n "$DISCOVERY_MODE" ]; then
    params+="-D "
fi

if [ -n "$UUID" ]; then
    if [[ ! $UUID =~ ^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-5[a-fA-F0-9]{3}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$ ]]; then
        echo "The UUID is not valid!"
        exit 30
    else
        params+="-U $UUID "
    fi
fi

echo "Running WSDD..."
python3 ./wsdd.py -v $params
