#include <stdio.h>
#include <stdlib.h>

struct item {
    char *filename;
    char *string;
    int length;
    int is_longest;
    struct item *next;
};

void add_item(struct item **first, struct item **last, char *file,
    char *str, int len)
{
    struct item *tmp = malloc(sizeof(struct item));
    tmp->filename = file;
    tmp->string = str;
    tmp->length = len;
    tmp->is_longest = 0;
    tmp->next = NULL;
    if(*first) {        
        (*last)->next = tmp;
        *last = tmp;
    }
    else
        *first = *last = tmp;
} 

void get_files_longest_string(char *file, struct item **first,
    struct item **last)
{
    FILE *f = fopen(file, "r");
    char *str;
    int c, offset = 0, counter = 0;
    int longest_len = 0, current_len = 0;
    if(!f) {
        perror(file);
        return;
    }
    while((c = fgetc(f)) != EOF) {
        counter++;
        current_len++;
        if(c == '\n') {
            if(current_len > longest_len) {
                longest_len = current_len;
                offset = counter - longest_len;
            }
            current_len = 0;
            continue;
        }
    }
    fseek(f, (long)offset, SEEK_SET);
    str = malloc(longest_len * sizeof(char));
    for(int i = 0; i < longest_len; i++) {
        c = fgetc(f);
        str[i] = (char)c;
    }
    fclose(f);
    add_item(first, last, file, str, longest_len);
}

void set_longest_string(struct item **first)
{
    int longest_len = 0;
    struct item *copy = *first;   
    while(*first) {
        longest_len = (*first)->length > longest_len ?
            (*first)->length : longest_len;
        *first = (*first)->next;
    }
    *first = copy;
    while(*first) {
        if(longest_len == (*first)->length)
            (*first)->is_longest = 1;
        *first = (*first)->next;
    }
    *first = copy;
}

void print_longest_strings(struct item **first)
{
    while(*first) {
        if((*first)->is_longest)
            printf("*");
        while(*(*first)->filename) {
            printf("%c", *((*first)->filename));
            (*first)->filename++;
        }
        printf(": ");
        for(int i = 0; i < (*first)->length; i++) {
            printf("%c", (*first)->string[i]);
        }
        *first = (*first)->next;
    }
}

int main(int argc, char **argv)
{
    int i;
    struct item *first = NULL, *last = NULL;
    if(argc < 2) {
        fprintf(stderr, "No file specified\n");
        return 1;
    }
    for(i = 1; i < argc; i++)
        get_files_longest_string(argv[i], &first, &last);
    set_longest_string(&first);
    print_longest_strings(&first);
    return 0;
}