#include <stdio.h>
#include <stdlib.h>

int get_str_length(const char *str)
{
    int count = 1;
    return *str ? count += get_str_length(str + 1) : 0;
}

int is_repeating_chars(char *str)
{
    int ptr;
    int len = get_str_length(str);
    for(ptr = 0; ptr < len; ptr++) {
        int i;
        for(i = ptr + 1; i < len; i++) {
            if(str[ptr] == str[i])
                return 1;
        }
    }
    return 0;
}

int main(int argc, char **argv)
{
    if(argc < 2) {
        printf("No arguments\n");
        exit(0);
    }
    int i;
    for(i = 1; i < argc; i++) {
        if(!is_repeating_chars(argv[i]))
            printf("%s\n", argv[i]);
    }
    return 0;
}