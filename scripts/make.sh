#!/bin/bash

function godep_installed {
  godep help &> /dev/null

  if ![ $? -eq 0 ]; then
    echo "Error: You must have godep installed."
    echo -e "https://github.com/tools/godep\n"
    echo -e "Run:\n go get github.com/tools/godep"
    return false
  else
    return true
  fi
}

echo $INSTALLPRE

## Make sure godep is installed
case $1 in
"test")
  if [ godep_installed ]; then
    GOPATH=`godep path`:${GOPATH}
    go test
  fi
  ;;
"build")
  if [ godep_installed ]; then
    mkdir -p bin
    GOPATH=`godep path`:${GOPATH}
    go build -o bin/gistcat ./main.go
  fi
  ;;
"install")
  cp bin/gistcat ${INSTALLPRE}/bin/
  ;;
esac
