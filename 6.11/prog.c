#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/select.h>

int main(int argc, char **argv)
{
    int rfd, wfd;
    if(argc != 3) {
        fprintf(stderr, "Two parameters required\n");
        return 1;
    }
    rfd = open(argv[1], O_RDONLY | O_NONBLOCK);
    if(rfd == -1) {
        perror(argv[1]);
        return 2;
    }
    wfd = open(argv[2], O_WRONLY);
    if(wfd == -1) {
        perror(argv[2]);
        return 2;
    }
    for(;;) {
        int res, readn, max_d = wfd;
        fd_set readfds;
        enum { buf_size = 4096 };
        char buf[buf_size];
        FD_ZERO(&readfds);
        FD_SET(0, &readfds);
        FD_SET(rfd, &readfds);
        res = select(max_d + 1, &readfds, NULL, NULL, NULL);
        if(res <= 0) {
            continue;
        }
        if(FD_ISSET(0, &readfds)) {
            readn = read(0, &buf, sizeof(buf));
            write(wfd, &buf, readn);
        }
        if(FD_ISSET(rfd, &readfds)) {
            readn = read(rfd, &buf, sizeof(buf));
            if(readn == 0)
                printf("Partner has left the chat\n");
            write(1, &buf, readn);
        }
    }
    return 0;
}