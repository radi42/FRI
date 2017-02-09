import java.util.Scanner;
/**
 * Trieda Main
 * vypisuje vysledky metod
 * 
 * @author Andrej Sisila
 * @version v1.0
 */
public abstract class Main
{
    static Cas time;
    static Stanica station;
    static Spoj spoj;
    
    private static void vypis(String s){
        System.out.print(s);
    }
    
    public static void main(String[] args){
        //vycisti obrazovku
        System.out.print("\f");
        
        ////zapni skener
        //Scanner scan = new Scanner(System.in);
        
        station = new Stanica("Zilina", 10, 5, 7, new Cas(15, 16, 17) );
        vypis(station.toString() + "\n");
        
        spoj.addSpoj();
        spoj.jazdaVlaku();
    }

    
}
