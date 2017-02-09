
/**
 * Geometricky program - Trieda Stvorec
 * 
 * @author Andrej Sisila
 * @version v0.1 beta
 */
public class Stvorec
{
    //-------------------Atributy instancie --
    private double aStrana;
    
    
    //-------------------Konstruktory --
    /**
     * vytvori instanciu stvorca
     * @param aStrana dlzka strany
     */
    public Stvorec(double aStrana)
    {
        this.aStrana = aStrana;
    }
    
    /**
     * Bezparametricky konstruktor
     */
    public Stvorec()
    {
        this(5);
    }

    //---------------------Metody instancie --
    
    //---------------------Settery a Gettery --
    /**
     * vrati hodnotu strany
     * @return hodnota dlzky strany stvorca
     */
    public double getAStrana()
    {
        return aStrana;
    }
    
    /**
     * nastavi hodnotu dlzky strany
     */
    public void setAStrana(double aStrana)
    {
        this.aStrana = aStrana;
    }
    
    //-------------------- Vzorce --
    /**
     * vypocita obvod stvorca
     * @return vrati obvod stvorca
     */
    public double obvodStvorca()
    {
        return 4 * aStrana;
    }
    
    /**
     * vypocita obsah stvorca
     * @return vrati obsah stvorca
     */
    public double obsahStvorca()
    {
        return aStrana * aStrana;
    }
    
    /**
     * vypocita uhlopriecku stvorca
     */
    public double dlzkaUhlopriecky()
    {
        return Math.sqrt( 2*(aStrana*aStrana) );
    }
    
    //-------------------- Vypis --
    /**
     * vypise stranu obdlznika
     * @return vypise dlzku strany stvorca ako text
     */
    public String toString()
    {
        return "[strana = " + aStrana + "]";
    }
    
    
}
