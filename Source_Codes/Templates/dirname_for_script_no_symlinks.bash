#!/usr/bin/env bash

# Get the absolute directory of the script (simplified, no symlink resolution)
__dirname() {
    local prog="${BASH_SOURCE[0]}"
    [[ -n "$prog" ]] || return 1
    # Use parameter expansion instead of dirname, and cd to resolve path
    (CDPATH= cd "${prog%/*}" && pwd)
}

# Call function and store result
__dirname=$(__dirname) || { echo 'Failed to determine __dirname' >&2; exit 1; }

# Output result
echo "$__dirname"
