/**
 * Trieda Miestnost realizuje jednu miestnost/priestor v celom priestore hry.
 * Kazda "miestnost" je z inymi miestnostami spojena vychodmi. 
 * Vychody z miestnosti su oznacovane svetovymi stranami sever, vychod, juh
 * a zapad. Pre kazdy vychod si miestnost pamata odkaz na susednu miestnost
 * alebo null, ak tym smerom vychod nema.
 *
 * @author  Michael Kolling, David J. Barnes
 * @version 2006.03.30
 * @author  lokalizacia: Lubomir Sadlon, Jan Janech
 * @version 2012.02.21
 */
public class Miestnost 
{

    public String aPopisMiestnosti;
    public Miestnost aSevernyVychod;
    public Miestnost aJuznyVychod;
    public Miestnost aVychodnyVychod;
    public Miestnost aZapadnyVychod;

    /**
     * Vytvori miestnost popis ktorej je v parametrom.
     * Po vytvoreni miestnost nema ziadne vychody. Popis miesnost strucne 
     * charakterizuje.
     * 
     * @param paPopis text popisu miestnosti.
     */
    public Miestnost(String paPopis) {
        this.aPopisMiestnosti = paPopis;
    }

    /**
     * Nastavi vychody z miestnosti. Kazdy vychod je urceny bud odkazom 
     * na miestnost alebo hodnotou null, ak vychod tym smerom neexistuje.
     * 
     * @param paSever miestnost smerom na sever.
     * @param paVychod miestnost smerom na vychod.
     * @param paJuh miestnost smerom na juh.
     * @param paZapad miestnost smerom na zapad.
     */
    public void nastavVychody(Miestnost paSever, Miestnost paVychod, Miestnost paJuh, Miestnost paZapad) {
        if (paSever != null) {
            aSevernyVychod = paSever;
        }
        if (paVychod != null) {
            aVychodnyVychod = paVychod;
        }
        if (paJuh != null) {
            aJuznyVychod = paJuh;
        }
        if (paZapad != null) {
            //</editor-fold>
            aZapadnyVychod = paZapad;
        }
    }

    /**
     * @return textovy popis miestnosti.
     */
    public String dajPopis() {
        return aPopisMiestnosti;
    }
}
