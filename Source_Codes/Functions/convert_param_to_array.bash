#!/usr/bin/env bash
function convert_param_to_array() {
    local -a result=()

    # Check for at least one parameter
    [[ "$#" -lt 1 ]] && { echo "Invalid input. Expected at least one parameter. Exit!" >&2; return 1; }

    if [[ "$#" -eq 1 ]]; then
        # Single parameter case
        if [[ "$1" =~ ^[0-9]+$ ]]; then
            # Case: single numeric value or string of digits (e.g., "12345")
            local param="$1"
            if [[ ${#param} -gt 1 ]]; then
                # String of numbers (split into digits)
                for (( i=0; i<"${#param}"; i++ )); do
                    result+=("${param:$i:1}")
                done
            else
                # Single number
                result=("$param")
            fi
        elif [[ "$(declare -p "$1" 2>/dev/null)" =~ "declare -a" ]]; then
              # Case: parameter is an array
              declare -n array_ref="$1"
              result=("${array_ref[@]}")
        else
                echo "Invalid input. Expected a numeric value, numeric string, or an array. Exit!" >&2
                return 1
        fi
    else
        # Multiple parameters case
        for param in "$@"; do
            if [[ ! "$param" =~ ^[0-9]+$ ]]; then
                echo "Invalid input. All parameters should be numeric values. Exit!" >&2
                return 1
            fi
            result+=("$param")
        done
    fi

    # Return the array as a space-separated string
    echo "${result[@]}"
}
