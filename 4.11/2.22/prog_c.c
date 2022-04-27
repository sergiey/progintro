#include <stdio.h>
#include <stdlib.h>

int is_contained_at_dot(const char *str)
{
    int contained_dot = 0;
    int contained_one_at = 0;
    for(; *str; str++) {
        if(*str == '.')
            contained_dot = 1;
        if(*str == '@')
            contained_one_at++;
    }      
    if(contained_one_at != 1)
        contained_one_at = 0;
    if(contained_dot && contained_one_at)
        return 1;
    return 0;
}

int main(int argc, char **argv)
{
    if(argc < 2)
        exit(0);
    int i;
    for(i = 1; i < argc; i++) {
        if(is_contained_at_dot(argv[i]))
            printf("%s\n", argv[i]);
    }
    return 0;
}