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
    public static void main(String[] args){
        Playlist pllst = new Playlist(999);
        pllst.setNazovPlaylistu(JOptionPane.showInputDialog(null, "Zadaj nazov playlistu") );
        
        int pocetPiesni = pllst.getPocetPiesni();
        String skladba = null;
            switch (pocetPiesni) {
                case 1:
                    skladba = "piesen"; break;
                case 2: case 3: case 4:
                    skladba = "piesne"; break;
                default:
                    skladba = "piesni";
            }
        System.out.print("\f" + " " + pllst.getNazovPlaylistu() );
        System.out.print("     V playliste " + pllst.getNazovPlaylistu() + " sa nachadza " + pocetPiesni + " " + skladba);
        System.out.printf("\n %s %13s %30s %26s","Číslo piesne", "Interprét", "Názov skladby", "Žáner");

        
        /**
         * Hlavne menu
         */
        //System.out.printf("\n %s %2d %2s","Stacte", 1, " pre hlavne menu \n");
        Scanner scan = new Scanner(System.in);
        int klavesa = scan.nextInt(); //nacitaj jedeno cislo
            switch (klavesa) {
                    
                    //case 1:
                    //int volba = Integer.parseInt(JOptionPane.showInputDialog(
                    //                             null,   
                    //                             "Pridat skladbu: 2; " +
                    //                             "Upravit skladbu: 3; " + 
                    //                             "Odstranit skladbu: 4; " +
                    //                             "Ukoncit program: 0; ")
                    //                             );
                    //break;
                    case 2:
                    do {
                        //vynuluj parametre pesnicky
                        Pesnicka song = new Pesnicka(null, null, null);
                        
                        //nastav parametre pesnicky
                        song.setInterpret (JOptionPane.showInputDialog(null, "Zadaj interpreta") );
                        song.setNazovSkladby (JOptionPane.showInputDialog(null, "Zadaj nazov skladby") );
                        song.setZaner (JOptionPane.showInputDialog(null, "Zadaj zaner") );
            
                        //pridaj skladbu
                        song = new Pesnicka(song.getInterpret(), song.getNazovSkladby(), song.getZaner() );
                        pllst.addSkladba(song);
                        pocetPiesni++;
                        
                        //vypis skladbu
                        System.out.print("\f" + " " + pllst.getNazovPlaylistu() );
                        System.out.print("     V playliste " + pllst.getNazovPlaylistu() + " sa nachadza " + pocetPiesni + " " + skladba);
                        System.out.printf("\n %s %13s %30s %26s","Číslo piesne", "Interprét", "Názov skladby", "Žáner");
                        System.out.println();
                        pllst.toString();
                       
                    } 
                    while (klavesa == scan.nextInt() ); //vrat sa na zaciatok switcha a zacni odznova iba ak stlacim 2
                
            }
    }
}