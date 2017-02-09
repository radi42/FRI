#pragma once
class Sifrator
{
private:
	char aCinnost;
	char *aHeslo;
	char *aVstupnySubor;
	char *aVystupnySubor;
public:
	Sifrator(char cinnost, const char *heslo, const char *vstupnySubor, const char *vystupnySubor);
	~Sifrator();

	void start();
};

