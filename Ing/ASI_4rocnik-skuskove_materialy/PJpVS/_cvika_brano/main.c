/* 
 * File:   main.c
 * Author: Luká
 *
 * Created on tvrtok, 2015, októbra 1, 14:52
 */

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

/*
 * 
 */
int main(int argc, char** argv) {

    int den;
    int mesiac;
    int rok;
    char rodnecislo[50];
    int vysledok = 0;
    
    
    printf("Zadaj rodne cislo: \n");
    fgets(rodnecislo,49,stdin);
    int pocetznakov = strlen(rodnecislo)-1;
    if (pocetznakov <9 || pocetznakov >10)
    {
        printf("Rodne cislo je dlhe alebo kratke \n");
        return (EXIT_FAILURE);
    }
    
    for(int i =0;i<pocetznakov;i++)
    {
        if(!isdigit(rodnecislo[i]))
        {
        printf("Rodne cislo neobsahuje cislo \n");
        return (EXIT_FAILURE);
    }
     long RC =atoi(rodnecislo);
        
     if(pocetznakov==10 && RC%11==0){
            printf("Rodne cislo je neplatne \n");
        return (EXIT_FAILURE);
           }
     char buffer[10];
     strncpy(buffer,rodnecislo,2);
     buffer[2]='\0';
     rok=atoi(buffer);
     
     if(pocetznakov == 9 ||rok>53)
         rok = rok+1900;
     else
         rok = rok+2000;
     
     strncpy(buffer,rodnecislo+2,2); // netreba davat buffer[2]='\0'; lebo kopirujem iba prve dva znaky
     mesiac=atoi(buffer);
    
     if(mesiac>12)
         mesiac -=50;
     
     strncpy(buffer,rodnecislo+4,2);
     den=atoi(buffer);
     
     
    }
        
   
    
    if(jePlatny(rok,mesiac,den))
    {
        printf("Datum je platny %d.%d.%d",den,mesiac,rok);
        return 1;
    }
    else
    {
        printf ("Datum je neplatny !");
        return 0;
    }
    
    
    
    
    
    return (EXIT_SUCCESS);
}

int jePriestupny(int rok)
    {
        if ((rok%4==0 && rok%100!=0)||(rok%400==0))
            return 1;
        else 
            return 0;}

int jePlatny(int rok,int mesiac, int den)
{
if(rok >1900)
        {
        if ( 1<= mesiac && mesiac <=12)
            {
            if(den >=1)
            {
                switch(mesiac)
                {
                    case 1:
                    case 3:
                    case 5:
                    case 7:
                    case 8:
                    case 10:
                    case 12:
                        if (den >31)
                        {printf("Den je neplatny \n");
                        return 0;}
                        break;
                        
                        
                    case 4:
                    case 6:
                    case 9:
                    case 11:
                        if (den >30)
                        {printf("Den je neplatny \n");
                        return 0;}
                        break;
                        
                    case 2:
                        if (jePriestupny(rok))
                        {
                            if (den >29)
                            {
                                printf ("Den je neplatny \n");
                                return 0;
                                 };
                        }
                        else {
                            if(den>28)
                            {printf ("Den je neplatny \n");
                        return 0;}};
                        break;
                            
                }
           
            
            
            }else{printf("Den je neplatny \n");
            return 0;};
            
        
              
        }else{printf("Mesiac je neplatny \n");
        return 0;};
    
    }
    else{printf("Rok je neplatny \n");
    return 0;};

}