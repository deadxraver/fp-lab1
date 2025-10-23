.PHONY: all clean test test-c

PROBLEM1=12
PROBLEM2=18

BUILD=build

SRC=src

CC=gcc
CSRC1=$(SRC)/$(PROBLEM1)/*.c

HSC=stack
HSSRC1=$(SRC)/$(PROBLEM1)/*.hs

CEXEC1=c-$(PROBLEM1)
HSEXEC1=hs-$(PROBLEM1)

all: build test
	@echo 'build & test successfully finished'

lint: $(SRC)/
	# TODO: linters

build: build-c build-hs
	@echo 'build finished, put binaries to $(BUILD)/'

build-hs: $(HSSRC)/
	# TODO: build haskell

build-c: $(CSRC1)
	-mkdir $(BUILD)
	$(CC) -o $(BUILD)/$(CEXEC1) $^

test: test-c
	@echo 'Tests OK'

test-hs:	build-hs
	# TODO: haskell tests

test-c:	build-c
	@echo "Running c tests..."
	[ $$($(BUILD)/$(CEXEC1)) = 76576500 ];
	@echo OK
	[ $$($(BUILD)/$(CEXEC1) 0) = 0 ];
	@echo OK
	[ $$($(BUILD)/$(CEXEC1) 6) = 28 ];
	@echo OK

clean:
	rm -rf $(BUILD)
