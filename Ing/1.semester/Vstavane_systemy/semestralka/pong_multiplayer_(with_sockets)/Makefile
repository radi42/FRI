OUTPUTS = infinite_pong_server infinite_pong_client
CC = gcc
CFLAGS = -Wall -g -I/usr/include/SDL2

all: $(OUTPUTS)

clean:
	rm -f $(OUTPUTS)
	rm -f *.o

.PHONY: all clean

# KOMPILACIA SERVERA
infinite_pong_server: infinite_pong_server.o
	$(CC) infinite_pong_server.o -lSDL2 -lSDL2_ttf -o infinite_pong_server

infinite_pong_server.o: infinite_pong_server.c infinite_pong_server.h
	$(CC) $(CFLAGS) -c infinite_pong_server.c -o infinite_pong_server.o

# KOMPILACIA KLIENTA
infinite_pong_client: infinite_pong_client.o
	$(CC) infinite_pong_client.o -lSDL2 -lSDL2_ttf -o infinite_pong_client

infinite_pong_client.o: infinite_pong_client.c infinite_pong_client.h
	$(CC) $(CFLAGS) -c infinite_pong_client.c -o infinite_pong_client.o