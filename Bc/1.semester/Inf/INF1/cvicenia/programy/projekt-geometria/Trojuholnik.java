
/**
 * Geometricky program - Trieda Trojuholnik
 * 
 * @author Andrej Sisila
 * @version v0.1 beta
 */
public class Trojuholnik
{
    private double aStranaA;
    private double aStranaB;
    private double aStranaC;
    
    /**
     * Parametricky konstruktor
     * vytvori instanciu Trojuholnik
     * @param aStranaA strana a
     * @param aStranaB strana b
     * @param aStranaC strana c
     */
    public Trojuholnik(double aStranaA, double aStranaB, double aStranaC)
    {
        this.aStranaA = aStranaA;
        this.aStranaB = aStranaB;
        this.aStranaC = aStranaC;
    }
    
    /**
     * Bezparametricky konstruktor
     */
    public Trojuholnik()
    {
        this(5, 6, 7);
    }
    
    //----------------Metody --
    //---------------Settery a Gettery --
    /**
     * vrati dlzku strany a
     * @return dlzka strany a
     */
    public double getAStranaA()
    {
        return aStranaA;
    }
    
    /**
     * vrati dlzku strany b
     * @return dlzka strany b
     */
    public double getAStranaB()
    {
        return aStranaB;
    }
    
    /**
     * vrati dlzku strany c
     * @return dlzka strany c
     */
    public double getAStranaC()
    {
        return aStranaC;
    }
    
    
    
    /**
     * nastavi dlzku strany a
     */
    public void setAStranaA(double aStranaA)
    {
        this.aStranaA = aStranaA;
    }
    
    /**
     * nastavi dlzku strany b
     */
    public void setAStranaB(double aStranaB)
    {
        this.aStranaA = aStranaB;
    }
    
    /**
     * nastavi dlzku strany c
     */
    public void setAStranaC(double aStranaC)
    {
        this.aStranaC = aStranaC;
    }
    
    //-------------- Test: Da sa trojuholnik skonstruovat? --
    /**
     * kontrola podmienky "dve strany su vacsie ako tretia"
     */
    public boolean Test()
    {
        if (aStranaA + aStranaB > aStranaC && 
            aStranaB + aStranaC > aStranaA &&
            aStranaC + aStranaA > aStranaB)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    
    //-------------- Vzorce --
    /**
     * vypocet obvodu trojuholnika
     * @return obvod trojuholnika
     */
    public double obvodTrojuh()
    {
        return aStranaA + aStranaB + aStranaC;
    }
    
    /**
     * vypocet obsahu trojuholnika - Heronov vzorec
     * @return obsah trojuholnika
     */
    public double obsahTrojuh()
    {
        double s;
        s = (aStranaA + aStranaB + aStranaC) / 2;
        return Math.sqrt( s * (s - aStranaA) * (s- aStranaB) * (s- aStranaC) );
    }
    
    public String toString()
    {
        return (
        "[strana a = " + aStranaA +
        "; strana b = " + aStranaB +
        "; strana c = " + aStranaC + "]"
        );
    }
    
    
}
