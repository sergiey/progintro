#include <stdio.h>

int is_space(int c)
{
    if(c == ' ' || c == '\t' || c == '\n')
        return 1;
    return 0;
}

int main()
{
    int c;
    int charcount = 0;
    int prevchar = -1;
    int curchar = -1;
    while((c = getchar()) != EOF) {
        if(!is_space(c))
            charcount++;
        if(!is_space(c) && prevchar)
            curchar = c;
        if(!is_space(c) && !prevchar)
            prevchar = c;
        if(is_space(c) && charcount == 2) {
            printf("%c%c ", prevchar, curchar);
            charcount = prevchar = curchar = 0;
        }
        if(is_space(c))
            charcount = prevchar = curchar = 0;
        if(c == '\n')
            printf("\n");
    }
    return 0;
}