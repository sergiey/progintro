#include <signal.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>

volatile static sig_atomic_t is_quit = 0;
char c = '+';

void write_char()
{
    write(1, &c, sizeof(char));
}

void sigint_handler(int s)
{
    signal(SIGINT, sigint_handler);
    if(is_quit)
        exit(0);
    c = '-';
    is_quit = 1;
    write_char(); 
    alarm(1);
}

void sigquit_handler(int s)
{
    signal(SIGQUIT, sigquit_handler);
    c = '+';
    write_char();
    alarm(1);
}
   
void sigalarm_handler(int s)
{
    write_char();
    is_quit = 0;
    alarm(1);
}

int main()
{
    signal(SIGALRM, sigalarm_handler);
    signal(SIGQUIT, sigquit_handler);
    signal(SIGINT, sigint_handler);
    alarm(1);
    for(;;)
        pause();
    return 0;
}