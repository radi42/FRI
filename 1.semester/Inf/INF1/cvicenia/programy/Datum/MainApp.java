import javax.swing.*;
/**
 * Hlavna aplikacia Datum
 * 
 * @author Andrej Sisila
 * @version v1.0
 */
public abstract class MainApp
{
    public static void main(String[] args)
    {
        /**
         * lokalne premenne
         */
        String jePriestupny;
        
        /**
         * Priradovanie hodnot premennym
         */
        int day = Integer.parseInt( JOptionPane.showInputDialog(null, "Zadaj den") );
        int month = Integer.parseInt( JOptionPane.showInputDialog(null, "Zadaj mesiac") );
        int year = Integer.parseInt( JOptionPane.showInputDialog(null, "Zadaj rok") );

        /**
         * priradi datum do premennej dnesT, vytvori docasnu referencnu premennu, ktora prijma
         * hodnoty premennych
         */
        Datum dnesT = new Datum(day, month, year);
        
        /**
         * kontrola priestupnosti roku
         * premenna jePriestupny sa dalej pouziva vo Vypise (na terminal)
         */
        if ( dnesT.priestupnyRok() ){
            jePriestupny = "je";
        }
        else {
            jePriestupny = "nie je";
        }
        /**
         * prepisanie hodnot ak nastane neplatny ciselny vstup
         */
        if (day > dnesT.pocetDniVmesiaci() || month > 12) {
            day = 1;
            month = 1;
        }
        /**
         * vymazanie referencie na objekt dnesT
         */
        dnesT = null;
        
        /**
         * vytvorenie noveho datumu s platnymi hodnotami
         */
        Datum dnes = new Datum(day, month, year);
         
        /**
         * Vypis hodnot do terminalu
         */
        System.out.println("\fDnesny den: " 
            + dnes.getDen() + ". " 
            + dnes.getMesiac() + ". " 
            + dnes.getRok() );
        System.out.println("Tento mesiac ma " + dnes.pocetDniVmesiaci() + " dni");
        
        System.out.println("Tento rok " + jePriestupny + " priestupny");
        
        System.out.println("Zajtra bude " + dnes.getZajtra());
        
        System.out.println("Do konca roku zostava " + dnes.pocetDniDoKoncaRoku() + ".");
    }
}
