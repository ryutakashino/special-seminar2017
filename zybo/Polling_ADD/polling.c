#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <assert.h>
#include <sys/mman.h>
#include <fcntl.h>

char inbyte(void){
    char in_data;
    int ret_val;

    in_data = getc(stdin);
    if (in_data == '\n')
        in_data = getc(stdin);
    return(in_data);
};

int main(){
    int inbyte_in;
    int val;
    int fd;
    volatile unsigned int *base;

    //UIO0
    fd = open("/dev/uio0", O_RDWR);
    if (fd<1) {
        fprintf(stderr, "/dev/uio0 open error\n");
        exit(-1);
    }
    base = (volatile unsigned int *)mmap(NULL, 0x10000, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);/*FPGAのレジスタをマッピング*/
    if (!base){
        fprintf(stderr, "LED4 mmap error \n");
        exit(-1);
    }
    
    while(1){
        printf("please enter arguments (0-7)\n");
	printf("in1(slv_reg1[2:0]):");
	scanf("%x", &val);
	base[1] = val; /*引数を入力*/
	
        printf("in2(slv_reg2[2:0]):");
	scanf("%x", &val);
	base[2] = val;

	printf("\n");
        
        printf("START\n");
　　　　　　　　　　　　　　　　base[0] = 0b01;　/*Validビットを1*/
	while(base[0]!=0b11){ /*Readyビットが1になるとループをぬける*/
	    printf("*");
	}
	printf("\n sum(slv_reg3[3:0]) is %d\n", base[3]);
	base[0] = 0b00; /*初期状態に戻す*/
        
        printf("END \n\n\n");
    }
    munmap((void *)base, 0x1000);
}
