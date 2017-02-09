#include <iostream>
#include <stdio.h>

#include "Vstup.h"

namespace cppvstup
{
	using namespace std;
	int vstup(const char *oznam)
	{
		int cislo;
		if(oznam != NULL && *oznam != '\0') //*oznam!=0; oznam[0]!=0;
			cout << oznam;
		cin >> cislo;
		return cislo;
	}
}

namespace cvstup
{
int vstup(const char *oznam)
	{
		int cislo;
		if(oznam != NULL && *oznam != '\0') //*oznam!=0; oznam[0]!=0;
			printf("%s", oznam);
		scanf("%d", cislo);
		return cislo;
	}
}