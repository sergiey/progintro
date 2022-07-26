#include <stdio.h> 
#include <stdlib.h> 
#include <unistd.h> 
#include <string.h> 
#include <sys/types.h> 
#include <sys/socket.h> 
#include <arpa/inet.h> 
#include <netinet/in.h> 

int init_server(const char *ip, const char *str_port, struct sockaddr_in *addr)
{
    int is_valid_ip;
    unsigned short port;
    addr->sin_family = AF_INET;
    sscanf(str_port, "%hu", &port);
    addr->sin_port = htons(port);
    is_valid_ip = inet_aton(ip, &addr->sin_addr);
    if(!is_valid_ip)
        return -1;
    return 0;
}

int main(int argc, char **argv)
{    
    struct sockaddr_in server;
    int res, sockfd;
    if(argc != 4) {
        fprintf(stderr, "Three parameters required: ip, port and message\n");
        return 1;
    }
    res = init_server(argv[1], argv[2], &server);
    if(res == -1) {
        fprintf(stderr, "Couldn't init sockaddr\n");
        return 2;
    }
    sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if(sockfd == -1) {
        perror("socket");
        return 3;
    }
    if(sendto(sockfd, argv[3], strlen(argv[3]), 0,
        (struct sockaddr*)&server, sizeof(server)) < 0)
        perror("sendto");
    close(sockfd);
    return 0;
}