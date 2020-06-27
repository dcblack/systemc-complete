#!/bin/sh
#
# Sets up the environment inside the SystemC docker container

case "$-" in
  *i*)  set -o vi
        set ignoreeof
        test -r "$BASH_ENV" && . "$BASH_ENV"
        ;;
esac

alias  cls='clear'
alias  ls='ls -ABCF --color'
alias  m='less'
export LESS='afrMRXj4x4'

# Setup path
PATH=/apps/bin:${PATH}
if [[ -d "$HOME/bin" ]]; then
  PATH="$HOME/bin":${PATH}
fi
export PROJ_ROOT="$HOME/work"
export BOOST_HOME=/usr/include/boost
export SYSTEMC_HOME=/apps/systemc
export CCI_HOME=/apps/cci
export LD_LIBRARY_PATH=$SYSTEMC_HOME/lib
export TEMPLATEPATH=/home/sc_user/work/templates:/apps/sc-templates

# Setup vimrc
mkdir -p "$HOME/.vim"
rsync -au /apps/.vim "$HOME/"

# Allow for overrides
if [[ -x "$HOME/.bashrc" ]]; then
  source "$HOME/.bashrc"
fi
hpath="$(perl -M'Cwd(realpath)' -le 'print realpath $ENV{HOME}')"
cpath="$(perl -M'Cwd(realpath)' -le 'print realpath q{.}')"
if [[ "$hpath" != "$cpath" ]]; then
  if [[ -x ./.bashrc ]]; then
    source ./.bashrc
  fi
fi

if [[ -d "$SCC_WORKDIR" ]]; then
  cd "$SCC_WORKDIR"
fi
if [[ "$SCC_LOGIN" != "" ]]; then
  $SCC_LOGIN
fi
