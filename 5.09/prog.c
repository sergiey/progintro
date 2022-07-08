#include <stdio.h>
#include <sys/stat.h>

int main(int argc, char **argv)
{
    struct stat buf;
    int res;
    if(argc < 2) {
        fprintf(stderr, "File name not specified\n");
        return 1;
    }
    res = stat(argv[1], &buf);
    if(0 == res) {
        printf("st_dev: %d\n", buf.st_dev);
        printf("st_ino: %llu\n", buf.st_ino);
        printf("st_mode: %d\n", buf.st_mode);
        printf("st_nlink: %d\n", buf.st_nlink);
        printf("st_uid: %d\n", buf.st_uid);
        printf("st_gid: %d\n", buf.st_gid);
        printf("st_rdev: %d\n", buf.st_rdev);
        printf("st_size: %lld\n", buf.st_size);
        printf("st_blksize: %d\n", buf.st_blksize);
        printf("st_blocks: %lld\n", buf.st_blocks);
        printf("st_atime: %ld\n", buf.st_atime);
        printf("st_mtime: %ld\n", buf.st_mtime);
        printf("st_ctime: %ld\n", buf.st_ctime);
    }
    return 0;
}