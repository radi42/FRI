
/**
 * Trieda Cas.
 * Cas je reprezentovany trojicou hodiny, minuty, sekundy
 */
public class Cas 
{
    private int hod;
    private int min;
    private int sek;

    /**
     * Konstruktor
     */
    public Cas(int hod, int min, int sek) {
        this.hod = hod;
        this.min = min;
        this.sek = sek;
    }
    
    /**
     * Pocet sekund odpovedajuci danemu casu
     */
    public int pocetSekund() {
        return this.hod*60*60 + this.min*60 + this.sek;  
    }

    /**
     * Retazcova reprezentacia casu
     */
    public String toString() {
        return String.format("%2d:%2d:%2d", hod, min, sek);
    }

    //------------------------------------------- staticke metody --
    /**
     * Vrati cas odpovedajuci danemu poctu sekund
     * @param pocetSekund sekundy prepocitavane na cas
     */
    public static Cas getCas(int pocetSekund) {
        int t = pocetSekund;
        int s = t%60; 
        t = t/60;
        int m = t%60; 
        t = t/60;
        int h = t%60;
        return new Cas(h, m, s);
    }
}
