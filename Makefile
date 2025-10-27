.PHONY: all clean test test-c test-hs format-check lint

PROBLEM1=12
PROBLEM2=18

BUILD=build

SRC=src

CC=gcc
CSRC1=$(SRC)/$(PROBLEM1)/*.c
CSRC2=$(SRC)/$(PROBLEM2)/*.c

HSC=ghc
HSSRC1=$(SRC)/$(PROBLEM1)/*.hs
HSSRC2=$(SRC)/$(PROBLEM2)/*.hs

CEXEC1=c-$(PROBLEM1)
CEXEC2=c-$(PROBLEM2)
HSEXEC1=hs-$(PROBLEM1)
HSEXEC2=hs-$(PROBLEM2)

all: format-check lint build test
	@echo 'build & test successfully finished'

format: $(HSSRC1)
	ormolu --mode inplace $(HSSRC1)

format-check:
	ormolu --mode check $(HSSRC1)

lint: $(SRC)/
	hlint $(HSSRC1)

build: build-c build-hs
	@echo 'build finished, put binaries to $(BUILD)/'

build-hs: $(HSSRC1)
	$(HSC) $(HSSRC1) -o $(BUILD)/$(HSEXEC1)

build-c: $(CSRC1) $(CSRC2)
	-mkdir $(BUILD)
	$(CC) -o $(BUILD)/$(CEXEC1) $(CSRC1)
	$(CC) -o $(BUILD)/$(CEXEC2) $(CSRC2)

test: test-c test-hs
	@echo 'Tests OK'

test-hs:	build-hs
	@echo "Running hs tests for problem $(PROBLEM1)..."
	[ $$($(BUILD)/$(HSEXEC1)) = 76576500 ];
	@echo OK
	[ $$($(BUILD)/$(HSEXEC1) 0) = 0 ];
	@echo OK
	[ $$($(BUILD)/$(HSEXEC1) 6) = 28 ];
	@echo OK

test-c:	build-c
	@echo "Running c tests for problem $(PROBLEM1)..."
	[ $$($(BUILD)/$(CEXEC1)) = 76576500 ];
	@echo OK
	[ $$($(BUILD)/$(CEXEC1) 0) = 0 ];
	@echo OK
	[ $$($(BUILD)/$(CEXEC1) 6) = 28 ];
	@echo OK
	@echo "...and for problem $(PROBLEM2)..."
	[ $$($(BUILD)/$(CEXEC2)) = 23 ];
	@echo OK

clean:
	rm -rf $(BUILD)
