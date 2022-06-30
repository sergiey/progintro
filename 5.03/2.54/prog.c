#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <limits.h>

void handle_int_file(int fd, int *count, int *min, int *max)
{
    *count = *max = 0;
    *min = INT_MAX;
    int buf, res;
    while((res = read(fd, &buf, sizeof(buf))) != 0) {
        *min = *min < buf ? *min : buf;
        *max = *max > buf ? *max : buf;
        (*count)++;
    }
}

void write_data_in_file(FILE *fd, const char *name, int count,
    int min, int max)
{
    fprintf(fd, "%s: %d %d %d\n", name, count, min, max);
}

int main(int argc, char **argv)
{
    int fsrc, i, count, min, max;
    FILE *fres;
    if(argc < 3) {
        fprintf(stderr, "At least two file names required\n");
        return 1;
    }
    fres = fopen(argv[argc - 1], "w");
    if(!fres) {
        perror(argv[argc - 1]);
        return 2;
    }
    for(i = 1; i < argc - 1; i++) {
        fsrc = open(argv[i], O_RDONLY);
        if(fsrc == -1) {
            perror(argv[i]);
            continue;
        }
        handle_int_file(fsrc, &count, &min, &max);
        write_data_in_file(fres, argv[i], count, min, max);
    }
    return 0;
}