#include <stdio.h>

int get_number_rank(int num)
{
    int count = 0;
    if(num <= 0)
        return 0;
    count++;
    return count += get_number_rank(num / 10);
}

void get_pow_str(char *str)
{
    int i, q;
    enum { max_range_num = 10000 };
    char *ptr = str;
    for(i = 1; i < max_range_num; i++) {
        q = i * i;
        sprintf(ptr, "%d", q);
        ptr += get_number_rank(q);
    }
}

void get_range_str(int from, int to, char *str)
{
    int i, j;
    enum { max_string_length = 80000 };
    if(from <= 0 || to <= 0)
        return;
    char pow_str[max_string_length];
    get_pow_str(pow_str);
    for(i = from - 1, j = 0; i < to; i++, j++) {
        str[j] = pow_str[i];
    }
}

int main(int argc, char **argv)
{
    enum { max_string_length = 1000 };
    int from, to;
    char str[max_string_length];
    if(argc < 3) {
        printf("Two arguments is required\n");
        return 1;
    }
    sscanf(argv[1], "%d", &from);
    sscanf(argv[2], "%d", &to);
    get_range_str(from, to, str);
    if(*str)
        printf("%s\n", str);
    return 0;
}