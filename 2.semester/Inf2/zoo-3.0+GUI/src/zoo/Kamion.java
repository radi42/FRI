package zoo;

import java.io.Serializable;
import lib.*;
public class Kamion extends PrepravnyProstriedok implements Serializable
{
    //=================================================== Atribúty inštancie ==
    private double kapacitaObjemu;

    //========================================================= Konstruktory ==
    /**
     * Konstruktor kamionu
     * @param vodic vodič kamionu
     * @param kapacitaVahy  maximalna nosnost vozidla
     */
    public Kamion(Osoba vodic, double kapacitaVahy) {
        super(vodic, kapacitaVahy);
        this.kapacitaObjemu = 150;
    }

    /**
     * Priklad dalsieho konstruktoru.
     * @param kapacitaObjemu
     * @param kapacitaVahy
     */
    public Kamion( double kapacitaObjemu, double kapacitaVahy ) {
        super(null, kapacitaVahy);
        this.kapacitaObjemu = kapacitaObjemu;
    }

    //===================================================== Met�dy instancie ==
    public double dajKapacituObjemu() { return kapacitaObjemu; }

    public double dajKapacituVahy() { return getMaxPrepravnaVaha() - 50; }

    /**
     * Informácie o kamióne
     * @return
     */
    @Override
    public String infoOVozidle() {
        String str = "Kamión - " + super.toString() + "\n";
        for (Prepravitelny zasielka : pasazieri) {
            Zivocich zviera = (Zivocich) zasielka; // polymorf. cez dedičnost
            str += zviera.toString() + "\n";
        }
        return str;
    }

    /**
     * Textova informácia o vozidle.
     * @return text informacie
     */
    @Override
    public String toString() {
        return "Kamion: " + super.toString();
    }

}

