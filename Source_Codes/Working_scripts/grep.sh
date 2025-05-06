#!/usr/bin/env bash
: ' 

Find a case sensitive "text" pattern in given file(s)
Usage: ./grep.sh <text> <filename> [morefilenames]

'
declare -i COUNT=1

if (( $# <= 1 )); then
    while IFS= read -r LINE && ((COUNT <= 6)); do
        ((COUNT<3)) && { ((COUNT++)); continue; }
        echo "$LINE"
        ((COUNT++))
    done < "$0"
    exit 1
fi 

set -- "$@"

declare LINE
if (( ${#@} == 2 )); then
   [[ ! -f "$2" ]] && { echo "Error, incorrect filename: $2" >&2; exit 1; }
    echo "Searching in the file: $2"
    COUNT=1
    while IFS= read -r LINE; do
        if [[ "$LINE" =~ "$1" ]]; then
            echo "$2: the pattern <$1> was found in line $COUNT - $LINE"
        fi
        ((COUNT++))
    done < "$2"
fi

if (( ${#@} > 2 )); then
    for (( i=2; i<=${#@}; i++ )); do
        [[ ! -f "${@:i:1}" ]] && { echo "Error, incorrect filename: ${@:i:1}" >&2; exit 1; }
        echo "Searching in the file: ${@:i:1}"
        COUNT=1 
        while IFS= read -r LINE; do
            if [[ "$LINE" =~ "$1" ]]; then
                echo "${@:i:1}: the pattern <$1> was found in line $COUNT - $LINE"
            fi
            ((COUNT++))
        done < "${@:i:1}"
        echo
    done 
fi
