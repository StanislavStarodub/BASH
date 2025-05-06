#!/usr/bin/env bash

function SIGN()
{
if [[ "$1" =~ ^-?[0-9]+$ ]]; then
    if [[ $1 -gt 0 ]]; then 
        echo "The sign of the value <$1> is '+'"
    elif [[ $1 -lt 0 ]]; then
        echo "The sign of the value <$1> is '-'"        
    else 
        echo "The value is zero and it has no a sign"     
    fi
else
    echo "<$1> isn't a number!"; exit 1
fi
}
