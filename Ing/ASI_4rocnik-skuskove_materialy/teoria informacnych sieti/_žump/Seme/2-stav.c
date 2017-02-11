#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define NULY "nuly.txt"
#define JEDNOTKY "jednotky.txt"

float randomFloat(void);
void zapisSubor(char* meno, int pocet, float pr[]);

float randomFloat() // funkcia generuje nahodne realne cislo v intervale (0,1)
{
  float r = (float) rand() / (float) RAND_MAX;
  return r;
}

void zapisSubor(char* meno, int pocet, float pr[])
{  
  FILE *f = fopen(meno, "w");
  
  if (f == NULL)
  {
    printf("Chyba otvorenia suboru.\n");
    exit(1);
  }
  
  fprintf(f,"#\tX\tY\n");
  for (int i=0; i<pocet; i++)
  {
    fprintf(f,"%d\t%.5f;\n", i+1, pr[i]);
  }
  fclose(f);
}

int main()
{
  char temp[10];  int pocet;  int stav = 1;  int jednotky = 0;	int nuly = 0;;
  int i;  float alfa;  float gama;  float beta;
  srand(time(NULL));

  system("clear");
  printf("Zadaj pocet generovanych cisel: ");
  scanf("%s", temp);
  pocet = atoi(temp);
  printf("Zadaj alfa: ");
  scanf("%f", &alfa);
  printf("Zadaj beta: ");
  scanf("%f", &beta);
  
  int pole[pocet]; // pole urcene na ukladanie 0 a 1
  float prJednotky[pocet]; // pole kde sa ukladaju pravdepodobnosti nastatia 1 pre dany pokus i
  float prNuly[pocet];	  // pole kde sa ukladaju pravdepodobnosti nastatia 0 pre dany pokus i
  
  for (i=0; i<pocet; i++)
  {
    gama = randomFloat();
    if (stav == 1)
    {
      if (gama > alfa)
      {
        pole[i] = 1; stav = 1;
      }
      else
      {
        pole[i] = 0; stav = 0;
      } 
    }
    else
    {
      if (gama > beta) 
      {
        pole[i] = 0; stav = 0;
      }
      else
      {
        pole[i] = 1; stav = 1;
      } 
    }
    
    if (pole[i] == 0) nuly++;
    else jednotky++; 
    
    prNuly[i] = (float) nuly / (float) (i+1);
    prJednotky[i] = (float) jednotky / (float) (i+1);
      
    if ((i%30) == 0) printf("\n"); // jednoduche formatovanie vypisu nula a jednotiek do riadku po 30
    printf("%d ", pole[i]);
  }
  
  zapisSubor(JEDNOTKY, pocet, prJednotky);
  zapisSubor(NULY, pocet, prNuly);  
  printf("\n\nPocet nul: %d\nPocet jednotiek: %d\n", nuly, jednotky);
  system("gnuplot -p -e \"plot 'jednotky.txt', 'nuly.txt';\"");
  return 0;
}
