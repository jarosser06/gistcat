#!/bin/bash

INSTALLPRE=/usr/local

## Make sure godep is installed
godep help &> /dev/null
if [ $? -eq 0 ]; then
  GOPATH=`godep path`:${GOPATH}
  case $1 in
  "test")
    go test
    ;;
  "build")
    mkdir -p bin
    go build -o bin/gistcat ./main.go
    ;;
  "install")
    cp bin/gistcat ${INSTALLPRE}/bin/
    ;;
  esac
else
  echo "Error: You must have godep installed."
  echo -e "https://github.com/tools/godep\n"
  echo -e "Run:\n go get github.com/tools/godep"
fi
