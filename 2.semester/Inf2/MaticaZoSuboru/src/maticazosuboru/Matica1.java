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
public class Matica1 {
    static int[][] matica = new int[999][999];

    public static void main(String[] args) throws FileNotFoundException, IOException {
        FileReader fr = new FileReader("matica velka.txt");
        Scanner scan = new Scanner(fr);
        
        int riadok = 0;
        int stlpec = 0;
        
        //ine riesenie
        while (scan.hasNextLine() ) {
          String r = scan.nextLine(); //nacita riadok do stringu r
          Scanner citacRiadku = new Scanner(r);
          
          while (citacRiadku.hasNext()) {
//            riesenie pre String
//            String token = lineScanner.next();
//            matica[riadok] [stlpec] = Integer.parseInt(token);
//            System.out.print(token + " ");
              
//            riesenie pre int
            int cislo = citacRiadku.nextInt();
            matica[riadok] [stlpec] = cislo;
            System.out.printf("%-4d", cislo);
            stlpec++;
          }
          citacRiadku.close();
          System.out.println();
          riadok++;
        }
        scan.close();
        fr.close();
    }
    
}
