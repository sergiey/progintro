#include <stdio.h>

int main()
{
    char c;
    char brac_balance = 1;
    int opbrac = 0;
    int clbrac = 0;
    enum { yes, no } a = 1;
    while((c = getchar()) != EOF) {
        if(c == '(')
            opbrac++;
        if(c == ')')
            clbrac++;
        if(clbrac > opbrac)
            brac_balance = 0;
        if(c == '\n') {
            if(brac_balance && opbrac == clbrac)
                a = yes;
            else
                a = no;
            switch(a) {
                case(yes): 
                    printf("YES\n");
                    break;
                case(no): 
                    printf("NO\n");
                    break;
                default:
                    printf("Somethings went wrong\n");
            }
            opbrac = clbrac = 0;
            brac_balance = 1;
        }
    }
    return 0;
}