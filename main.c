#include <stdio.h>
#include <string.h>
#include "pstring.h"

int main() {


       Pstring p1;
       p1.len = 8;
       strcpy(p1.str,"abcdabcd");
       Pstring p2;
       p2.len = 10;
       strcpy(p2.str,"0123456789");
       run_func(35,&p1,&p2);
   /*
       //int x,y=6;

       printf("p1: %s\n",p1.str);
       printf("p2: %s\n",p2.str);
       Pstring * x= pstrijcpy(&p1,&p2,2,4);
       printf("hey %s\n",x->str);
       printf("p1: %s\n",p1.str);
       printf("p2: %s\n",p2.str);


/*
       //run_main();
       printf("p1: %s\n",p1.str);
       printf("p2: %s\n",p2.str);
       int x = pstrijcmp(&p1,&p2,-1,4);
       printf("x: %d\n",x);
       printf("p1: %s\n",p1.str);
       printf("p2: %s\n",p2.str);
        */

    run_main();
    return 0;
}
