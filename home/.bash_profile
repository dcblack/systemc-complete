#!/bin/bash

export BASH_ENV=$HOME/.bashrc; # for non-interactive cases
export ENV=$BASH_ENV; # in case --posix used
export RSYNC_RSH=ssh

source $HOME/setup.profile
