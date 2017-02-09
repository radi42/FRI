
/**
 * Info o stanici na vlakovaj linke
 */
public class Stanica
{
    // atributy
    private String nazov;
    private Cas cas;            // cas odchodu (u poslednej zastavky - prichodu)
    private int pocetVyst;      // pocet cestujucich vystupujucich v stanici
    private int pocetNast;      // pocet cestujucich nastupujucich v stanici
    private int celkomOdislo;   // aktualny pocet cstujucich vo vlaku v stanici

    /**
     * Konstruktor
     */
    public Stanica(String nazov, Cas cas) {
        this.nazov = nazov;
        this.cas = cas;
        this.pocetVyst = 0;
        this.pocetNast = 0;
        this.celkomOdislo = 0;
    }
    
    /**
     * Getter- nazov stanice
     */
    public String dajNazov() {
        return this.nazov;
    }
    
    /**
     * Getter- pocet cestujucich, ktori nastupili v stanici
     */
    public int dajPocetNast() {
        return this.pocetNast;
    }
    
    /**
     * Getter- pocet cestujucich, ktori vystupili v stanici
     */
    public int dajPocetVyst() {
        return this.pocetVyst;
    }
    
    /**
     * Getter- celkovy pocet cestujucich pri odchode vlaku
     */
    public int dajCelkomOdislo() {
        return this.celkomOdislo;
    }

    /**
     * Vloz pocet vystupujucich cestujucich.
     */
    public void vlozVystup(int pocetVyst) {
        this.pocetVyst = pocetVyst;
    }

    /**
     * Vloz pocet nastupujucich cestujucich
     */
    public void vlozNastup(int pocetNast) {
        this.pocetNast = pocetNast;
    }

    /**
     * Vloz pocet cestujucich vo vlaku
     */
    public void vlozCelkom(int celkomOdislo) {
        this.celkomOdislo = celkomOdislo;
    }

    /**
     * Retazcova reprezentacia stanice
     */
    public String toString() {
        String vysl = " [" + cas + "] " + nazov + " - vystupilo "
                    + pocetVyst + ", nastupilo " + pocetNast + " cestujucich, "
                    + "odislo: " + celkomOdislo;
        return vysl;
    }
}
