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
    int prevwordlength = 0;
    int letterscount = 0;
    int oddwords = 0;
    int evenwords = 0;
    while((c = getchar()) != EOF) {
        if(!isSpace(c)) {
            letterscount++;
        }
        else {
            prevwordlength = letterscount;
            if(prevwordlength == 0)
                goto PRNT;
            if(prevwordlength % 2)
                oddwords++;
            else
                evenwords++;
            letterscount = 0;
        }
        PRNT:
            if(c == '\n') {
            printf("Odd words: %d\n", oddwords);
            printf("Even words: %d\n", evenwords);
            oddwords = 0;
            evenwords = 0;
            letterscount = 0;
            prevwordlength = 0;
        }
    }
    return 0;
}