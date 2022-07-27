#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <string.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <unistd.h>

int init_server_addr(const char *str_ip, const char *str_port,
    struct sockaddr_in *addr)
{
    unsigned short port = 0;
    int is_valid_ip;
    sscanf(str_port, "%hu", &port);
    addr->sin_family = AF_INET;
    addr->sin_port = htons(port);
    is_valid_ip = inet_aton(str_ip, &addr->sin_addr);
    if(!is_valid_ip)
        return -1;
    return 0;
}

void init_client(const char *str_port, struct sockaddr_in *addr)
{
    unsigned short port = 0;
    sscanf(str_port, "%hu", &port);
    addr->sin_family = AF_INET;
    addr->sin_addr.s_addr = INADDR_ANY;
    addr->sin_port = htons(port);
}

void sigalrm_handler(int s)
{
    char msg[] = { "No response in 15 seconds\n" };
    signal(SIGALRM, sigalrm_handler);
    write(1, &msg, sizeof(msg));
    exit(7);
}

int main(int argc, char **argv)
{
    int socket_fd, res, recv;
    struct sockaddr_in server, recv_addr, client;
    struct response {
        unsigned int recv_count, recv_size;
    } resp;
    resp.recv_count = resp.recv_size = 0;
    signal(SIGALRM, sigalrm_handler);
    socklen_t recv_addr_len = sizeof(recv_addr);
    if(argc != 4) {
        fprintf(stderr, "Three parameters required\n");
        return 1;
    }
    socket_fd = socket(AF_INET, SOCK_DGRAM, 0);
    if(socket_fd == -1) {
        perror("socket");
        return 2;
    }
    init_client(argv[2], &client);
    res = bind(socket_fd, (struct sockaddr*)&client, sizeof(client));
    if(res == -1) {
        perror("bind");
        return 3;
    }
    if(init_server_addr(argv[1], argv[2], &server) == -1) {
        fprintf(stderr, "Invalid ip\n");
        return 4;
    }
    if(sendto(socket_fd, argv[3], strlen(argv[3]), 0,
        (struct sockaddr*)&server, sizeof(server)) < 0) {
        perror("sendto");
        close(socket_fd);
        return 5;
    }
    alarm(15);
    recv = recvfrom(socket_fd, &resp, sizeof(resp), 0,
        (struct sockaddr*)&recv_addr, &recv_addr_len);
    if(recv == -1) {
        perror("recv");
        close(socket_fd);
        return 6;
    }
    printf("Datagrams recived %u, total size %u\n",
        resp.recv_count, resp.recv_size);
    close(socket_fd);
    return 0;
}