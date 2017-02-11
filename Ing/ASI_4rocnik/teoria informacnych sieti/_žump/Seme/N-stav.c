#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

float randomFloat(void);

float randomFloat() // funkcia generuje nahodne realne cislo v intervale (0,1)
{
  float r = (float) rand() / (float) RAND_MAX;
  return r;
}


int main()
{
  char temp[10];
  int pocet_hodnot;
  int aktualny_stav = 1;
  int pocet_stavov;
  int i, j, k;
  int vektor = 97;
  char files_to_plot[100];
  srand(time(NULL));
  
  // INICIALIZACIA SYSTEMU //
  system("clear");
  printf("Zadaj pocet generovanych cisel: ");
  scanf("%s", temp);
  pocet_hodnot = atoi(temp);

  printf("Zadaj pocet stavov: ");  
  scanf("%s", temp);
  pocet_stavov = atoi(temp);
  
  // VYTVORENIE PRECHODOVEJ MATICE //
  float prechodova_matica[pocet_stavov][pocet_stavov];
  for (i=0; i<pocet_stavov; i++)
  {
    for (j=0; j<pocet_stavov; j++)
    {
      printf("Zadaj prechod %d->%d: ", i+1, j+1);
      scanf("%f", &prechodova_matica[i][j]);
    }
  } 
  
  // VYTVORENIE KUMULACNEJ MATICE //
  float kumulacna_matica[pocet_stavov][pocet_stavov];
  for (i=0; i<pocet_stavov; i++)
  {
    float sucet_riadok = 0;
    for (j=0; j<pocet_stavov; j++)
    {  
      sucet_riadok = sucet_riadok + prechodova_matica[i][j];      
      kumulacna_matica[i][j] = sucet_riadok;
    }
  }
  
  int pole[pocet_hodnot]; // do pola ukladam cisla stavov, ktore nastali pri generovani
  
  // DYNAMICKA ALOKACIA PAMATE PRE MATICU HODNOT V STAVE //
  float **pr;
  pr = malloc(sizeof(float*) * pocet_stavov);
  for (i=0; i<pocet_stavov; i++)
  {
    *(pr + i) = malloc(sizeof(float) * pocet_hodnot);
  }
  for (i=0; i<pocet_stavov; i++)
  {
    for (j=0; j<pocet_hodnot; j++)
    {
      pr[i][j] = (float) 0;
    }
  }
  
  // INICIALIZACIE POLA PRE UKLADANIE POCTU VYSKYTU DANEHO STAVU //
  int *sucty_stavov;
  sucty_stavov = malloc(sizeof(int*) * pocet_stavov);
  for (i=0; i<pocet_stavov; i++)
  {
    sucty_stavov[i] = 0;
  }
  
  // HLAVNA FUNKCIA PROGRAMU DIP2 //
  for (i=0; i<pocet_hodnot; i++)
  {
    float nahodna = randomFloat();
    for (j=0; j<pocet_stavov; j++)
    {
      if (nahodna < kumulacna_matica[aktualny_stav][j])
      {
        pole[i] = j;
        aktualny_stav = j;
        sucty_stavov[j]++; 
        for (k=0; k<pocet_stavov; k++)
        {
          pr[k][i] = (float) sucty_stavov[k] / (float) (i+1);
        }
        break; 
      }
    }
  }
  
  // ZAPIS DO SUBORU //
  strcpy(files_to_plot, "gnuplot -p -e \"plot");
  for (j=0; j<pocet_stavov; j++)
  {
    sprintf(temp, "%c", vektor);
    strcat(temp, ".txt");
    FILE *f = fopen(temp, "w");
    if (f == NULL)
    {
      printf("Chyba otvorenia suboru.\n");
      exit(1);
    }
    
    fprintf(f, "#\tX\tY\n");
    for (i=0; i<pocet_hodnot; i++)
    {
      fprintf(f,"%d\t%.5f\n", i, pr[j][i]);
    }
    fclose(f);
    vektor++;
    strcat(files_to_plot, " '");
    strcat(files_to_plot, temp);
    strcat(files_to_plot, "'");
    if (j != (pocet_stavov-1)) strcat(files_to_plot, ",");
    else strcat(files_to_plot, ";\"");
  }
  
  /* VYPIS KUMULACNEJ MATICE 
  for (int i=0; i<pocet_stavov; i++)
  {
    for (int j=0; j<pocet_stavov; j++)
    {  
      printf("%.2f ", kumulacna_matica[i][j]);
    }
    printf("\n");
  }
  */
  
  /* VYPIS POCTU VYSKYTOV DANEHO STAVU V GENEROVANOM TOKU
  for (i=0; i<pocet_stavov; i++)
  {
    printf("Stav %d: %dx\n", i, sucty_stavov[i]);
  }
  */
  
  // VYPIS POLA GENEROVANYCH HODNOT
  for (i=0; i<pocet_hodnot; i++)
  {
    printf("%d ", pole[i]);
  }  
  printf("\n");
  
  /* VYPIS MATICE HODNOT V STAVOCH
  for (i=0; i<pocet_stavov; i++)
  {
    for (j=0; j<pocet_hodnot; j++)
    {
      printf("%.2f ", pr[i][j]);
    }
    printf("\n");
  }
  */
  
  system(files_to_plot);
  return 0;
}