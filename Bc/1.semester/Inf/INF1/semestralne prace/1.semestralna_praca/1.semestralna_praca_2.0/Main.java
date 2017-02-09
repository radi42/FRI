import javax.swing.*;
import java.util.*;
/**
 * Trieda Main - Hlavny program - Vypisuje pesnicky
 * 
 * @author Andrej Sisila
 * @version v4.0
 */
public abstract class Main
{
    static Playlist pllst;
    static Pesnicka song;
    
    /**
     * @return
     */
    private static String menu() {
        return
        "\nMenu" +
        "\n\t1 - Vytvor novy playlist" +
        "\n\t2 - Vypis playlist" +
        "\n\t3 - Pridat skladbu" +
        "\n\t4 - Upravit skladbu" +
        "\n\t5 - Odstranit skladbu" +
        "\n\t6 - Odstran vsetky skladby" +
        "\n\t7 - Vygenerovanie skladieb do playlistu" +
        "\n\t8 - Premenovat playlist" +
        "\n\t0 - Ukoncit\n\n"
        ;
    }
    
    /**
     * @param
     */
    private static String inputDialog(String text) {
        return JOptionPane.showInputDialog(null, text);
    }
    
    /**
     * #param
     */
    private static void textOut(String text) {
        System.out.print(text);
    }
    
    /**
     * 
     */
    private static Playlist vytvorPlaylist() {
        Playlist pllst = new Playlist();
        String meno = inputDialog("Zadajte nazov playlistu");
        pllst.setNazovPlaylistu(meno);
        textOut("Playlist " + meno + " je vytvoreny");
        return pllst;
    }
    
    /**
     * 
     */
    private static void vypisPlaylist() {
        textOut(pllst.getNazovPlaylistu() + "\n");
        textOut(pllst.toString() );
    }
    
    /**
     * @param
     */
    private static void pridajSkladbu(Pesnicka song) {
        Scanner scan = new Scanner(System.in);
        String nazovSkladby = inputDialog("Zadajte nazov skladby");
        String interpret = inputDialog("Zadajte nazov skladby");
        String zaner = inputDialog("Zadajte nazov skladby");   
        pllst.add(new Pesnicka (nazovSkladby, interpret, zaner) );
    }
    
    
    /**
     * @param
     */
    private static void upravSkladbu(Pesnicka song) {
        Scanner scan = new Scanner(System.in);
        int index = Integer.parseInt( inputDialog("Zadajte LEN CISLO skladby, ktoru chcete upravit") );
        String nazovSkladby = inputDialog("Zadajte nazov skladby");
        String interpret = inputDialog("Zadajte interpreta");
        String zaner = inputDialog("Zadajte zaner");
        pllst.set(index, new Pesnicka(nazovSkladby, interpret, zaner) );
    }
    
    /**
     * 
     */
    private static void odstranSkladbu() {
        int index = Integer.parseInt( inputDialog("Zadajte LEN CISLO skladby") );
        pllst.delete(index);
    }
    
    /**
     * 
     */
    private static void odstranVsetkySkladby() {
        pllst.deleteAll();
    }
    
    /**
     * 
     */
    private static void generujPesnicky(Playlist pllst) {
        pllst.add(new Pesnicka("Avicii", "Hey Brother", "House") );
        pllst.add(new Pesnicka("The Whip", "Fire", "Indie House") );
        pllst.add(new Pesnicka("Justice", "Genesis", "Indie House") );
        pllst.add(new Pesnicka("Parov Stelar", "The Snake", "Electroswing") );
        pllst.add(new Pesnicka("Eric Morillo", "Live Your Life (Chuckie Remix)", "House") );
        pllst.add(new Pesnicka("Yelle", "A Cause Des Gracons", "Electro") );
    }
    
    /**
     * 
     */
    private static void premenujPlaylist() {
        String nazov = inputDialog("Zadajte novy nazov");
        pllst.setNazovPlaylistu(nazov);
    }
    
    /**
     * 
     */
    private static int vyber(String oznam) {
        System.out.print(oznam + ": ");
        Scanner scan = new Scanner(System.in);
        int volba = scan.nextInt();
        return volba;
    }
    
    /**
     * 
     */
    public static void main (String[] args) {
        textOut("\f");
        int volba;
        
       
        do {
            volba = vyber(menu() + "Zadaj cislo volby");
            textOut("\f" + "Volba cislo " + volba + "\n");
            switch (volba) {
                case 0:
                    textOut("***Dakujem za pozornost. Program sa o chvilu ukonci.***");
                    System.exit(1);
                    break;
                case 1:
                    pllst = vytvorPlaylist();
                    break;
                case 2:
                    vypisPlaylist();
                    break;
                case 3:
                    pridajSkladbu(song);
                    break;
                case 4:
                    upravSkladbu(song);
                    break;
                case 5:
                    odstranSkladbu();
                    break;
                case 6:
                    odstranVsetkySkladby();
                    break;
                case 7:
                    generujPesnicky(pllst);
                    break;
                case 8:
                    premenujPlaylist();
                    break;
                default:
                    textOut("*** Zadajte platne cislo volby ***");
                    break;
            }
            
        } while(volba != 0);
    }
    
    
    
}