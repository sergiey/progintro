#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <unistd.h>

int main(int argc, char **argv)
{
    int f, count;
    unsigned int key;
    enum { bufsize = 1024 };
    unsigned int buf[bufsize], encr_buf[bufsize];
    if(argc < 2) {
        fprintf(stderr, "Two parameters required\n");
        return 1;
    }
    sscanf(argv[2], "%u", &key);
    f = open(argv[1], O_RDWR);
    if(f == -1) {
        perror(argv[1]);
        return 2;
    }
    while((count = read(f, &buf, sizeof(buf))) != 0) {
        int i;
        if(count == -1) {
            perror(argv[1]);
            return 3;
        }
        for(i = 0; i < count / 4; i++)
            encr_buf[i] = buf[i] ^ key;
        lseek(f, -count, SEEK_CUR);
        write(f, &encr_buf, count);
    }
    close(f);
    return 0;
}