#!/bin/bash
# Common entrypoint function library.

# Environment variable reading function
# The function enables reading environment variable from file.
#
# usage: file_env VAR [DEFAULT]
#    ie: file_env 'XYZ_DB_PASSWORD' 'example'
# (will allow for "$XYZ_DB_PASSWORD_FILE" to fill in the value of
#  "$XYZ_DB_PASSWORD" from a file, especially for Docker's secrets feature
function file_env() {
  local var="$1"
  local fileVar="${var}_FILE"
  local def="${2:-}"
  if [ "${!var:-}" ] && [ "${!fileVar:-}" ]; then
    echo >&2 "error: both $var and $fileVar are set (but are exclusive)"
    exit 1
  fi
  local val="$def"
  if [ "${!var:-}" ]; then
    val="${!var}"
  elif [ "${!fileVar:-}" ]; then
    val="$(<"${!fileVar}")"
  fi
  export "$var"="$val"
  unset "$fileVar"
}

# Validate environment variable
# Validates the environment variable to make sure it matches expected input.
function validate_env() {
  local var="$1"
  local types=$(echo $2 | tr "," "\n")

  for type in $types; do
    local cmd=$(echo $type | cut -d= -f1)
    case "$cmd" in
    "req")
      if [ -z "${!var}" ]; then
        echo "Environment variable $var is required"
        exit -1
      fi
      ;;
    "int")
      if [ -n "${!var:-}" ] && [[ ${!var:-} != [0-9]* ]]; then
        echo "Environment variable $var must be an integer"
        exit -2
      fi
      ;;
    "dfmt")
      local param=$(echo $type | cut -d= -f2)
      if [ -n "${!var:-}" ] && ! date -d "${!var}" +"${param}" >/dev/null 2>&1; then
        echo "Environment variable $var must be a date format ${param}"
        exit -3
      elif [ -n "${!var:-}" ]; then
        export "$var"=$(date -d "${!var}" +"${param}")
      fi
      ;;
    "bool")
      if [ -n "${!var:-}" ] && [[ ${!var:-} != "true" && ${!var:-} != "false" ]]; then
        echo "Environment variable $var must be a boolean"
        exit -4
      fi
      ;;
    "ip4")
      ipre="^((2([0-4][0-9]|5[0-5])|[0-1]?[0-9]?[0-9])\.){3}((2([0-4][0-9]|5[0-5])|[0-1]?[0-9]?[0-9]))$"
      if [ -n "${!var:-}" ] && ! [[ ${!var:-} =~ $ipre ]]; then
        echo "Environment variable $var must be an IPv4 address"
        exit -5
      fi
    esac
  done
}

log () {
	echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}