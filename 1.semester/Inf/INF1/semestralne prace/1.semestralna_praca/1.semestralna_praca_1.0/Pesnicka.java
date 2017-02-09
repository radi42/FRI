import java.util.*;
/**
 * Trieda Pesnicka
 * @date Datum zaciatku: 22.11.2013
 * @author Andrej Sisila
 * @version v2.0
 */
public class Pesnicka
{
    /**
     * Atributy triedy
     */
    private int cisloSkladby;
    private String interpret;
    private String nazovSkladby;
    private String zaner;
    
    /**
     * ----------------------Parametricky konstruktor 1 - vsetky parametre
     */
    public Pesnicka(String interpret, String nazovSkladby, String zaner) {
        cisloSkladby = 1;
        this.interpret = interpret;
        this.nazovSkladby = nazovSkladby;
        this.zaner = zaner;
    }
    
    /**
     * ------------------------------Parametricky konstruktor 2
     * chyba parameter "zaner" v pripade, ze by sme si neboli isti
     */
    public Pesnicka(String interpret, String nazovSkladby) {
        cisloSkladby = 1;
        this.interpret = interpret;
        this.nazovSkladby = nazovSkladby;
        this.zaner = "";
    }
    
    /**
     * ---------------------Bezparametricky konstruktor (testovacie ucely)
     */
    public Pesnicka() {
        this("Tiesto ft. Sneaky Sound System", "I Will Be Here", "Trance");
    }
    
    
    /**
     * -----------------------------------------Gettery----------------------------------------
     */
    public int getCisloSkladby() {
        return cisloSkladby;
    }
    
    public String getInterpret() {
        return interpret;
    }
    
    public String getNazovSkladby() {
        return nazovSkladby;
    }
    
    public String getZaner() {
        return zaner;
    }
    
    
    /**
     * -----------------------------------------Settery----------------------------------------
     */
    public void setCisloSkladby(int cisloSkladby) {
        this.cisloSkladby = cisloSkladby;
    }
    
    public void setInterpret(String interpret) {
        this.interpret = interpret;
    }
    
    public void setNazovSkladby(String nazovSkladby) {
        this.nazovSkladby = nazovSkladby;
    }
    
    public void setZaner(String zaner) {
        this.zaner = zaner;
    }
    
    
    /**
     * -------------------------------------String toString-------------------------------------
     */
    public String toString() {
        StringBuilder strBuilder = new StringBuilder();
        Formatter formatter = new Formatter(strBuilder, Locale.getDefault() );
        
        formatter.format("%s %-16d %-26s %-34s %s", "",cisloSkladby, interpret, nazovSkladby, zaner);
        
        System.out.println( strBuilder.toString() );
        return strBuilder.toString();
    }
}
