#include "vstup.h"
#include "data.h"

//metoda naplna pole vyherneZreby jednotlivymi zrebmi
void pripravZreby()
{
	int i = 0;
	vyherneZreby[i].cislo = 100;
	strcpy(vyherneZreby[i].majitel, "A"); //funkcia dokaze prepisat retazce, menej bezpecna funkcia; 2 parametre: miesto a cim 
	i++;

	vyherneZreby[i].cislo = 101;
	strcpy(vyherneZreby[i].majitel, "B");
	i++;

	vyherneZreby[i].cislo = 102;
	strcpy(vyherneZreby[i].majitel, "C"); //funkcia dokaze prepisat retazce, menej bezpecna funkcia; 2 parametre: miesto a cim 
	i++;

	vyherneZreby[i].cislo = 103;
	strcpy(vyherneZreby[i].majitel, "D"); //funkcia dokaze prepisat retazce, menej bezpecna funkcia; 2 parametre: miesto a cim 
	i++;

	vyherneZreby[i].cislo = 104;
	strcpy(vyherneZreby[i].majitel, "E"); //funkcia dokaze prepisat retazce, menej bezpecna funkcia; 2 parametre: miesto a cim 
	i++;

	vyherneZreby[i].cislo = 105;
	strcpy(vyherneZreby[i].majitel, "F"); //funkcia dokaze prepisat retazce, menej bezpecna funkcia; 2 parametre: miesto a cim 
	i++;

	vyherneZreby[i].cislo = 106;
	strcpy(vyherneZreby[i].majitel, "A"); //funkcia dokaze prepisat retazce, menej bezpecna funkcia; 2 parametre: miesto a cim 
	i++;

	vyherneZreby[i].cislo = 107;
	strcpy(vyherneZreby[i].majitel, "G"); //funkcia dokaze prepisat retazce, menej bezpecna funkcia; 2 parametre: miesto a cim 
	i++;

	vyherneZreby[i].cislo = 108;
	strcpy(vyherneZreby[i].majitel, "H"); //funkcia dokaze prepisat retazce, menej bezpecna funkcia; 2 parametre: miesto a cim 
	i++;

	vyherneZreby[i].cislo = 109;
	strcpy(vyherneZreby[i].majitel, "I"); //funkcia dokaze prepisat retazce, menej bezpecna funkcia; 2 parametre: miesto a cim 
	i++;
}