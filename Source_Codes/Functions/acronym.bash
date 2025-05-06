#!/usr/bin/env bash
function acronym()
{
  declare my_acronym=""
  IFS="-, " read -a words <<< "${@//[.\!\?\+=\*]/ }"
  for i in "${words[@]}"; do
    my_acronym+="${i:0:1}"
  done
    echo "${my_acronym^^}"
}
