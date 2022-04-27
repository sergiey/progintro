#include <stdio.h>
#include <stdlib.h>

int get_str_length(const char *str)
{
    int count = 1;
    return *str ? count += get_str_length(str + 1) : 0;
}

int main(int argc, char **argv)
{
    int longest_arg, i;
    int longest_arg_len = 0;
    if(argc < 2) {
        printf("No arguments\n");
        exit(0);
    }
    for(i = 1; i < argc; i++) {
        int len = get_str_length(argv[i]);
        if(len > longest_arg_len) { 
            longest_arg_len = len;
            longest_arg = i;
        }
    }
    printf("Longest argumetn: %s\n", argv[longest_arg]);
    printf("It's length: %d\n", longest_arg_len);
    return 0;
}