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
    int morethan7letters = 0;
    int lessthan3letters = 0;
    int prewwordlength = 0;
    int letterscount = 0;
    while((c = getchar()) != EOF) {
        if(!isSpace(c)) {
            letterscount++;
        }
        else {
            prewwordlength = letterscount;
            letterscount = 0;
        }
        if(prewwordlength >= 1 && prewwordlength <= 2) {
            lessthan3letters++;
            prewwordlength = 0;
        }
        if(prewwordlength > 7) {
            morethan7letters++;
            prewwordlength = 0;
        }
        if(c == '\n') {
            printf("Words with more than 7 letters: %d\n", morethan7letters);
            printf("Words with less than 3 letters: %d\n", lessthan3letters);
            morethan7letters = 0;
            lessthan3letters = 0;
            letterscount = 0;
            prewwordlength = 0;
        }
    }
    return 0;
}