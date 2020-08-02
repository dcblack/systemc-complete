#!/bin/sh

let ERRORS=0
if [[ ! -r build/log.dir/compile-f.log ]]; then
  echo "ERROR: Missing compiler output." 1>&2
  let ++ERRORS
fi

if [[ -r build/log.dir/link.log ]]; then
  echo "ERROR: Unexpected link output." 1>&2
  let ++ERRORS
fi

if [[ -r build/log.dir/run.log ]]; then
  echo "ERROR: Unexpected run output." 1>&2
  let ++ERRORS
fi

if [[ $ERRORS == 0 ]]; then
  echo "Success"
  exit 0
else
  echo "Failure"
  exit 1
fi
