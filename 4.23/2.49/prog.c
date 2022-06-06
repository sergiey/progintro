#include <stdio.h>

int main(int argc, char **argv)
{
    FILE *f;
    int c;
    if(argc < 2) {
        fprintf(stderr, "File name not specified\n");
        return 1;
    }
    f = fopen(argv[1], "w");
    if(!f) {
        perror(argv[1]);
        return 2;
    }
    while((c = getchar()) != EOF)
        fputc(c, f);
    fclose(f);
    return 0;
}