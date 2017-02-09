/**
 * <h2>Trieda Obdlznik</h2>
 * Tato trieda sluzi ako <b>priklad</b> pre vyucbu v predmete Informatika 1.
 * Obsahuje i dokumentaèné komentáre
 * 
 * @author Bene 
 * @version 4. 10. 2012
 */
public class Obdlznik
{
    //------------------------------------------------- Atribúty triedy --
    private static int pocetObdlznikov = 0;

    //--------------------------------------------------- Metódy triedy --
    public static int getPocetObdlznikov() {
        return pocetObdlznikov;
    }

    //--------------------------------------------- Atribúty insatancie --
    private double vyska;
    private double sirka;

    //---------------------------------------------------- Konštruktory --
    /**
     * Konstruktor s nastavenim atributov
     * @param vyska vyska obdlznika
     * @param sirka sirka obdlznika
     */
    public Obdlznik(double vyska, double sirka) {
        this.vyska = vyska;
        this. sirka = sirka;
        pocetObdlznikov++;
    }

    /**
     * Bezparametricky konstruktor
     */
    public Obdlznik() {
        this(0, 0);
    }

    //------------------------------------------------ Metódy instancie --
    //--------------------------- Gettery a settery --
    /**
     * Vrati vysku obdlznika
     * @return hodnota vysky obdlznika
     */
    public double getVyska() {
        return vyska;
    }

    /**
     * Vlozi novu hodnotu vysky
     * @param vyska vkladana hodnota vysky
     */
    public void setVyska(double vyska) {
        this.vyska = vyska;
    }

    /**
     * Vrati sirku obdlznika
     * @return hodnota sirky obdlznika
     */
    public double getSirka() {
        return sirka;
    }

    /**
     * Vlozi novu hodnotu sirky
     * @param sirka vkladana hodnota sirky
     */
    public void setSirka(double sirka) {
        this.sirka = sirka;
    }

    //----------------------------- Ostatne metody --
    /**
     * Vrati obvod obdlznika
     * @return hodnota obvodu
     */
    public double obvod() {
        return 2*vyska + 2*sirka;
    }

    /**
     * Vrati obsah obdlznika
     * @return hodnota obsahu
     */
    public double obsah() {
        return vyska*sirka;
    }

    /**
     * Vrati dlzku uhlopriecky
     * @return hodnota dlzky uhlopriecky
     */
    public double uhlopriecka() {
        return Math.sqrt(vyska*vyska + sirka*sirka);
    }

    public String toString() {
        return "[v= " + vyska + ", s= " + sirka + "]";
    }
}
