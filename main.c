#include <stdio.h>
#include <string.h>
#include "pstring.h"

int main() {
    Pstring p1;
    p1.len = 10;
    strcpy(p1.str,"abfdefghij");
    Pstring p2;
    p2.len = 9;
    strcpy(p2.str,"123456789");
    //run_main();
    printf("p1: %s\n",p1.str);
    printf("p2: %s\n",p2.str);
    Pstring* x = pstrijcpy(&p1,&p2,5,8);
    if(x){
        printf("x: %s\n",x->str);
    }
    printf("p1: %s\n",p1.str);
    printf("p2: %s\n",p2.str);
	//run_main();
	return 0;
}
