#!/usr/bin/env bash
#
# Node.JS style __dirname in bash
#
# Author: Stanislav Starodub
# Date: June 18, 2025
# License: GPL

# Get the absolute directory of the script, resolving symlinks
__dirname() {
    local prog="${BASH_SOURCE[0]}"
    [[ -n "$prog" ]] || return 1

    # Resolve symlinks using parameter expansion where possible
    while [[ -L $prog ]]; do
        local rl
        if ! rl=$(readlink "$prog") || [[ -z "$rl" ]]; then
          # or you can use:  rl=$(ls -l "$prog" | sed 's/.* -> //')
            return 1
        fi
        # Handle absolute or relative symlinks
        [[ ${rl:0:1} == '/' ]] && prog="$rl" || prog="${prog%/*}/$rl"
    done

    # Resolve directory path
    (CDPATH= cd "${prog%/*}" && pwd)
}

# Call function and store result
__dirname=$(__dirname) || { echo 'Failed to determine __dirname' >&2; exit 1; }

# Output result
echo "$__dirname"
