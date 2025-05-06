#!/usr/bin/env bash

function ABS()
{
if [[ "$1" =~ ^-?[0-9]+$ ]]; then

    if [[ $1 -lt 0 ]] ;then 
        ABS=$((-1*$1))
    else 
        ABS=$1
    fi
    echo "ABS of <VAR> $1 is $ABS"
else
    echo "<$1> isn't a number!"; exit 1
fi
}

