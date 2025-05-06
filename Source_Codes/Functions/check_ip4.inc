#!/usr/bin/env bash

function CHECK_IP4()
{
read -a OCTS <<< "${1//./ }"
declare WRONG="Your IP address is incorrect!"
declare -i FINE=0

for O in ${OCTS[@]}; do
    !(( 10#${O} >= 0 && 10#${O} <= 255 )) && { echo $WRONG; exit 1; }
    [[ 10#${O:0:1} -eq 0 && ${#O} -ne 1 ]] && { echo $WRONG; exit 1; }
    ((FINE++))
done
!(( $FINE == 4 )) && { echo $WRONG; exit 1; }
echo "Your IP address is CORRECT!"
}
