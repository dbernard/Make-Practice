SRCS := $(wildcard src/*.c)
OBJS := $(patsubst %.c,%.o,$(SRCS))
UNITY_SRCS := $(wildcard unity/src/*.c)
UNITY_OBJS := $(patsubst %.c,%.o,$(UNITY_SRCS))

EXTRA_CFLAGS := -Wall -Wextra -O2


all: build/runners/test_dummy_runner

%.o: %.c
	$(CC) $(EXTRA_CFLAGS) $(CFLAGS) $(EXTRA_CPPFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -o $@ $^

tests/test_dummy.o: EXTRA_CPPFLAGS += -Iunity/src
build/runners/test_dummy_runner.o: EXTRA_CPPFLAGS += -Iunity/src -Itests

build/runners/test_dummy_runner.c: tests/test_dummy.c
	mkdir -p build/runners
	ruby unity/auto/generate_test_runner.rb $^ $@

build/runners/test_dummy_runner: $(UNITY_OBJS) tests/test_dummy.o build/runners/test_dummy_runner.o
	mkdir -p build/runners
	$(CC) -o $@ $^

clean:
	rm -rf $(OBJS) $(UNITY_OBJS) build

.PHONY: clean
