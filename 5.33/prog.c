#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <termios.h>

int main(int argc, char **argv)
{
    FILE *f;
    struct termios ts1, ts2;
    enum { buf_size = 128 };
    char file_pass[buf_size], type_pass[buf_size];
    if(argc < 2) {
        fprintf(stderr, "One parameter required\n");
        return 1;
    }
    if(!isatty(0)) {
        fprintf(stderr, "Not found associated terminal\n");
        return 2;
    }
    f = fopen(argv[1], "r");
    if(!f) {
        perror(argv[1]);
        return 3;
    }
    if(!fgets(file_pass, sizeof(file_pass), f)) {
        fprintf(stderr, "Couldn't read password from %s\n", argv[1]);
        return 4;
    }
    fclose(f);
    tcgetattr(0, &ts1);
    memcpy(&ts2, &ts1, sizeof(ts1));
    ts1.c_lflag &= ~ECHO;
    tcsetattr(0, TCSANOW, &ts1);
    printf("Type the password\n");
    if(!fgets(type_pass, sizeof(type_pass), stdin)) {
        fprintf(stderr, "Couldn't read typed password\n");
        return 5;
    }
    if(strcmp(type_pass, file_pass)) {
        fprintf(stderr, "Incorrect password\n");
        tcsetattr(0, TCSANOW, &ts2);
        return 6;
    }
    tcsetattr(0, TCSANOW, &ts2);
    return 0;
}