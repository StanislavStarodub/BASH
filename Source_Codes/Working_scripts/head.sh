#!/usr/bin/env bash
: ' 

Show first N lines in one or more files
Usage: ./head.sh <-n N> <filename> [morefilenames]
N - number of lines to show 1-10; filename - name of a file 

'
declare -i COUNT=1 N

if (( $# < 1 )); then
    while IFS= read -r LINE && ((COUNT <= 7)); do
        ((COUNT<3)) && { ((COUNT++)); continue; }
        echo "$LINE"
        ((COUNT++))
    done < "$0"
  exit 1
fi

if [[ "$1" =~ ^-n([-0-9]+)$ ]]; then
    N="${1#-n}"
    shift
elif [[ "$1" == "-n" && $# -ge 2 && "$2" =~ ^-?[0-9]+$ ]]; then
    N="$2"
    shift 2
else
    echo "An error, incomplete parameter <$1>" >&2; exit 1
fi
if (( N <= 0 )); then
   echo "Warning: Number of lines must be positive, setting to 1" >&2
   N=1
fi

declare -a LINES=() FILES=()
declare LINE
FILES=("$@")

: '
# This part of code only for checking
echo "Verification of parameters by numbers"
echo N=$N
for (( i=0; i<${#FILES[@]}; i++ )); do
    echo "$i - ${FILES[i]}"
done
echo
# end part
'

if (( ${#FILES[@]} == 0 )); then
    echo "Reading from STDOUT"
    echo -e "Enter the text line by line as in a editor (enter EOF on a separate line for completion):\n"
    while IFS= read -r LINE; do
        [[ "$LINE" == "EOF" ]] && break
        [[ -z "$LINE" ]] && continue
        LINES+=("$LINE") 
    done
    echo "Your $N line(s) is(are): "
    for ((i=0; i<$N && i<${#LINES[@]}; i++ )); do
        echo "${LINES[i]}"
    done
fi


if (( ${#FILES[@]} == 1 )); then
   [[ ! -f "${FILES[0]}" ]] && { echo "Error, incorrect filename: ${FILES[0]}" >&2; exit 1; }
    echo "Reading from one file: ${FILES[0]}"
    echo "Your $N line(s) is(are): "
    while IFS= read -r LINE && ((COUNT <= N)); do
        echo "$LINE"
        ((COUNT++))
    done < "${FILES[0]}"
fi

if ((  ${#FILES[@]} > 1 )); then
    for (( i=0; i<${#FILES[@]}; i++ )); do
        [[ ! -f "${FILES[i]}" ]] && { echo "Error, incorrect filename: ${FILES[i]} " >&2; exit 1; }
        echo "Reading from the file: ${FILES[i]}" >&2 
        echo "Your $N line(s) is(are): "
        COUNT=1
        while IFS= read -r LINE && ((COUNT <= N)); do
            echo "$LINE"
            ((COUNT++))
        done < "${FILES[i]}"
        echo
    done
fi
