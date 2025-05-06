#!/usr/bin/env bash
function convert_s_to_hms()
{
  # convert given seconds to hours-minutes-seconds
  # usage: convert_s_to_hms 3700

  if [[ "$1" =~ ^[0-9]+$ ]]; then

    seconds="$1"

    hours=$((seconds / 3600))
    seconds=$((seconds % 3600))
    minutes=$((seconds / 60))
    seconds=$((seconds % 60))

    echo "$hours hour(s) $minutes minute(s) $seconds second(s)"
  else
    echo "Error, wrong number. Exit!"
    exit 1
  fi
}
