FROM debian:stable

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -qqy update \
  && apt-get -qqy upgrade \
  && apt-get -qqy install locales sudo \
  && useradd -m -s /bin/bash sherona \
  && localedef -i en_US -f UTF-8 en_US.UTF-8 \
  && echo 'sherona ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
  && apt-get autoremove --purge -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/{archives,lists}/*

USER sherona
RUN sudo apt-get -qqy update \
  && sudo apt-get -qqy upgrade \
  && sudo apt-get -qqy install \
    autoconf \
    automake \
    autopoint \
    binutils \
    build-essential \
    curl \
    g++ \
    gcc \
    gettext \
    git \
    intltool \
    libc-dev \
    libgmp-dev \
    libisl-dev \
    libmpc-dev \
    libmpfr-dev \
    libtool \
    m4 \
    make \
    mercurial \
  && sudo apt-get autoremove --purge -qqy \
  && sudo apt-get clean \
  && sudo rm -rf /var/lib/apt/{archives,lists}/*

COPY --chown=sherona:sherona . /sherona
WORKDIR /sherona
ARG SHERONA_ARCH
RUN SHERONA_CLEANUP=1 sudo ./build.sh "${SHERONA_ARCH}"
