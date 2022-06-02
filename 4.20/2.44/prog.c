#include <stdio.h>
#include <stdlib.h>

char* init_char_array(int array_len)
{
    return malloc(array_len * sizeof(char));
}

int add_char_to_array(char c, char **array_ptr)
{
    static int content_len = 0;
    static int array_len = 5;
    if(c == '\n') {
        content_len = 0;
        return -1;
    }
    if(!*array_ptr)
        *array_ptr = init_char_array(array_len);
    if(array_len <= content_len) {
        char *tmp = *array_ptr;
        array_len *= 2;
        *array_ptr = init_char_array(array_len);
        for(int i = 0; i < content_len; i++)
            (*array_ptr)[i] = tmp[i];
        free(tmp);
    }
    (*array_ptr)[content_len] = c;
    return ++content_len;
}

void print_char_array(char *array, int array_len)
{
    int i;
    for(i = 0; i < array_len; i++)
        printf("%c", array[i]);
}

void print_longest_number_in_char_array(char *array, int array_length)
{
    int longest_num = 0;
    int current_num = 0;
    for(int i = 0; i <= array_length; i++) {
        if(array[i] == '-' || (i == array_length)) {
            if(current_num > longest_num)
                longest_num = current_num;
            current_num = 0;
            continue;
        }
        current_num++;
    }
    current_num = 0;
    for(int i = 0; i <= array_length; i++) {
        if(array[i] == '-' || (i == array_length)) {
            if(current_num == longest_num) {
                print_char_array(&(array[i - longest_num]), longest_num);
                printf(" ");
                current_num = 0;
                continue;
            }
            current_num = 0;
            continue;
        }
        current_num++;
    }
}

int main()
{
    char c;
    char *arr = NULL;
    int data_len = 0;
    int isNumber = 0;
    while((c = getchar()) != EOF) {
        if(c == '\n') {
            if(data_len)
                print_longest_number_in_char_array(arr, data_len);
            printf("\n");
            add_char_to_array(c, &arr);
            free(arr);
            arr = NULL;
            data_len = 0;
            isNumber = 0;
            continue;
        }
        if(c >= '0' && c <= '9') {
            isNumber = 1;
            data_len = add_char_to_array(c, &arr);
        } else if(isNumber) {
            isNumber = 0;
            data_len = add_char_to_array('-', &arr);
        }
    }
    return 0;
}