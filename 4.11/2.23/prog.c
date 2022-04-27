#include <stdlib.h>
#include <stdio.h>

int is_spaced(int c)
{
    if(c == ' ' || c == '\t' || c == '\n')
        return 1;
    return 0;
}

int count_words_in_str(char *str)
{
    int word_started = 0;
    int count = 0;
    int i;
    for(i = 0; str[i]; i++) {
        if(!is_spaced(str[i]) && !word_started) {
            count++;
            word_started = 1;
            continue;
        }
        if(is_spaced(str[i]))
            word_started = 0;
    }
    return count;
}

int main(int argc, char **argv)
{
    if(argc != 2) {
        printf("Exactly one argument is required\n");
        return 1;
    }
    printf("Words in argument: %d\n", count_words_in_str(argv[1]));
    return 0;
}