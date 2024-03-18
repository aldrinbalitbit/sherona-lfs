FROM debian:stable

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -qqy update \
  && apt-get -qqy upgrade \
  && apt-get -qqy install sudo \
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
    gnupg-agent \
    skopeo \
    software-properties-common \
  && sudo add-apt-repository -y ppa:git-core/ppa \
  && sudo apt-get -qqy update \
  && sudo apt-get -qqy upgrade \
  && sudo apt-get -qqy install \
    autoconf \
    automake \
    autopoint \
    binutils \
    build-essential \
    g++ \
    gcc \
    gettext \
    git \
    intltool \
    libgmp-dev \
    libisl-dev \
    libmpc-dev \
    libmpfr-dev \
    libtool \
    m4 \
    make \
    mercurial \
  && sudo apt-get remove --purge -qqy software-properties-common \
  && sudo apt-get autoremove --purge -qqy \
  && sudo apt-get clean \
  && sudo rm -rf /var/lib/apt/{archives,lists}/*

ARG sherona_arc
RUN SHERONA_CLEANUP=1 ./build.sh "${_sherona_arch}"
