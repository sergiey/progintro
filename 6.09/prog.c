#include <stdio.h>
#include <sys/select.h>

int main()
{
    int res, fd = 0;
    fd_set readfds;
    struct timeval timeout;
    char name[32];
    FD_ZERO(&readfds);
    FD_SET(fd, &readfds);
    timeout.tv_sec = 15;
    printf("What is your name please?\n");
    res = select(3, &readfds, NULL, NULL, &timeout);
    if(res == 0) {
        printf("Sorry, I'm terribly busy\n");
    }
    if(FD_ISSET(fd, &readfds)) {
        scanf("%s", name);
        printf("Nice to meet you, dear %s\n", name);
    }
    return 0;
}