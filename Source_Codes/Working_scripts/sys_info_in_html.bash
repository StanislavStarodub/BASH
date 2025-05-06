#!/usr/bin/env bash

declare PROGNAME="${0##*/}"
declare FILENAME=""
declare TITLE="System Information for $HOSTNAME"
declare RIGHT_NOW=$(date +"%d-%m-%Y %r %Z")
declare TIME_STAMP="Updated on $RIGHT_NOW by $USER"
declare interactive=

if [ -d "~/tmp" ]; then
  TEMP_DIR=~/tmp
else
  TEMP_DIR=/tmp
fi
FILENAME="$TEMP_DIR/$PROGNAME.$$.$RANDOM.html" 

function usage()
{
    printf "\n%s\n" "Gather system info and write to a html file"
    printf "%s\n" "Usage: $PROGNAME [[[-f file ] [-i]] | [-h]]"
    exit 1 
}

function clean_up()
{
	rm -f "$FILENAME"
	exit $1
}

function error_exit()
{
	local error_message="$1"
    printf "\n%s\n" "${PROGNAME}: ${error_message:-"Unknown Error"}" 1>&2
    clean_up 1 
}

trap clean_up SIGHUP SIGINT SIGTERM

function parameters_handler()
{
  while [[ "$1" != "" ]]; do
    
    case "$1" in

        -f | --file )          shift
                               FILENAME="$1"
                               ;;
        -i | --interactive )   interactive=1
                               ;;
        -h | --help )          usage
                               clean_up
                               ;;
        *)                     usage
                               error_exit
                               ;;
   esac
   shift
 done
}

function system_info()
{
  if ls /etc/*release &>/dev/null; then
    printf "\n%s" "<h2>System release info</h2>"
    printf "\n%s\n" "<pre>"
    for i in /etc/*release; do
      head -n 1 "$i"
    done
    uname -orp # print OS, kernel, processor
    printf "\n%s\n" "</pre>" 
  fi
}

function show_uptime()
{
    printf "\n%s" "<h2>System uptime</h2>"
    printf "\n%s" "<pre>"
    uptime
    printf "\n%s" "</pre>"
}
function drive_space()
{
    printf "\n%s" "<h2>Filesystem space</h2>"
    printf "\n%s" "<pre>"
    df -h
    printf "\n%s" "</pre>"
}
function home_space()
{     printf "\n%s" "<h2>Home directory space by user</h2>"
      printf "\n%s" "<pre>"
      format="%8s%9s%10s%13s\n"
      printf "$format" "Dirs" "Files" "Blocks" "Directory"
      printf "$format" "----" "-----" "------" "---------"
    if [[ "$(id -u)" == "0" ]]; then
      dir_list="/home/*"
    else
      dir_list="$HOME"
    fi
    for home_dir in $dir_list; do
      total_dirs=$(find "$home_dir" -type d | wc -l)
      total_files=$(find "$home_dir" -type f | wc -l)
      total_blocks=$(du -sh "$home_dir" | cut -f1)
      len_home_dir=$((${#home_dir} + 5))
      format="%8s%8s%9s%*s\n"
      printf "$format" "$total_dirs" "$total_files" "$total_blocks" "$len_home_dir" "$home_dir"
    done
      printf "\n%s" "</pre>"
}

function write_page()
{
cat <<- _EOF_
    <html>
    <head>
        <title>
        $TITLE
        </title>
    </head>

    <body>
    <h1>$TITLE</h1>
    <p>$TIME_STAMP </p>
   <div>$(system_info)</div> 
   <div>$(show_uptime)</div> 
   <div>$(drive_space)</div> 
   <div>$(home_space)</div> 
    </body>
    </html>
_EOF_
}

##### Main
parameters_handler "$@"
if [ "$interactive" = "1" ]; then

    response=

    read -p "Enter name of output file [$FILENAME] > " response
    if [ -n "$response" ]; then
        FILENAME="$response"
    fi

    if [ -f $FILENAME ]; then
        echo -n "Output file exists. Overwrite? (y/n) > "
        read response
        if [ "$response" != "y" ]; then
           printf "\n%s\n" "Exiting program without creating a file."
		   printf "%s\n" "The file is here: $FILENAME"
           exit
        fi
    fi
fi
write_page > "$FILENAME"
cp "$FILENAME" "/home/student/LearnLinux/BASH/Learning/Exams"
clean_up
