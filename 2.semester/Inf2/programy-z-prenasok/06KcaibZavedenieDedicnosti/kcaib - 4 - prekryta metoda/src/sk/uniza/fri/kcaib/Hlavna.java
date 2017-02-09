/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sk.uniza.fri.kcaib;

import javax.swing.JOptionPane;
import sk.uniza.fri.kcaib.databaza.Katalog;
import sk.uniza.fri.kcaib.polozky.CD;
import sk.uniza.fri.kcaib.polozky.DVD;

/**
 *
 * @author janik
 */
public class Hlavna {

    private static Katalog aKatalog = new Katalog();
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        

//        katalog.pridaj(new CD("The Best of", "The Beatles", 12, 30));
//        katalog.pridaj(new CD("Brave New World", "Styx", 14, 45));
//
//        katalog.pridaj(new DVD("Tenkrat na zapade", "Neznamy", 90));
//        katalog.pridaj(new DVD("The Avengers", "The Avengers", 142));
//
//        katalog.vypisPolozky();
        
            int vyber = -1;
            String hlasenie = null;
            
        while(vyber !=0){
            hlasenie = JOptionPane.showInputDialog(null, hlavneMenuPolozky() );
            try{
                vyber = Integer.parseInt(hlasenie);
            }catch(NumberFormatException nfe){
                JOptionPane.showMessageDialog(null, "Zadajte platne cislo volby");
            }
            
        switch(vyber){
            case 0:
                System.exit(0);
                
            case 1:
                vypisNaTerminal();
                break;
            
            case 2:
                vytvorCD();
                break;
                
            case 3:
                vytvorDVD();
                break;
            }
        }
    }
    
    public static String hlavneMenuPolozky(){
        return    "1. Vypis skladby (vid terminal)\n"
                + "2. Pridaj CD\n"
                + "3. Pridaj DVD\n"
                + "0. Koniec";
    }
    
    public static void vytvorCD(){
        String titulCD = JOptionPane.showInputDialog(null, "Zadaj nazov CD" );
        String autorCD = JOptionPane.showInputDialog(null, "Zadaj nazov kapely" );
        int pocetSkladieb = 0;
        int celkovyCasCD = 0;
        boolean vynimka;
        
        do{
            try{
                pocetSkladieb = Integer.parseInt(JOptionPane.showInputDialog(null, "Zadaj pocet skladieb (0 ak nie je znamy)" ) );
                vynimka = false;
            }catch(NumberFormatException nfe1){
                JOptionPane.showMessageDialog(null, "Zadaj platnu celociselnu hodnotu");
                vynimka = true;
            }
        }
        while(vynimka);
        
        do{
            try{
                celkovyCasCD = Integer.parseInt(JOptionPane.showInputDialog(null, "Zadaj celkovy cas (0 ak nie je znamy)" ) );
                vynimka = false;
            }catch(NumberFormatException nfe2){
                JOptionPane.showMessageDialog(null, "Zadaj platnu celociselnu hodnotu");
                vynimka = true;
            }
        }
        while(vynimka);
        
        aKatalog.pridaj(new CD(titulCD, autorCD, pocetSkladieb, celkovyCasCD) );
        JOptionPane.showMessageDialog(null, "CD uspesne pridane\n"
                + "Nazov CD: " + titulCD + "\n"
                + "Autor CD: " + autorCD +"\n"
                + "Pocet skladieb: " + (pocetSkladieb == 0 ? "neuvedene" : pocetSkladieb) + "\n"
                + "Celkovy cas: " + (celkovyCasCD == 0 ? "neuvedene" : celkovyCasCD) );
    }
    
    public static void vytvorDVD(){
        String titulDVD = JOptionPane.showInputDialog(null, "Zadaj nazov DVD" );
        String reziser = JOptionPane.showInputDialog(null, "Zadaj meno rezisera" );
        int celkovyCasDVD = 0;
        boolean vynimka = false;
        
        do{
            try{
                celkovyCasDVD = Integer.parseInt(JOptionPane.showInputDialog(null, "Zadaj celkovy cas (0 ak nie je znamy)" ) );
                vynimka = false;
            }catch(NumberFormatException nfe){
                JOptionPane.showMessageDialog(null, "Zadajte platnu celociselnu hodnotu");
                vynimka = true;
            }
        }
        while(vynimka);
        
        aKatalog.pridaj(new DVD(titulDVD, reziser, celkovyCasDVD) );
        JOptionPane.showMessageDialog(null, "DVD uspesne pridane\n"
                + "Nazov DVD: " + titulDVD + "\n"
                + "Reziser DVD: " + reziser +"\n"
                + "Celkovy cas: " + (celkovyCasDVD == 0 ? "neuvedene" : celkovyCasDVD) );
    }
    
    public static void vypisNaTerminal(){
        aKatalog.vypisPolozky();
    }
    
    //toto bude kapanek zlozitejsie, lebo treba zmenit metodu "vypis" v kazdej triede na to abe vracala String
    public static void vypisDoMessageBoxu(){
        
    }
}
