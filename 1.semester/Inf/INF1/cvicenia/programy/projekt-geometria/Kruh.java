
/**
 * Geometricky program - Trieda Kruh
 * 
 * @author Andrej Sisila
 * @version @version v0.1 beta
 */
public class Kruh
{
    //-------------------Atributy triedy --
    private double aR; //R - odvodene od maleho r - polomer
    
    //----------------- Konstruktory --
    /**
     * Parametricky kostruktor
     * vytvori instanciu kruhu
     * @param aR polomer
     */
    public Kruh(double aR)
    {
        this.aR = aR;
        
    }
    
    /**
     * Bezparametricky konstruktor
     */
    public Kruh()
    {
        this(8);
    }
    //--------------Metody --
    //--------------Settery a Gettery
    /**
     * vrati hodnotu polomeru
     * @return hodnota dlzky polomeru
     */
    public double getAR()
    {
        return aR;
    }
    
    /**
     * nastavi hodnotu polomeru
     */
    public void setAR(double aR)
    {
        this.aR = aR;
    }
    
    //--------------Vzorce
    /**
     * vzorec na obvod kruhu
     * @return obvod kruhu
     */
    public double obvodKruhu()
    {
        return 2*Math.PI*aR;
    }
    
    /**
     * vzorec na obsah kruhu
     * @return obsah kruhu
     */
    public double obsahKruhu()
    {
        return Math.PI * aR * aR;
    }
    
    /**
     * vypise polomer kruhu
     */
    public String toString()
    {
        return ("[polomer: " + aR + "]");
    }
    
    
}
