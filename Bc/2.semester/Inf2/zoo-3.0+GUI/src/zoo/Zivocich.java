package zoo;

import java.io.Serializable;
import lib.*;

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
//     public final int KOEF_OBJEMU = 10;

    //=================================================== Atributy instancie ==
    protected String nazovDruhu;    // druh zivocicha = zebra, simpanz a pod.
    protected String umiestnenie;   // voliera, bazen, klietka a pod.
    protected Datum datNar;         // datum narodenia
    //========================================================= Konstruktory ==
    /**
     * Konstruktor s nastavenim vsetkych vlastnosti
     * 
     */
    public Zivocich(String nazovDruhu, String umiestnenie, Datum datNar) {   
        this.nazovDruhu = nazovDruhu;
        this.umiestnenie = umiestnenie;
        this.datNar = datNar;
    }

    public Zivocich(String nazovDruhu, String umiestnenie) {   
        this(nazovDruhu, umiestnenie, null);
    }

    //====================================================== Metody instancie ==
    //
    //----------------------------------------------------- Gettery a Settery --
    public String getNazovDruhu() {
        return nazovDruhu;
    }

    public String getUmiestnenie() {
        return umiestnenie;
    }

    public Datum getDatNar() {
        return datNar;
    }

    public void setNazovDruhu(String nazovDruhu) {
        this.nazovDruhu = nazovDruhu;
    }

    public void setDatNar(Datum datNar) {
        this.datNar = datNar;
    }
    
    /**
     * 
     */
    public String toString() {
        return nazovDruhu
             + " datum narodenia: " + datNar
             + ", umiestnenie: "+ umiestnenie + ", "; 
    }
}

