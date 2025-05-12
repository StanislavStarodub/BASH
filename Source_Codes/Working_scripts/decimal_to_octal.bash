#!/usr/bin/env bash

declare PROGNAME="${0##*/}"
declare DEC_NUM=$(printf '%(%Y)T')

function usage()
{
  printf "\n%s\n" "Convert a decimal number to the octal one"
  printf "%s\n" "Usage: $PROGNAME [-n your_decimal_number] | [-h | --help]]"
  printf "%s\n" "Here:"
  printf "%s\n" "-n your_decimal_number: a decimal number. By default it's equal to present year"
  printf "%s\n" "-h | --help: this help information"
  exit 1
}

function error_exit()
{
	local error_message="$1"
    printf "\n%s\n" "${PROGNAME}: ${error_message:-"Unknown Error"}" 1>&2
    exit 1
}

function to_octal()
{
  local num=$1
  local result=""
  if [[ $num -eq 0 ]]; then
    result="0"
  else
    while [[ $num -gt 0 ]]; do
      # Get remainder (0-7)
      local rem=$(( num % 8 ))
      # Prepend remainder to result
      result="${rem}${result}"
      # Integer division by 8
      num=$(( num / 8 ))
    done
  fi
  echo "$result"
}

function check_number()
{
  if [[ ! $1 =~ ^[0-9]+$ ]]; then
  error_exit "Arg is not a number"
  fi
}

function parameters_handler()
{
  while [[ "$1" != "" ]]; do

    case "$1" in
      -n  )                  shift
                              DEC_NUM="$1"
                              ;;
      -h | --help )          usage
                              ;;
      *)                     error_exit "Invalid input"
                              ;;
    esac
    shift
  done
}

##### main
parameters_handler "$@"
check_number $DEC_NUM

declare OCT_NUM=$(to_octal "$DEC_NUM")
printf "\n%s\n" "The start number is $DEC_NUM"
printf "%s\n" "The octal number is $OCT_NUM"