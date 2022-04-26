#include <stdio.h>

int is_space(char c)
{
    if(c == ' ' || c == '\t' || c == '\n')
        return 1;
    return 0;
}

int main()
{
    char c;
    char word_started = 0;
    while((c = getchar()) != EOF) {
        if(!is_space(c) && !word_started) {
            printf("(");
            word_started = 1;
        }
        if(is_space(c) && word_started) {
            printf(")");
            word_started = 0;
        }
        printf("%c", c);
    }
    return 0;
}