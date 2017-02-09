/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package kruskalovalgoritmus;

import java.io.FileNotFoundException;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.SwingConstants;

/**
 * Trieda Main
 * 
 * Rozcestnik AKA Launcher
 * @author Andy
 */
public class Main {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws FileNotFoundException {
        String volba = "x";
        
        do{
            volba = JOptionPane.showInputDialog(null, "Kruskalov algoritmus\n"
                    + "zadajte cislo volby\n"
                    + "==============================\n"
                    + "1. Najlacnejsia kostra\n"
                    + "2. Najdrahsia kostra\n"
                    + "0. Ukoncit");

            switch(volba){
                case "1":
                    KostraNajlacnejsia lacna = new KostraNajlacnejsia();
                    break;
                case "2":
                    KostraNajdrahsia draha = new KostraNajdrahsia();
                    break;
                case "0":
                    JOptionPane.showMessageDialog(null, "             Na Zdorovie!");
                    System.exit(1);
                default:
                    JOptionPane.showMessageDialog(null, "Prosim zadajte spravne cislo volby");
            }
        }while(!volba.equals("0") );
    }
    
}
