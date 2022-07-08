#include <stdio.h>
#include <sys/types.h>
#include <dirent.h>
#include <string.h>

void search_and_print_file_rec(const char *dir_name, const char *file_name)
{
    struct dirent *dent;
    DIR *dir = opendir(dir_name);
    enum { name_len = 1024 };
    char next_dir[name_len];   
    if(!dir) {
        perror(dir_name);
        return;
    }
    while((dent = readdir(dir)) != NULL) {
        if(dent->d_type == 4 && strcmp(dent->d_name, ".") &&
            strcmp(dent->d_name, "..")) {
            strncat(next_dir, dir_name, name_len);
            strncat(next_dir, "/", name_len);
            strncat(next_dir, dent->d_name, name_len);
            search_and_print_file_rec(next_dir, file_name);
            memset(next_dir, 0, name_len);
            continue;
        }
        if(0 == strcmp(dent->d_name, file_name)) {
            printf("%s\n", dir_name);
        }
    }
    closedir(dir);
}

int main(int argc, char **argv)
{
    if(argc < 2) {
        fprintf(stderr, "File name not specified\n");
        return 1;
    }
    search_and_print_file_rec(".", argv[1]);
    return 0;
}