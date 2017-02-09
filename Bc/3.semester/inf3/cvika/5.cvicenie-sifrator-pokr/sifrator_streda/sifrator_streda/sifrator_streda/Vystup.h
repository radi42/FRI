#pragma once
class Vystup
{
private:
	char *aMenoSuboru;
public:
	Vystup(const char *menoSuboru);
	~Vystup();
	bool zapis(const unsigned char *text);
};

