#include <stdlib.h>
#include <stdio.h>

int main(int argc, char **argv)
{
    int c;
    if(argc < 2) {
        fprintf(stderr, "File name not specified\n");
        return 1;
    }
    FILE *f;
    f = fopen(argv[1], "r");
    if(!f) {
        perror(argv[1]);
        return 2;
    }
    while((c = fgetc(f)) != EOF)
        fputc(c, stdout);
    fclose(f);
    return 0;
}