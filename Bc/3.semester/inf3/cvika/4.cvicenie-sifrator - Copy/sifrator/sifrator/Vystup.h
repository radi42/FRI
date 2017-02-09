#pragma once
class Vystup
{
private:
	char *aMenoSuboru;
public:
	Vystup(const char *aMenoSuboru);
	~Vystup();
	bool zapis(const unsigned char *text);
};

