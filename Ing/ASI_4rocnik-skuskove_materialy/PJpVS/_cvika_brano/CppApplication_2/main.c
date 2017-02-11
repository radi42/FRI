/* 
 * File:   main.c
 * Author: student
 *
 * Created on September 28, 2015, 11:12 AM
 */

#include <stdio.h>
#include <stdlib.h>

/*
 * 
 */
int main(int argc, char** argv) {
    
    int den;
    int mesiac;
    int rok;
    printf("Zadaj den: \n");
    scanf ("%d", &den);
    printf("Zadaj mesiac: \n");
    scanf ("%d", &mesiac);
    printf("Zadaj rok: \n");
    scanf ("%d", &rok);
    
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
                        {printf("Datum je neplatny \n");
                        return 0;}
                        break;
                        
                        
                    case 4:
                    case 6:
                    case 9:
                    case 11:
                        if (den >30)
                        {printf("Datum je neplatny \n");
                        return 0;}
                        break;
                        
                    case 2:
                        if (jePriestupny(rok))
                        {
                            if (den >29)
                            {
                                printf ("Datum je neplatny \n");
                                return 0;
                                 };
                        }
                        else {
                            if(den>28)
                            {printf ("Datum je neplatny \n");
                        return 0;}};
                        break;
                            
                }
           
            
            
            }else{printf("Den je neplatny \n");};
            
        
              
        }else{printf("Mesiac je neplatny \n");};
    
    }
    else{printf("Rok je neplatny \n");};
    
    printf ("datum je %d.%d.%d",den,mesiac,rok);
    
    
    return (EXIT_SUCCESS);
}

int jePriestupny(int rok)
    {
        if ((rok%4==0 && rok%100!=0)||(rok%400==0))
            return 1;
        else 
            return 0;}

//int jePlatny(int poRok,int paMesiac, int paDen)


