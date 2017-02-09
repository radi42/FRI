OUTPUTS = databaza_server 
CC = gcc

all: $(OUTPUTS)

clean:
	rm -f $(OUTPUTS)
	rm -f *.o

.PHONY: all clean

%.o: %.c
	$(CC) -c -o $@ @<

%: %.o
	$(CC) -o $@ $^