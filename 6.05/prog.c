#include <stdio.h>

int main(int argc, char **argv)
{
    int i;
    unsigned int ip1, ip2, ip3, ip4, ip;
    unsigned int mask  = 0b11111111111111111111111111111111;
    unsigned int mask1 = 0b11111111000000000000000000000000;
    unsigned int mask2 = 0b00000000111111110000000000000000;
    unsigned int mask3 = 0b00000000000000001111111100000000;
    unsigned int mask4 = 0b00000000000000000000000011111111;
    if(argc < 2) {
        fprintf(stderr, "IP address is not specified\n");
        return 1;
    }
    sscanf(argv[1], "%d.%d.%d.%d", &ip1, &ip2, &ip3, &ip4);
    ip1 <<= 24;
    ip2 <<= 16;
    ip3 <<= 8;
    ip = ip1 + ip2 + ip3 + ip4;
    for(i = 32; i > 0; i--) {
        ip &= mask;
        ip1 = ip2 = ip3 = ip4 = ip;
        ip1 &= mask1;
        ip2 &= mask2;
        ip3 &= mask3;
        ip4 &= mask4;
        ip1 >>= 24;
        ip2 >>= 16;
        ip3 >>= 8;
        mask <<= 1; 
        printf("%d.%d.%d.%d/%d\n", ip1, ip2, ip3, ip4, i);
    }
    return 0;
}