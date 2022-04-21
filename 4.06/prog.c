#include <stdio.h>

int put_sum(int *a, int *b, int *c)
{
    int sum = *a + *b + *c;
    *a = sum;
    *b = sum;
    *c = sum;
    return sum;
}

int main()
{
    int a, b, c, sum;
    a = 1;
    b = 2;
    c = 3;
    printf("Variables before call function:");
    printf("a = %d, b = %d, c = %d\n", a, b, c);
    sum = put_sum(&a, &b, &c);
    printf("Variables after call function:");
    printf("a = %d, b = %d, c = %d\n", a, b, c);
    printf("Returned value %d\n", sum);
    return 0;
}
