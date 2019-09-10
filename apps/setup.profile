#!/bin/bash

set -o vi
alias m=less
PATH=/apps/bin:$PATH
pwd
if [[ -x .bashrc ]]; then
  source .bashrc
fi
