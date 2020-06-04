# Dockerfile
#
# Requires
#   execute-only: bash 
#
FROM ubuntu:latest
LABEL description="Tools to compile SystemC with Clang under Ubuntu" \
      maintainer="David Black <david.black@doulos.com>" alternate="dcblack@mac.com"

ENV DEBIAN_FRONTEND=noninteractive\
    TZ=US/Central

RUN perl -pi -e 's{^# +(deb http://archive.canonical.com/ubuntu bionic partner)}{$1}' /etc/apt/sources.list \
 && echo "$TZ" >/etc/timezone

RUN apt-get -y update && apt-get -y install \
    apt apt-utils

RUN apt-get -y update && apt-get -y install \
    astyle \
    autoconf \
    automake \
    bison \
    cgdb \
    clang \
    cppcheck \
    doxygen \
    flex \
    g++ \
    gdb 

RUN apt-get -y update && apt-get -y install \
    git \
    graphviz \
    libboost-all-dev \
    libyaml-cpp-dev \
    make \
    ninja-build \
    cmake \
    python3-pip 

RUN apt-get -y update && apt-get -y install \
    rsync \
    silversearcher-ag \
    vim \
    wget 

ENV APPS=/apps \
    CMAKE_VERSION=3.14 CMAKE_BUILD=4\
    CC=gcc CXX=g++ \
    BOLD="[01m" \
    CBLK="[30m" CRED="[31m" CGRN="[32m" CYLW="[33m" \
    CBLU="[34m" CMAG="[35m" CCYN="[36m" CWHT="[37m" \
    NONE="[00m" 
# RED,GRN,YLW,BLU,MAG,CYN,WHT,BLK

WORKDIR $APPS/src
COPY apps $APPS
# RUN pip3 install -U sphinx \
#  && $APPS/bin/install-cmake

# Install SystemC, CCI and other components
RUN $APPS/bin/install-systemc

ENV USER=sc_user \
    TZ=US/Central \
    TERM=xterm-color \
    EMAIL=sc_user@doulos.com \
    HOME=/home/sc_user \
    SYSTEMC_HOME=/apps/systemc

RUN adduser --home $HOME --shell /bin/bash --ingroup users --disabled-password \
      --gecos "SystemC developer" $USER \
 && printf "%s\n%s\n" $EMAIL $EMAIL | passwd $USER \
 && chown -R $USER $APPS; chgrp -R users $APPS; chmod u=rwx,g+sx $APPS \
 && chmod g+s $HOME && mkdir $HOME/work

COPY home $HOME
WORKDIR $HOME/work
USER $USER:users
