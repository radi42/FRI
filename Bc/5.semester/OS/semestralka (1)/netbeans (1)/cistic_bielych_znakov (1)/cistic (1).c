#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char** argv) {
    
    char buffer[256], blank[256];
    int i=0, j=0;
    
    printf("Zadajte slovo\n");
    fgets(buffer, 255, stdin);
    
    int velkostBuffra = strlen(buffer);
    printf("\nPocet znakov zadaneho retazca: ");
    printf("%d\n", velkostBuffra);
    
    while(i != velkostBuffra){
        if(buffer[i] == ' ' || buffer[i] == '\t' || buffer[i] == '\n' || buffer[i] == '\r')
        {
            i++;
        }
        else
        {
            //nasiel som normalny znak
            blank[j] = buffer[i];
            i++;
            j++;
        }
    }
    printf("Dlzka retazca bez bielych znakov: ");
    printf("%d\n",j);   //vypis dlzku noveho retazca
    blank[j] = '\0';    //pridaj null terminator na koniec retazca, inak bude na konci vypisovat divne znaky
    
    printf("\nRetazec bez bielych znakov\n");
    printf("%s\n", blank);
    printf("Pocet znakov: ");
    printf("%d\n", strlen(blank));
    
    char prikaz[11];
    if(strcmp(blank, strcpy(prikaz, "uloz")) == 0 ||
            strcmp(blank, strcpy(prikaz, "dajHodnotu")) == 0 ||
            strcmp(blank, strcpy(prikaz, "zmaz")) == 0){
        
            printf("\nPrikazovy retazec, ktory bude porovnavat server\n");
            printf("%s\n", prikaz);
            printf("Pocet znakov: ");
            printf("%d\n\n", strlen(prikaz));
    
        printf("Prikazy sa zhoduju a su podporovane serverom!\n");
    }
    else
    {
        printf("Server nepodporuje tento prikaz");
    }
    
    return (EXIT_SUCCESS);
}

