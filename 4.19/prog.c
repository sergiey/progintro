#include <stdio.h>
#include <stdlib.h>

struct item {
    int data;
    struct item *next;
};

void add_item_to_list(struct item **first, int n)
{
    struct item *tmp = malloc(sizeof(struct item));
    tmp->data = n;
    if(*first)
        tmp->next = *first;
    else
        tmp->next = NULL;
    *first = tmp;
}

void print_less_than_5_diff(const struct item *list)
{
    int diff;
    for(; list->next; list = list->next) {
        if(list->data > (list->next)->data)
            diff = list->data - (list->next)->data;
        else if(list->data < (list->next)->data)
            diff = (list->next)->data - list->data;
        else
            diff = 0;
        if(diff <= 5)
            printf("%d %d   ", list->data, (list->next)->data);
    }
}

int main()
{
    int check, n;
    struct item *first = NULL;
    while((check = scanf("%d", &n)) != EOF) {
        if(check != 1) {
            printf("Couldn't read number\n");
            return 1;
        }
        add_item_to_list(&first, n);
    }
    print_less_than_5_diff(first);
    printf("\n");
    return 0;
}