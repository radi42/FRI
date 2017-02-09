import java.util.*;

/**
 * Trieda Main pre start aplikacie.
 * 
 * @author (Bene) 
 * @version (14. 10. 2012)
 */
public abstract class Main
{
    /**
     * Trieda pre spustenie aplikacie
     */
    public static void main(/*String[] args*/) {
        System.out.println("\f\t**** Praca s obdlznikmi ****"
                         + "\n\t----------------------------");

        double vyska;
        double sirka;
        Scanner klav = new Scanner(System.in);

        System.out.print("Vloz vysku: ");
        vyska = klav.nextInt();
        System.out.print("Vloz sirku: ");
        sirka = klav.nextInt();
        
        Obdlznik obdlznik = new Obdlznik(vyska, sirka);
        System.out.println("\nVytvorili sme obdlznik: " + obdlznik);
        System.out.println("\t- obsah      : " + obdlznik.obsah());
        System.out.println("\t- obvod      : " + obdlznik.obvod());
        System.out.println("\t- uhlopriecka: " + obdlznik.uhlopriecka());

        System.out.println("\n\t**** Koniec [Obdlznik]");

    }

    //--****************************************************************
    //------------------------------------------------------------------
    /**
     * Trieda pre spustenie aplikacie s pomocnymi metodami
     */
    public static void main2() {
        System.out.println("\f\t**** Praca s obdlznikmi - main2 ****"
                         + "\n\t------------------------------------");

        double vyska = vlozInt("Vloz vysku");
        double sirka = vlozInt("Vloz sirku");
        Obdlznik obdlznikA = new Obdlznik(vyska, sirka);
        Obdlznik obdlznikB = new Obdlznik(vyska, 20);
        Obdlznik obdlznikC = new Obdlznik(20, sirka);

        System.out.println("\nVytvorili sme obdlzniky\n---- pocet: " 
                         + Obdlznik.getPocetObdlznikov() + " ----");

        vypisObdlznika(obdlznikA);
        vypisObdlznika(obdlznikB);
        vypisObdlznika(obdlznikC);

        System.out.println("\n\t**** Koniec [Obdlznik]");
    }

    /**
     * Vrati hodnotu typu double po jej vlozeni z klavesnice
     * @param str text vyzvy pre vstup z klavesnice
     * @return hodnota vlozeni z klavesnice
     */
    private static double vlozInt(String str) {
        System.out.print(str + ": ");
        return new Scanner(System.in).nextDouble();
    }

    private static void vypisObdlznika(Obdlznik obd) {
        System.out.println("Parametre obdlznika: " + obd + ":");
        System.out.println("\t- vyska      : " + obd.getVyska());
        System.out.println("\t- sirka      : " + obd.getSirka());
        System.out.println("\t- obsah      : " + obd.obsah());
        System.out.println("\t- obvod      : " + obd.obvod());
        System.out.println("\t- uhlopriecka: " + obd.uhlopriecka());
    }
}
