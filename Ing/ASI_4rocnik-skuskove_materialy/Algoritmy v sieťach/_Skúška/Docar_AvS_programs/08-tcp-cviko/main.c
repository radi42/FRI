#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>

#include <string.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <netdb.h>

#define         ERROR           (1)
#define         SERV_ADDR_STR   "158.193.152.2"
#define         SERV_PORT       (80)
#define         HTTP_GET_REQ    "GET /index.html HTTP/1.0\r\n\r\n"
#define         MAX_MSG_LEN     (1500)
#define         SERV_HOSTNAME   "www.kis.fri.uniza.sk"

/*
 * man tcp 7
 */
int main(int argc, char** argv) {

    int Sock;
    struct sockaddr_in ServAddr;
    char Msg[] = HTTP_GET_REQ;
    char Response[MAX_MSG_LEN];
    struct addrinfo * AddrInfo;
    struct addrinfo AddressHints;

    int BytesSent = 0;
    int BytesRcv = 0;

    Sock = socket(AF_INET, SOCK_STREAM, 0);
    if (Sock == -1) {
        perror("socket");
        exit(ERROR);
    }

    /*
        memset(&ServAddr, 0, sizeof (ServAddr));
        ServAddr.sin_family = AF_INET;
        ServAddr.sin_port = htons(SERV_PORT);
        if (inet_aton(SERV_ADDR_STR, &(ServAddr.sin_addr)) == 0) {
            fprintf(stderr, "Error: inet_aton");
            close(Sock);
            exit(ERROR);
        }
     */

    memset(&AddressHints, 0, sizeof (AddressHints));

    AddressHints.ai_family = AF_INET;
    AddressHints.ai_socktype = SOCK_STREAM;
    AddressHints.ai_protocol = 0;
    AddressHints.ai_flags = 0;

    int errCode;
    if ((errCode = getaddrinfo(SERV_HOSTNAME, "http", &AddressHints, &AddrInfo)) != 0) {
        fprintf(stderr, "Error: %s\n", gai_strerror(errCode));
        close(Sock);
        exit(ERROR);
    }

    if (connect(Sock, AddrInfo->ai_addr, AddrInfo->ai_addrlen) == -1) {
        perror("connect");
        exit(ERROR);
    }

    freeaddrinfo(AddrInfo);

    char * index = Msg;
    while (BytesSent < sizeof (Msg)) {
        int sent = write(Sock, index, sizeof (Msg));
        if (sent == -1) {
            perror("write");
            close(Sock);
            exit(ERROR);
        }
        index += sent;
        BytesSent += sent;
    }

    memset(Response, '\0', sizeof (Response));
    index = Response;
    int recv = 0;
    while ((recv = read(Sock, index, sizeof (Response) - 1 - BytesRcv)) > 0) {
        BytesRcv += recv;
        index += recv;
    }

    if (recv < 0) {
        perror("read");
        close(Sock);
        exit(ERROR);
    } else {
        printf("Response: \n%s\n", Response);
    }
    
    close(Sock);

    return (EXIT_SUCCESS);
}