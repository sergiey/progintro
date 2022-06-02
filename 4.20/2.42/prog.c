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
    return content_len++;
}

void print_char_array(char *array, int array_len)
{
    int i;
    for(i = 0; i < array_len; i++)
        printf("%c", array[i]);
}

void print_char_array_reverse(char *array, int array_len)
{
    int posl = array_len - 1;
    int posr = posl;
    if(!array_len)
        return;
    while(posl != 0) {
        if(array[posl] == ' ') {
            print_char_array(&(array[posl + 1]), posr - posl);
            printf(" ");
            print_char_array_reverse(array, posl);
            return;
        }
        posl--;
    }
    print_char_array(array, posr - posl + 1);
}

int main()
{
    char c;
    int content_len = 0;
    char *arr = NULL;
    while((c = getchar()) != EOF)
        content_len = add_char_to_array(c, &arr);
    print_char_array_reverse(arr, content_len);
    printf("\n");
    return 0;
}