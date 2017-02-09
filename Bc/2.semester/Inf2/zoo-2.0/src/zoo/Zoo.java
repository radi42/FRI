package zoo;

import lib.*;
/**
 * <h2>Trieda Zoo</h2>
 * Instancia typu Zoo ma manazera, zvierata a vozidla.
 * Je kompoziciou tychto objektov. 
 * 
 * @author bene 
 * @version 16.3.2012
 */
public class Zoo
{
    //===================================================== Atributy instancie ==
    private Osoba manazer;
    private Zverinec zverinecZOO;               // zoznam zvierat v Zoo
    private Kamion pracVozidlo;                 // Pracovne vozidlo
    //=========================================================== Konstruktory ==
    /**
     * Konstruktor s nastavenim atributov
     * @param manager
     * @param kapacitaZverinca
     */
    public Zoo(Osoba manager, int kapacitaZverinca) {
        this.manazer  = manager;
        this.zverinecZOO = new Zverinec(kapacitaZverinca);
        this.pracVozidlo = null;
    }

    public Zoo() {
        this(null, 50);
        setManazer(new Osoba("Jan", "Novak", 
                             new Datum(26, 3, 1970)));
    }

    //==================================================== Metody instancie ==
    public Osoba getManazer() { return manazer; }
    public void setManazer(Osoba manazer) { this.manazer = manazer; }
    public Zverinec getZverinecZOO() { return zverinecZOO; }
    public Kamion getPracVozidlo() { return pracVozidlo; }


    public void vytvorKamion() {
        Osoba man = new Osoba("Peter", "Hrasko", new Datum(5, 7, 1975));
        this.pracVozidlo = new Kamion(man, 1500);
    }

    /**
     * Naloženie živočícha na vozidlo
     * @param ziv
     * @return
     */
    public boolean nalozZivocicha(Prepravitelny ziv) {
        return pracVozidlo.nalozZivocicha(ziv);
    }

    @Override
    public String toString(){
        String vozidlo = pracVozidlo == null ? "vozidlo nie je pristavené"
                                             : pracVozidlo.toString();
        return "Manazer: " + manazer + "\n--------\n" + zverinecZOO
            + "\n--------\n" + vozidlo;
    }

    /**
     * @return informacia o zoo
     */
    public String info() {
        String str = "*** Zoologicka Zahrada ***\n";
        str += "Manazer: " + manazer + "\n-------------\n"
                + "Zverinec " + zverinecZOO + "\n-----------\n";
        return str;
    }
}

