#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <unistd.h>


void add_int_to_file(int fd, int num)
{
    write(fd, &num, sizeof(int));
}

void add_char_to_file(FILE *fd, int c)
{
    fputc(c, fd);
}

void f(FILE *fsrc, FILE *fspc, int flen)
{
    int c;
    int strlen, spcstr = 0;
    while((c = fgetc(fsrc)) != EOF) {
        if(c == '\n') {
            add_int_to_file(flen, strlen);
            if(spcstr)
                add_char_to_file(fspc, c);
            strlen = spcstr = 0;
            continue;
        }
        if(c == ' ' && !strlen)
            spcstr = 1;
        if(spcstr)
            add_char_to_file(fspc, c);
        strlen++;
    }
}

int main(int argc, char **argv)
{
    FILE *fsrc, *fspc;
    int flen;
    if(argc < 4) {
        fprintf(stderr, "At least three parameters required");
        return 1;
    }
    fsrc = fopen(argv[1], "r");
    if(!fsrc) {
        perror(argv[1]);
        return 2;
    }
    fspc = fopen(argv[2], "w");
    if(!fspc) {
        perror(argv[2]);
        return 3;
    }
    flen = open(argv[3], O_WRONLY | O_CREAT | O_TRUNC);
    if(flen == -1) {
        perror(argv[3]);
        return 4;
    }
    f(fsrc, fspc, flen);
    fclose(fsrc);
    fclose(fspc);
    close(flen);
    return 0;
}
