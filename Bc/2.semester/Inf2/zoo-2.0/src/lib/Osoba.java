package lib;

import lib.*;
import java.io.*;
/**
 * <h2>Trieda Osoba</h2> 
 * Zakladny typ osoby
 * @author Bene
 */
public class Osoba implements Serializable
{
    //------------------------------------------------------------------------------------- Atributy instancie --
    private String meno;
    private String priezvisko;
    private Datum datumNarodenia;

    //------------------------------------------------------------------------------------------- Konstruktory --
    /**
     * Konstruktor uplny vsetky atributy
     */ 
    public Osoba(String meno, String priezvisko, Datum datumNarodenia) {
        this.meno = meno;
        this.priezvisko = priezvisko;
        this.datumNarodenia = datumNarodenia;
    }

    /**
     * Konstruktor vsetky atributy, datum ako den, mesiac, rok
     */ 
    public Osoba(String meno, String priezvisko, int den, int mesiac, int rok) {
        this(meno, priezvisko, new Datum(den, mesiac, rok));
    }

    /**
     * Konstruktor bez datumu narodenia
     */
    public Osoba(String meno, String priezvisko) {
        this(meno, priezvisko, null);
    }

    public String toString() {
        return String.format("[%s %s narodeny: %s ]", meno, priezvisko, datumNarodenia);   
    }   
}
