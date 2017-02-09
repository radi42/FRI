#pragma once
#include <cstdlib>
#include <cstring>
#include <cstdio>
#include "helper.h"

class Vstup
{
private:
	char *aMenoSuboru;
	bool aKlavesnica;
public:
	Vstup(char *menosuboru)
	{
		aMenoSuboru = NULL;
		if (menosuboru != NULL && *menosuboru)
		{
			int dlzka = strlen(menosuboru);
			aMenoSuboru = new char[dlzka + 1];
			strcpy(aMenoSuboru, menosuboru);
		}
	}

	~Vstup()
	{
		if (aMenoSuboru != NULL)
			delete[] aMenoSuboru;
	}

	unsigned char *citaj()
	{
		unsigned char *text{ NULL };
		if (aMenoSuboru != NULL)
		{
			FILE *f;
			f = fopen(aMenoSuboru, "rb");
			if (f != NULL)
			{
				int dlzka = dlzkaSuboru(aMenoSuboru);
				if (dlzka > 0)
				{
					text = new unsigned char[dlzka] + 1;
					fread(text, dlzka, 1, f);
					text[dlzka] = '\0';
				}
				fclose(f);
			}
		}
		return text;
	}
};

