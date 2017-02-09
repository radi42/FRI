
/**
 * Geometricky program - Trieda Obdlznik
 * 
 * @author Andrej Sisila
 * @version v0.1 beta
 */
public class Obdlznik
{
    //-------------------Atributy instancie --
    private double aSirka; //atrib typ double - lebo malokedy dostaneme cele cislo
    private double aVyska;
    private static int count = 0;
    
    //-------------------Konstruktory --
    /**
     * Parametricky konstruktor
     * vytvori instanciu obdlznika
     * @param aVyska vyska obdlznika
     * @param aSirka sirka obdlznika
     */
    public Obdlznik(double aSirka, double aVyska) //ak su nazvy parametrov aj atributov rovnake treba ich odlisit prikazom THIS
    {
        this.aSirka = aSirka;
        this.aVyska = aVyska;
        count++;
    }
    
    /**
     * Bezparametricky konstruktor
     */
    public Obdlznik()
    {
        aSirka = 7; //konstruktor this(7, 4, cont++); vypisuje chybu
        aVyska = 4;
        count++;
    }

    //---------------------Metody instancie --
    
    //--------------------- Settery a Gettery --
    /**
     * vrati hodnotu vysky
     * @return hodnota vysky obdlznika
     */
    public double getAvyska()
    {
        return aVyska;
    }
    
    /**
     * vrati hodnotu sirky
     * @return hodnota sirky obdlznika
     */
    public double getAsirka()
    {
        return aSirka;
    }
    
    /**
     * nastavi hodnotu vysky
     */
    public void setAvyska(double aVyska)
    {
        this.aVyska = aVyska;
    }
    
    /**
     * nastavi hodnotu sirky
     */
    public void setSirka(double aSirka)
    {
        this.aSirka = aSirka;
    }
    
    //---------------------- Vzorce --
    /**
     * vypocita obvod obdlznika
     */
    public double obvodObdlznika()
    {
        return 2*aVyska + 2*aSirka;
    }
    
    /**
     * vypocita obsah obdlznika
     */
    public double obsahObdlznika()
    {
        return aVyska * aSirka;
    }
    
    /**
     * vypocita uhlopriecku obdlznika
     */
    public double dlzkaUhlopriecky()
    {
        return Math.sqrt(aVyska*aVyska + aSirka*aSirka);
    }
    
    //--------------------Vypis --
    /**
     * vypise sirku a vysku obdlznika
     */
    public String toString()
    {
        return "[vyska = " + aVyska + "; sirka = " + aSirka+"]";
    }
    
    //--------------Pocitadlo instancii
    //http://stackoverflow.com/questions/5640272/count-instances-of-class/5640392#5640392
    //http://stackoverflow.com/questions/2506488/java-finalize-method-call     
    public int getPocetObdl()
    {
        return count;
    }
    //treba vytvorit metodu, ktora odcita count-- tesne pred odstranenim instancie
    
}
