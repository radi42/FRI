#pragma once
#include <cstdio>
#include <string.h>

int lengthFile(const char *meno){
	FILE *f = fopen(meno, "rb");//otvorime si structuru FILE a otvori v nom subor; rb: r znamena ze subor je otvoreny iba na citanie, b ze ho otvorime binarne a bez zbytocnych ukoncovacich znakov
	if (f != NULL){
		fseek(f, 0, SEEK_END);	//SEEK_END - skocime na koniec suboru
		int velkost = ftell(f);
		fclose(f);
		return velkost;
	}
	return 0;
}

char *copyString(const char *zdrojtext){
	if (zdrojtext && *zdrojtext){	//ak existuje smernik na zdrojtext
		int dlzka = strlen(zdrojtext);
		char *vystupnytext = new char[dlzka + 1];	//+ 1 lebo chceme pridat ukoncovaci znak; ak dame ne char[dlzka] + 1, pole znakov bude posunute o jedna a bude o jedna kratsie
		strcpy(vystupnytext, zdrojtext);
		return vystupnytext;
	}
	return NULL;
}