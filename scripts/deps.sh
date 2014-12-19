#!/bin/bash

gpm help &> /dev/null
if [ $? -eq 0 ]; then

  rm -rf $GOPATH
  mkdir -p $GOPATH

  gpm install
else
  echo "gpm not found"
fi
