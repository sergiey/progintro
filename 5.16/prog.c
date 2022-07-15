/* Shell II */
                                                                           
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

struct word_item {
    char *word;
    struct word_item *next;
};

int is_space(char c)
{
    return c == ' ' || c == '\t' ? 1 : 0;
}

void add_char_to_word(char c, char **wordptr)
{
    **wordptr = c;
    *wordptr += 1;
    wordptr = &(*wordptr);
}

void print_string(const char *string)
{
    for(; *string; string++)
        printf("%c", *string);
}

int get_string_len(const char *word)
{
    int len = 0;
    for(; *word; word++)
        len++;
    return len;
}

void add_word_item_to_list(char *word, struct word_item **first,
    struct word_item **last)
{
    int word_len = get_string_len(word);
    if(!word_len)
        return;
    struct word_item *tmp = malloc(sizeof(struct word_item));
    tmp->word = malloc(word_len * sizeof(char));
    for(int i = 0; i < word_len; i++)
        tmp->word[i] = word[i];
    tmp->next = NULL;
    if(*first) {
        (*last)->next = tmp;
        *last = tmp;
    } else
        *first = *last = tmp;
}

void execute_cd(struct word_item *list)
{
    char *home_dir;
    if(!list->next) {
        if((home_dir = getenv("HOME"))) {
            if(chdir(home_dir))
                perror(home_dir);
        } else
            printf("Couldn't find home directory\n");
        return;
    }
    if(list->next->next) {
        printf("cd: too many arguments\n");
        return;
    }
    else {
        if(chdir(list->next->word))
            perror(list->next->word);
    }
}

int count_lists_elements(struct word_item *list)
{
    int count = 0;
    for(; list; list = list->next)
        count++;
    return count;
}

void execute_command(struct word_item *list)
{
    int pid, wcnt, i;
    char **args;
    if(!list)
        return;
    if(0 == strcmp(list->word, "cd"))
        execute_cd(list);
    else {
        pid = fork();
        if(pid == 0) {
            wcnt = count_lists_elements(list);
            args = malloc((wcnt + 1) * sizeof(char*));
            for(i = 0; list; list = list->next, i++)
                args[i] = list->word;
            args[i] = NULL;
            execvp(args[0], args);
            perror(args[0]);
            exit(1);
        } else
            wait(NULL);
    }
}

/* Function chars_to_words returns: 
    0 if added a character to the word,
    1 if typed odd number of quotes,
    2 if the word is finished */
int chars_to_words(char c, char** wordptr)
{
    static int word_goes_on = 0;
    static int quote_mode = 0, quotes_counter = 0;
    int res;
    if(c == '\n') {
        add_char_to_word(0, wordptr);
        res = quotes_counter % 2 ? 1 : 2;
        quotes_counter = 0;
        quote_mode = 0;
        return res;
    }
    if(c == '"') {
        quotes_counter++;
        if(quote_mode) {
            quote_mode = 0;
            add_char_to_word(0, wordptr);
            return 2;
        } else if(word_goes_on) {
            quote_mode = 1;
            add_char_to_word(0, wordptr);
            return 2;
        } else
            quote_mode = 1;
        return 0;
    }
    if(quote_mode) {
        add_char_to_word(c, wordptr);
    } else if(!is_space(c)) {
        word_goes_on = 1;
        add_char_to_word(c, wordptr);
    } else if(is_space(c) && word_goes_on) {
        add_char_to_word(0, wordptr);
        word_goes_on = 0;
        return 2;
    }
    return 0;
}

void unmatched_quotes_handler(char **buf_beginning, char **word)
{
    fprintf(stderr, "Error: unmatched quotes\n");
    *word = *buf_beginning;
}

void save_word_handler(char **buf_beginning, char **word)
{
    *word = *buf_beginning;
}

void free_word_item_list(struct word_item *list)
{
    if(list) {
        free_word_item_list(list->next);
        free(list->word);
        free(list);
    }
}

int main()
{
    enum { buf_size = 100 };
    enum result {
        char_is_taken,
        unmatched_quotes,
        save_word
    };
    for(;;) {
        int c;
        enum result res;
        char *buf = malloc(buf_size * sizeof(char));
        char *buf_beginning = buf;
        struct word_item *first, *last;
        first = last = NULL;
        printf("=> ");
        while((c = getchar()) != EOF) {
            res = chars_to_words(c, &buf);
            if(res == unmatched_quotes) {
                fprintf(stderr, "Error: unmatched quotes\n");
                buf = buf_beginning;
                goto clear;
            } else if(res == save_word) {
                buf = buf_beginning;
                add_word_item_to_list(buf_beginning, &first, &last);
            }
            if(c == '\n')
                break;
        }
        if(c == EOF) {
            printf("End of file\n");
            break;
        }
        // print_word_item_list(first);
        execute_command(first);
    clear:
        free_word_item_list(first);
        first = NULL;
        free_word_item_list(first);
        free(buf_beginning);
    }
    return 0;
}