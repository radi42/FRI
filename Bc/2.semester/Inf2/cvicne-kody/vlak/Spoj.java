import java.util.*;

/**
 * Vlakovy spoj
 */
public class Spoj
{
    // atributy
    private String popisSpoja;    // Typ linky ( Osobny, Rychlik, EC a pod.)
    private ArrayList<Stanica> stanice;    // zoznam stanic na linke
    private int jeVoVlaku;        // aktualny pocet cestujucich
    private int vlakVStaniciCis;  // cislo stanice, v ktorej je vlak

    /**
     * Konstruktor
     */
    public Spoj(String popisSpoja) {
        this.popisSpoja = popisSpoja;
        stanice = new ArrayList<>();
        jeVoVlaku = 0;
        vlakVStaniciCis = -1;   // vlak este nie je na trase
    }

    /**
     * Zisti pocet stanic na linke 
     */
    public int dajPocetStanic() {
        return stanice.size();
    }

    /**
     * Zisti stanicu na linke s danym indexom
     */
    public Stanica dajStanicu(int index) {
        return stanice.get(index);
    }

    /**
     * Zisti stanicu, v ktorej je vlak
     */
    public int kdeJeVlak() {
        return vlakVStaniciCis;
    }

    /**
     * Vlozenie stanice do vlakoveho spoja
     */
    public void pridajStanicu(Stanica stanica) {
        stanice.add(stanica);
    }

    /**
     * Zisti nasledujúcu stanicu, do ktorej sa presúva vlak
     */
    public int dalsiaStanica() {
        return ++vlakVStaniciCis;
    }

    /**
     * Vlozenie jazdy vlaku v spoji cez klavesnicu
     */
    public void vlozJazduVlaku() {
        int vystup, nastup;   // pracovné premenné pre pocet
                              // vystupujucich a nastupujucich cstujúcich
        System.out.println("*** Vlak vychadza na trat ***");
        jeVoVlaku = 0;
        for (int i=0; i<stanice.size(); i++) {
            System.out.println("Stanica: " + dajStanicu(i).dajNazov()
                + "; vo vlaku je " + jeVoVlaku + " cestujucich.");

            if (i == stanice.size() -1) {  // je to posledna stanica
                vystup = jeVoVlaku;
            } else {
                vystup = vlozVystupVStanici(i);
            }
            if (vystup > jeVoVlaku)
                vystup = jeVoVlaku;
            nastup = vlozNastupVStanici(i);
            jeVoVlaku += nastup - vystup;

            stanice.get(i).vlozVystup(vystup);
            stanice.get(i).vlozNastup(nastup);
            stanice.get(i).vlozCelkom(jeVoVlaku);
        }
        System.out.println("*** Vlak ukoncil spoj ***\n    ******************\n");

    }

    /**
     * Vrati pocet cestujucich vystupujucich v danej stanici
     * @param index stanice
     * @return pocet vystupujucich cestujucich
     */
    public int vlozVystupVStanici(int index) {
        if (index == 0) {  // vychodzia stanica
            return 0;
        }
        if (index == stanice.size()-1) {   // koncova stanica
            return dajStanicu(index).dajCelkomOdislo();
        }
        // ostatne stanice
        java.util.Scanner klav = new java.util.Scanner(System.in);
        System.out.print("    Pocet vystupujucich: ");
        return klav.nextInt();
    }

    /**
     * Vrati pocet cestujucich nastupujucich v danej stanici
     * @param index stanice
     * @return pocet nastupujucich cestujucich
     */
    public int vlozNastupVStanici(int index) {
        if (index ==stanice.size()-1) {   // koncova stanica
            return 0;
        }
        // ostatne stanice
        java.util.Scanner klav = new java.util.Scanner(System.in);
        System.out.print("    Pocet nastupujucich: ");
        return klav.nextInt();
    }

    /**
     * Retazcova reprezentacia uctu
     */
    public String toString()
    {
        String str = "Spoj ";
        if (popisSpoja != "") str += popisSpoja;
        str += "\n";
        if (stanice.size()==0) return str;
        str += "na trase: " + dajStanicu(0).dajNazov() + "-"
        + dajStanicu(stanice.size()-1).dajNazov() + "\n----\n";
        for (int i=0; i<stanice.size(); i++)
            str += "  " + dajStanicu(i) + "\n";
        return str;

    }
}
