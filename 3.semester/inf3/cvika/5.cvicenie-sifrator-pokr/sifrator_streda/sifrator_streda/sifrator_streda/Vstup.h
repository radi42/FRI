#pragma once
class Vstup
{
private:
	char *aMenoSuboru;
	
public:
	Vstup(const char *menoSuboru);
	~Vstup();
	unsigned char *nacitaj();
};

