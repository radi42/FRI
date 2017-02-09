#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {

    int pips[2];
    char buf[255];
    char *inp="Toto je skuska rury rofl rofl rofl rofl rofl rofl rof lrof lrofl rofl rofl rofl rofl \n";
      
    if (pipe(pips)==-1) {
        perror("Chyba pri volani pipe ");
        exit(1);
     }
                  
    write(pips[1], inp, strlen(inp) + 1);
    read(pips[0], buf, 255);
                      
    printf("Dostal som:\n%s\n", buf);
                        
    exit(0);
}