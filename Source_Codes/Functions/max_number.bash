#!/usr/bin/env bash

source ./convert_param_to_array.bash

# function of finding the maximum among all given numbers
function max() 
{
    local -i max=0
    local -a array_ref=()

    array_ref=($(convert_param_to_array "$@"))
    for num in "${array_ref[@]}"; do
        if (( num > max )); then
            max="$num"
        fi
    done
echo "$max"
}
