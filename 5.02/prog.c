#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <unistd.h>

int main()
{
    int count;
    enum { len = 4096 };
    void *buf = malloc(len);
    while((count = read(0, buf, len)) != 0)
        write(1, buf, count);
    return 0;
}
