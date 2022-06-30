#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

int main(int argc, char **argv)
{
    int f, n;
    if(argc < 2) {
        fprintf(stderr, "At least one parameter required\n");
        return 1;
    }
    f = open(argv[1], O_WRONLY | O_CREAT | O_TRUNC);
    if(f == -1) {
        perror(argv[1]);
        return 2;
    }
    while((scanf("%i", &n)) != EOF)
        write(f, &n, sizeof(int));
    close(f);
    return 0;
}