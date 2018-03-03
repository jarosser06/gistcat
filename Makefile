export INSTALLPRE := /usr/local

all: build

build:
		@echo "Building..."
		go build -v -o bin/gistcat

test:
		@echo "Running tests..."
		go test

clean:
		@echo "Cleaning up..."
		@rm -rf bin

install: build
		@echo "Installing to ${INSTALLPRE}/bin"
		@cp bin/gistcat ${INSTALLPRE}/bin/

.PHONY: build test clean install
