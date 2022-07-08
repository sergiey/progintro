#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>

int main(int argc, char **argv)
{
    int pid, status;
    if(argc < 2) {
        fprintf(stderr, "At least one parameter required\n");
        return 1;
    }
    pid = fork();
    if(pid == 0) {
        execvp(argv[1], argv + 1);
        perror(argv[1]);
        exit(1);
    } else {
        wait(&status);
        if(WIFEXITED(status)) {
            printf("Process has exited with code %d\n", WEXITSTATUS(status));
        } else {
            printf("Process was killed by signal %d\n", WTERMSIG(status));
        }
    }
    return 0;
}