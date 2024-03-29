#!/bin/bash -e
_cur_dir="$(pwd)"
_sources_dir="${_cur_dir}"/sources
_dist_dir="${_cur_dir}"/dist
_toolchain_dir="${_cur_dir}"/toolchain

_sherona_static="-static --static"
_sherona_cc="gcc ${_sherona_static}"
_sherona_cflags="-Wall -w"
_sherona_cxx="g++ ${_sherona_static}"
_sherona_cxxflags="${_sherona_cflags}"
_sherona_ld="ld -s ${_sherona_static}"

_gmp_configure_args=(
    --enable-alloca=malloc-reentrant
    --enable-assembly
    --enable-cxx
    --enable-fake-cpuid
    --enable-fat
    --enable-fft
    --enable-nails
    --enable-old-fft-full
    --enable-shared
    --enable-static
    --disable-werror
)

echo -e "\e[1;32m>>\e[m Downloading gmp"
mkdir -p "${_sources_dir}"/toolchain/gmp
curl -sLo- https://ftp.gnu.org/gnu/gmp/gmp-6.3.0.tar.gz | tar -zxf- --strip-components=1 -C "${_sources_dir}"/toolchain/gmp
mkdir -p "${_dist_dir}"/toolchain/gmp
echo -e "\e[1;32m>>\e[m Configuring gmp"
AR=gcc-ar                     \
AS=as                         \
CC="${_sherona_cc}"           \
CFLAGS="${_sherona_cflags}"   \
CXX="${_sherona_cxx}"         \
CXXFLAGS="${_sherona_cflags}" \
LD="${_sherona_ld}"           \
NM=gcc-nm                     \
RANLIB=gcc-ranlib             \
"${_sources_dir}"/toolchain/gmp/configure --prefix="${_toolchain_dir}" \
                                          --bindir=/bin                \
	                                  --sbindir=/bin               \
					  --libdir=/lib                \
					  --libexecdir=/lib            \
					  --includedir=/include        \
					  --datarootdir=/share         \
					  ${_gmp_configure_args} > /dev/null 2>&1
echo -e "\e[1;32m>>\e[m Building gmp"
make > /dev/null 2>&1
echo -e "\e[1;32m>>\e[m Installing gmp to the Sherona LFS' toolchain"
make install > /dev/null 2>&1

if [ "${SHERONA_CLEANUP}" = 1 ]; then
    echo -e "\e[1;32m>>\e[m Cleaning gmp directories"
    rm -rf "${_sources_dir}"/toolchain/gmp
    rm -rf "${_dist_dir}"/toolchain/gmp
fi
