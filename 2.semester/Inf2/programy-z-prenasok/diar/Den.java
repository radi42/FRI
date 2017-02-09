/**
 * Udrzuje udalosti jedneho dna.
 * 
 * @author David J. Barnes and Michael Kolling
 * @version 2006.03.30
 * 
 * lokalizacia
 * @author Lubomir Sadon a Jan Janech
 * @version 2010.02.12
 */
public class Den
{
    // The first and final bookable hours in a day.
    public static final int PRVA_HODINA_DNA = 9;
    public static final int POSLEDNA_HODINA_DNA = 17;
    // The number of bookable hours in a day.
    public static final int MAX_POCET_UDALOSTI_DNA =
                                POSLEDNA_HODINA_DNA -
                                PRVA_HODINA_DNA + 1;
    
    // A day number within a particular year. (1-366)
    private int aCisloDna;
    // The current list of appointments for this day.
    private Udalost[] aUdalosti;

    /**
     * Constructor for objects of class Day.
     * @param dayNumber The number of this day in the year (1-366).
     */
    public Den(int paCisloDna)
    {
        this.aCisloDna = paCisloDna;
        aUdalosti = new Udalost[MAX_POCET_UDALOSTI_DNA];
    }

    /**
     * Try to find space for an appointment.
     * @param appointment The appointment to be accommodated.
     * @return The earliest time today that can accommodate
     *         the appointment. Return -1 if there is 
     *         insufficient space.
     */ 
    public int najdiPriestor(Udalost paUdalost)
    {
        int trvanie = paUdalost.dajTrvanie();
        for(int index = 0; index < MAX_POCET_UDALOSTI_DNA; index++) {
            if(aUdalosti[index] == null) {
                final int casZaciatku = PRVA_HODINA_DNA + index;
                // Potential start point.
                if(trvanie == 1) {
                    // Only a single slot needed.
                    return casZaciatku;
                }
                else {
                    // How many more slots are needed?
                    int pocetPotrebychHodin = trvanie - 1;
                    for(int dalsiaHodina = index + 1;
                                pocetPotrebychHodin > 0 &&
                                aUdalosti[dalsiaHodina] == null;
                                    dalsiaHodina++) {
                        pocetPotrebychHodin--;
                    }
                    if(pocetPotrebychHodin == 0) {
                        // A big enough space has been found.
                        return casZaciatku;
                    }
                }
            }
        }
        // Not enough space available.
        return -1;
    }

    /**
     * Make an appointment.
     * @param time The hour at which the appointment starts.
     * @param appointment The appointment to be made.
     * @return true if the appointment was successful,
     *         false otherwise.
     */
    public boolean vlozUdalost(int paHodina,
                                   Udalost paUdalost)
    {
        if(jePripustnaHodina(paHodina)){
            int indexZaciatku = paHodina - PRVA_HODINA_DNA;
            if(aUdalosti[indexZaciatku] == null) {
                int trvanie = paUdalost.dajTrvanie();
                // Fill in all the slots for the full duration
                // of the appointment.
                for(int i = 0; i < trvanie; i++) {
                    aUdalosti[indexZaciatku + i] = paUdalost;
                }
                return true;
            }
            else {
                return false;
            }
        }
        else {
            return false;
        }
    }
    
    /**
     * @param time Which time of day. This must be between the
     *        START_OF_DAY time and the FINAL_APPOINTMENT_TIME.
     * @return The Appointment at the given time. null is returned
     *         if either the time is invalid or there is no
     *         Appointment at the given time.
     */
    public Udalost dajUdalost(int paHodina)
    {
        if(jePripustnaHodina(paHodina)) {
            return aUdalosti[paHodina - PRVA_HODINA_DNA];
        }
        else {
            return null;
        }
    }

    /**
     * Print a list of the day's appointments on standard output.
     */
    public void vypisUdalosti()
    {
        System.out.println("=== Den " + aCisloDna + " ===");
        int hodina = PRVA_HODINA_DNA;
        for(Udalost udalost : aUdalosti) {
            System.out.print(hodina + ": ");
            if(udalost != null) {
                System.out.println(udalost.dajPopis());
            }
            else {
                System.out.println();
            }
            hodina++;
        }
    }

    /**
     * @return The number of this day within the year (1 - 366).
     */
    public int dajCisloDna()
    {
        return aCisloDna;
    }
    
    /**
     * @return true if the time is between FINAL_APPOINTMENT_TIME and
     *         END_OF_DAY, false otherwise.
     */
    public boolean jePripustnaHodina(int paHodina)
    {
        return paHodina >= PRVA_HODINA_DNA && paHodina <= POSLEDNA_HODINA_DNA;
    }
}
