#include <stdio.h>

int get_and_zero(int *v)
{   
    int i = *v;
    *v = 0;
    return i;
}

int main()
{
    int v = 5;
    int w;
    printf("Var before call %d\n", v);
    w = get_and_zero(&v);
    printf("Var after call %d\n", v);
    printf("Returned value %d\n", w);
    return 0;
}