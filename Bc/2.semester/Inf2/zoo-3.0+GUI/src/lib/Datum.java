package lib;

import java.io.Serializable;


/**
 * <h2>Praca s datumom.</h2>
 * Trieda datumu doplnena dalsimi metodami
 * 
 * @author Bene
 * @version 28. 10. 2013
 */
public class Datum implements Serializable
{
    ///////////////////////////////////////////////-- Atributy instancie --
    private int den;    // den datumu
    private int mesiac; // mesiac
    private int rok;    // rok
    
    /////////////////////////////////////////////////////-- Konstruktory --
    /**
     * Konstruktor uplny
     */
    public Datum(int den, int mesiac, int rok) {
        this.den = den;
        this.mesiac = mesiac;
        this.rok = rok;
//         pocetDatumov++;         // zvysi pocet vytvorenych datumov (static!!)
    }

    /**
     * Konstruktor so zakladnym datumom
     */
    public Datum() {
        this(1, 1, 1970);
    }

    /////////////////////////////////////////////////-- Metody instancie --
    //--------------------------------------------- Gettery a settery --
    public int getDen()    { return den; }
    public int getMesiac() { return mesiac; }
    public int getRok()    { return rok; }

    public void setDen(int den)       { this.den = den; }
    public void setMesiac(int mesiac) { this.mesiac = mesiac; }
    public void setRok(int rok)       { this.rok = rok; }

    //------------------------------------------------- dalsie metody --

    /** Staticka metoda triedy **
     * Zistenie poctu dni v danom mesiaci daneho roku
     * @param mesiac    dany mesiac
     * @param rok       dany rok
     * @return      zisteny pocet dni
     */
    public static int pocetDniVMesiaci(int mesiac, int rok) {
        switch (mesiac) {
            case 1: case 3: case 5: case 7: case 8: case 10: case 12:
                return 31;
            case 4: case 6: case 9: case 11:
                return 30;
            case 2: 
                return jePriestupny(rok) ? 29 : 28;
            default:
                return 0;
        }
    }

    /**
     * Zistenie poctu dni v aktualnom mesiaci aktualneho roku
     * @return      zisteny pocet dni
     */
    public int pocetDniVMesiaci() {
        return pocetDniVMesiaci(mesiac, rok);
    }

    /** Staticka metoda triedy **
     * Zistenie priestupnosti daneho roku
     * @param rok       dany rok
     * @return      <b>true</b> - ak je rok priestupny<br>
     *              <b>false</b> - rok je nepriestupny
     */
    public static boolean jePriestupny(int rok) {
        if (rok%4   != 0) return false;
        if (rok%100 != 0) return true;
        if (rok%400 != 0) return false;
        else              return true; 
    }

    /**
     * Zistenie priestupnosti aktualneho roku
     * @return      <b>true</b> - ak je rok priestupny<br>
     *              <b>false</b> - rok je nepriestupny
     */
    public boolean jePriestupny() {
        return  jePriestupny(rok);
    }

    /**
     * Zistenie poctu dni do zaciatku aktualneho roku<br>
     * Pocita sa vratane aktualneho datumu
     * @return zisteny pocet dni
     */
    public int pocetDniOdZaciatkuRoku() {
        int pocet = 0;
        for (int m=1; m < mesiac; m++) {
            pocet += pocetDniVMesiaci(m, rok);
        }
        return pocet + den;
    }

    /**
     * Zistenie poctu dni do konca aktualneho roku<br>
     * Pocita sa od nasledujuceho datumu
     * @return zisteny pocet dni
     */
    public int pocetDniDoKoncaRoku() {
        int pocet = jePriestupny() ? 366 : 365;
        return pocet- pocetDniOdZaciatkuRoku();
    }

    /**
     * Vrati den nasledujuci po aktualnom dni
     * @return instancia datumu nasledujuceho dna
     */
    public Datum dajZajtra() {
        int zDen = den + 1;
        int zMesiac = mesiac;
        int zRok = rok;
        
        if (zDen > pocetDniVMesiaci()) {
            zDen = 1;
            zMesiac++;
            if (zMesiac > 12) {
                zMesiac = 1;
                zRok++;
            }
        }
        return new Datum(zDen, zMesiac, zRok);
    }

    /**
     * Pocet dni po zadany datum zadany v parametroch
     * @param den       zadany den
     * @param mesiac    zadany mesiac
     * @param rok       zadany rok
     * @return    zisteny pocet dni
     */
    public int pocetDniPoZadanyDatum (int den2, int mesiac2, int rok2) {
        int pocet = pocetDniDoKoncaRoku();
        Datum datum2 = new Datum(den2, mesiac2, rok2);
        if (rok2 == getRok()) {    // sme v tom istom roku
            int zvysok = datum2.pocetDniDoKoncaRoku();
            return pocet - zvysok;
        }
        else {
            for (int r=rok+1; r<datum2.getRok(); r++) {
                pocet += jePriestupny(rok2) ? 366 : 365;
            }
            return pocet + datum2.pocetDniOdZaciatkuRoku();
        }
    }

    /**
     * Pocet dni po zadany datum zadany v parametroch
     * @param d       zadany datum
     * @return    zisteny pocet dni
     */
    public int pocetDniPoZadanyDatum (Datum d) {
        return pocetDniPoZadanyDatum(d.getDen(), d.getMesiac(), d.getRok());
    }

    /**
     * Textova informacia o instancii
     * @return textova informacia
     */
    public String toString() {
        return den + ". " + mesiac + ". " + rok;
    }

//     ///////////////////////////////////////////////////////-- Atributy triedy --
//     public static int pocetDatumov = 0;
// 
//     /////////////////////////////////////////////////////////-- Metody triedy --
//     /************* Staticka metoda
//      * Zistenie poctu vytvorenych datumov
//      */
//     public static int pocetDatumov() {
//         return pocetDatumov;
//     }

}
