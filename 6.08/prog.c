#include <stdio.h>
#include <time.h>
#include <string.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <stdlib.h>
#include <fcntl.h>
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
    int listen_sd = -1, res, client_sd;
    struct sockaddr_in server, client;
    socklen_t client_addrlen = sizeof(client);
    time_t accept_time = time(NULL);
    char msg[1024];
    if(argc < 2) {
        fprintf(stderr, "Port is not specified\n");
        close(listen_sd);
        return 1;
    }
    memset(msg, '\0', sizeof(msg));
    listen_sd = socket(AF_INET, SOCK_STREAM, 0);
    if(listen_sd == -1) {
        perror("socket");
        close(listen_sd);
        return 2;
    }
    init_server(argv[1], &server);
    res = bind(listen_sd, (struct sockaddr*)&server, sizeof(server));
    if(res == -1) {
        perror("bind");
        close(listen_sd);
        return 3;
    }
    listen(listen_sd, 128);
    client_sd = accept(listen_sd, (struct sockaddr*)&client, &client_addrlen);
    res = sprintf(msg, "%sAddress %s:%hu\n", ctime(&accept_time),
        inet_ntoa(client.sin_addr), ntohs(client.sin_port));
    write(client_sd, msg, res);
    close(listen_sd);
    return 0;
}