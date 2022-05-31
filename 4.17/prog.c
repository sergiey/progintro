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

struct item* int_array_to_list_rec(const int *arr, int len)
{
    struct item *ptr;
    if(len == 0)
        return NULL;
    ptr = malloc(sizeof(struct item));
    ptr->x = *arr;
    ptr->next = int_array_to_list_rec(++arr, --len);
    return ptr;
}

void print_list(const struct item *list)
{
    for(; list; list = list->next)
        printf("%d ", list->x);
}

int* int_list_to_array(struct item *list)
{
    struct item *list_copy = list;
    int len = 0;
    for(; list; list = list->next)
        len++;
    int *arr = malloc((len + 1) * sizeof(int));
    arr[0] = len;
    int i;
    for(i = 1; i <= len; i++) {
        arr[i] = list_copy->x;
        list_copy = list_copy->next;
    }
    return arr;
}

void print_int_array(int *arr)
{
    int i;
    for(i = 1; i <= arr[0]; i++)
        printf("%d ", arr[i]);
}

int get_array_element_number()
{
    static int x = 1;
    return x++;
}

int get_list_length(struct item *list)
{
    int len = 0;
    for(; list; list = list->next)
        len++;
    return len;
}   

int* int_list_to_array_rec(struct item *list)
{
    int pos = get_array_element_number();
    static int *arr;
    if(pos == 1) {
        int len = get_list_length(list);
        arr = malloc((len + 1) * sizeof(int));
        arr[0] = len;
        arr[1] = list->x;
    } else
        arr[pos] = list->x;
    if(list->next)
        int_list_to_array_rec(list->next);
    return arr;
}

int main()
{
    int arr[] = { 1, 3, 5, 7, 13, 15 };
    int arrlen = sizeof(arr) / sizeof(arr[0]);
    struct item *ptr = int_array_to_list_rec(arr, arrlen);
    print_list(ptr);
    printf("\n");
    int* arr2 = int_list_to_array_rec(ptr);
    print_int_array(arr2);
    printf("\n");
    return 0;
}