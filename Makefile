export GOPATH := ${PWD}/.gopath
export INSTALLPRE := /usr/local

all: deps build

build:
		@echo "Building binaries..."
		@scripts/make.sh build

package: deps build
		@echo "Packaging..."
		scripts/make.sh package

deps:
		scripts/deps.sh

test:
		@echo "Running tests..."
		scripts/make.sh test

clean:
		@echo "Cleaning up..."
		rm -rf bin
		rm -rf packages
		rm -rf .gopath

install:
		@echo "Installing to ${INSTALLPRE}/bin"
		@scripts/make.sh install
