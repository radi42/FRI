 

import lib.*;
public class Kamion extends PrepravnyProstriedok
{
    //=================================================== Atributy instancie ==
    private double kapacitaObjemu;
    private static final int KAPACITA_POCTU = 100;

    //========================================================= Konstruktory ==
    /**
     * Konstruktor kamionu
     * @param meno          meno vodica
     * @param priezvisko    priezvisko vodica
     * @param den           den narodenia
     * @param mesiac        mesiac narodenia
     * @param rok           rok narodenia
     * @param kapacitaVahy  maximalna nosnost vozidla
     */
    public Kamion(String meno, String priezvisko, int den, int mesiac, int rok,
                  double kapacitaVahy) {
        super(new Osoba(meno, priezvisko, den, mesiac, rok), kapacitaVahy);
        this.kapacitaObjemu = 150;
    }

    /**
     * Priklad dalsieho konstruktoru
     */
    public Kamion( double kapacitaObjemu, double kapacitaVahy ) {
        super(null, kapacitaVahy);
        this.kapacitaObjemu = kapacitaObjemu;
    }

    //===================================================== Metody instancie ==

    @Override
    public double dajKapacituObjemu() { return kapacitaObjemu; }

    @Override
    public double dajKapacituVahy() { return getMaxPrepravnaVaha() - 50; }

    @Override
    public int dajKapacituPoctu() { return KAPACITA_POCTU; }

    /**
     * Textova informacia o vozidle
     * @return text informacie
     */
    public String toString() {
        return "Kamion: " + super.toString();    
    }

}

