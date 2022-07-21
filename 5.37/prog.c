#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <fcntl.h>
#include <syslog.h>

volatile static sig_atomic_t n = 0;
volatile static sig_atomic_t is_sigusr1 = 0;
volatile static sig_atomic_t is_sigalrm = 0;

void sigusr1_handler(int s)
{
    signal(SIGUSR1, sigusr1_handler);
    n++;
    is_sigusr1 = 1;
}

void sigalrm_handler(int s)
{
    signal(SIGALRM, sigalrm_handler);
    is_sigalrm = 1;
    alarm(30);
}

int main()
{
    int pid;
    time_t start_time = time(NULL);
    close(0);
    close(1);
    close(2);
    open("/dev/null", O_RDONLY);
    open("/dev/null", O_WRONLY);
    open("/dev/null", O_WRONLY);
    chdir("/");
    pid = fork();
    if(pid > 0)
        exit(0);
    setsid();
    pid = fork();
    if(pid > 0)
        exit(0);
    signal(SIGALRM, sigalrm_handler);
    signal(SIGUSR1, sigusr1_handler);
    alarm(30);
    pid = getpid();
    for(;;) {
        pause();
        sleep(5);
        if(is_sigusr1 || is_sigalrm) {
            openlog("progd", 0, LOG_USER);
            syslog(LOG_INFO, "prog deamon: pid = %d, SIGUSR1 recived = %d, "\
                "working time = %ld\n", pid, n, (time(NULL) - start_time) / 60);
            closelog();
            is_sigusr1 = 0;
            is_sigalrm = 0;
        }
    }
    return 0;
}