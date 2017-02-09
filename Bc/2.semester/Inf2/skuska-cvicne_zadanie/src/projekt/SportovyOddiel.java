package projekt;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Scanner;

/**
 *
 * @author Andy
 */
public class SportovyOddiel {
    
    private ArrayList<IVykonnostnySportovec> aZoznam;
    private int aMaxPocet;
    
    public SportovyOddiel(int paMaxPocet) {
        aZoznam = new ArrayList<IVykonnostnySportovec>();
    }

    public int getaMaxPocet() {
        return aMaxPocet;
    }

    public void setaMaxPocet(int aMaxPocet) {
        this.aMaxPocet = aMaxPocet;
    }
    
    public boolean vloz(IVykonnostnySportovec sportovec){
        if(aZoznam.size() < aMaxPocet){
            aZoznam.add(sportovec);
            return true;
        }
        else{
            return false;
        }
    }
    
    public String vypisZoznam(){
        String sportovci = "";
        for(IVykonnostnySportovec sportovec : aZoznam){
            sportovci += sportovec.vypis() + "\n";
        }
        return sportovci;
    }
    
    public String vytvorZostavu() throws FileNotFoundException{
        PrintWriter pw = new PrintWriter("zostava.txt");
        
        String sportovci = "";
        int pocitadlo = 0;
        
        
        sportovci += String.format("%s %n", "Vykonnostna trieda 1");
        sportovci += String.format("%s %n","================================================");
        for(IVykonnostnySportovec sportovec : aZoznam){
            if(sportovec.vykonnostnaTrieda() == 1){
                sportovci += String.format("%s %n", sportovec.vypis() );
                pocitadlo++;
            }
        }
        sportovci += String.format("%s %3d %n %n", "Pocet sportovcov:", pocitadlo);
        
        
        pocitadlo = 0;
        sportovci += String.format("%s %n", "Vykonnostna trieda 2");
        sportovci += String.format("%s %n","================================================");
        for(IVykonnostnySportovec sportovec : aZoznam){
            if(sportovec.vykonnostnaTrieda() == 2){
                sportovci += String.format("%s %n", sportovec.vypis() );
                pocitadlo++;
            }
        }
        sportovci += String.format("%s %3d %n %n", "Pocet sportovcov:", pocitadlo);
        
        
        pocitadlo = 0;
        sportovci += String.format("%s %n", "Vykonnostna trieda 3");
        sportovci += String.format("%s %n","================================================");
        for(IVykonnostnySportovec sportovec : aZoznam){
            if(sportovec.vykonnostnaTrieda() == 3){
                sportovci += String.format("%s %n", sportovec.vypis() );
                pocitadlo++;
            }
        }
        sportovci += String.format("%s %3d %n %n", "Pocet sportovcov:", pocitadlo);
        
        
        pocitadlo = 0;
        sportovci += String.format("%s %n", "Vykonnostna trieda 0");
        sportovci += String.format("%s %n","================================================");
        for(IVykonnostnySportovec sportovec : aZoznam){
            if(sportovec.vykonnostnaTrieda() == 0){
                sportovci += String.format("%s %n", sportovec.vypis() );
                pocitadlo++;
            }
        }
        sportovci += String.format("%s %3d %n %n", "Pocet sportovcov:", pocitadlo);
        
        
        pw.print(sportovci);
        pw.close();
        
        return sportovci;
    }
    
    public void zapisDoSuboru() throws FileNotFoundException{
        PrintWriter pw = new PrintWriter("subor.txt");
        for(IVykonnostnySportovec sportovec : aZoznam){
            pw.println(sportovec.zapisDoSuboru() );
        }
        pw.close();
    }
    
    public void naplnZoSuboru() throws FileNotFoundException{
        File f = new File("subor.txt");
        Scanner scan = new Scanner(f);
        aZoznam.clear();
        
        String typSportovca = "";
        String vykon = "";
        String meno = "";
        String rokNarodenia = "";
        
        while(scan.hasNext() ){
            typSportovca = scan.nextLine().replace(" ", "");
            vykon = scan.nextLine().replace(" ", "");
            meno = scan.nextLine().replace(" ", "");
            rokNarodenia = scan.nextLine().replace(" ", "");

            switch(typSportovca){
                case "turista":
                    aZoznam.add(new Turista(Integer.parseInt(rokNarodenia), meno, Integer.parseInt(vykon) ) );
                    break;
                case "strelec":
                    aZoznam.add(new Strelec(Integer.parseInt(rokNarodenia), meno, Integer.parseInt(vykon) ) );
                    break;
                default:
//                    System.out.println("Boli nacitane zle parametre do konstruktora");
            }
        }
        scan.close();
    }
}
