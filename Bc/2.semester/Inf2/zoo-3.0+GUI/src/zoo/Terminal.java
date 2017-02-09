package zoo;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.Random;
import javax.swing.JOptionPane;
import lib.*;
/**
 * <h2>Aplikacna trieda Terminal</h2>
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
    public static void main(String[] args){
        MojeMetody.hlavickaApp("Zoologicka zahrada");  // Uvod prace s terminalom
        Osoba manager = new Osoba("Jan", "Novak", 26, 3, 1980);
        zoo = new ZOO(manager, 200);
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

    //===================================== Pomocne metody pre aplikqacnu metodu ==
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
        strMenu += "6. Vytvor kamión\n";
        strMenu += "7. Vlož zviera do kamiónu\n";
        strMenu += "8. Vylož zviera z kamiónu\n";
        strMenu += "9. Uloz ZOO do suboru\n";
        strMenu += "10. Otvor ZOO zo suboru\n";

        return MojeMetody.vlozInt(strMenu + "----\nVlož celé číslo 0 - 8");
    }

    private static void vykonajAkciu(int volba){
        switch (volba){
            case 1:     //-- ZOO je vypísaná priamo v cykle výberu činnosti,
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
            case 4:     //-- Odstranenie zivocicha zo ZOO -------------------
                odstranZivocicha();
                break;
            case 5:     //-- Vytvorenie noveho managera ZOO -----------------
                Osoba manager = nacitajOsobu(); // vytvorim noveho managera
                zoo.setManazer(manager);        // nastavim noveho manazera ZOO
                oznam = "Novy manazer Zoo je: " + zoo.getManazer();
                break;
            case 6:     //-- Nastavenie pracovneho prepravneho vozidla ------
                zoo.vytvorKamion();
                oznam = "Nastavene pracovne vozidlo: " + zoo.getManazer();
                break;
            case 7:     //-- Vlozenie zivocicha zo ZOO do prepravneho prostriedku -------
                vlozZvieraDoAuta();
                if (zoo.getPracVozidlo() != null) {
                    Kamion k = zoo.getPracVozidlo();
                    System.out.println(k.infoOVozidle());;
                }
                break;
            case 8:
                ulozObjektZoo();
            case 9:
                nahrajObjektZoo();
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
     * Vytvorenie zivocicha
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
                zviera = new Papagaj("Ara", null, kolkoVazi, farba); 
                break;
            case 4: //slon
                kolkoVazi=20 + (480*generator.nextDouble());   //cislo <20;500> 
                int pocet=generator.nextInt(50);               //pocet zubov bude <0,49>
                zviera=new Slon(kolkoVazi,pocet);
                break;
        }//switch
        return zviera;
    }

    private static void generuj10Zvierat(){
        for (int i = 0; i < 10; i++) {
            zoo.getZverinecZOO().pridajZviera(vytvorZviera());
        }
    }

    /**
     * 
     */
    private static void odstranZivocicha() {
        MojeMetody.println(zoo.getZverinecZOO());  // vypíše zoznam ZOO
        //-- Index živočícha na odstránenie zo ZOO
        int pozicia = MojeMetody.vlozInt("Vyber zviera a vlož jeho index");
        oznam = "Zviera na indexe " + pozicia;
        try {
            Zivocich zv = zoo.getZverinecZOO().getZvierata().remove(pozicia);
            oznam += ": " + zv + " bolo vymazane";
        } catch (Exception e) {
            oznam += " nebolo nájdené" ;
        }
}

    private static void vlozZvieraDoAuta() {
        Kamion kamion = zoo.getPracVozidlo();
        if (kamion== null) {
            oznam = "Nie je pristavené vozidlo!!";
            return;
        }
        Zivocich zv = null;
        Prepravitelny prZv = null;
        MojeMetody.println(zoo.getZverinecZOO());  // vypíše zoznam ZOO
        int cisloZiv = MojeMetody.vlozInt("Vyber zviera a vlož jeho index:");

        oznam = "Na indexe "+cisloZiv+" som ";
        //-- Hľadanie zvieraťa na danom indexe --
        try {
            zv = zoo.getZverinecZOO().getZvierata().get(cisloZiv);
            oznam += "našiel som zviera:\n"+zv;
            prZv = (Prepravitelny)zv;

        } catch (IndexOutOfBoundsException ex) {
            oznam += " nenašiel žiadne zviera!\n\t<"+ex.toString()+">";
            return;
        } catch (ClassCastException ex) {
            oznam += "\nZviera typu: "+zv.getNazovDruhu()+" neprepravujem!!";
            return;
        }

        //-- Kontrola hmotnosti --
        if (kamion.getAktualnaVaha() + prZv.poziadavkaVahy()
                >kamion.dajKapacituVahy()) {
            oznam += "\n-nenaložím ho, prekročená hmotnosť!";
            return;
        }
        //-- Naložíme ho na kamión a odpíšeme ho zo stavu zverinca --
        kamion.getPasazieri().add(prZv);
        zoo.getZverinecZOO().getZvierata().remove(cisloZiv);
    }
    
    /**
     * ulozenie celej zoo do suboru ako objekt
     */
    private static void ulozObjektZoo(){
        ObjectOutputStream subor = null;
        try{
            subor = new ObjectOutputStream(new BufferedOutputStream(new FileOutputStream("subor.dat")));
            subor.writeObject(zoo);
            JOptionPane.showMessageDialog(null, "Zoo je ulozena");
            subor.close();
        } catch(IOException ex){
            JOptionPane.showMessageDialog(null, "nemozem zapisovat do suboru \n" + ex.getMessage() );
        }
    }
    
    /**
     * otvorenie zoo zo suboru ako objekt
     */
    private static void nahrajObjektZoo(){
        ObjectInputStream subor = null;
        zoo = new ZOO();
        try{
            subor = new ObjectInputStream(new BufferedInputStream(new FileInputStream("subor.dat")));
            zoo = (ZOO) subor.readObject();
        } catch(IOException ex){
            JOptionPane.showMessageDialog(null, "nemozem citat zo suboru \n" + ex.getMessage() );
        } catch(ClassNotFoundException ex){
            JOptionPane.showMessageDialog(null, "trieda sa nenasla \n" + ex.getMessage() );
        }
    }

}
