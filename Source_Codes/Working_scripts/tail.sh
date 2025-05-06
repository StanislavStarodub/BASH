#!/usr/bin/env bash
: ' 

Show last N lines in one or more files
Usage: ./tail.sh <-n N> <filename> [morefilenames]
N - number of lines to show 1-10; filename - name of a file 

'
declare -i COUNT=1 
if (( $# < 1 )); then
    while IFS= read -r LINE && ((COUNT <= 7)); do
        ((COUNT<3)) && { ((COUNT++)); continue; }
        echo "$LINE"
        ((COUNT++))
    done < "$0"
    exit 1
fi 

declare N
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
declare -i REC_NUM=0
declare -i CACHE_POS
FILES=($@)

if (( ${#FILES[@]} == 0 )); then
    echo "Reading from STDOUT"
    echo -e "Enter the text line by line as in a editor (enter EOF on a separate line for completion):\n"
    while IFS= read -r LINE; do
        [[ "$LINE" == "EOF" ]] && break
        [[ -z "$LINE" ]] && continue
        CACHE_POS=$(( REC_NUM % N ))
        LINES[$CACHE_POS]="$LINE" 
        (( REC_NUM++ ))
    done

    ACTUAL_LINES=$(( REC_NUM < N ? REC_NUM : N ))
    echo "Your last $N line(s) is(are): "
    for ((i=0; i<ACTUAL_LINES; i++)); do
        POS=$(( (REC_NUM - ACTUAL_LINES + i) % N ))
        echo "${LINES[$POS]}"
    done
fi

if (( ${#FILES[@]} == 1 )); then
   [[ ! -f "${FILES[0]}" ]] && { echo "Error, incorrect filename: ${FILES[0]}" >&2; exit 1; }
    echo "Reading from one file: ${FILES[0]}"
    while IFS= read -r LINE; do
        [[ -z "$LINE" ]] && continue
        CACHE_POS=$(( REC_NUM % N ))
        LINES[$CACHE_POS]="$LINE" 
        (( REC_NUM++ ))
    done < ${FILES[0]}

    ACTUAL_LINES=$(( REC_NUM < N ? REC_NUM : N ))
    echo "Your last $N line(s) is(are): "
    for ((i=0; i<ACTUAL_LINES; i++)); do
        POS=$(( (REC_NUM - ACTUAL_LINES + i) % N ))
        echo "${LINES[$POS]}"
    done
fi

if (( ${#FILES[@]} > 1 )); then
    for (( i=0; i<${#FILES[@]}; i++ )); do
        [[ ! -f "${FILES[i]}" ]] && { echo "Error, incorrect filename: ${FILES[i]} " >&2; exit 1; }
        echo "Reading from the file: ${FILES[i]}" >&2 

        while IFS= read -r LINE; do
            [[ -z "$LINE" ]] && continue
            CACHE_POS=$(( REC_NUM % N ))
            LINES[$CACHE_POS]="$LINE" 
            (( REC_NUM++ ))
       done < ${FILES[i]}

        ACTUAL_LINES=$(( REC_NUM < N ? REC_NUM : N ))
        echo "Your last $N line(s) is(are): "
        for ((k=0; k<ACTUAL_LINES; k++)); do
            POS=$(( (REC_NUM - ACTUAL_LINES + k) % N ))
            echo "${LINES[$POS]}"
        done
        REC_NUM=0
        LINES=()
        echo
    done
fi
