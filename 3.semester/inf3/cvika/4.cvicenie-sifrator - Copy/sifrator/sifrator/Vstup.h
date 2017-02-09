#pragma once
class Vstup
{
private:
	char *aMenoSuboru;
	
public:
	Vstup(const char *MenoSuboru);
	~Vstup();
	unsigned char *nacitaj();
};

