package projekt;

import java.io.FileNotFoundException;
import javax.swing.JOptionPane;

public class Program {

    private static SportovyOddiel oddiel;
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        String maxPocet = JOptionPane.showInputDialog(null, "Zadajte maximalny pocet sportovcov v oddieli");
        oddiel = new SportovyOddiel(Integer.parseInt(maxPocet) );
        oddiel.setaMaxPocet(Integer.parseInt(maxPocet) );
        
        String volba = "-1";
        while(!volba.equals(0) ){
            volba = String.valueOf(numInputBox() );
            try {
                vykonajAkciu(volba);
            } catch (FileNotFoundException ex) {
                System.out.println("Subor nenajdeny");
            }
        }
    }
    
    private static int numInputBox(){
        String volba = JOptionPane.showInputDialog(null, hlavneMenu() );
        return Integer.parseInt(volba);
    }
    
    private static String hlavneMenu(){
        String menu = "";
        menu += "1. generuj sportovcov \n";
        menu += "2. vypis sportovcov \n";
        menu += "3. vyhodnot sportovcov podla triedy a uloz ich do suboru\n";
        menu += "4. uloz sportovcov do suboru \n";
        menu += "5. nacitaj sportovcov zo suboru \n";
        menu += "0. koniec \n";
        return menu;
    }
    
    private static void vykonajAkciu(String volba) throws FileNotFoundException{
        switch(volba){
            case "1":
                generujSportovcov();
                break;
            
            case "2":
                System.out.println(oddiel.vypisZoznam() );
                break;
           
            case "3":
                System.out.println(oddiel.vytvorZostavu() );
                break;
            
            case "4":
                oddiel.zapisDoSuboru();
                break;
            
            case "5":
                oddiel.naplnZoSuboru();
                break;
                
            case "0":
                System.exit(0);
        }
    }
    
    private static void generujSportovcov(){
        oddiel.vloz(new Turista(1950, "Duro", 150) );
        oddiel.vloz(new Strelec(1965, "Jano", 95) );
        oddiel.vloz(new Turista(1990, "Jozo", 150) );
        oddiel.vloz(new Strelec(1991, "Fero", 85) );
        
    }
    
}
