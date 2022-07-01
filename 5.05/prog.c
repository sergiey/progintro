#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>

int main(int argc, char **argv)
{
    int f, len, val, i, div, rem;
    long pos;
    enum { bufsize = 4096 };
    unsigned char buf[bufsize];
    if(argc < 5) {
        fprintf(stderr, "Four parameters required\n");
        return 1;
    }
    f = open(argv[1], O_WRONLY | O_CREAT, 0660);
    if(f == -1) {
        perror(argv[1]);
        return 2;
    }
    sscanf(argv[3], "%d", &len);
    sscanf(argv[4], "%d", &val);
    sscanf(argv[2], "%ld", &pos);
    for(i = 0; i < bufsize; i++)
        buf[i] = val;
    printf("start = %ld, len = %d, val = %d \n", pos, len, val);
    lseek(f, pos, SEEK_SET);
    if(len <= bufsize)
        write(f, &buf, len);
    else {
        div = len /bufsize;
        rem = len % bufsize;
        for(i = 0; i < div; i++)
            write(f, &buf, bufsize);
        write(f, &buf, rem);
    }
    close(f);
    return 0;
}
