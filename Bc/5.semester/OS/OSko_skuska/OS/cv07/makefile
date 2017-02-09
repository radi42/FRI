PROGS = fib zrebcin z

all: $(PROGS)

clean:
	rm -f $(PROGS)

%: %.c
	gcc -lpthread -o $@ $<