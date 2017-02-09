#include <stdio.h>

//Databaza studentov
//o kazdom studentovi si uchovavame meno a znamku z testu
int main(int argc, char *argv[])
{
	FILE *pFile;
	char name[21];
	int grade;
	char textGrade;
	//este treba studentov do niecoho ukladat-ArrayList v C?
	
	pFile = fopen("/home/debian/OS/semestralka/databaza.txt", "w");
	printf("subor je otvoreny\n");
	
	if(pFile != NULL) printf("nasiel som subor\n");
	
	//nacitaj meno
	printf("Krstne meno: ");
	scanf("%s", name);
	fputs(name, pFile);
	
	//pridaj oddelovac
	fputs("|", pFile);
	
	//nacitaj znamku
	printf("Znamka: ");
	scanf("%d", &grade);
	textGrade = grade + '0';
	fputs(&textGrade, pFile);
	
	//pridaj novy riadok
	fputs("\n", pFile);
	
	fclose(pFile);
	printf("subor je uzavrety\n");
	getchar(); //cakanie na lubovolnu klavesu, ktora ukonci program
	return 0;
}