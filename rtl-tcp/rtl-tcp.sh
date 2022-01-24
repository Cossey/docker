#!/bin/bash

# RTL TCP Entrypoint script
# Copyright (C) 2022 Stewart Cossey

. ./library.sh

extraparams=""

file_env "DEVICE"
file_env "GAIN"
file_env "BUFFERS"
file_env "LIST_BUFFERS"
file_env "PPM_ERROR"
file_env "FREQUENCY"
file_env "SAMPLE_RATE"
file_env "BIAS_T"

validate_env "DEVICE" int
validate_env "GAIN" int
validate_env "BUFFERS" int
validate_env "LIST_BUFFERS" int
validate_env "PPM_ERROR" int
validate_env "FREQUENCY" int
validate_env "SAMPLE_RATE" int
validate_env "BIAS_T" bool

if [ -n "$DEVICE" ]
then
    echo "Using device index ${DEVICE}"
    extraparams+="-d ${DEVICE} "
fi

if [ -n "$GAIN" ]
then
    echo "Using gain ${GAIN}"
    extraparams+="-g ${GAIN} "
fi

if [ -n "$BUFFERS" ]
then
    echo "Using ${BUFFERS} buffers"
    extraparams+="-b ${BUFFERS} "
fi

if [ -n "$LIST_BUFFERS" ]
then
    echo "Using ${LIST_BUFFERS} max linked list buffers"
    extraparams+="-n ${LIST_BUFFERS} "
fi

if [ -n "$PPM_ERROR" ]
then
    echo "Using ppm ${PPM_ERROR}"
    extraparams+="-P ${PPM_ERROR} "
fi

if [ -n "$FREQUENCY" ]
then
    echo "Using frequency ${FREQUENCY}"
    extraparams+="-f ${FREQUENCY} "
fi

if [ -n "$SAMPLE_RATE" ]
then
    echo "Using sample rate ${SAMPLE_RATE}"
    extraparams+="-s ${SAMPLE_RATE} "
fi

if [ -n "$BIAS_T" ] && [ "$BIAS_T" == "true" ]
then
    echo "Using bias-T"
    extraparams+="-T "
fi

rtl_tcp -a ${LISTEN_IP:-$(hostname -i)} $extraparams
