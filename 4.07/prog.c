#include <stdio.h>

int count_spaces(char *str)
{
    int count = 0;
    for(; *str; str++) {
        if(*str == ' ')
            count++;
    }
    return count;
}

int main()
{
    char s1[] = "Hello, world!\n";
    char s2[] = "Amicus Plato, sed magis amica veritas\n";
    char s3[] = "Cogito, ergo sum\n";
    printf(s1);
    printf("Spaces in string: %d\n", count_spaces(&s1));
    printf(s2);
    printf("Spaces in string: %d\n", count_spaces(&s2));
    printf(s3);
    printf("Spaces in string: %d\n", count_spaces(&s3));
    return 0;
}