package podgrafyGrafu;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Scanner;

/**
 * Trieda Postupnost
 * vyhodnocuje, usporaduva a vypisuje vysledky metod pre algoritmus na
 * zistenie skonstruovatelnosti grafu na zaklade stupna, ktory je priradeny
 * vrcholu
 * 
 */

class Postupnost {

    private ArrayList<Integer> vrcholy;  
    
    //Bezparametricky konstruktor
    public Postupnost() throws FileNotFoundException, IOException 
    {
        vrcholy = new ArrayList<Integer>();
        citaj();
        System.out.println("\nZadali ste: " + vypisCisel());
        System.out.println("Priebeh vypoctu je vypisany nizsie: \n");
        vyhodnot();
    }

    /**
     * citaj vypise informacie o tvare vstupu
     * inicializuje scanner a vola metodu, ktora nacitava cisla.
     */
    private void citaj() throws FileNotFoundException, IOException
    {
        System.out.println("Citam stupne stupnov zo suboru 'vrcholy.txt'!");
        FileReader fr = new FileReader("vrcholy.txt");
        Scanner scan = new Scanner(fr);
        int dalsieCislo;
        while(scan.hasNextLine() ){
            dalsieCislo = scan.nextInt();
            vrcholy.add(dalsieCislo);
        }
        scan.close();
        fr.close();
    }



    //vyhodnoti, ci sa da zostrojit graf podla zadanych hodnot
    private void vyhodnot() {
        if(nulovyVysledok() == false && zapornyVysledok() == false){
            usporiadaj();
            skrtni();
            vyhodnot();
        } else if(zapornyVysledok() == true){
            System.out.println("Taký graf neexistuje! Aspon jedna vstupna "
                    + "hodnota je záporná.");
            System.out.println();
        } else if(nulovyVysledok() == true){
            System.out.println("Gratulujeme :D" + "\n"
                    + "Graf s vrcholmi takychto stupnov je platny.");
        }
    }
    
    //usporiadaj hodnoty v poli zostupne
    private void usporiadaj() {
        Collections.sort(vrcholy, new Porovnavac() );
        System.out.println("Usporiadaj cisla: " + vypisCisel() );
    }
    
    //skrtni - zmaze prve cislo; 
    private void skrtni(){
        int cislo1 = vrcholy.get(0);
        vrcholy.remove(0);
        if(cislo1 <= vrcholy.size()){
            for(int i = 0; i < cislo1; i++){
                int mensieCislo = vrcholy.get(i) - 1;
                vrcholy.set(i, mensieCislo);
            }
            System.out.println("Skrtni prve cislo a odpocitaj: " 
                    + vypisCisel() + "\n");
        }else{
            System.out.println("Taky graf neexistuje!" + "\n"
                    + "Stupen sa neda znizit. Overte hodnoty v textovom subore");
            System.exit(0);
        }
    }

    //metoda nulovyVysledok zistuje ci su vsetky stupne v kontajnery nulove
    private boolean nulovyVysledok() {
        int dohromady = 0;
        for(Integer cislo: vrcholy){
            dohromady = dohromady + cislo;
        }
        if(dohromady == 0){
            return true;
        }
        return false;

    }

    //metoda zapornyVysledok kontroluje pole pre zaporne cisla
    private boolean zapornyVysledok() {
        for(Integer cislo: vrcholy) {
            if(cislo < 0) {
                return true;
            }
        }
        return false;
    }     
    
    //metoda vypisCisel vypise vsetky cisla v poli
    public String vypisCisel() {
        String vypis = null;
        vypis = vrcholy.toString();
        
        //vymaz vsetky nepotrebne znaky
        vypis = vypis.replace("[", "");
        vypis = vypis.replace("]", "");
        vypis = vypis.replace(",", "");
        return vypis;
    }
}