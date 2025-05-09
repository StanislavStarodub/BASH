#!/usr/bin/env bash

declare PROGNAME="${0##*/}" 
declare sec_in_one_day=86400
declare days_in_years_range=0
declare START_YEAR=1970
declare USER_YEAR=$(printf '%(%Y)T') year=$START_YEAR
declare is_leap=
declare -a leap_years=()
declare count_leap_years=0

function usage()
{
  printf "\n%s\n" "Calculation of the number of days and seconds from January 1, 1970 to the year set by the user. As a addition, display of leap years during this period"
  printf "%s\n" "Usage: $PROGNAME [[-y | --year] | [-h | --help]]"
  printf "%s\n" "Here:"
  printf "%s\n" "-y | --year: a year between 1970-9999, by default year = present year"
  printf "%s\n" "-h | --help: this help information"
} 

function error_exit()
{
    local error_message="$1"
    printf "\n%s\n" "${PROGNAME}: ${error_message:-"Unknown Error"}" 1>&2
    exit 1
} 

function parameters_handler()
{
  while [[ "$1" != "" ]]; do
    
    case "$1" in
        -y | --year )          shift
                               USER_YEAR="$1"
                               ;;
        -h | --help )          usage
                               error_exit "Read this help, please"
                               ;;
        *)                     usage
                               error_exit
                               ;;
   esac
   shift
 done
} 

function is_leap_year()
{
  if (( $1 % 4 != 0 )); then
    return 1 #False
  elif (( $1 % 100 != 0 )); then
    return 0 #True
  elif (( $1 % 400 != 0 )); then
    return 1 
  else
    return 0
  fi
}

parameters_handler "$@" 
while (( year < USER_YEAR )); do
  is_leap_year $year
  is_leap=$?
  if (( is_leap == 0 )); then
     ((count_leap_years++))
     leap_years+=" $year"
     ((days_in_years_range+=366))
   else
     ((days_in_years_range+=365))
  fi
  ((year++))
done

printf "\n%s\n" "From $START_YEAR to $USER_YEAR are(is) $((USER_YEAR-START_YEAR)) year(s)"
printf "%s\n" "Count of leap years is: $count_leap_years"
printf "%s\n" "These leap years are: ${leap_years[@]}"
printf "%s\n" "All days from 1 Jan  $START_YEAR to 1 Jan $USER_YEAR are: $days_in_years_range"
printf "%s\n" "All seconds are $(($days_in_years_range * $sec_in_one_day))"
printf "%s\n" "--------------------------------"

