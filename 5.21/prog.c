#include <stdlib.h>
#include <signal.h>
#include <unistd.h>
#include <stdio.h>

volatile static sig_atomic_t n = 0;
volatile static sig_atomic_t is_sigusr1 = 0;

void sigint_handler(int s)
{
    signal(SIGINT, sigint_handler);
    n++;
}

void sigusr1_handler(int s)
{
    signal(SIGUSR1, sigusr1_handler);
    is_sigusr1 = 1;
}

int main()
{
    signal(SIGINT, sigint_handler);
    signal(SIGUSR1, sigusr1_handler);
    for(;;) {
        pause();
        if(is_sigusr1) {
            printf("\n%d\n", n);
            is_sigusr1 = 0;
        }
    }
    return 0;
}