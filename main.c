#include <stdio.h>
#include <string.h>
#include "pstring.h"

int main() {
    Pstring p;
    p.len = 10;
    strcpy(p.str,"abfdefghij");
    //run_main();
    printf("%s\n",p.str);
    Pstring* x = replaceChar(&p,'f','s');
    printf("%s\n",x->str);
	//run_main();
	return 0;
}
