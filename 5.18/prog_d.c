#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
    int fd;
    if(argc < 3) {
        fprintf(stderr, "At least two arguments required\n");
        return 1;
    }
    fflush(stdout);
    fd = open(argv[1], O_WRONLY | O_APPEND);
    if(fd == -1) {
        perror(argv[1]);
        exit(1);
    }
    dup2(fd, 1);
    close(fd);
    execvp(argv[2], argv + 2);
    perror(argv[2]);
    return 0;
}