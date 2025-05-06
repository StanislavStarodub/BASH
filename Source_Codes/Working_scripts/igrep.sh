#!/usr/bin/env bash
: ' 

Find a case-insensitive "text" pattern in given file(s)
Usage: ./grep.sh <text> <filename> [morefilenames]

'
! [[ $# -ge 2 ]] && { head -6 $0 | tail -4 >&2; exit 1 ; } 

declare LINE
declare -i COUNT=1

set -- "$@"
declare PATTERN="${1@U}"

# This part of code only for checking
echo "Verification of parameters by numbers"
for (( i=1; i<=${#@}; i++ )); do
    echo "$i - ${@:i:1}"
done
echo
# end part


if (( ${#@} == 2 )); then
   [[ ! -f "$2" ]] && { echo "Error, incorrect filename" >&2; exit 1; }
    echo "Searching in the file: $2"
    while IFS= read -r LINE; do
        if [[ "${LINE@U}" =~ "$PATTERN" ]]; then
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
            if [[ "${LINE@U}" =~ "$PATTERN" ]]; then
                echo "${@:i:1}: the pattern <$1> was found in line $COUNT - $LINE"
            fi
            ((COUNT++))
        done < "${@:i:1}"
        echo
    done 
fi
