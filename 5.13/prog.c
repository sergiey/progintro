#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv)
{
    int status, wr, pid, i, leftp;
    int prog_counter = 1;
    char ***progp;
    if(argc < 2) {
        fprintf(stderr, "At least one parameter required\n");
        exit(1);
    }
    for(i = 1; i < argc; i++) {
        if(0 == strcmp(argv[i], ";;"))
            prog_counter++;
    }
    progp = malloc(prog_counter * sizeof(progp));
    leftp = 1;
    prog_counter = 0;
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
    int arr[prog_counter];
    for(i = 0; i < prog_counter; i++) {
        pid = fork(); 
        if(pid == -1) {
            perror("fork");
            exit(1);
        }
        if(pid == 0) {
            execvp(progp[i][0], progp[i]);
            perror(progp[i][0]);
            exit(1);
        } 
        arr[i] = pid;
    }
    do {
        wr = wait(&status);
        if(0 == WEXITSTATUS(status)) {
            for(i = 0; i < prog_counter; i++) {
                if(wr == arr[i])
                printf("%s\n", progp[i][0]);
            }
        }
    } while(wr != -1);
    return 0;
}