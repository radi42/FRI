/**
 * Trieda prikaz implemntuje casti prikazu, ktore moze hrac zadat.
 * V tejto verzii prikaz tvoria dve slova: nazov prikazu a druhe slovo.
 * Napriklad prikaz "chod juh" tvoria dva retazce "chod" ako nazov prikazu a
 * "juh" ako oznacenie smeru.
 * 
 * Predpoklada sa, ze prikaz je skontrolovany, t.j., ze nazov prikazu je znamy.
 * Pre neznamy prikaz je jeho nazov nastaveny na hodnotu <null>.
 *
 * Ak prikaz nema parameter, potom ma druhe slovo hodnotu <null>.
 * 
 * @author  Michael Kolling and David J. Barnes
 * @version 2006.03.30
 * @author  lokalizacia: Lubomir Sadlon, Jan Janech
 * @version 2012.02.21
 */

public class Prikaz
{
    private String aNazovPrikazu;
    private String aParameter;

    /**
     * Inicializuje slova prikazu dvomi zadanymi parametrami. Jeden alebo oba
     * parametre mozu mat hodnotu <null>.

     * @param paNazovPrikazu prve slovo - nazov prikazu, 
     *                       null, ak je prikaz neznamy.
     * @param paParameter druhe slovo prikazu.
     */
    public Prikaz(String paNazovPrikazu, String paParameter)
    {
        aNazovPrikazu = paNazovPrikazu;
        aParameter = paParameter;
    }

    /**
     * @return prve slovo - nazov prikazu.
     */
    public String dajNazov()
    {
        return aNazovPrikazu;
    }

    /**
     * @return druhe slovo - parameter prikazu.
     */
    public String dajParameter()
    {
        return aParameter;
    }

    /**
     * @return true, ak je prikaz neznamy.
     */
    public boolean jeNeznamy()
    {
        return (aNazovPrikazu == null);
    }

    /**
     * @return true, ak prikaz ma parameter.
     */
    public boolean maParameter()
    {
        return (aParameter != null);
    }
}