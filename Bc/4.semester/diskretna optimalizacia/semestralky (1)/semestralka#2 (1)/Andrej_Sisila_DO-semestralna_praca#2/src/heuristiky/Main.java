package heuristiky;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;

/**
 * Trieda Main - Hlavna trieda
 * @author Andrej Šišila
 */
public class Main {
    
    private static int aPocPrvkov = 500;
    private static int aMaxPocPrvkov = 300;
    private static int aKapacita = 15000;
    private static Batoh batoh;

    public static void main(String[] args) {
        batoh = new Batoh(aPocPrvkov, aMaxPocPrvkov, aKapacita);
        
        System.out.println("Pociatocny stav batohu:");
        System.out.println(batoh.dajStav() );  //vypise startovacie riesenie
        zapisDoSuboru("zadanie.txt", batoh.dajStav());
        
        //dualna heuristika
        int[] pole = new int[aPocPrvkov];
        pole = batoh.dualnaHeuristika();
        System.out.println("Stav batohu po aplikovani dualnej heuristiky so strategiou Last Admissible :");
        System.out.println(batoh.dajStav() );
        zapisDoSuboru("riesenieDualnaHeuristika.txt", batoh.dajStav() );
        
        //vymenna heuristika
        batoh.initVymenna(pole);
        pole = batoh.vymennaHeuristika();
        System.out.println("Stav batohu po aplikovani vymennej heuristiky so strategiou First Admissible :");
        System.out.println(batoh.dajStav() );
        zapisDoSuboru("riesenieVymennaHeuristika.txt", batoh.dajStav());
    }
    
    private static void zapisDoSuboru(String paNazovSuboru, String paCoZapisat){
        try {
            PrintWriter zapisovac = new PrintWriter(new File(paNazovSuboru));
            zapisovac.println(paCoZapisat);
            zapisovac.close();
        } catch (FileNotFoundException ex) {
            System.out.println("Chyba pri zapise do suboru!");
        }
    }
}
