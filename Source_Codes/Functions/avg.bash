#!/usr/bin/env bash
source ./sum.bash

source ./convert_param_to_array.bash

# function of numbers averaging 
function average() 
{
    local -i total_sum=0 count=0 average_value=0
    local -a array_ref=()

    array_ref=($(convert_param_to_array "$@"))
    total_sum=$(sum "${array_ref[@]}")
    count="${#array_ref[@]}"
    average_value=$(( total_sum / count ))
echo "$average_value"
}
