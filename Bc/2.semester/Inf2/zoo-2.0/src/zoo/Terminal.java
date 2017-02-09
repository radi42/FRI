package zoo;

import java.util.Random;
import lib.*;
/**
 * <h2>Aplikacna trieda Terminal</h2>
 * 
 * @author Bene
 * @version 25.3.2012
 */
public abstract class Terminal
{
    //------------------------------------------------------------- Atributy triedy --
        /** Text pre vypisy oznamov pocas cinnosti aplikacie */
    private static String oznam = "";
        /** Generator pre zivocichy */
    private static Random generator = new Random();
        /** Zoologicka zahrada */
    private static Zoo zoo;
    

    /** Aplikacna metoda */
    public static void main(String[] args){
        MojeMetody.hlavickaApp("Zoologicka zahrada");  // Uvod prace s terminalom
        Osoba manager = new Osoba("Jan", "Novak", 26, 3, 1980);
        zoo = new Zoo(manager, 200);
        MojeMetody.println(zoo);

        while(true){                // cyklus pre vyber cinnosti
            Integer vyber = menu();
            if (vyber == null || vyber == 0) break;     // ukoncenie cinnosti
            System.out.println("\n*\n***\n*****\n****\n***\n**\n*\n");
            MojeMetody.hlavickaApp("Zoologicka zahrada");
            vykonajAkciu(vyber);
            MojeMetody.println("\t******************************\n" + zoo);
            if (!oznam.equals("")) MojeMetody.disp(oznam);
            oznam = "";
        }

        MojeMetody.koniecApp();
    }

    //=============================== Pomocné metódy pre aplikačnú metódu ==
    //
    /**
     * Menu pre volbu akcie.
     * <br> Do retazca je vlozeny zoznam moznosti a tento zoznam
     * je zobrazeny v dialogu. V dialogu je mozno vybrat cinnost.
     */
    private static Integer menu() {
        String strMenu = "*************------------------****************\n";
        strMenu += "0. Koniec\n";
        strMenu += "              *******   MENU ZOO   ********\n";
        strMenu += "1. Výpis obsahu ZOO\n";
        strMenu += "2. Pridaj živocícha do ZOO\n";
        strMenu += "3. Pridaj do ZOO 10 náhodných živocíchov\n";
        strMenu += "4. Odstráň živocícha zo ZOO\n";
        strMenu += "5. Nastav riaditeľa\n";
        strMenu += "6. Pristav kamión\n";
        strMenu += "7. Nalož zviera na kamión\n";
        strMenu += "8. Vylož zviera z kamiónu\n";

        return MojeMetody.vlozInt(strMenu + "----\nVlož celé číslo 0 - 8");
    }

    private static void vykonajAkciu(int volba){
        switch (volba){
            case 1:     //-- Zoo je vypísaná priamo v cykle výberu činnosti,
                        //   preto ju nemusime vypisovat na tomto mieste ----
                oznam = "Vypísany obsah ZOO"; break;
            case 2:     //-- Vytvorenie zivocicha a vlozenie do zoznamu -----
                Zivocich zviera = vytvorZviera();
                //   Návratová hodnota oznámi úspech resp. neúspech akcie
                if (zoo.getZverinecZOO().pridajZviera(zviera))     // nepodarilo
                    oznam = "Vložený živocích:\n" + zviera;
                else                                 // nepodarilo
                    oznam = "Zoo je už plná!";
                break;
            case 3:     //-- Vygenerovanie viacerych zvierat do zoznamu -----
                generuj10Zvierat();     // volame metodu generovania...
                oznam = "Pridanych nahodne 10 zvierat!";
                break;             
            case 4:     //-- Odstranenie zivocicha zo Zoo -------------------
                odstranZivocicha();
                break;
            case 5:     //-- Vytvorenie noveho managera Zoo -----------------
                Osoba manager = nacitajOsobu(); // vytvorim noveho managera
                zoo.setManazer(manager);        // nastavim noveho manazera Zoo
                oznam = "Novy manazer Zoo je: " + zoo.getManazer();
                break;
            case 6:     //-- Pristavenie pracovneho prepravneho vozidla ------
                zoo.vytvorKamion();
                oznam = "Nastavene pracovne vozidlo: " + zoo.getPracVozidlo();
                break;
            case 7: //-- Nalozenie zivocicha zo Zoo do prepravneho prostriedku -
                vlozZvieraDoAuta();
                if (zoo.getPracVozidlo() != null) {
                    Kamion k = zoo.getPracVozidlo();
                    System.out.println(k.infoOVozidle());;
                }
                break; 
            case 8: //-- Vylozenie zivocicha z kamionu
                vylozZvieraZAuta();
                break;
            default:    //-- Zadanie cisla nexistujucej moznosti -------------
                MojeMetody.disp("Volba mimo rozsah!");
        } //------------------------------------------- koniec switch --<<
    }

    private static Osoba nacitajOsobu() {
        String meno = MojeMetody.vlozString("Vloz meno:");
        String priezvisko = MojeMetody.vlozString("Vloz priezvisko:");
        return new Osoba(meno, priezvisko);
    }

    /**
     * Vytvorenie zivocicha pomocou generátora náhodných čísel
     */
    private static Zivocich vytvorZviera() {
     final String[] zFarba = {"cervena", "zelena", "modra", "zlta", "zlto-zelena"};
        Zivocich zviera = null;
        double kolkoVazi = 0.0;

        //-- Vygenerujeme zviera
        int vygenerovane = 1 + generator.nextInt(4); //cislo <1,4>

        switch (vygenerovane) {
            case 1: //blcha                       
                double kolkoDoskoci=3 * generator.nextDouble() ; //cislo <0;2.99>
                double kolkoVyskoci=3 * generator.nextDouble() ; //cislo <0;2.99>
                zviera=new Blcha(6,kolkoDoskoci,kolkoVyskoci);
                break;
            case 2: //simpanz
                kolkoVazi=3 + (97 * generator.nextDouble());  //cislo <3;99.9>
                boolean cviceny;
                cviceny=generator.nextBoolean();                   
                zviera=new Simpanz(kolkoVazi,cviceny);
                break;
            case 3: //papagaj
                kolkoVazi = 0.1 + (5*generator.nextDouble());    // cislo <0.1; 6>
                String farba = zFarba[generator.nextInt(5)];     // farba zo zoznamu
                zviera = new Papagaj("Ara", 2, kolkoVazi, farba); 
                break;
            case 4: //slon
                kolkoVazi=20 + (480*generator.nextDouble());   //cislo <20;500> 
                int pocet=generator.nextInt(50);               //pocet zubov bude <0,49>
                zviera=new Slon(kolkoVazi,pocet);
                break;
        }//switch
        return zviera;
    }

    /**
     * Vygeneruje 10 náhodných zvierat
     */
    private static void generuj10Zvierat(){
        for (int i = 0; i < 10; i++) {
            zoo.getZverinecZOO().pridajZviera(vytvorZviera() );
        }
    }

    /**
     * Odstráni zviera zo zverinca Zoo
     */
    private static void odstranZivocicha() {
        MojeMetody.println(zoo.getZverinecZOO());  // vypíše zoznam Zoo
        //-- Index živočícha na odstránenie zo Zoo
        int pozicia = MojeMetody.vlozInt("Vyber zviera a vlož jeho index");
        oznam = "Zviera na indexe "+pozicia;

        //-- TODO -- treba otestovať existenciu pozície
        Zivocich zv = zoo.getZverinecZOO().getZvierata().remove(pozicia);
        oznam += ": "+zv+" bolo vymazane";

    }

    /**
     * Naloží vybrané zviera na kamión a odpíše ho zo stavu zverinca
     */
    private static void vlozZvieraDoAuta() {
        Kamion kamion = zoo.getPracVozidlo();
        //-- TODO -- otestujte existenciu kamiónu --
        if(kamion == null){
            oznam += "Kamion nie je pristaveny";
        }

        //inicializacia premennych
        Zivocich zv = null;             //-- pre zistenie živočícha v Zoo...
        Prepravitelny prZv = null;      //-- pre prepraviteľné zvieratá...
        MojeMetody.println(zoo.getZverinecZOO());  // vypíše zoznam Zoo
        int cisloZiv = MojeMetody.vlozInt("Vyber zviera a vlož jeho index:");

        oznam = "Na indexe "+cisloZiv+" som ";      //-- 1. časť oznamu
        //-- Hľadanie zvieraťa na danom indexe --
        //TODO   1. Testujte na existenciu zvieraťa na danom indexe
        //TODO   2. Zistite, či je zviera prepraviteľné
        // chranime cely blok "try" a testujeme viacero premennych na viacero vynimiek
        try{
            zv = zoo.getZverinecZOO().getZvierata().get(cisloZiv);
            oznam += "našiel som zviera:\n" + zv;
            prZv = (Prepravitelny)zv; //pretypovanie urcuje, ze sa prepravia IBA zivocichy, ktore su prepravitelne (implementuje interfece prepravitelny)
        } catch(IndexOutOfBoundsException ex){
            oznam += "nenasiel zviera";
            return;
            
        } catch(ClassCastException ex){
            oznam += "nasiel NEPREPRAVITELNEHO zivocicha";
            return;
            
        } catch (Exception ex){ //ak nastane akakolvek ina vynimka nez vyssie uvedena
            MojeMetody.disp("Nastala vynimka \n" + ex);
            return;
        }


        //-- TODO -- Skontrolujte hmotnosť na preťaženie kamiónu
        /*ak aktualna vaha + poziadavka vahy zivocicha je vacsia ako maximalna
        kapacita kamionu odmietni ho, inak pridaj zivocicha do kamionu a vymaz
        zviera zo zoo*/

        //-- Naložíme ho na kamión a odpíšeme ho zo stavu zverinca --
        kamion.getPasazieri().add(prZv);
        zoo.getZverinecZOO().getZvierata().remove(cisloZiv);

    }

    private static void vylozZvieraZAuta() {
        Kamion kamion = zoo.getPracVozidlo();
        Zivocich zv = null;
        Prepravitelny prZv = null;
        int cisloZiv = MojeMetody.vlozInt("Vyber zviera a vlož jeho index:");
        try{
            zv = (Zivocich) kamion.getPasazieri().get(cisloZiv);
        }catch(IndexOutOfBoundsException ex){
            MojeMetody.disp("Zviera s danym indexom sa nenaslo\n" + ex);
        }
        kamion.getPasazieri().remove(cisloZiv);
        zoo.getZverinecZOO().pridajZviera(zv);
    }
}
