#!/bin/bash -e
_cur_dir="$(pwd)"
_sources_dir="${_cur_dir}"/sources
_dist_dir="${_cur_dir}"/dist
_toolchain_dir="${_cur_dir}"/toolchain
_sherona_configure_args=(
    --eanble-alloca
    --enable-assembly
    --enable-cxx
    --enable-fake-cpuid
    --enable-fat
    --enable-fft
    --enable-nails
    --enable-old-fft-full
)

export PATH="${PATH}:${_toolchain_dir}/bin"

echo -e "\e[1;31m>>\e[m Cloning gmp"
hg clone https://gmplib.org/repo/gmp/ "${_sources_dir}"/toolchain/gmp > /dev/null 2>&1
cd "${_sources_dir}"/toolchain/gmp
echo -e "\e[1;31m>>\e[m Bootstrapping gmp"
./.bootstrap > /dev/null 2>&1
mkdir -p "${_dist_dir}"/toolchain/gmp
cd "${_dist_dir}"/toolchain/gmp
echo -e "\e[1;31m>>\e[m Configuring gmp"
"${_sources_dir}"/toolchain/gmp/configure --prefix=${_toolchain_dir} \
	                                  --sbindir=/bin             \
					  --libexecdir=/lib          \
					  "${_sherona_configure_args}" > /dev/null 2>&1

if [ "${SHERONA_CLEANUP}" = 1 ]; then
    echo -e "\e[1;31m>>\e[m Cleaning gmp directories"
    rm -rf "${_sources_dir}"/toolchain/gmp
    rm -rf "${_dist_dir}"/toolchain/gmp
fi
