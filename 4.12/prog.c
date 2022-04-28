#include <stdlib.h>
#include <stdio.h>

int str_len(const char *str)
{
    int len = 0;
    for(; *str; str++)
        len++;
    return len;
}

const char* get_entry_substr_in_str(const char *substr, const char *str)
{
    const char *ptr = substr;
    for(; *str; str++) {
        if(*ptr != *str) {
            str = str - (ptr - substr);
            ptr = substr;
            continue;
        }
        ptr++;
        if(!*ptr) {
            if(str_len(substr) == 1)
                return str;
            else
               return str - 1;
        }
    }
    return NULL;
}

void print_str_included_substr(const char *substr, const char *str)
{
    const char *adr = get_entry_substr_in_str(substr, str);
    if(adr)
        printf("%s\n", str);
}

int count_entries_substr_in_str(const char *substr, const char *str)
{
    int count = 0;
    if(!str)
        return 0;
    const char *adr = get_entry_substr_in_str(substr, str);
    if(adr) {
        count++;
        count += count_entries_substr_in_str(substr, adr + 1);
    }
    return count;
}

int main(int argc, char **argv)
{
    if(argc < 3) {
        printf("At least 2 arguments required\n");
        return 1;
    }
    int i;
    printf("Arguments which include '%s':\n", argv[1]);
    for(i = 2; i < argc; i++)
        print_str_included_substr(argv[1], argv[i]);
    printf("\n");
    for(i = 2; i < argc; i++) {
        if(get_entry_substr_in_str(argv[1], argv[i]))
            printf("Argument '%s' include '%s' %d times\n", argv[i], 
                argv[1], count_entries_substr_in_str(argv[1], argv[i]));
    }
    return 0;
}