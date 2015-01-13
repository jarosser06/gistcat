#!/bin/bash

gpm help &> /dev/null
if [ $? -eq 0 ]; then

  rm -rf $GOPATH
  mkdir -p $GOPATH

  gpm install
  exit 0
else
  echo "gpm not found"
  exit 0
fi
