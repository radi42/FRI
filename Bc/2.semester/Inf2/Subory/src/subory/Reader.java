package subory;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.Scanner;
/**
 * Trieda Main
 * vypisuje vysledky metod
 * @author sisila
 * 
 * Citanie z disku texty
 * treba vyuzit balicky s triedami:
 * java.io.FileReader
 * 
 */
public class Reader {

    /**
     * Vyhlada, otvori a vypise subor
     * @param nazov nazov suboru, ktory citame
     * @throws FileNotFoundException osetrime vynimku, kedy nie je nacitany
     * ziadny subor
     */
    public void citac(String nazov) throws FileNotFoundException{
        FileReader fr = new FileReader(nazov);
        Scanner scan = new Scanner(fr);
        int i = 1;
        //vypisuj riadky pokym subor este nejake riadky ma
        while(scan.hasNextLine() ){
            String riadok = scan.nextLine();
            System.out.println(i + ". " + riadok);
            i++;
        }
        //zatvori scanner, vycisti buffer a zatvori subor, cim ho uvolni na dalsie pouzitie
        scan.close();
    }
    
    public static void main(String[] args) throws FileNotFoundException{
        Reader r = new Reader();
        r.citac("obdlznik.txt");
    }
}