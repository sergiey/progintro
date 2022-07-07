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

void merge_items_lists(int src_f, int dest_f)
{
    char is_exist;
    struct item src_buf, dest_buf;
    while(read(src_f, &src_buf, sizeof(src_buf)) != 0) {
        lseek(dest_f, 0, SEEK_SET);
        is_exist = 0;
        while(read(dest_f, &dest_buf, sizeof(dest_buf)) != 0) {
            if(!strcmp(src_buf.id, dest_buf.id)) {
                dest_buf.counter += src_buf.counter;
                lseek(dest_f, -sizeof(dest_buf), SEEK_CUR);
                write(dest_f, &dest_buf, sizeof(dest_buf));
                is_exist = 1;
                break;
            }
        }
        if(!is_exist)
            write(dest_f, &src_buf, sizeof(src_buf));
    }
}

int main(int argc, char ** argv)
{
    int dest_f, src_f, count;
    enum { bufsize = 1024 };
    unsigned int buf[bufsize];
    if(argc < 4) {
        fprintf(stderr, "Three parameters required\n");
        return 1;
    }
    dest_f = open(argv[3], O_RDWR | O_CREAT, 0660);
    if(dest_f == -1) {
        perror(argv[3]);
        return 1;
    }
    src_f = open(argv[1], O_RDONLY);
    if(src_f == -1) {
        perror(argv[1]);
        return 1;
    }
    while((count = read(src_f, &buf, sizeof(buf))) != 0)
        write(dest_f, &buf, count);
    src_f = open(argv[2], O_RDONLY);
    if(src_f == -1) {
        perror(argv[2]);
        return 1;
    }
    merge_items_lists(src_f, dest_f);
    return 0;
}