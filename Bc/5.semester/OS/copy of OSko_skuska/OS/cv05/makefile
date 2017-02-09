PROGS = hello prog1 prog2 prog3

all: $(PROGS)

clean:
	rm -f $(PROGS)

%: %.c
	gcc -o $@ $<