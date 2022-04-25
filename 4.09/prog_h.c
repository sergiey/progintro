#include <stdio.h>

int main()
{
    char c;
    int count = 0;
    char isOpenBracket = 0;
    while((c = getchar()) != EOF) {
        if(c == '\n') {
            printf("Bracket pairs () in string: %d\n", count);
            count = 0;
            isOpenBracket = 0;
            continue;
        }
        if(c == '(')
            isOpenBracket = 1;
        else if(c == ')' && isOpenBracket) {
            count++;
            isOpenBracket = 0;
        }
        else
            isOpenBracket = 0;
    }
    return 0;
}