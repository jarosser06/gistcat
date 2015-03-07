export INSTALLPRE := /usr/local

all: build

build:
		@echo "Building..."
		scripts/make.sh build

test:
		@echo "Running tests..."
		scripts/make.sh test

clean:
		@echo "Cleaning up..."
		@rm -rf bin
		@rm -rf packages

install:
		@echo "Installing to ${INSTALLPRE}/bin"
		@scripts/make.sh install
