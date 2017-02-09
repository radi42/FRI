import java.util.*;
/**
 * Trieda Pesnicka
 * @date Datum zaciatku: 22.11.2013
 * @author Andrej Sisila
 * @version v3.0
 */
public class Pesnicka
{
    /**
     * Atributy
     * private int cisloSkladby;
     * uklada poradove cislo pesnicky
     * 
     * private String interpret;
     * uklada nazov interpreta
     * 
     * private String nazovSkladby;
     * uklada nazov pesnicky
     * 
     * private String zaner;
     * uklada zaner pesnicky
     */
    private String interpret;
    private String nazovSkladby;
    private String zaner;
    
    /**
     * Parametricky konstruktor 1 - vsetky parametre
     * @param interpret
     * odovzdava nazov interpreta
     * 
     * @param nazovSkladby
     * odovzdava nazov pesnicky
     * 
     * @param zaner
     * odovzdava nazov zanra
     * 
     * cislo pesnicky automaticky nastavuje na 1
     */
    public Pesnicka(String interpret, String nazovSkladby, String zaner) {
        
        this.interpret = interpret;
        this.nazovSkladby = nazovSkladby;
        this.zaner = zaner;
    }
    
    /**
     * Parametricky konstruktor 2
     * chyba parameter zaner (predpokladajme, ze ho nepozname)
     * 
     * @param interpret
     * odovzdava nazov interpreta
     * 
     * @param nazovSkladby
     * odovzdava nazov pesnicky
     * 
     * cislo pesnicky automaticky nastavuje na 1
     */
    public Pesnicka(String interpret, String nazovSkladby) {
        
        this.interpret = interpret;
        this.nazovSkladby = nazovSkladby;
        this.zaner = "";
    }
    
    /**
     * Bezparametricky konstruktor
     * Vsetky parametre su predvolene dane
     * Sluzi na testovacie ucely
     */
    public Pesnicka() {
        this("Tiesto ft. Sneaky Sound System", "I Will Be Here", "Trance");
    }
    
    
    /**
     * Gettery
     */
    
    /**
     * Metoda getInterpret
     * @return interpret
     * vracia interpreta pesnicky
     */
    public String getInterpret() {
        return interpret;
    }
    
    /**
     * Metoda getNazovSkladby
     * @return nazovSkladby
     * vracia nazov pesnicky
     */
    public String getNazovSkladby() {
        return nazovSkladby;
    }
    
    /**
     * Metoda getZaner
     * @return zaner
     * vracia zaner pesnicky
     */
    public String getZaner() {
        return zaner;
    }
    
    
    /**
     * Settery
     */
    
    /**
     * Metoda setInterpret
     * Nastavuje interpreta pesnicky
     * @param interpret
     * odovzdava interpreta pesnicky
     */
    public void setInterpret(String interpret) {
        this.interpret = interpret;
    }
    
    /**
     * Metoda setNazovSkladby
     * Nastavuje nazov pesnicky
     * @param nazovSkladby
     * odovzdava nazov pesnicky
     */
    public void setNazovSkladby(String nazovSkladby) {
        this.nazovSkladby = nazovSkladby;
    }
    
    /**
     * Metoda setZaner
     * Nastavuje zaner pesnicky
     * @param zaner
     * odovzdava zaner pesnicky
     */
    public void setZaner(String zaner) {
        this.zaner = zaner;
    }
    
    
    /**
     * toString
     * @return strBuilder.toString
     * vypisuje formatovany vypis jednej pesnicky prostrednictvom triedy Formatter a StringBuffer
     */
    public String toString() {
        // vytvorenie referencnych premennych pre StringBuilder a Formatter
        //pouzil som StringBuilder, pretoze pri String premennej mi hlasilo chybu pre Formatter: neexistuje vhodny konstruktor
        StringBuilder strBuilder = new StringBuilder();
        
        //pouzitie StringBuildera vnutri Formattera pre usporiadanejsi vypis, nastavenie jazyka
        //podla predvolenych nastaveni systemu
        Formatter formatter = new Formatter(strBuilder, Locale.getDefault() );
        
        //formatovanie vypisu jednej pesnicky
        formatter.format("%-26s %-34s %-20s", interpret, nazovSkladby, zaner);
        
        //samotny vypis pesnicky
        System.out.println( strBuilder.toString() );
        return strBuilder.toString();
    }
}
