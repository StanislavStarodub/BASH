#!/usr/bin/env bash

source ./convert_param_to_array.bash

# function of finding the minimum among all given numbers
function min() 
{
    local -i min=$((10**10))
    local -a array_ref=()

    array_ref=($(convert_param_to_array "$@"))
    for num in "${array_ref[@]}"; do
        if (( num < min )); then
            min="$num"
        fi
    done
echo "$min"
}
