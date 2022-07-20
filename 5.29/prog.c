#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>

volatile sig_atomic_t is_sigpipe = 0;

void sigpipe_handler(int s)
{   
    signal(SIGPIPE, sigpipe_handler);
    is_sigpipe = 1;
}

int main(int argc, char **argv)
{
    int status, i, wr;
    int fd[2], fdp[2];
    FILE *wfd;
    signal(SIGPIPE, sigpipe_handler);
    if(argc < 2) {
        fprintf(stderr, "At least one parameter required\n");
        return 1;
    }
    if(pipe(fd) == -1) {
        fprintf(stderr, "Couldn't open pipe\n");
        exit(1);
    }
    if(pipe(fdp) == -1) {
        fprintf(stderr, "Couldn't open pipe\n");
        exit(1);
    }
    if(fork() == 0) {
        dup2(fd[0], 0);
        dup2(fdp[1], 1);
        close(fd[0]);
        close(fd[1]);
        close(fdp[0]);
        close(fdp[1]);
        execvp(argv[1], argv + 1);
        perror(argv[1]);
        exit(1);
    }
    if(fork() == 0) {
        int c, lines = 0, chars = 0;
        FILE *rfd;
        close(fd[0]);
        close(fd[1]);
        close(fdp[1]);
        rfd = fdopen(fdp[0], "r");
        while((c = fgetc(rfd)) != EOF) {
            if(c == '\n')
                lines++;
            chars++;
        }
        close(fdp[0]);
        printf("Chars %d, lines %d\n", chars, lines);
        exit(0);
    }
    close(fd[0]);
    wfd = fdopen(fd[1], "w");
    for(i = 1; i < 100000; i++) {
        if(is_sigpipe) {
            printf("Exit by SIGPIPE\n");
            fflush(stdout);
            exit(1);
        }
        fprintf(wfd, "%d\n", i);
    }
    close(fd[1]);
    close(fdp[0]);
    close(fdp[1]);
    while((wr = wait(&status)) > 0) {
        printf("Process with pid %d is ended\n", wr);
        if(WIFEXITED(status))
            printf("Exit code %d\n", WEXITSTATUS(status));
        else
            printf("Exit signal %d\n", WTERMSIG(status));
    } 
    return 0;
}