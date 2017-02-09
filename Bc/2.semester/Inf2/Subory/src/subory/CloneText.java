package subory;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Scanner;
/**
 * Trieda CloneText
 * podobna metode citac(). vypisovat riadok po riadku do terminalu
 * prekopirovat riadok po riadku z povodneho suboru do novovytvoreneho suboru
 * kazdy riadok ocislovany
 * @author sisila
 */
public class CloneText {
    
    public static void kopirovac(String menoSuboru, String menoKlonSuboru) 
            throws FileNotFoundException, IOException{
        FileReader fr = new FileReader(menoSuboru);
        PrintWriter pw = new PrintWriter(menoKlonSuboru);
        Scanner scan = new Scanner(fr);
        
        System.out.println("Takyto obsah originalneho suboru sa naklonoval do "
                + "noveho suboru: " + "\n");
        int i = 1;
        while(scan.hasNextLine() ){
            String riadok = scan.nextLine();
            System.out.println(riadok);
            pw.println(i + ". " + riadok);
            i++;
        }
        pw.close();
        fr.close();
    }
    
    public static void kopirovacDva(String menoSuboru, String menoKlonDvaSuboru) 
            throws FileNotFoundException, IOException{
        FileReader fr = new FileReader(menoSuboru);
        PrintWriter pw = new PrintWriter(menoKlonDvaSuboru);
        Scanner scan = new Scanner(fr);
        
        int i = 1;
        String s = "";
        while(scan.hasNextLine() ){
            String riadok = scan.nextLine();
            System.out.println(riadok);
            //novy riadok sa do suboru pridava cez %n pri String.format do parametrovej casti
            s += String.format("*** %3d *** %s %n", i, riadok);
            
            //z neznameho dovodu neodriadkuje: odriadkuj a daj carriage return
            //s += i + ". " + riadok + "\u0032" + "\u0013";
            
            i++;
        }
        pw.println(s);
        pw.close();
        fr.close();
    }
    
    public static void main(String[] args)
            throws FileNotFoundException, IOException{
        
        CloneText ct = new CloneText();
        
        //ct.kopirovac("obdlznik.txt", "klon.txt");
        ct.kopirovacDva("obdlznik.txt", "klonDva.txt");
        System.out.println("Subor uspesne naklonovany!");
    }
}
