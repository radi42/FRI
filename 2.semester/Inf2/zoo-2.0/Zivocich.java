  

import java.io.*;
/**
 * <h2>Trieda Zivocich</h2>
 * Rodicovska trieda, od ktorej budu dedit vsetky instancie zivocichov.
 * Je abstraktna, lebo sme v deklaraci uviedli slovo abstract
 * To, ze je abstraktna, znamena ze z nej nemozeme vytvarat objekty     
 * @author Bene
 * @version 14.3.2012
 */

public abstract class Zivocich implements Serializable
{
    //============================================================ Konstanty ==
    public final int KOEF_OBJEMU = 10;

    //=============================================== Atributy instancie ==
    private String nazovDruhu;    // druh zivocicha = zebra, simpanz a pod.
    private String umiestnenie;   // voliera, bazen, klietka a pod.
    private int pocetKoncatin;    // nohy, horne koncatiny, plutvy, ...

    //===================================================== Konstruktory ==
    /**
     * Konstruktor s nastavenim vsetkych vlastnosti
     * 
     */
    public Zivocich(String nazovDruhu, String umiestnenie, int pocetKoncatin) {   
        this.nazovDruhu = nazovDruhu;
        this.umiestnenie = umiestnenie;
        this.pocetKoncatin = pocetKoncatin;
    }

    public Zivocich(String nazovDruhu, String umiestnenie) {   
        this(nazovDruhu, umiestnenie, 4);
    }

    //================================================= Metody instancie ==
    //
    //------------------------------------------------ Gettery a Settery --
    public String getNazovDruhu() { return nazovDruhu; }

    public String getUmiestnenie() { return umiestnenie; }

    public int getPocetKoncatin() { return pocetKoncatin; }

    public void setNazovDruhu(String nazovDruhu) {
        this.nazovDruhu = nazovDruhu;
    }

    public void setPocetKoncatin(int pocetKoncatin) {
        this.pocetKoncatin = pocetKoncatin;
    }

    //------------------------------------------------ Metody instancie --
    /**
     * Textova infomacia o instancii zivocicha
     * @return text informacie
     */
    public String toString() {
        return nazovDruhu + ": " + pocetKoncatin + " koncatiny, "
             + "umiestnenie: "+ umiestnenie + ", "; 
    }
} //koniec triedy

