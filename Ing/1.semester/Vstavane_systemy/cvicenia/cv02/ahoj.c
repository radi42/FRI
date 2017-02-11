#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int min(int a, int b);

int main(int argc, char** argv) {
  
  char meno[30];
  int rok;
  
  /*
  printf("Zadaj svoje meno:\n");
  scanf("%s", meno);
  printf("Zadaj rok narodenia:\n");
  scanf("%d", &rok);

  printf("Ahoj! Volam sa %s a mam %d rokov.\n", meno, 2016-rok);
  */

  
  printf("&main=%p\n", &main);
  printf("&printf=%p\n", &printf);
  printf("&scanf=%p\n", &scanf);

  printf("sizeof(main)=%lu\n", sizeof(main));
  printf("velkost adresy = %p\n", sizeof(&meno));
  /*adresa premennej meno*/
  printf("&meno=%lu\n", &meno);
  /*velkost premennej meno*/
  printf("sizeof(meno)=%lu\n", sizeof(meno));
  /*posledna adresa premennej meno*/
  printf("velkost = %lu\n", (char*)(&meno)+sizeof(meno));




  printf("sizeof(\"meno\")=%d\n", sizeof("meno"));
  printf("&\"meno\"=%p\n",&"meno");
  printf("&\"meno\"=%p\n",&"meno");
  /*"meno"[0]='a';*/ /*urobi segfault*/
  printf("meno=%s\n",meno);
  meno[0]='a';
  printf("meno=%s\n",meno);

  printf("minimum z cisel %d a %d = %d\n", a, b, min(2,4));
  return 0;
}

int min(int a, int b)
{
  return a<b?a:b;
}
