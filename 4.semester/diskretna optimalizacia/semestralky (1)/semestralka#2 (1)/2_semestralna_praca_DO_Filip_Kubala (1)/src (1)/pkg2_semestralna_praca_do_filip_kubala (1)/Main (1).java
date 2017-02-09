package pkg2_semestralna_praca_do_filip_kubala;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * @author Filip Kubala
 */
public class Main {
    private static final int aPocPrvkov = 500;
    private static final int aMaxPocPrvkov = 300;
    private static final int aKapacita = 15000;
    private static Batoh batoh;

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        batoh = new Batoh(aPocPrvkov, aMaxPocPrvkov, aKapacita);
        
        System.out.println("Pociatocny stav batohu:");
        System.out.println(batoh.dajStart() );  //vypise startovacie riesenie
        zapisDoSuboru("zadanie.txt", batoh.dajStart());
        
        //dualna heuristika
        int[] pole = new int[aPocPrvkov];
        pole = batoh.dualnaHeuristika();
        System.out.println("Stav batohu po aplikovani dualnej heuristiky so strategiou Last Admissible :");
        System.out.println(vypisRiesenie(pole) );
        zapisDoSuboru("riesenieDualnaHeuristika.txt", vypisRiesenie(pole));
        
        //vymenna heuristika
        batoh.initVymenna(pole);
        pole = batoh.vymennaHeuristika();
        System.out.println("Stav batohu po aplikovani vymennej heuristiky so strategiou First Admissible :");
        System.out.println(vypisRiesenie(pole) );
        zapisDoSuboru("riesenieVymennaHeuristika.txt", vypisRiesenie(pole));
    }   

    private static String vypisRiesenie(int[] pole) {
        String riesenie = "";
        //vypis vysledny vektor
        for (int i = 0; i < batoh.dajMaxPocPrvkovVBatohu(); i++) {
            riesenie += pole[i] + " ";
        }
        riesenie += String.format("%n");
        
        //vypis previs, volnu kapacitu a hodnotu ucelovej funkcie
        riesenie += String.format("%s %d %n", "Hodnota ucelovej funkcie = ", batoh.dajAktualCenaPrvkovVBatohu() );
        riesenie += String.format("%s %d %n", "Pocet prvkov v batohu = ", batoh.dajAktualPocPrvkovVBatohu() );
        riesenie += String.format("%s %d %n", "Hmotnost batoha = ", batoh.dajAktualHmotPrvkovVBatohu() );
        riesenie += String.format("%s %d %n", "Previs = ", batoh.dajPrevis() );
        riesenie += String.format("%s %d %n", "Volna kapacita = ", (-batoh.dajPrevis() ) );
        return riesenie;
    }
    
    private static void zapisDoSuboru(String paNazovSuboru, String paCoZapisat){
        try {
            PrintWriter zapisovac = new PrintWriter(new File(paNazovSuboru));
            zapisovac.println(paCoZapisat);
            zapisovac.close();
        } catch (FileNotFoundException ex) {
            Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}