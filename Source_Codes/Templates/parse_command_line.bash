# Parse command line
while [[ -n "$1" ]]; do
  case $1 in
    -h | --help)
      help_message
      graceful_exit
      ;;
    -q | --quiet)
      quiet_mode=yes
      ;;
    -s | --root)
      root_mode=yes
      ;;
    --* | -*)
      usage > &2; error_exit "Unknown option $1"
      ;;
    *)
      tmp_script="$1"
      break
      ;;
  esac
  shift
done
