#!/usr/bin/env bash

source ./convert_param_to_array.bash

# function of summing all parameters
function sum() 
{
    local -i sum=0
    local -a array_ref=()

    array_ref=($(convert_param_to_array "$@"))
    for num in "${array_ref[@]}"; do
        (( sum += num ))
    done
echo "$sum"
}
