#!/bin/bash

case $1 in
"test")
  go test
  ;;
"build")
  mkdir -p ${GOPATH}/src/github.com/jarosser06
  mkdir -p bin
  go build -o bin/gistcat ./main.go
  ;;
"install")
  cp bin/gistcat ${INSTALLPRE}/bin/
  ;;
esac
