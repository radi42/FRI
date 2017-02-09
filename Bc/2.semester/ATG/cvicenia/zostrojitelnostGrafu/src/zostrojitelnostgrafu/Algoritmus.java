package zostrojitelnostgrafu;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Scanner;
import javax.swing.JOptionPane;

/**
 * Trieda Algoritmus - Valencna postupnost
 * 
 * Algoritmus zistuje, ci sa graf s danymi stupnami vrcholov da zostrojit
 * Vrcholov s neparym stupnom musi byt parny pocet
 * Najvyssi stupen vrchola musi byt n-1 kde n je pocet vrcholov
 * @author Andy
 */
public class Algoritmus {
    
    private ArrayList<Integer> postupnost;
    
    public Algoritmus(){
        postupnost = new ArrayList<>();
        naplnPostupnost();
        zoradPostupnost();
        overPostupnost();
        vypis();
    }

    
    private void naplnPostupnost() {
        File f = null;
        Scanner scan = null;
        
        try {
            f = new File("zadanie.txt");
            scan = new Scanner(f);
        } catch (FileNotFoundException ex) {
            JOptionPane.showMessageDialog(null, "Subor nenajdeny\n" + ex);
        }
        
        while(scan.hasNext() ){
            try{
                postupnost.add(scan.nextInt() );
            }catch(NumberFormatException ex){
                JOptionPane.showMessageDialog(null, "To co som nacital nie je cislo\n" + ex);
            }
        }
    }

    
    private void zoradPostupnost() {
        Collections.sort(postupnost, new Porovnavac() );
    }

    
    private boolean overPostupnost() {
        int pocetVrcholov = postupnost.size() -1;
        int stupenVrchola = postupnost.get(pocetVrcholov);
        
        //stupen vrchola nesmie byt vacsi ako pocet vrcholov
        if(stupenVrchola >= pocetVrcholov){
            return false;
        }
        
        //pocet vrcholov neparneho stupna je vzdy parny
        int pocet = 0;
        for(Integer i : postupnost){
            if(i % 2 != 0) pocet++;
        }
        if(pocet % 2 != 0){
           return false; 
        }
        else return true;
    }

    /**
     * vypis vyhonotenia postupnosti
     */
    private void vypis() {
        System.out.println("Zadanie");
        for(Integer i : postupnost){
            System.out.print(i + " ");
        }
        System.out.println("");
        if(overPostupnost() ) System.out.println("Postupnost " + postupnost.toString() + " sa DA zostrojit");
        else System.out.println("Postupnost " + postupnost.toString() + " sa NEDA zostrojit");
    }
    
    
}
