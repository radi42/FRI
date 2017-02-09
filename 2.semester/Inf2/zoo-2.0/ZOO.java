 

import lib.*;
import java.io.*;
/**
 * <h2>Trieda Zoo</h2>
 * Instancia typu Zoo ma manazera, zvierata a vozidla.
 * Je kompoziciou tychto objektov. 
 * 
 * @author bene 
 * @version 16.3.2012
 */
public class ZOO implements Serializable
{
    //===================================================== Atributy instancie ==
    private Osoba manazer;
    private Zverinec zvierataZOO;               // zoznam zvierat v ZOO
    private Zivocich zivocich;                  // pracovny atribut zivocicha
    private Kamion pracVozidlo;                 // Pracovne vozidlo

    //=========================================================== Konstruktory ==
    /**
     * Konstruktor s nastavenim atributov
     */
    public ZOO(Osoba manager, int kapacitaZverinca, int kapacitaAutoparku) {
        this.manazer  = manager;
        this.zvierataZOO = new Zverinec(kapacitaZverinca);
        this.pracVozidlo = null;     // neurcene
    }

    /**
     * Konstruktor vytvori prazdnu zoologicku zahradu
     */
    public ZOO() {
        this(null, 50, 10);
        // setManazer(new Osoba("Jan", "Novak", 26, 3, 1970));
    }

    //======================================================== Metody instancie ==
    //
    //------------------------------------------------------- Gettery a Settery --
    public Osoba getManazer() { return manazer; }

    public void setManazer(Osoba manazer) { this.manazer = manazer; }

    //----------------------------------------------------------- Ostatne metody --
    public Zivocich getZvierataZOO(int index) {
        return zvierataZOO.getZivocich(index);
    }

    /**
     * Pridanie zivocicha do zverinca ZOO
     * @param ziv vkladany zivocich
     * @return   true - ak je vlozeny<br>false - inak
     */
    public boolean pridajZivocicha(Zivocich ziv) {
        return zvierataZOO.add(ziv);
    }

    /**
     * Ziskanie zivocicha zo zverinca na danom indexe
     * @param i     index daneho zivocicha
     * @return  dany zivocich, alebo null, ak neexistuje
     */
    public Zivocich dajZivocicha(int i){
        return zvierataZOO.getZivocich(i);
    }

    /**
     * Odstrani zivocicha zo zverinca z daneho indexu
     * @param i  index daneho zvierata
     * @return  odstraneny zivocich, alebo<br>null - ak neexistuje
     */
    public Zivocich odstranZivocicha(int i){
        return zvierataZOO.odstranZivocicha(i);
    }

    public void setPracovneVozidlo() {
        pracVozidlo = new Kamion("Janko", "Hrasko", 1, 4, 1975, 1500);
    }

    public Kamion getPracovneVozidlo() {
        return pracVozidlo;
    }

    /**
     * Nalozenie zivocicha na vozidlo
     * @param ziv   vkladany zivocich
     * @return      true - nalozeny; false - nepodarilo sa
     */
    public boolean nalozZivocicha(Prepravitelny ziv) {
        return pracVozidlo.nalozZivocicha(ziv);
    }

    /**
     * Vylozenie zivocicha z vozidla
     * @param index index vykladaneho zivocicha
     * @return      vylozeny zivocich; null - ak nie je na vozidle
     */
    public Zivocich vylozZivocicha(int index) {
        Zivocich zviera = (Zivocich) pracVozidlo.vylozZivocicha(index);
        return zviera;
    }

    /**
     * Textova informacia o instancii ZOO
     */
    @Override
    public String toString(){
        return "**** Zoologicka zahrada v Hornej Dolnej ****"
             + "\nManazer: " + manazer
             + "\n--------\n" + zvierataZOO
             + "\n--------\n" + ( pracVozidlo == null
                                  ? "vozidlo nie je pristavene"
                                  : pracVozidlo );
    }

}

