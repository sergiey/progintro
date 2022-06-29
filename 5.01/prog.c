#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

int main(int argc, char **argv)
{
    int fd;
    long long ls;
    if(argc < 2) {
        fprintf(stderr, "At least one argument required\n");
        return 1;
    }
    fd = open(argv[1], O_RDONLY);
    if(fd == -1) {
        perror(argv[1]);
        return 2;
    }
    ls = lseek(fd, 0, SEEK_END);
    close(fd);
    printf("File size is %lldB\n", ls);
    return 0;
}
