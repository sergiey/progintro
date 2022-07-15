#include <signal.h>
#include <stdlib.h>
#include <unistd.h>

void handler(int s)
{
    const char message[] = "\nGood bye\n";
    write(1, message, sizeof(message) - 1);
    exit(0);
}

int main()
{
    const char message[] = "Press Ctrl-C to quit\n";
    write(1, message, sizeof(message) - 1);
    signal(SIGINT, handler);
    for(;;)
        pause();
    return 0;
}