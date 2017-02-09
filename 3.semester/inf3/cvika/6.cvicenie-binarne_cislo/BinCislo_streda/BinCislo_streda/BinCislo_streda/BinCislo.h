#pragma once
class BinCislo
{
private:
	// "binarne" cislo
	long long aCislo;
	long long Bin2LL(const char * bcislo);
	const char * LL2Bin(long long cislo, char * pomcislo);
public:
	BinCislo(const char *bcislo) : aCislo(0)
	{
		aCislo = Bin2LL(bcislo);
	}

	BinCislo(long long pcislo = 0) : aCislo(pcislo)
	{
		//aCislo = pcislo;
	}

	~BinCislo();

	void vypis();

	// operator scitania
	friend BinCislo operator +(BinCislo op1, BinCislo op2);
	friend BinCislo operator -(BinCislo op1, BinCislo op2);
	friend BinCislo operator *(BinCislo op1, BinCislo op2);
	friend BinCislo operator /(BinCislo op1, BinCislo op2);
	friend bool operator <(BinCislo op1, BinCislo op2);
	friend bool operator >(BinCislo op1, BinCislo op2);
	friend bool operator <=(BinCislo op1, BinCislo op2);
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
	//return !operator >(op1.aCislo, op2.aCislo);
	return !(op1 > op2);
}

inline bool operator ==(BinCislo op1, BinCislo op2)
{
	return op1.aCislo == op2.aCislo;
}

inline bool operator !=(BinCislo op1, BinCislo op2)
{
	//return op1.aCislo != op2.aCislo;
	return !(op1 == op2);
}