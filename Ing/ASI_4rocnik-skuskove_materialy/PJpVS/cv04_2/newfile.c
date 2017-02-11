#include <stdio.h>
#include <stdlib.h>
#include <time.h>

/*
 * 
 */

 void vypis(int pole [][4],int riadky, int stlpce){
     int i,j;
     for( i=0; i<riadky;i++){
        for(j=0;j<stlpce;j++){
            printf(" %d",pole[i][j]);
        } 
        printf("\n");
     }
     
     printf("\n");
    }
 
 
 void naplnPole(int pole[][4],int riadky,int stlpce,int a,int b){
    int i,j;
     for( i=0; i<riadky;i++){
        for(j=0;j<stlpce;j++){
            pole[i][j]=a+rand()%(b-a+1);
        } 
        printf("\n");
     }
     
     printf("\n");
}
 
// 
 
int main(int argc, char** argv) {
    
    /*
     int pole[3][4];
     * int *pole[3]; //dopredu musime vediet ako velkema byt
     * int(*pole)[4]; 
     * pole > (int(*)[4])malloc(3*sizeof(int));
     * pole= (int **)malloc(3* sizeof (int*)); 
     *  
     * 
     */
    
    //int pole[3][6];
    
    srand(time(NULL));
    
    int n1=7;
    int n2=14;
    int pole[n1][n2];
    naplnPole(pole,n1,n2,10,90);
    vypis(pole,n1,n2);
    
    
    return (EXIT_SUCCESS);
}