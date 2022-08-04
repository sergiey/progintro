#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <sys/errno.h>
#include <sys/select.h>
#include <arpa/inet.h>
#include <netinet/in.h>

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
    struct sockaddr_in server, client;
    int ls, res, i;
    socklen_t client_addrlen = sizeof(client);
    enum { max_connections = 128 };
    int all_connections[max_connections];
    if(argc < 2) {
        fprintf(stderr, "Port is not specified\n");
        return 2;
    }
    init_server(argv[1], &server);
    ls = socket(AF_INET, SOCK_STREAM, 0);
    if(ls == -1) {
        perror("socket");
        close(ls);
        return 1;
    }
    res = bind(ls, (struct sockaddr*)&server, sizeof(server));
    if(res == -1) {
        perror("bind");
        close(ls);
        return 3;
    }
    listen(ls, max_connections);
    for(i = 0; i < max_connections; i++)
        all_connections[i] = -1;
    for(;;) {
        int cs;
        fd_set readfds;
        enum { buf_size = 4096 };
        char buf[buf_size];
        int max_d = ls;
        FD_ZERO(&readfds);
        FD_SET(ls, &readfds);
        for(i = 0; i < max_connections; i++) {
            if(all_connections[i] != -1) {
                FD_SET(all_connections[i], &readfds);
                if(all_connections[i] > max_d)
                    max_d = all_connections[i];
            }
        }
        res = select(max_d + 1, &readfds, NULL, NULL, NULL);
        if(res == -1) {
            if(errno == EINTR)
                perror("EINTR");
            else
                perror("select");
            continue;
        }
        if(res == 0) {
            perror("timeout")
            continue;
        }
        if(FD_ISSET(ls, &readfds)) {
            cs = accept(ls, (struct sockaddr*)&client, &client_addrlen);
            if(cs == -1) {
                perror("accept");
            } else {
                all_connections[cs] = cs;
            }
        }
        for(i = 0; i < max_connections; i++) {
            if(FD_ISSET(all_connections[i], &readfds)) {
                int j;
                res = read(all_connections[i], &buf, sizeof(buf));
                if(res == -1) {
                    perror("read");
                    continue;
                }
                if(res == 0) {
                    close(all_connections[i]);
                    all_connections[i] = -1;
                    continue;
                }
                for(j = 0; j < res; j++) {
                    if(buf[j] == '\n')
                        write(all_connections[i], "Ok\n", 3);
                }
            }
        }
    }
    return 0;
}