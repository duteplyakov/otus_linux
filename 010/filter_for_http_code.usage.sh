#!/bin/sh
# file: filter_for_http_code.usage.sh
# usage: ./filter_for_http_code.usage.sh ./access-4560-644067.log
. ./filter_for_http_code.sh

# Проверка на переданный параметр
USAGE="SYNOPSIS: filter_for_ip.usage.sh LOG_FILE"
if [ -z "$1" ]
then
    echo "Sorry, there is no first parameter LOG_FILE. "
    echo $USAGE
    exit 1
fi

LOG_FILE="${1}"

. ./get_hour.sh
AT_HOUR=$(get_hour)
DEBUG=true
if $DEBUG
then
  echo "GET DATA OF HOUR" $AT_HOUR
fi

echo 'FILTER FOR HTTP-CODES:'
get_data_at_hour | filter_for_http_code

exit 0