#!/bin/sh
#
# Sets up the environment inside the SystemC docker container

set -o vi
alias m=less
alias cls=clear
export LESS=afrMRXj4x4

# Setup path
PATH=/apps/bin:${PATH}
if [[ -d "$HOME/bin" ]]; then
  PATH="$HOME/bin":${PATH}
fi
export PROJ_HOME="$HOME/work"

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

echo "HOME='${hpath}'" "CWD='${cpath}'"
