#pragma once
class BinCislo
{
private:
	// "binarne" cislo
	long long aCislo;

	// konverza cisla na retqaz "01"
	const char * LL2Bin(long long cislo, char * pomCislo);
	// konverzia "01" na long long dekadicky tvar
	long long Bin2LL(const char * bcislo);

public:
	BinCislo(long long pcislo = 0) //: aCislo(0)
	{
		aCislo = pcislo;
	}

	BinCislo(const char * bcislo) : aCislo(0)
	{
		aCislo = Bin2LL(bcislo);
	}

	~BinCislo();

	void vypis();

	friend BinCislo operator +(BinCislo op1, BinCislo op2);
	friend BinCislo operator -(BinCislo op1, BinCislo op2);
	friend BinCislo operator *(BinCislo op1, BinCislo op2);
	friend BinCislo operator /(BinCislo op1, BinCislo op2);

	friend bool operator <(BinCislo op1, BinCislo op2);
	friend bool operator >(BinCislo op1, BinCislo op2);
	friend bool operator <=(BinCislo op1, BinCislo op2);
	friend bool operator >=(BinCislo op1, BinCislo op2);
	friend bool operator ==(BinCislo op1, BinCislo op2);
	friend bool operator !=(BinCislo op1, BinCislo op2);
	

};

inline BinCislo operator +(BinCislo op1, BinCislo op2)
{
	return op1.aCislo + op2.aCislo;
}

inline BinCislo operator -(BinCislo op1, BinCislo op2)
{
	return op1.aCislo - op2.aCislo;
}

inline BinCislo operator *(BinCislo op1, BinCislo op2)
{
	return op1.aCislo * op2.aCislo;
}

inline BinCislo operator /(BinCislo op1, BinCislo op2)
{
	return op1.aCislo / op2.aCislo;
}

inline bool operator <(BinCislo op1, BinCislo op2)
{
	return op1.aCislo < op2.aCislo;
}

inline bool operator >(BinCislo op1, BinCislo op2)
{
	return op1.aCislo > op2.aCislo;
}

inline bool operator <=(BinCislo op1, BinCislo op2)
{
	//return op1.aCislo <= op2.aCislo;
	return  !(op1 > op2);
}

inline bool operator >=(BinCislo op1, BinCislo op2)
{
	//return op1.aCislo >= op2.aCislo;
	return  !(op1 < op2);
}

inline bool operator ==(BinCislo op1, BinCislo op2)
{
	return op1.aCislo == op2.aCislo;
}

inline bool operator !=(BinCislo op1, BinCislo op2)
{
	return !(op1.aCislo == op2.aCislo);
}