#include <stdio.h>
#include <stdlib.h>

#define TEXT \
    "Humpty Dumpty sat on a wall\n" \
    "Humpty Dumpty had a great fall\n" \
    "All the king's horses and all the king's men\n" \
    "Couldn't put Humpty together again\n"

int main(int argc, char **argv)
{
    if(argc < 2) {
        fprintf(stderr, "File address not specified\n");
        exit(1);
    }
    FILE *f;
    f = fopen(argv[1], "w");
    if(!f) {
        perror(argv[1]);
        exit(2);
    }
    fprintf(f, TEXT);
    fclose(f);
    return 0;
}