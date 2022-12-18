#include <stdio.h>
#include <string.h>
#include "pstring.h"

int main() {


       Pstring p1;
       p1.len = 5;
       strcpy(p1.str,"abcde");
       Pstring p2;
       p2.len = 5;
       strcpy(p2.str,"12345");
       run_func(32,p1,p2);
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
