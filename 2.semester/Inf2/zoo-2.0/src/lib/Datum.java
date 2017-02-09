package lib;

/**
 * Trieda Datum udrziava a spracuva info o datume
 * 
 * @author Bene
 * @version  V-1-1 ;  (okt. 2012)
 */
public class Datum
{
    ///////////////////////////////////////////////-- Atributy instancie --
    private int den;        // den datumu
    private int mesiac;     // cislo mesiaca
    private int rok;        // rok datumu

    /////////////////////////////////////////////////////-- Konstruktory --
    /**
     * Konstruktor vytvori konkretny datum z parametrov
     * @param den    den vkladaneho datumu
     * @param mesiac cislo mesiaca
     * @param rok    rok vkladaneho datumu
     */
    public Datum(int den, int mesiac, int rok) {
        this.den = den;
        this.mesiac = mesiac;
        this.rok = rok;
        pocetDatumov++;
    }

    /**
     * Konstruktor vytvori pociatocny datum: 1. 1. 1970
     */
    public Datum() {
        this(1, 1, 1970);
    }

    //////////////////////////////////////////////////-- Metody instancie --
    //------------------------------------------- Gettery a Settery 
    public int getDen()    { return den; }
    public int getMesiac() { return mesiac; }
    public int getRok()    { return rok; }

    public void setDen(int den)       { this.den = den; }
    public void setMesiac(int mesiac) { this.mesiac = mesiac; }
    public void setRok(int rok)       { this.rok = rok; }

    //------------------------------------------- Ostatne metody 
    /**
     * Pocet dni v aktualnom mesiaci
     */
    public int pocetDniVMesiaci() {
        return pocetDniVMesiaci(mesiac, rok);
    }

    /**
     * Zisti, ci aktualny rok je priestupny
     * @return   <b>true</b> - ak je rok priestupny<br>
     *           <b>false</b> - rok je nepriestupny
     */
    public boolean jePriestupny() {
        return jePriestupny(rok);
    }

    /**
     * Vrati instanciu datumu nasledujuceho za aktualnym datumom
     * @return  datum nasledujuceho datumu
     */
    public Datum dajZajtra() {
        int zDen = den + 1;
        int zMesiac = mesiac;
        int zRok = rok;
        int pocetDniM = pocetDniVMesiaci();

        if (zDen > pocetDniM) {
            zDen = 1; zMesiac++;
            if (zMesiac > 12) {
                zMesiac = 1; zRok++;
            }
        }
        return new Datum(zDen, zMesiac, zRok);
    }

    /**
     * Zisti poradove cislo aktualneho dna v aktualnom roku
     * @return   pocet dni od zaciatku roku
     */
    public int poradCisloDnaVRoku() {
        int poradie=0;

        for (int i=1; i<mesiac; i++) {
            switch (i) {
                case 1: case 3: case 5: case 7: case 8: case 10: case 12: 
                    poradie=poradie + 31; break;
                case 4: case 6: case 9: case 11:
                    poradie=poradie + 30; break;
                case 2:
                    if (jePriestupny()) { poradie=poradie + 29; }
                    else                { poradie=poradie + 28; }
                    break;
            }             
        }
        return poradie + den;
    }

    /**
     * Informacia o aktualnej instancii
     * @return text informacie
     */
    public String toString() {
        return den + ". " + mesiac + ". " + rok;
    }

    ///////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////-- Atributy triedy --
    public static int pocetDatumov = 0;     // pocet instancii datumov

    ////////////////////////////////////////////////////-- Metody triedy --
    /**
     * Pocet dni v danom mesiaci daneho roku
     * @param mesiac cislo testovaneho mesiaca
     * @param rok    rok
     * @return  zisteny pocet dni
     */
    public static int pocetDniVMesiaci(int mesiac, int rok) {
        switch (mesiac) {
            case 2:
                if (jePriestupny(rok)) { return 29; }
                else                   { return 28; }
            case 4: case 6: case 9: case 11:
                return 30;
            default:
                return 31;
        }
    }

    /**
     * Zisti, ci zadany rok je priestupny
     * @param rok   testovany rok
     * @return      <b>true</b> - ak je rok priestupny<br>
     *              <b>false</b> - rok je nepriestupny
     */
    public static boolean jePriestupny(int rok) {
        return (rok%400 == 0) || ((rok%100 != 0) && (rok%4 == 0));
        ////// Druha moznost: ////////////////////////
//         if (  rok%4 != 0) return false;
//         if (rok%100 != 0) return true;
//         if (rok%400 != 0) return false;
//         else              return true; 
    }
}