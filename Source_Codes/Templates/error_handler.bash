#!/usr/bin/env bash

declare PROGNAME="${0##*/}"

function error_exit()
{
    local error_message="$1"
    printf "\n%s\n" "${PROGNAME}: ${error_message:-"Unknown Error"}" 1>&2
    exit 1
}
# usage example:
# ls /bugs &>/dev/null || error_exit "ls /bugs failed in line $LINENO" 
