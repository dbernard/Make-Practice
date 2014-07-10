SRCS := $(wildcard src/*.c)


all: hello-world

hello-world: $(SRCS)
	gcc -o $@ -Wall -Wextra -O2 $^

clean:
	rm -f hello-world

.PHONY: clean
