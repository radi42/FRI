package Zoo;

import java.util.Scanner;
//import javax.swing.JOptionPane;
import lib.Datum;
/**
 * Trieda Main
 * 
 * vypisuje zoo
 * @author Andrej Sisila 
 * @version v3.11.2014
 */
public abstract class MainOld
{
//   /**
//    * Hlavna metoda
//    * @param args 
//    */
//   public static void main(String[] args){
//       //bez importu triedy datum
//       //Zivocich kon = new Zivocich("Kon", "Pavilon 1", new lib.Datum(5, 4, 2005) );
//       
//       //s importom triedy Datum
//       Zivocich kon = new Zivocich("Kon", "Dostihovy Pavilon", new Datum(5,4,2005) );
//       
//       //simpanz
//       Zivocich simpanz = new Simpanz(44, false);
//       simpanz.setUmiestnenie("Pavilon Exotica");
//       simpanz.setDatum(new Datum(8, 2, 2013) );
//       
//       //slon
//       Zivocich slon = new Slon(200, 3500, true);
//       slon.setUmiestnenie("Pavilon Indo-Africky");
//       slon.setNazovDruhu("Slon John");
//       
//       //papuch
//       Zivocich papagaj = new Papagaj("ruzova", 3, true);
//       papagaj.setNazovDruhu("Papagaj Iki");
//       papagaj.setDatum(new Datum(8, 6, 2013) );
//       papagaj.setUmiestnenie("Pavilon Papuchov");
//       
//       //had
//       Zivocich had = new Had(547.4, 90, true);
//       had.setNazovDruhu("Had Slicky");
//       had.setUmiestnenie("Hadi Pavilon");
//       
//       System.out.print("\n");
////       System.out.println(kon.toString() );
////       System.out.println(simpanz.toString() );
////       System.out.println(slon.toString() );
////       System.out.println(papagaj.toString() );
////       System.out.println(had.toString() );
//       
//       System.out.println();
//       
//       Zverinec zv = new Zverinec(50);
//       zv.addZviera(kon);
//       zv.addZviera(simpanz);
//       zv.addZviera(slon);
//       zv.addZviera(papagaj);
//       zv.addZviera(had);
//       
//       System.out.println(zv.getZoznam() );
//   }
    
    static Zverinec zv;
    static Zivocich zver;
    
    /**
     * Hlavna ponuka
     * @return vypise hlavnu ponuku
     */
    private static String menu() {
        return
        "\nMenu" +
        "\n\t1 - Vytvor zverinec" +
        "\n\t2 - Vypis zivocichov v ZOO" +
        "\n\t3 - Pridat zivocicha" + "\n"//+
        //"\n\t4 - Upravit skladbu" +
        //"\n\t5 - Odstranit zivocicha" +
        //"\n\t6 - Odstran vsetky skladby" +
        //"\n\t7 - Vygenerovanie zivocichov do ZOO" +
        //"\n\t8 - Premenovat playlist" +
        //"\n\t9 - Usporiadat podla interpreta" +        
        //"\n\t0 - Ukoncit\n\n"
        ;
    }
    
    private static String menuZivocichov() {
        return
        "\nMenu zivocichov" +
        "\n\t1 - Slon" +
        "\n\t2 - Had" +
        "\n\t3 - Papuch" +
                "\n"
        ;
    }
    
//    /**
//     * Dialogove okno vstupu
//     * ziada vstup od pouzivatela
//     * @param text datovy typ String
//     * @return vstup vracia ako text
//     */
//    private static String inputDialog(String text) {
//        return JOptionPane.showInputDialog(null, text);
//    }
    
    /**
     * Vypis textu
     * Vypise text na terminal
     * @param text datovy typ String
     */
    private static void textOut(String text) {
        System.out.print(text);
    }
    
    /**
     * Vytvori triedu Zverinec so zadanym nazvom
     * @return instancia triedy Zverinec
     */
    private static Zverinec vytvorZverinec() {
        System.out.println("Zadajte kapacitu ZOO:");
        Scanner scan = new Scanner(System.in);
        int kap = scan.nextInt();
        zv = new Zverinec(kap);
        textOut("Zverinec s kapacitou " + kap + " zvierat je vytvoreny!" + "\n");
        return zv;
    }
    
    /**
     * Vypise vsetky prvky v zverinci
     */
    private static void vypisZverinec(Zverinec zv) {
        textOut(zv.getZoznam() );
    }
    
    /**
     * Prida zivocicha do zverinca
     * @param zver datovy typ Zivocich
     */
    private static void pridajSlona(Zivocich zver) {
        Scanner scan = new Scanner(System.in);
        textOut("Zadajte nazov zivocicha: " + "\n");
        String meno = scan.nextLine();
        textOut("Zadajte umiestnenie zivocicha: " + "\n");
        String umiestnenie = scan.nextLine();
        //String datNar = inputDialog("Zadajte jeho datum narodenia");
        //Datum datNar = new Datum(den, mesiac, rok);
        zv.addZviera(new Zivocich (meno, umiestnenie) );
    }
    
    
//    /**
//     * Upravi skladbu v playliste
//     * @param zver datovy typ Zivocich
//     */
//    private static void upravSkladbu(Zivocich zver) {
//        Scanner scan = new Scanner(System.in);
//        int index = Integer.parseInt( inputDialog("Zadajte LEN CISLO skladby, ktoru chcete upravit") );
//        String nazovSkladby = inputDialog("Zadajte nazov skladby");
//        String interpret = inputDialog("Zadajte interpreta");
//        String zaner = inputDialog("Zadajte zaner");
//        zv.set(index, new Zivocich(nazovSkladby, interpret, zaner) );
//    }
    
//    /**
//     * Odstrani skladbu na prislusnom mieste
//     */
//    private static void odstranSkladbu() {
//        int index = Integer.parseInt( inputDialog("Zadajte LEN CISLO skladby") );
//        zv.delete(index);
//    }
    
//    /**
//     * Odstrani vsetky skladby z playlistu
//     */
//    private static void odstranVsetkySkladby() {
//        zv.deleteAll();
//    }
    
//    /**
//     * Prida vopred definovane pesnicky do playlistu
//     * @param zv datovy typ Zivocich - odovzdava Zverinec
//     */
//    private static void generujPesnicky(Zverinec zv) {
//        zv.add(new Zivocich("Avicii", "Hey Brother", "House") );
//        zv.add(new Zivocich("The Whip", "Fire", "Indie House") );
//        zv.add(new Zivocich("Justice", "Genesis", "Indie House") );
//        zv.add(new Zivocich("Parov Stelar", "The Snake", "Electroswing") );
//        zv.add(new Zivocich("Eric Morillo", "Live Your Life (Chuckie Remix)", "House") );
//        zv.add(new Zivocich("Yelle", "A Cause Des Gracons", "Electro") );
//    }
    
//    /**
//     * Dovoluje premenovat playlist
//     */
//    private static void premenujZverinec() {
//        String nazov = inputDialog("Zadajte novy nazov");
//        zv.setNazovZverinecu(nazov);
//    }
    
    /**
     * Uklada volbu
     * @param oznam String - vracia oznam
     * @return vracia volbu
     */
    private static int vyber(String oznam) {
        System.out.print(oznam + ": ");
        Scanner scan = new Scanner(System.in);
        int volba = scan.nextInt();
        return volba;
    }
    
    /**
     * Vypisuje hlavne menu
     */
    public static void main (String[] args) {
        textOut("\f");
        int volba;
        
       
        do {
            volba = vyber(menu() + "Zadaj cislo volby");
            textOut("\f" + "Volba cislo " + volba + "\n" + "\n");
            switch (volba) {
                case 0:
                    textOut("***Koniec programu***");
                    System.exit(1);
                    break;
                case 1:
                    zv = vytvorZverinec();
                    break;
                case 2:
                    vypisZverinec(zv);
                    break;
                case 3:
                    pridajZivocicha(zver);
                    break;
                case 4:
                    //upravZivocicha(zver);
                    break;
                case 5:
                    //odstranZivocicha();
                    break;
                case 6:
                    //odstranVsetkychZivocichov();
                    break;
                case 7:
                    //generujZivocichov(zv);
                    break;
                case 8:
                    //premenujZverinec();
                    break;
                case 9:
                    //usporiadajPiesneInterpret();
                    break;
                default:
                    textOut("*** Zadajte platne cislo volby ***");
                    break;
            }
            
        } while(volba != 0);
    }
}
