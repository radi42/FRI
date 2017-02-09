/**
 * Represent a week's worth of Days.
 * Reprezentuje dni týždòa.
 * 
 * @author David J. Barnes and Michael Kolling
 * @version 2006.03.30
 * @author Lubomir Sadon a Jan Janech
 * @version 2010.02.12
 */
public class Tyzden
{
    // Represent a Week as a set of Monday to Friday days.
    public static final int POCET_PRACOVNYCH_DNI_TYZDNA = 5;
    
    // A week number within a particular year (0-52).
    private final int aCisloTyzdna;
    private final Den[] aDni;

    /**
     * Constructor for objects of class Week.
     * @param weekNumber The week number (0-52).
     */
    public Tyzden(int paCisloTyzdna)
    {
        this.aCisloTyzdna = paCisloTyzdna;
        aDni = new Den[POCET_PRACOVNYCH_DNI_TYZDNA];
        int cisloDna = aCisloTyzdna * 7 + 1;
        for(int indexDna = 0; indexDna < POCET_PRACOVNYCH_DNI_TYZDNA; indexDna++) {
            aDni[indexDna] = new Den(cisloDna);
            cisloDna++;
        }
    }

    /**
     * Print a list of appointments for this week on standard output.
     */
    public void vypisUdalosti()
    {
        System.out.println("*** Tyzden " + aCisloTyzdna + " ***");
        for(Den den : aDni) {
            den.vypisUdalosti();
        }
    }

    /**
     * @param dayInWeek Which day (1..BOOKABLE_DAYS_PER_WEEK).
     * @return The Day representing that day number, or null if
     *         dayInWeek is out of range.
     */
    public Den dajDen(int paDenTyzdna)
    {
        if(paDenTyzdna >= 1 && paDenTyzdna <= POCET_PRACOVNYCH_DNI_TYZDNA) {
            return aDni[paDenTyzdna - 1];
        }
        else {
            return null;
        }
    }

    /**
     * @return The week number (0-52).
     */
    public int dajCisloTyzdna()
    {
        return aCisloTyzdna;
    }
}
