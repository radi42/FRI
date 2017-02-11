/* 
 * File:   main.c
 * Author: klepo
 *
 * Created on Pondelok, 2015, októbra 5, 11:12
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>


int jePriestupny(int pomRok){
    
    if((pomRok%4==0 && pomRok%100!=0)||pomRok%400==0){
                  return 1;
                   }                
     else  return 0 ;
    }

int jePlatny(int rok,int mesiac, int den){
   if(rok<=1900){
        printf("zly rok!");
        return 0;
    }
    
    if(mesiac<1||mesiac>12){
        printf("zly mesiac !");    
        return 0;
    }
    switch(mesiac){
            case 2:            
                   
               if(jePriestupny(rok)){
                     if (den>29){
                        printf("datum je neplatny, pozor na februar!\n");
                        return 0;        
                        }
                     }
               else {
                     if(den>28) {
                       printf("datum je neplatny, pozor na februar !\n");
                       return 0;  
                     }    
                     
               }
               break; 
             
                  
            case 1:
            case 3:
            case 5:
            case 7:
            case 8:
            case 10:
            case 12:
                if(den>31){
                    printf("zadal si vela dni na dany mesiac, datum je neplatny\n");
                    return 0;
                }
                break;
                
                
            case 4:
            case 6:
            case 9:
            case 11:
                if(den>30){
                    printf("zadal si vela dni na dany mesiac,datum je neplatny\n");
                   return 0;
                }
                break;                        
        }    
    
    if(den>=1 && den<=31){       
        
        printf("Datum %d.%d.%d je platny\n",den,mesiac,rok);
    }
}

int rodneCislo(char rc[]){
    
    int pomDlzka;
    int i;
    //'8' ... 8  znak osem a odcitam znak nula... reprezent8cia  osmicky...
    //atoi vrati z retazca cislo ako int
    //atol to iste len vrati long
    //
    printf("zadaj rodne cislo\n");    
    fgets(rc, 49, stdin); 
    rc[strlen(rc)-1]='\0';
    pomDlzka= strlen(rc); //vrati dlzku retazca   
   
    
    if (pomDlzka <9 || pomDlzka >10){
        printf("neplatne rodne cislo\n");        
    //else printf("cislo je v poriadku");
     return 1;
    }
    
    else { 
         for (i = 0; i < pomDlzka; i++){
        
            if(!isdigit(rc[i])) //negacia teda ak nie je cislo... 
            return 1;      
           }
                        
        printf("zadal si dobry tvar rodneho cisla\n");
    }
    
    char buffer[10];
    strncpy(buffer, rc ,2); //strn copy nko vravi kolko kopirujem znakov v tomto pripade 2 
    buffer[2]='\0';
    int rok=atoi(buffer);
    
    if (pomDlzka==9)
        rok+=1900;
    else if (rok>53)
        rok+=1900;
    else
        rok+=2000;
    
    printf("rok je: %i\n", rok);
    
    strncpy(buffer, rc +2, 2);
    int mesiac= atoi(buffer);
    if (mesiac >50)
        mesiac=mesiac-50;
    printf("mesiac je: %i\n", mesiac);
    
    strncpy(buffer, rc +4, 2);
    int den= atoi(buffer);
    printf("den je: %i\n", den);
    
    if(!jePlatny(rok,mesiac,den))
        return 1;
    
    if (pomDlzka==10){
        
      int  pom=0;
      for(int i; i<pomDlzka; i++){
          if (i%2==0)
              pom+=(rc[i] -'0');
          else 
              pom-=(rc[i]-'0');
      }
      if (pom%11 !=0)
          printf("Rodne cislo nemoze existovat nie je delitelne 11-timi \n!");
          return 1;
    }
    return 0;
}

/*
 * 
 */
int main(int argc, char** argv) {
    
    char rc [50];
    
    if (rodneCislo(rc)==0)
        
        printf("RODNE CISLO JE NEPLATNE\n");
    else
        printf("RODNE CISLO JE PLATNE\n");
        

    return (EXIT_SUCCESS);
}



