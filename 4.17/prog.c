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
        ptr -> x = arr[i];
        ptr -> next = NULL;
        if(first) {
            last -> next = ptr;
            last = last -> next;  
        } else {
            first = last = ptr;
        }
    }
    return first;
}

struct item* int_array_to_list_rec(const int *arr, int len)
{
    struct item *ptr;
    if(len == 0)
        return NULL;
    ptr = malloc(sizeof(struct item));
    ptr -> x = *arr;
    ptr -> next = int_array_to_list_rec(++arr, --len);
    return ptr;
}

void print_list(const struct item *list)
{
    for(; list; list = list -> next)
        printf("%d ", list -> x);
}

int main()
{
    int arr[] = { 1, 3, 5, 7, 13, 15 };
    int arrlen = sizeof(arr) / sizeof(arr[0]);
    struct item *ptr = int_array_to_list_rec(arr, arrlen);
    print_list(ptr);
    printf("\n");
    return 0;
}