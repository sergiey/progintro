#include <stdio.h>
#include <string.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <unistd.h>

void init_server(const char *str_port, struct sockaddr_in *addr)
{
    unsigned short port = 0;
    sscanf(str_port, "%hu", &port);
    addr->sin_family = AF_INET;
    addr->sin_addr.s_addr = INADDR_ANY;
    addr->sin_port = htons(port);
}

int main(int argc, char **argv)
{
    int socket_fd, res, recv;
    struct sockaddr_in server, recv_addr;
    enum { buf_size = 256 };
    char buf[buf_size];
    struct response {
        unsigned int recv_count, recv_size;
    } resp;
    resp.recv_count = 0;
    resp.recv_size = 0;
    socklen_t recv_addr_len = sizeof(recv_addr);
    if(argc != 2) {
        fprintf(stderr, "Port is not specified\n");
        return 1;
    }
    init_server(argv[1], &server);
    socket_fd = socket(AF_INET, SOCK_DGRAM, 0);
    if(socket_fd == -1) {
        perror("soket");
        return 2;
    }
    res = bind(socket_fd, (struct sockaddr*)&server, sizeof(server));
    if(res == -1) {
        perror("bind");
        return 3;
    }
    for(;;) {
        recv = recvfrom(socket_fd, &buf, buf_size, 0,
            (struct sockaddr*)&recv_addr, &recv_addr_len);
        resp.recv_count++;
        resp.recv_size += recv;
        if(sendto(socket_fd, &resp, sizeof(resp), 0,
                    (struct sockaddr*)&recv_addr, recv_addr_len) < 0)
            printf("ff\n");
    }
    return 0;
}