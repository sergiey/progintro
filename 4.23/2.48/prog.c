#include <stdlib.h>
#include <stdio.h>

int main(int argc, char **argv)
{
    int c;
    int nl = 0;
    FILE *f;
    if(argc < 2) {
        fprintf(stderr, "File name not specified\n");
        return 1;
    }
    f = fopen(argv[1], "r");
    if(!f) {
        perror(argv[1]);
        return 2;
    }
    while((c = fgetc(f)) != EOF) {
        if(c == '\n')
            nl++;
    }
    fclose(f);
    fprintf(stdout, "%d\n", ++nl);
    return 0;
}