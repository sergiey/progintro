#include <stdio.h>

int is_space(int c)
{
    if(c == ' ' || c == '\t' || c == '\n')
        return 1;
    return 0;
}

void remove_spaces_from_str(char *str)
{
    char *from = str;
    char *to = str;
    while(*from) {
        if(!is_space(*from)) {
            *to = *from;
            from++;
            to++;
        }
        else
            from++;
    }
    *to = 0;
}

int main()
{
    char str[] = "qwe rty  uio\t asd  ghj  12\n23";
    printf("%s\n", str);
    remove_spaces_from_str(str);
    printf("%s\n", str);
    return 0;
}