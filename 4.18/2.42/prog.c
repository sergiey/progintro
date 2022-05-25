#include <stdio.h>
#include <stdlib.h>

struct item {
    char data;
    struct item *next;
};

void add_char_to_list(char c, struct item **first)
{
    struct item *tmp = malloc(sizeof(struct item));
    tmp->data = c;
    if(*first) {
        tmp->next = *first;
        *first = tmp;
    } else {
        *first = tmp;
        (*first)->next = NULL;
    }
}

void print_list(const struct item *list)
{
    for(; list; list = list->next)
        printf("%c", list->data);
}

void delete_list(struct item *list)
{
    if(list) {
        delete_list(list->next);
        free(list);
    }
}

int main()
{
    char c;
    struct item *first = NULL;
    while((c = getchar()) != EOF) {
        if(c != '\n')
            add_char_to_list(c, &first);
        else {
            print_list(first);
            printf("\n");
            delete_list(first);
            first = NULL;
        }
    }
    return 0;
}