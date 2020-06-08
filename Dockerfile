# Dockerfile
#
# Requires
#   execute-only: bash 
#
FROM ubuntu:latest
LABEL description="Tools to compile SystemC with Clang under Ubuntu" \
      maintainer="David Black <david.black@doulos.com>" alternate="dcblack@mac.com"

# Eliminate interactive queries during build
ENV DEBIAN_FRONTEND=noninteractive\
    TZ=US/Central

RUN perl -pi -e 's{^# +(deb http://archive.canonical.com/ubuntu bionic partner)}{$1}' /etc/apt/sources.list \
 && echo "$TZ" >/etc/timezone

RUN apt-get -y update && apt-get -y install \
    apt apt-utils

# Compiler tools
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

# Libraries and automation
RUN apt-get -y update && apt-get -y install \
    git \
    libsecret-1-0 \
    libsecret-1-dev \
    graphviz \
    libboost-all-dev \
    libyaml-cpp-dev \
    make \
    ninja-build \
    cmake \
    python3-pip 

# Useful in an interactive context
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

COPY apps/bin $APPS/bin/
COPY apps/setup.profile $APPS/
COPY apps/src $APPS/src/
COPY apps/systemc $APPS/systemc/

# Install cmake if not available from repo
# WORKDIR $APPS/src
# RUN pip3 install -U sphinx && $APPS/bin/install-cmake

# Install SystemC, CCI and other components
WORKDIR $APPS/src
RUN $APPS/bin/install-systemc

RUN apt-get -y update && apt-get -y install \
    sudo && perl -pi -e 'if( m/^root/ ) { print; s/root/sc_user/; }' /etc/sudoers

ENV USER=sc_user \
    TZ=US/Central \
    TERM=xterm-color \
    EMAIL=sc_user@doulos.com \
    HOME=/home/sc_user \
    SYSTEMC_HOME=/apps/systemc

# Stuff that changes more frequently
COPY home $HOME/
COPY apps/.vim $APPS/.vim/
COPY apps/cmake $APPS/cmake/
COPY apps/make  $APPS/make/
COPY apps/sc-templates $APPS/sc-templates/
# WORKDIR $APPS
# RUN git clone git@github.com:dcblack/sc-templates.git

RUN adduser --home $HOME --shell /bin/bash --ingroup users --disabled-password \
      --gecos "SystemC developer" $USER \
 && printf "%s\n%s\n" $EMAIL $EMAIL | passwd $USER \
 && chown -R $USER $APPS $HOME; chgrp -R users $APPS $HOME; chmod u=rwx,g+sx $APPS $HOME/bin\
 && chmod g+s $HOME $HOME/bin && mkdir -p $HOME/work

WORKDIR $HOME/work
USER $USER:users
