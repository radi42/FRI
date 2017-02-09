 

import java.util.Random;
import lib.*;
/**
 * <h2>Aplikacna trieda Main</h2>
 * 
 * @author Bene
 * @version 25.3.2012
 */
public class Terminal
{
    //------------------------------------------------------------- Atributy triedy --
        /** Text pre vypisy oznamov pocas cinnosti aplikacie */
    private static String oznam = "";
        /** Generator pre zivocichy */
    private static Random generator = new Random();
        /** Zoologicka zahrada */
    private static ZOO zoo;
    

    /** Aplikacna metoda */
    public static void start(){
        MojeMetody.hlavickaApp("Zoologicka zahrada");  // Uvod prace s terminalom

        Osoba manager = new Osoba("Jan", "Novak", 26, 3, 1980);
        zoo = new ZOO(manager, 20, 10);
        MojeMetody.println(zoo);

        while(true){                // cyklus pre vyber cinnosti
            Integer vyber = menu();
            if (vyber == null || vyber == 0) break;     // ukoncenie cinnosti
            MojeMetody.hlavickaApp("Zoologicka zahrada");
            vykonajAkciu(vyber);
            MojeMetody.println("\t******************************\n" + zoo);
            MojeMetody.disp(oznam); 
        }

        MojeMetody.koniecApp();
    }

    //====================================== Pomocne metody pre aplikacnu metodu ==
    //==
    /**
     * Menu pre volbu akcie<br>
     * Do retazca je vlozeny zoznam moznosti a tento zoznam je zobrazeny v dialogu.
     * V dialogu je mozno vybrat cinnost.
     */
    private static Integer menu() {
        String strMenu = "*************------------------****************\n";
        strMenu += "0. Koniec\n";
        strMenu += "              *******   MENU ZOO   ********\n";
        strMenu += "1. Pridaj zivocicha do ZOO\n";
        strMenu += "2. Pridaj do ZOO 10 nahodnych zivocichov\n";
//         strMenu += "3. Zmaz zivocicha zo ZOO\n";
//         strMenu += "4. Prijat riaditela\n";
        strMenu += "5. Vytvor kamion\n";
        
        
//         strMenu += "8. Vloz do auta\n";

        return MojeMetody.vlozInt(strMenu + "----\nVloz cele cislo 0 - 7");
    }

    private static void vykonajAkciu(int volba){
        switch (volba){
            case 1:     //-- Vytvorenie zivocicha a vlozenie do zoznamu
                Zivocich zviera = vytvorZivocicha();    // Vytvorime ho a
                //-- Pridame do zoznamu.
                //   Navratova hodnota oznami uspech resp. neuspech
                if (zoo.pridajZivocicha(zviera))     // podarilo sa
                    oznam = "Vlozeny zivocich:\n" + zviera;
                else                                 // nepodarilo
                    oznam = "Zoo je uz plna!";

                MojeMetody.println(oznam);
                break;
            case 2:     //-- Vygenerovanie viacerych zvierat do zoznamu
                generuj10Zvierat();     // volame metodu generovania...
                oznam = "Pridanych nahodne 10 zvierat!";
                break; 
            case 5:
                zoo.setPracovneVozidlo();
                oznam = "kamion bol nastaveny na prprevne vozidlo";
                break;
            default:    //-- Zadanie cisla nexistujucej moznosti
                MojeMetody.disp("Volba mimo rozsah!");
        }
    }

    /**
     * Vytvorenie zivocicha vygenerovanim druhu a hodnot prislusneho druhu
     */
    private static Zivocich vytvorZivocicha() {
        final String[] zFarba = {"cervena", "zelena", "modra", "zlta", "zlto-zelena"};
        Zivocich zviera = null;
        double kolkoVazi = 0.0;

        //-- Vygenerujeme zviera --
         switch (generator.nextInt(4) + 1) {
            case 1: //-- blcha --
                double kolkoDoskoci = 3*generator.nextDouble() ; // cislo <0; 2.99>
                double kolkoVyskoci = 3*generator.nextDouble() ; // cislo <0; 2.99>
                zviera = new Blcha(6, kolkoDoskoci, kolkoVyskoci);
                break;
            case 2: //-- simpanz --
                kolkoVazi = 3 + (97 * generator.nextDouble());   // cislo <3; 99.9>
                boolean cviceny;
                cviceny = generator.nextBoolean();                   
                zviera = new Simpanz(kolkoVazi,cviceny);
                break;
            case 3: //-- papagaj --
                kolkoVazi = 0.1 + (5*generator.nextDouble());    // cislo <0.1; 6>
                String farba = zFarba[generator.nextInt(5)];     // farba zo zoznamu
                zviera = new Papagaj("Ara", 2, kolkoVazi, farba); 
                break;
            case 4: //-- krokodil --
                kolkoVazi = 20 + (480*generator.nextDouble());  // cislo <20; 500> 
                int pocet = generator.nextInt(50);              // pocet zubov bude <0, 49>
                zviera = new Slon(kolkoVazi,pocet);
                break;
        }  // switch -----------------------<<<<
        return zviera;
    }

    /**
     * Vygenerovanie 10 roznych zivocicov
     */
    private static void generuj10Zvierat(){
        for (int i = 0; i < 10; i++) {
            Zivocich nahodny = vytvorZivocicha();
            zoo.pridajZivocicha(nahodny);
            //-- Mozno pouzit takyto skrateny zapis. Volanim metody vytvorZivocicha
            //   ziskame novy objekt a ten pouzijeme hned ako parameter
            //zoo.vlozZivocicha(vytvorZivocicha());
        }
    }

}
