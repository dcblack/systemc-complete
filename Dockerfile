# Dockerfile
#
# Requires
#   execute-only: bash 
#
FROM ubuntu:latest
LABEL description="Tools to compile SystemC with Clang under Ubuntu" \
      maintainer="David Black <david.black@doulos.com>" alternate="dcblack@mac.com"

RUN perl -pi -e 's{^# +(deb http://archive.canonical.com/ubuntu bionic partner)}{$1}' /etc/apt/sources.list \
 && echo US/Central >/etc/timezone \
 && apt-get update

RUN apt-get install -y \
    apt-utils \
    astyle \
    autoconf \
    automake \
    bison \
    cgdb \
    clang \
    doxygen \
    flex \
    g++ \
    gdb \
    git \
    graphviz \
    libboost-all-dev \
    libyaml-cpp-dev \
    make \
    ninja-build \
    python3-pip \
    qt4-default \
    silversearcher-ag \
    vim \
    wget

ENV APPS=/apps \
    CMAKE_VERSION=3.14 CMAKE_BUILD=4\
    CC=gcc CXX=g++ \
    TZ=US/Central \
    BOLD="[01m" \
    CBLK="[30m" CRED="[31m" CGRN="[32m" CYLW="[33m" \
    CBLU="[34m" CMAG="[35m" CCYN="[36m" CWHT="[37m" \
    NONE="[00m" 
# RED,GRN,YLW,BLU,MAG,CYN,WHT,BLK

WORKDIR $APPS/src
COPY apps $APPS
RUN pip3 install -U sphinx \
 && $APPS/bin/install-cmake

# Install SystemC, CCI and other components
RUN $APPS/bin/install-systemc

ENV USER=techie \
    EMAIL=$USER@doulos.com \
    HOME=/home/work
RUN adduser --home $HOME --shell /bin/bash --ingroup users --disabled-password \
      --gecos "Doulos Techie" $USER \
 && printf "%s\n%s\n" $EMAIL $EMAIL | passwd $USER \
 && printf "set -o vi" >>$APPS/.profile \
 && printf 'PATH=$APPS/bin:$PATH' >>$APPS/.profile \
 && chown -R $USER $APPS; chgrp -R users $APPS; chmod u=rwx,g+sx $APPS

WORKDIR $HOME
USER $USER:users
