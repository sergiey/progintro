#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

int main(int argc, char **argv)
{
    int fd;
    if(argc < 3) {
        fprintf(stderr, "At least two arguments required\n");
        return 1;
    }
    fflush(stdout);
    fd = open(argv[1], O_RDONLY);
    if(fd == -1)
        perror(argv[1]);
    dup2(fd, 0);
    close(fd);
    execvp(argv[2], argv + 2);
    perror(argv[2]);
    return 0;
}