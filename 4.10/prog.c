#include <stdio.h>

int main(int argc, char **argv)
{   
    argv++;
    for(; argc > 1; argc--, argv++) {
        if(*argv[0] != '-')
            printf("%s\n", *argv);
    }
    return 0;
}