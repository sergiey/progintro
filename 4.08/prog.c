#include <stdio.h>

int count_spaces_recur(const char *str)
{
    int count = 0;
    if(*str)
        count += count_spaces_recur(++str);
    return *str == ' ' ? ++count : count; 
}

int main()
{
    char s1[] = "Hello, world!\n";
    char s2[] = "Amicus Plato, sed magis amica veritas\n";
    char s3[] = "Cogito, ergo sum\n";
    printf(s1);
    printf("Spaces in string: %d\n", count_spaces_recur(&s1));
    printf(s2);
    printf("Spaces in string: %d\n", count_spaces_recur(&s2));
    printf(s3);
    printf("Spaces in string: %d\n", count_spaces_recur(&s3));
    return 0;
}