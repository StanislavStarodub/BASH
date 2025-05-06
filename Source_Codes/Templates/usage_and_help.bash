#!/usr/bin/env bash

declare PROGNAME="${0##*/}"
declare VERSION="v1.0"

usage() {
  printf "%s\n" \
    "Usage: ${PROGNAME} [-h|--help ]"
  printf "%s\n" \
    "       ${PROGNAME} [-q|--quiet] [-s|--root] [script]"
}

help_message() {
  cat <<- _EOF_
  ${PROGNAME} ${VERSION}
  Bash shell script template generator.

  $(usage)

  Options:

  -h, --help    Display this help message and exit.
  -q, --quiet   Quiet mode. No prompting. Outputs default script.
  -s, --root    Output script requires root privileges to run.

_EOF_
}
