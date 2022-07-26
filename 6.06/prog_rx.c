#include <stdio.h>
#include <string.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <unistd.h>

void init_server_addr(const char *str_port, struct sockaddr_in *addr)
{
    unsigned short port;
    addr->sin_family = AF_INET;
    sscanf(str_port, "%hu", &port);
    addr->sin_port = htons(port);
    addr->sin_addr.s_addr = INADDR_ANY;
}

int main(int argc, char **argv)
{    
    struct sockaddr_in fromaddr, serveraddr;
    int s, res, recvn;
    char buf[1024];
    socklen_t from_len = sizeof(fromaddr);
    if(argc != 2) {
        fprintf(stderr, "Port is not specified\n");
        return 1;
    }
    init_server_addr(argv[1], &serveraddr);
    s = socket(AF_INET, SOCK_DGRAM, 0);
    if(s == -1) {
        perror("socket");
        return 2;
    }
    res = bind(s, (struct sockaddr*)&serveraddr, sizeof(serveraddr));
    if(res == -1) {
        perror("bind");
        return 3;
    }
    for(;;) {
        int i;
        recvn = recvfrom(s, &buf, sizeof(buf), 0,
            (struct sockaddr*)&fromaddr, &from_len);
        printf("Recived from %s:%u\n",
            inet_ntoa(fromaddr.sin_addr), ntohs(fromaddr.sin_port));
        for(i = 0; i < recvn; i++) {
            if((32 <= buf[i] && buf[i] <= 126) ||
                buf[i] == '\t' || buf[i] == '\n')
                putchar(buf[i]);
            else
                putchar('?');
        }
        printf("\n");
    }
    return 0;
}