#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv)
{
    int i, leftp,prog_counter = 0;
    int fd[2];
    char ***progp;
    if(argc < 3) {
        fprintf(stderr, "At least 2 parameters required\n");
        exit(1);
    }
    progp = malloc(2 * sizeof(progp));
    leftp = 1;
    for(i = 1; i < argc; i++) {
        if(0 != strcmp(argv[i], ";;") && i != argc - 1)
            continue;
        else {
            int j, k = 0;
            if(i == argc - 1)
                k = 1;
            progp[prog_counter] =
                malloc((i - leftp + 1 + k) * sizeof(*progp));
            for(j = 0; j < i - leftp + k; j++)
                progp[prog_counter][j] = argv[leftp + j];
            progp[prog_counter][j] = NULL;
            prog_counter++;
            leftp = i + 1;
        }
    }
    if(pipe(fd) == -1) {
        fprintf(stderr, "Couldn't open pipe\n");
        exit(1);
    }
    if(fork() == 0) {
        close(fd[0]);
        dup2(fd[1], 1);
        close(fd[1]);
        execvp(progp[0][0], progp[0]);
        perror(progp[0][0]);
        exit(1);
    }
    if(fork() == 0) {
        close(fd[1]);
        dup2(fd[0], 0);
        close(fd[0]);
        execvp(progp[1][0], progp[1]);
        perror(progp[1][0]);
        exit(1);
    }
    close(fd[0]);
    close(fd[1]);
    wait(NULL);
    wait(NULL);
    return 0;
}