.PHONY: all clean test test-c

PROBLEM1=12
PROBLEM2=18

BUILD=build

SRC=src

CC=gcc
CSRC1=$(SRC)/$(PROBLEM1)/*.c

HSC=ghc
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
	$(HSC) $(HSSRC1) -o $(BUILD)/$(HSEXEC1)

build-c: $(CSRC1)
	-mkdir $(BUILD)
	$(CC) -o $(BUILD)/$(CEXEC1) $^

test: test-c test-hs
	@echo 'Tests OK'

test-hs:	build-hs
	@echo "Running hs tests..."
	[ $$($(BUILD)/$(HSEXEC1)) = 76576500 ];
	@echo OK
	[ $$($(BUILD)/$(HSEXEC1) 0) = 0 ];
	@echo OK
	[ $$($(BUILD)/$(HSEXEC1) 6) = 28 ];
	@echo OK

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
