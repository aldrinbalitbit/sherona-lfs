#!/bin/bash -e
_cur_dir="$(pwd)"
_build_dir="${_cur_dir}"/build

for i in {1..4}; do
    echo -e "\e[1;32m>>\e[m Entering stage ${i}"
    sleep 2
    "${_build_dir}"/"${i}".sh "${1}"
    echo -e "\e[1;32m>>\e[m Leaving stage ${i}"
    sleep 5
done
