#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>

int main()
{
    int rc;
    int fd[2];
    const char poem[] = 
        "Twice or thrice had I loved thee,\n"\
        "Before I knew thy face or name;\n"\
        "So in a voice, so in a shapeless flame,\n"\
        "Angels affect us oft, and worshipped be...\n";
    enum { buf_size = 1042 };
    char buf[buf_size];
    if(pipe(fd) == -1) {
        fprintf(stderr, "Couldn't open pipe\n");
        exit(1);
    }
    if(fork() == 0) {
        close(fd[0]);
        write(fd[1], &poem, sizeof(poem) - 1);
        exit(0);
    }
    close(fd[1]);
    while((rc = read(fd[0], &buf, buf_size)) > 0)
        write(1, &buf, rc);
    wait(NULL);
    return 0;
}