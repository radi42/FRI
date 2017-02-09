//import javax.swing.*;
import java.util.*;
/**
 * Hlavna aplikacia Datum
 * 
 * @author Andrej Sisila
 * @version v1.0
 */
public abstract class Main //abstract - trieda, ktora nevytvara instancie
{   
    static Skupina skup;

    private static int vyber(String prompt) {
        int v = -1;
        
        System.out.print("--" + prompt + ": ");
        Scanner klav = new Scanner(System.in);
        v = klav.nextInt();
        return v;
    }
    
    private static void outNadpis(String s) {
        //naprogramujeme si vypis riadku len jeden krat a pouzivame ho v programe. metoda komunikuje cez parameter, ktory sa ma menit
        System.out.println(s);
    }
    
    private static boolean nedefSkupina(Skupina skupina) {
        if (skupina != null) return false;
        outNadpis("!!! Skupina nie je definovana");
        return true;
    }
    
    private static void vypisSkupinu(Skupina skupina) {
        if (nedefSkupina(skupina) ) return;
        outNadpis(skupina.toString() );
        //if (skupina == null ) { 
    }
        
    private static Skupina vytvorSkupinu() {
        Scanner klav = new Scanner(System.in); // vytvorime scanner a hned ho zabudneme
        System.out.print(" nazov skupiny ");
        String nazov = klav.nextLine();
        outNadpis(" Skupina " + nazov + " je vytvorena :D");
        return new Skupina(30, nazov);
    }
    
    private static void generujStud(Skupina skupina) {
        if (nedefSkupina(skupina)){
            outNadpis("Supina este neexistuje");
            return;
        }
        else {
            //pri pridavani studentov sa pozerame na konstruktory jednotlivych tried
            skupina.add(new Student 
                            (new Osoba
                                ("Ivan",
                                 "Hrozny",
                                 new Datum( 4, 
                                            5,
                                            1800
                                           ),
                                 "Moskva"
                                 ),
                              "Informatika"
                             )
                        );
            skupina.add(new Student
                            (new Osoba("Jan", "Novak", new Datum (25, 6, 1992), "Zilina" ), "Informatika") );
            skupina.add(new Student
                            (new Osoba("Jan", "Nagy", new Datum (5, 4, 1993), "Vrutky" ), "Informatika") );
            skupina.add(new Student
                            (new Osoba("Jan", "Puk", new Datum (19, 8, 1994), "Terchova" ), "Informatika") );
            skupina.add(new Student
                            (new Osoba("Jan", "Maros", new Datum (3, 1, 1993), "Ochodnic" ), "Management") );
                            
            outNadpis("Bolo vygenerovanych 5 studentov");
        }
    }
    
    private static String menu() {
        return
        "\n Ponuka" +
        "\n\t0 - Koniec cinnosti\n" +
        "\n\t1 - Vytvor novu skupinu\n" +
        "\n\t2 - Vygenerovanie studentov do skupiny \n" +
        "\n\t3 - Vypis zoznamu studentov v skupine\n" +
        "\n\t4 - Vloz studenta do zoznamu\n" +
        "\n\t5 - Vloz vsetkym rocnik studia\n" +
        "\n\t6 - Pridaj studentom mesto\n" +
        "\n\t7 - Vloz vsetkym predmet\n" +
        "\n\t8 - Vloz hodnotenie skusky\n" +
        "\n\t111 - Testovaci vstup\n"
        ;
    }
    
    
    private static boolean vlozStudenta(Skupina skupina) {
        Scanner scan = new Scanner(System.in);
        String meno = "Meno " + scan.nextLine();
        String priezvisko = "Priezvisko " + scan.nextLine();
        String bydlisko = "Bydlisko " + scan.nextLine();
        String odbor = "Odbor " + scan.nextLine();
        int den = scan.nextInt();
        int mesiac = scan.nextInt();
        int rok = scan.nextInt();
        
        skupina.add(new Student 
                        (new Osoba
                            (meno, //nextline
                             priezvisko,//nextline
                             new Datum( den, //nextint
                                        mesiac, //nextint
                                        rok//nextint
                                       ),
                             bydlisko//nextline
                             ),
                          odbor//nextline
                         )
                    );
        return true;
    }
    
    private static void vlozRocnikVsetkym(Skupina skupina) {
        Scanner scan = new Scanner(System.in);
        int rocnik = scan.nextInt();
        for(int i = 0; i < skupina.size(); i++) {
            //prejst vsetky prvky pola a nastavit rocnik z premennej rocnik
            //vsetko sa riesi getterom z gettera
            skupina.get(i).setRocnik(rocnik);
        }
    }
    
    private static void studentiZMesta(Skupina skupina) {
        if (nedefSkupina(skupina) ) return;
        System.out.print("Vloz zadane mesto: ");
        Scanner scan = new Scanner (System.in);
        String mesto = scan.nextLine();
        
        String s = "\n** Zoznam studentov v meste: " + mesto;
        
        int pocet = 0;
        for (int i = 0; i < skupina.size(); i++) {
            if (skupina.get(i).getClovek().getBydlisko().equals(mesto) ) {
                s += "\n" + skupina.get(i);
                pocet++;
            }
        }
        outNadpis(">>> Pocet studentov z mesta " + mesto + " je " + pocet + s);
    }
   
    public static void main (String[] args) {
        int volba;
        do {
            volba = vyber(menu() + "\n Vloz cislo volby");
            outNadpis("\f*** Volba cislo " + volba + "***"); //Mozme System.out.println nahradit metodou ktora to bude vypisovat
            switch (volba) {
                case 0:
                    outNadpis("***Dakujem za pozornost. Error 404***");
                    break;
                case 1:
                    skup = vytvorSkupinu();
                    break;
                case 2:         //Vygenerovanie studentov do skupiny
                    generujStud(skup);
                    break;
                case 3:
                    vypisSkupinu(skup);
                    break;
                case 4:        //Vloz studenta do zoznamu
                    vlozStudenta(skup);
                    break;
                case 5:         //Vloz vsetkym rocnik studia
                    vlozRocnikVsetkym(skup);
                    break;
                case 6:
                    studentiZMesta(skup);
                    break;
                case 7:
                    outNadpis("*** Neimplementovane ***");
                    break;
                case 8:
                    outNadpis("*** Neimplementovane ***");
                    break;
                case 111:
                    outNadpis("*** Neimplementovane ***");
                    break;
                default:
                    outNadpis("*** Zadajte platne cislo volby ***");
            }
            
            outNadpis("OK");
        } while(volba != 0);
    }
     
}
