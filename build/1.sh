#!/bin/bash -e
_cur_dir="$(pwd)"
_stages_dir="${_cur_dir}"/stages

for i in "${_stages_dir}"/1/*.sh; do
    echo -e "\e[1;32m>>\e[m Entering ${i}"
    sleep 2
    "${i}" "${1}"
    echo -e "\e[1;32m>>\e[m Leaving ${i}"
    sleep 5
done
