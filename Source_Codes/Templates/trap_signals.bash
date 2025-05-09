#!/usr/bin/env bash

declare -a SIGS=(SIGINT SIGQUIT SIGHUP)
declare PROGNAME="${0##*/}"
# declare FILENAME="$(mktemp /tmp/"$PROGNAME".$$.XXXXXXXXX)" # you can write the RANDOM command instead of the nine X characters
declare FILENAME=""

if [ -d "~/tmp" ]; then
  TEMP_DIR=~/tmp
else
  TEMP_DIR=/tmp
fi
FILENAME="$TEMP_DIR/$PROGNAME.$$.$RANDOM"


function ON_EXIT()
{
echo
cat "$FILENAME"
rm "$FILENAME"
ls "$FILENAME"
}

trap 'exit' "${SIGS[@]}"
trap 'ON_EXIT' EXIT

#trap 'ON_EXIT; exit' SIGINT SIGQUIT SIGHUP
echo "Echo trap -p"
trap -p
echo "--------------------------"
echo "Echo trap"
trap

for i in {1..10}; do
    ((i==2)) && echo "Press Ctrl-C"
    printf "%s\n" $i >>"$FILENAME"
    sleep 1
done

# OTHER EXAMPLE


# Trap signals
trap "signal_exit TERM" TERM HUP
trap "signal_exit INT"  INT

function error_exit()
{
    local error_message="$1"
    printf "\n%s\n" "${PROGNAME}: ${error_message:-"Unknown Error"}" 1>&2
    exit 1
}

function graceful_exit()
{
    exit
}

signal_exit() { # Handle trapped signals

  local signal="$1"

  case "$signal" in
    INT)
      error_exit "Program interrupted by user"
      ;;
    TERM)
      printf "\n%s\n" "$PROGNAME: Program terminated" >&2
      graceful_exit
      ;;
    *)
      error_exit "$PROGNAME: Terminating on unknown signal"
      ;;
  esac
}

