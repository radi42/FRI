PROGS = fibb

all: $(PROGS)

clean:
	rm -f $(PROGS)

%: %.c
	gcc -lpthread -o $@ $<