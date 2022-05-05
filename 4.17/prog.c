#include <stdio.h>
#include <stdlib.h>

struct item {
    int x;
    struct item *next;
};

struct item* int_array_to_list(const int *arr, int len)
{
    int i;
    struct item *first = NULL, *last = NULL, *ptr;
    for(i = 0; i < len; i++) {
        ptr = malloc(sizeof(struct item));
        ptr->x = arr[i];
        ptr->next = NULL;
        if(first) {
            last->next = ptr;
            last = last->next;  
        } else {
            first = last = ptr;
        }
    }
    return first;
}

void print_list(const struct item *list)
{
    for(; list; list = list->next)
        printf("%d ", list->x);
}

int main()
{
    int arr[] = { 1, 5, 7, 9, 15 };
    struct item *ptr = int_array_to_list(arr, 5);
    print_list(ptr);
    printf("\n");
    return 0;
}