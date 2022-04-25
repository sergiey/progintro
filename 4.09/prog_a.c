#include <stdio.h>

int isSpace(char c)
{
    if(c == ' ' || c == '\t' || c == '\n')
        return 1;
    return 0;
}

int main()
{
    char c;
    int count = 0;
    char isWordStarted = 0;
    while((c = getchar()) != EOF) {
        if(!isSpace(c) && !isWordStarted) {
            count++;
            isWordStarted = 1;
        }
        if(isSpace(c)) 
            isWordStarted = 0;
    }
    printf("Words in stdin: %d\n", count);
    return 0;
}