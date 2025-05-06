#!/usr/bin/env bash

function REV()
{
declare REVERSE_STR=""
declare LEN=$((${#1}-1))
for ((i=$LEN; i>=0; i--)); do
    REVERSE_STR+="${1:i:1}"
done
echo "$REVERSE_STR"
}
