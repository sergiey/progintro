#include <stdio.h>
#include <stdlib.h>

struct item {
    long data;
    struct item *next;
};

void add_item_to_list(long x, struct item **first, struct item **last)
{
    struct item *tmp = malloc(sizeof(struct item));
    tmp->data = x;
    tmp->next = NULL;
    if(*first) {
        (*last)->next = tmp;
        (*last) = tmp;
    } else {
        *first = *last = tmp;
    }
}

void print_list(const struct item *list)
{
    for(; list; list = list->next)
        printf("%ld ", list->data);
}

void print_nums_occurs_3_times_in_list(struct item *list)
{
    while(list) {
        int counter = 0;
        long n = list->data;
        struct item **pcur = &list;
        while(*pcur) {
            if((*pcur)->data == n) {
                counter++;
                struct item *tmp = *pcur;
                *pcur = tmp->next;
                free(tmp);
            } else {
                pcur = &(*pcur)->next;
            }
        }
        if(counter == 3)
            printf("%ld ", n);
    }
}

int main()
{
    long n;
    int check;
    struct item *first = NULL, *last = NULL;
    while((check = (scanf("%ld", &n))) != EOF) {
        if(check != 1) {
            printf("Couldn't read number\n");
            return 1;
        }
        add_item_to_list(n, &first, &last);
    }
    print_nums_occurs_3_times_in_list(first);
    printf("\n");
    return 0;
}