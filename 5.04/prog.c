#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <unistd.h>


int count_nl(const char *arr, int len)
{
    int i, count = 0;
    for(i = 0; i < len; i++) {
        if(arr[i] == '\n')
            count++;
    }
    return count;
}

int main(int argc, char **argv)
{
    int f, count, nl = 0;
    enum { bufsize = 4096 };
    char buf[bufsize];
    if(argc < 2) {
        fprintf(stderr, "One parameter required\n");
        return 1;
    }
    f = open(argv[1], O_RDONLY);
    if(f == -1) {
        perror(argv[1]);
        return 2;
    }
    while((count = read(f, &buf, sizeof(buf))) != 0)
        nl += count_nl(buf, bufsize);
    close(f);
    printf("Line numbers in %s: %d\n", argv[1], nl);
    return 0;
}