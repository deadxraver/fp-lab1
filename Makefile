.PHONY: all clean

BUILD=build

SRC=src

CC=gcc
CSRC1=$(SRC)/12/*.c

CEXEC1=c-12

all: build test
	@echo 'build & test successfully finished'

build: build-c
	@echo 'build finished, put binaries to $(BUILD)/'

build-c: $(CSRC1)
	-mkdir $(BUILD)
	$(CC) -o $(BUILD)/$(CEXEC1) $^

test: test-c
	@echo 'Tests OK'

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
