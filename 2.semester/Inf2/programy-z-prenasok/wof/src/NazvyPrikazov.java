/**
 * Trieda NazvyPrikazov udrzuje zoznam nazvov platnych prikazov hry. 
 * Za ulohu ma rozpoznavat platne prikazy.
 *
 * @author  Michael Kolling and David J. Barnes
 * @version 2006.03.30
 * @author  lokalizacia: Lubomir Sadlon, Jan Janech
 * @version 2012.02.21
 */

public class NazvyPrikazov
{
    // konstantne pole nazvov prikazov
    private static final String[] aPlatnePrikazy = {
        "chod", "ukonci", "pomoc"
    };

    /**
     * Inicializuje zoznam platnych prikazov.
     */
    public NazvyPrikazov()
    {
    	// v tejto verzii nerobi nic
    }

    /**
     * Kontroluje, ci nazov v parametri je platny prikaz.
     *  
     * @return true ak je parameter platny prikaz,
     * false inak.
     */
    public boolean jePrikaz(String paNazov)
    {
        for(int i = 0; i < aPlatnePrikazy.length; i++) {
            if(aPlatnePrikazy[i].equals(paNazov))
                return true;
        }
        // ak algoritmus dosiahne tento bod, parameter nie je platny prikaz
        return false;
    }
}
