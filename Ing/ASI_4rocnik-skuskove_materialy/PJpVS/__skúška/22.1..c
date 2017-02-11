/* 
 * File:   main.c
 * Author: miamka
 *
 * Created on Piatok, 2016, január 22, 8:57
 */

#include <stdio.h>
#include <stdlib.h>

/*
 * 
 */


int main(int argc, char** argv) {
    FILE *fPointer;
    int pocet=0;
    printf("zadaj subor:");
    char nazov[200];
    scanf("%s",nazov);
    fPointer=fopen(nazov,"r");
     if (fPointer == NULL) {
        printf("neexistujuci subor\n");
        return (EXIT_FAILURE);
    }
   

    char struktura[20][256];
    char pomoc[20];
    
    printf("nacitane:\n");
      while(!feof(fPointer)) {
         fgets(struktura[pocet], 100, fPointer);
         printf("%s\n", struktura[pocet]);
         pocet++;
    }
   
    
     printf("zoradene:\n");
 for(int g=0; g < pocet ; g++){
        for(int h=g+1; h< pocet; h++)
        {            
            if(strcmp(struktura[g],struktura[h]) > 0)
            {
                strcpy(pomoc,struktura[g]);
                strcpy(struktura[g],struktura[h]);
                strcpy(struktura[h],pomoc);
            }
             
        }
    }

    for (int i = 0; i < pocet; i++){
        printf("%s\n", struktura[i]);
    }
     
    /* printf("\n\nPre pridanie polozky stlacte 1\n Pre zapis do suboru 2\n pre Koniec 0");
     int volba=-1;
     scanf("%d",&volba);
     */ 
     char slovo[1][256];
     
     printf("zadaj nove slovo:");
     fgets(&slovo,256,stdin);
     pocet=pocet+1;
     scanf("%s",&slovo);
     //fgets(struktura[pocet],200, &slovo);
     //fgets(struktura[pocet],256,stdin);
    strcpy(struktura[pocet-1],slovo[0]);
      for (int i = 0; i < pocet; i++){
        printf("%s\n", struktura[i]);
    }
    
           FILE *fPointer1;
    fPointer1=fopen("vystup.txt","w");
    for(int g=0;g<pocet;g++)
    fprintf(fPointer1,"%s",struktura[g]);
    fclose(fPointer1);

     
    return (EXIT_SUCCESS);
}