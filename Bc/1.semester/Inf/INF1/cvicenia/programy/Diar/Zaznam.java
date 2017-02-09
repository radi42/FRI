
/**
 * Write a description of class Zaznam here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Zaznam
{
    private String poznamka;
    private String datum;
    
    /**
     * vytvorme zaznam
     * @param ktory obsahuje Stringovu poznamku a
     * @param Stringovy datum
     */
    public Zaznam(String datum, String poznamka) {
        this.datum = datum;
        this.poznamka = poznamka;
    }
    
    /**
     * Gettery
     */
    /**
     *@return vrati hodnotu stringovej poznamky
     */
    public String getPoznamka(){
        return poznamka;
    }
    
    /**
     *@return vrati hodnotu stringoveho datumu
     */
    public String getDatum(){
        return datum;
    }
    
    /**
     * Settery
     */
    /**
     * @param prepise povodnu poznamku inym Stringom
     */
    public void setPoznamka(String poznamka){
        this.poznamka = poznamka;
    }
    
    /**
     * @param prepise povodny datum inym Stringom
     */
    public void setDatum(String datum){
        this.datum = datum;
    }
    
    /**
     * nechame to zaznam vypisat
     */
    public String toString(){
        String s = null;
        s = s.format("%-15s, %s", datum, poznamka);
        return s.replace(",", "");
    }
}
