#!/usr/bin/env bash
# Script to generate Pythagoras multiplication table (default 1-10, but you can specify any range of numbers) as a table to html file


function help()
{
    printf "\n%s\n\n" "Create the Pythagoras table and write it as a html-table to a html file"
    printf "%s\n\n" "Usage: $0 <filename.html> [START] [END]"
    printf "%s\n" "Here:"
    printf "\t%s\n\n" "filename.html is your name of file for saving the table. It's a mandatory parameter"
    printf "\t%s\n\n" "START is the first number for the table"
    printf "\t%s\n" "END is the last number for the table"
    exit 1
}

function parameters_handler()
{
    set -- "$@"

    case "$#" in
        0) help
            ;;

        1) export FILENAME="$1"
           export START=1
           export END=10
            ;;

        2) export FILENAME="$1"
           local S_LOCAL="$2"
           local E_LOCAL=10
           if ! [[ "$S_LOCAL" =~ ^[0-9]+$ ]]; then
               help
           fi
           if (( S_LOCAL > E_LOCAL )); then 
               TEMP="$E_LOCAL"
               export END="$S_LOCAL"
               export START="$TEMP"
           else
               export START="$S_LOCAL"
               export END="$E_LOCAL"
           fi
           ;;

        3) export FILENAME="$1"
           local S_LOCAL="$2"
           local E_LOCAL="$3"
           if ! [[  "$S_LOCAL" =~ ^[0-9]+$ ]] || ! [[ "$E_LOCAL" =~ ^[0-9]+$ ]]; then
               help
           fi
           if (( S_LOCAL > E_LOCAL )); then 
               TEMP="$E_LOCAL"
               export END="$S_LOCAL"
               export START="$TEMP"
           else
               export START="$S_LOCAL"
               export END="$E_LOCAL"
           fi
           ;;

       *) help
           ;;
   esac

}

function pythagor()
{

    local -i S="$START"
    local -i N="$END"
    local -i NMAX=$(( N * N ))
    export TITLE="The Pythagoras table"
    printf "%s\n" "<caption>$TITLE</caption>"
    printf "%s\n%s" "<tr>" "<td>X</td>"

    for (( i=$S; i<=$N; i++ )); do
        printf "%s%i%s" "<td>" "$i" "</td>"
        if (( i == $N )); then
            printf "\n%s" "</tr>"
        fi
    done


    for (( i=$S; i<=$N; i++ )); do
        printf "\n%s" "<tr>"
        printf "%s%i%s" "<td>" "$i" "</td>"
        for (( j=$S; j<=$N; j++ )); do
            printf "%s%i%s" "<td>" "$(( i * j ))" "</td>"
            if (( j == $N )); then
                printf "\n%s" "</tr>"
            fi
        done
    done
}


function file_init()
{
    :> "$FILENAME"
    exec 3>&1
    exec 1>"$FILENAME"
    printf "%s" "
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">"
    printf "%s" "<title>$TITLE</title>"
    printf "%s" "
      <style>
        body {font-family: monospace;white-space:pre;}
        h2   {color: blue;}
        table, th, td {
                       color: green;
                       border: 2px solid black;
                       border-collapse: collapse;
                       white-space:pre;
        }
        td {text-align: center;}
      </style>
    </head>
    <body>
    <h1>The Exam, number 3</h1>
    <table>
    "
}

function file_close()
{ 
    printf "\n%s\n%s\n%s" "</table>" "</body>" "</html>"
    exec 1>&3
    exec 3>&-
}


function main()
{
	file_init > "$FILENAME"
	pythagor >> "$FILENAME"
	file_close >> "$FILENAME"
    return 0
}
    parameters_handler "$@"
    main
    less "$FILENAME"
