#pragma once
class Sifrator
{
private:
	char aCinnost;
	char *aHeslo;
	char *aVstupnySubor;
	char *aVystupnySubor;
public:
	Sifrator(char cinnost, const char *heslo, 
		const char *vstupnysubor,
		const char *vystupnysubor);
	~Sifrator();

	void start();
};

