package zoo;

import java.util.Random; 
import javax.swing.JOptionPane;
import lib.Datum;
import lib.MojeMetody;
import lib.Osoba;
/**
 * Trieda Main.
 * 
 * @author Andrej Sisila
 * @version 
 */
public class Main
{
    private static String oznam = "";
    private static Random generator = new Random();
    private static Zoo zoo;
    
    public static void main(String[] args){
        System.out.println("Zoologicka zahrada");
        Osoba manager = new Osoba("Jan", "Novak"); //vytvor noveho menezera Zoo
        zoo = new Zoo(manager, new Zverinec(50) );  //vytvor novu zoo s menezerom
        System.out.println(zoo);
    
        while(true){
            Integer vyber = menu();
            if (vyber == null || vyber == 0) break;
            
            MojeMetody.hlavickaApp("Zoologicka zahrada"); //vypis privitanie
            vykonajAkciu(vyber); //vyber volbu
            System.out.println("******************************\n");
            if (!oznam.equals("")){
                MojeMetody.disp(oznam);
                //System.out.println(oznam);
            }
            oznam = "";
        }
    }
    
    /**
     * metoda menu
     * 
     * generuje hlavne menu
     * @return vracia cislo polozky v menu
     */
    private static Integer menu() {
        String strMenu = "**************-----------------*************\n";
        strMenu += "0. Koniec\n";
        strMenu += "1. Vypis obsah Zoo\n";
        strMenu += "2. Pridaj zviera\n"; //vytvor dalsie menu v inputboxe s typom zvierata
        strMenu += "3. Generuj 10 zvierat\n"; //staci vypisat na terminal evnt. ulozit do zoznamu
        strMenu += "4. Odstran zviera\n"; //odstranit zviera na indexe
        strMenu += "5. Nastav riaditela\n"; //nastavi informacie o menezerovi
//        strMenu += "6. Vygeneruj nahodneho zivocicha\n"; //nahodny zivocich
        strMenu += "6. Vytvor kamion\n";
        strMenu += "7. Vloz zviera do auta\n";
        strMenu += "8. Vyloz zviera z auta\n";
        return MojeMetody.vlozInt(strMenu + "\nVloz cele cislo 0 - 8");
    }
    
    /**
     * metoda menu
     * 
     * generuje hlavne menu
     * @return vracia cislo zvierata
     */
    private static Integer menuZvierat() {
        String strMenu = "**************-----------------*************\n";
        strMenu += "1. Had\n";
        strMenu += "2. Papagaj\n";
        strMenu += "3. Simpanz\n";
        strMenu += "4. Slon\n";
        return MojeMetody.vlozInt(strMenu + "\nVloz cele cislo 1 - 4");
    }
    
    /**
     * vykonava metody na zaklade priradeneho cisla v hlavnom menu
     * 
     * @param volba 
     */
    private static void vykonajAkciu(int volba){
        switch(volba){
            case 1: //vypis vsetky zvierata v zoo
                oznam = "Informacie o zverinci v ZOO\n";
                System.out.println(zoo.getZvierataZoo().getZoznam() );
                String zoznam = zoo.getZvierataZoo().getZoznam();
                oznam += zoznam;
                break;
                
            case 2: //pridaj zviera
                //vyvolaj dalsie menu pre vyber zvierata
                Zivocich zviera = new Simpanz(45, false);
                if(zoo.getZvierataZoo().pridajZviera(zviera))
                    oznam = "Vlozeny zivocich:\n" + zviera;
                else
                    oznam = "Zoo je uz plna";
                break;
            
            case 3: //vygeneruj 10 zvierat a pridaj ich do zverinca v zoo
                generujDesatzvierat(zoo.getZvierataZoo() );
                break;
                
            case 4: //odstran konkretne zviera na pozicii
                odstranZviera();
                break;
                
            case 5: //nastav parametre menezera zoo
            //z inputDialogu vytiahnut meno, priezvisko a cisla: den, mesiac, rok
            //nastav meno a priezvisko menezera
                String meno = JOptionPane.showInputDialog("Meno menezera");
                String priezvisko = JOptionPane.showInputDialog("Priezvisko menezera");
                
                //Nastav datum narodenia menezera
                //osetri vynimku - ak sa v inputboxe
                int d = 0;
                try{
                d= Integer.parseInt(JOptionPane.showInputDialog(
                        "Den narodenia") );
                }catch(NumberFormatException e){
                    JOptionPane.showMessageDialog(null,
                            "Zadavam menezera bez datumu narodenia");
                    zoo.getManager().setMeno(meno);
                    zoo.getManager().setPriezvisko(priezvisko);
                    break;
                }
                int m= Integer.parseInt(JOptionPane.showInputDialog(
                        "Mesiac narodenia") );
                int r= Integer.parseInt(JOptionPane.showInputDialog(
                        "Rok narodenia") );
                
                zoo.getManager().setMeno(meno);
                zoo.getManager().setPriezvisko(priezvisko);
                zoo.getManager().setDatNar(new Datum(d, m, r) );
                break;
            
//            case 6: //vygeneruj nahodne zviera a pridaj ho do zverinca v zoo
//                //zoo.getZvierataZoo().pridajZviera(vytvorZivocicha() );
//                if(zoo.getZvierataZoo().pridajZviera(vytvorRandomZivocicha() ) )
//                    oznam = "Vlozeny zivocich:\n" + vytvorRandomZivocicha();
//                else
//                    oznam = "Zoo je uz plna";
//                break;
                
            case 6: //pridaj kamion
                pridajKamion();
                break;
                
            case 7: //naloz zviera do kamiona
                
                
            case 8: //vyloz zviera z kamiona
                
            default:
                System.out.println("volba neimplementovana");
        }
    }
    
    /**
     * vygeneruje 10 zvierat zo zverinca
     * @param zv Zverinec do ktoreho sme zvierata ulozili
     */
    private static void generujDesatzvierat(Zverinec zv)
    {
        if (zv == null)
        {
            System.out.println("Zverinec este neexistuje.");
            return;
        }
        
       //simpanz
       Zivocich simpanz = new Simpanz(44, false);
       simpanz.setUmiestnenie("Pavilon Exotica");
       simpanz.setDatum(new Datum(8, 2, 2013) );
       zv.pridajZviera(simpanz);
       
       //slon
       Zivocich slon = new Slon(200, 3500, true);
       slon.setUmiestnenie("Pavilon Indo-Africky");
       slon.setNazovDruhu("Slon John");
       zv.pridajZviera(slon);
       
       //papuch
       Zivocich papagaj = new Papagaj("ruzova", 3, true);
       papagaj.setNazovDruhu("Papagaj Iki");
       papagaj.setDatum(new Datum(8, 6, 2013) );
       papagaj.setUmiestnenie("Pavilon Papuchov");
       zv.pridajZviera(papagaj);
       
       //had
       Zivocich had = new Had(547.4, 90, true);
       had.setNazovDruhu("Had Slicky");
       had.setUmiestnenie("Hadi Pavilon");
       zv.pridajZviera(had);
       
       //vytvor ostatne zvierata a zarad ich do zverinca
       Zivocich had2 = new Had(800, 120, false);
       zv.pridajZviera(had2);
       
       Zivocich papagaj2 = new Papagaj("modra", 2, true);
       zv.pridajZviera(papagaj2);
       
       Zivocich simpanz2 = new Simpanz(55, true);
       zv.pridajZviera(simpanz2);
       
       Zivocich slon2 = new Slon(120, 1400, false);
       zv.pridajZviera(slon2);
       
       Zivocich papagaj3 = new Papagaj("zelena", 2.7, true);
       zv.pridajZviera(papagaj3);
       
       Zivocich papagaj4 = new Papagaj("zlta", 0.7, true);
       zv.pridajZviera(papagaj4);
    }
    
    /**
     * 
     * @return nahodny typ zvierata
     */
    private static Zivocich vytvorRandomZivocicha(){
        final String[] zoznamFarieb = {"cervena", "zelena", "modra", "zlta"};
        
        Zivocich zviera = null;
        double kolkoVazi = 0.0;
        
        int vygenerovanie = 1 + generator.nextInt(4);
        String farba = zoznamFarieb[vygenerovanie];
        
        switch(vygenerovanie){
            case 1:
                zviera = new Had(800, 120, false);
                //zv.pridajZviera(zviera);
            case 2:
                zviera = new Simpanz(55, true);
            case 3:
                zviera = new Slon(120, 1400, false);
            case 4:
                int nahodnaFarba = generator.nextInt(zoznamFarieb.length);
                zviera = new Papagaj(zoznamFarieb[nahodnaFarba], 0.7, true);
            default:
                System.out.println("Zadaj platne cele cislo v rozsahu");
        }
        
        return zviera;
    }  

    private static void pridajKamion() {
        String menoVodica = JOptionPane.showInputDialog(null,"Zadajte meno vodica");
        String priezviskoVodica = JOptionPane.showInputDialog(null,"Zadajte meno vodica");
        int kapacitaKamionu = 15000;
        PrepravnyProstriedok kamion = new Kamion(new Osoba(menoVodica, priezviskoVodica), kapacitaKamionu);
        JOptionPane.showMessageDialog(null, "Kamion uspesne pridany!");
    }

    /**
     * odstranuje zviera zo zverinca
     */
    private static void odstranZviera() throws IndexOutOfBoundsException{
        int pozicia = 0;
        pozicia= Integer.parseInt(JOptionPane.showInputDialog(
                "Zadajte cislo zvierata, ktore chcete odstranit") );
        
        //potrebujeme testovat, ci je zviera s danym indexom v zverinci
        try{
            //zoo.getZvierataZoo().odstranZviera(pozicia); //alebo aj inak - nizsie
            zoo.getZvierataZoo().getZvierata().remove(pozicia);
            oznam += "Zviera uspesne vymazane";
        }catch(IndexOutOfBoundsException ex){
            MojeMetody.disp(ex + "\n"
                    + "Zviera s indexom " + pozicia + " v danom zverinci neexistuje \n"
                    + "Zviera nebolo vymazane. Zadajte platne cislo zvierata");
            oznam += "Neexistujuce cislo nemohlo byt odstranene";
        }
    }
    
//    /**
//     * Naloží vybrané zviera na kamión a odpíše ho zo stavu zverinca
//     */
//    private static void vlozZvieraDoAuta() {
//        Kamion kamion = zoo.getPracVozidlo();
//        //-- TODO -- otestujte existenciu kamiónu --
//        if(kamion == null){
//            oznam += "Kamion nie je pristaveny";
//        }
//
//        //inicializacia premennych
//        Zivocich zv = null;             //-- pre zistenie živočícha v ZOO...
//        Prepravitelny prZv = null;      //-- pre prepraviteľné zvieratá...
////        MojeMetody.println(zoo.getZvierataZoo().getZoznam() );  // vypíše zoznam ZOO
//        int cisloZiv = MojeMetody.vlozInt("Vyber zviera a vlož jeho index:");
//
//        oznam = "Na indexe "+cisloZiv+" som ";      //-- 1. časť oznamu
//        //-- Hľadanie zvieraťa na danom indexe --
//        //TODO   1. Testujte na existenciu zvieraťa na danom indexe
//        //TODO   2. Zistite, či je zviera prepraviteľné
//        // chranime cely blok "try" a testujeme viacero premennych na viacero vynimiek
//        try{
//            zv = zoo.getZvierataZoo().getZvierata().get(cisloZiv);
//            oznam += "našiel som zviera:\n" + zv;
//            prZv = (Prepravitelny)zv; //pretypovanie urcuje, ze sa prepravia IBA zivocichy, ktore su prepravitelne (implementuje interfece prepravitelny)
//        } catch(IndexOutOfBoundsException ex){
//            oznam += "nenasiel zviera";
//            return;
//            
//        } catch(ClassCastException ex){
//            oznam += "nasiel NEPREPRAVITELNEHO zivocicha";
//            return;
//            
//        } catch (Exception ex){ //ak nastane akakolvek ina vynimka nez vyssie uvedena
//            MojeMetody.disp("Nastala vynimka \n" + ex);
//            return;
//        }
//
//
//        //-- TODO -- Skontrolujte hmotnosť na preťaženie kamiónu
//        /*ak aktualna vaha + poziadavka vahy zivocicha je vacsia ako maximalna
//        kapacita kamionu odmietni ho, inak pridaj zivocicha do kamionu a vymaz
//        zviera zo zoo*/
//
//        //-- Naložíme ho na kamión a odpíšeme ho zo stavu zverinca --
//        kamion.getPasazieri().add(prZv);
//        zoo.getZvierataZoo().getZvierata().remove(cisloZiv);
//
//    }

    private static void vylozZvieraZAuta() {
        
    }
}