#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

int main(int argc, char ** argv)
{
    int c, nl = 1, prnt = 0;
    int fd[2];
    FILE *f;
    if(argc < 2) {
        fprintf(stderr, "At least one parameter required\n");
        exit(1);
    }
    if(pipe(fd) == -1) {
        perror("pipe");
        exit(2);
    }
    if(fork() == 0) {
        close(fd[0]);
        dup2(fd[1], 1);
        close(fd[1]);
        execvp(argv[1], argv + 1);
        perror(argv[1]);
        exit(1);
    }
    close(fd[1]);
    f = fdopen(fd[0], "r");
    while((c = fgetc(f)) != EOF) {
        if(c == '\n') {
            if(prnt)
                putchar('\n');
            nl = 1;
            prnt = 1;
            continue;
        }
        if(nl) {
            if(c == ' ' || c == '\t')
                prnt = 1;
            else
                prnt = 0;
            nl = 0;
        }
        if(prnt)
            putchar(c);
    }
    wait(NULL);
    return 0;
} 