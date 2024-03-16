#!/bin/bash -e
for _source in variables functions; do
    source common/"${_source}".sh
done

for _stage in {1..4}; do
    "${_build_dir}"/"${_stage}".sh "${1}"
done
