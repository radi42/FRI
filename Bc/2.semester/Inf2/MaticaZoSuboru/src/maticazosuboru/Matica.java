package maticazosuboru;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;

/**
 *
 * @author Andy
 */
public class Matica {
    static ArrayList<Integer> matica = new ArrayList<Integer>();

    public static void main(String[] args) throws FileNotFoundException, IOException {
        FileReader fr = new FileReader("matica velka.txt");
        Scanner scan = new Scanner(fr);
        
        //ine riesenie
        while (scan.hasNextLine() ) {
          String riadok = scan.nextLine();

          Scanner lineScanner = new Scanner(riadok);
          while (lineScanner.hasNext()) {
//            riesenie pre string
//            String znak = lineScanner.next();
//            matica.add(Integer.parseInt(znak) );
//            System.out.print(znak + " ");
              
//            riesenie pre int
            int cislo = lineScanner.nextInt();
            matica.add(cislo);
            System.out.printf("%-4d", cislo);
          }
          lineScanner.close();
          System.out.println();
        }
        scan.close();
        fr.close();
    }
    
}
