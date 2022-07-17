#include <signal.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>

volatile static sig_atomic_t is_quit = 0;
volatile static sig_atomic_t show = 0;

void sigalrm_handler(int s)
{
    char msg[] = "\nAre you sleeping?\n";
    signal(SIGALRM, sigalrm_handler);
    write(1, msg, sizeof(msg));
    is_quit = 0;
    alarm(5);
}

void sigint_handler(int s)
{
    signal(SIGINT, sigint_handler);
    if(is_quit)
        exit(0);
    show = 1;
    is_quit = 1;
    alarm(5);
}

int main()
{
    int c, lines = 0, chars = 0;
    signal(SIGALRM, sigalrm_handler);
    signal(SIGINT, sigint_handler);
    alarm(5);
    while((c = getchar())) {
        if(c == '\n')
            lines++;
        else
            chars++;
        if(show) {
            printf("\nChars: %d, lines: %d\n", chars, lines);
            show = 0;
        }
        alarm(5);
    }
    return 0;
}