#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/uio.h>

struct item {
    char id[60];
    unsigned int counter;
};

void write_to_list(int fd, const struct item itm)
{
    int count = write(fd, &itm, sizeof(itm));
    if(count != sizeof(itm))
        fprintf(stderr, "Couldn't write data\n");
    close(fd);
}

void add_item_to_list(const char *file_name, const char *id)
{
    int i = 0;
    struct item new_item, tmp;
    for(; *id; id++, i++)
        new_item.id[i] = *id;
    new_item.id[++i] = 0;
    new_item.counter = 1;
    int f = open(file_name, O_RDWR | O_CREAT, 0660);
    if(f == -1) {
        perror(file_name);
        return;
    }
    while(read(f, &tmp, sizeof(tmp)) != 0) {
        if(!strcmp(tmp.id, new_item.id)) {
            new_item.counter += tmp.counter;
            lseek(f, -sizeof(new_item), SEEK_CUR);
            write_to_list(f, new_item);
            return;
        }
    }
    write_to_list(f, new_item);
}

void print_items_counter(const char *file_name, const char *id)
{   
    int i = 0;
    char str_id[60];
    struct item tmp;
    int f = open(file_name, O_RDONLY);
    if(f == -1) {
        perror(file_name);
        return;
    }
    for(; *id; id++, i++)
        str_id[i] = *id;
    str_id[++i] = 0;
    while(read(f, &tmp, sizeof(tmp)) != 0) {
        if(!strcmp(tmp.id, str_id)) {
            printf("%d\n", tmp.counter);
            return;
        }
    }
    printf("0\n");
}

void print_list_of_items(const char *file_name)
{
    struct item itm;
    int f = open(file_name, O_RDONLY);
    if(f == -1) {
        perror(file_name);
        return;
    }
    while(read(f, &itm, sizeof(itm)) != 0) {
        int i;
        for(i = 0; itm.id[i] != 0; i++)
            printf("%c", itm.id[i]);
        printf(": %d\n", itm.counter);
    }
    close(f);
}

int main(int argc, char **argv)
{
    if(argc < 3) {
        fprintf(stderr, "At least two parameters required\n");
        return 1;
    }
    if(argc >= 4 && !strcmp(argv[2], "add")) {
        add_item_to_list(argv[1], argv[3]);
    } else if(argc >= 4 && !strcmp(argv[2], "query")) {
        print_items_counter(argv[1], argv[3]);
    } else if(!strcmp(argv[2], "list")) {
        print_list_of_items(argv[1]);
    }
    return 0;
}