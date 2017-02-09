import java.util.*; import java.io.*;
/**
 * Write a description of class Relacia here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Relacia
{
   private boolean aTabulka [] [];
   
   public Relacia() throws FileNotFoundException
   {
       aTabulka = new boolean [5] [5];
       FileInputStream fis = new FileInputStream("relacia.txt");
       Scanner s = new Scanner(fis);

       for (int i = 0; i < 5; i++) {
           
           for (int j = 0; j < 5; j++) {
           int h = s.nextInt();
           aTabulka[i][j] = (h == 1);
           }
        }
   }
   
   public boolean jeTranzitivna(){
       boolean vysledok = true;
       for (int y = 0; y < 5; y++){
           for (int x = 0; x < 5; x++){
               for (int z = 0; z < 5; z++){

                if( aTabulka[x][y] && aTabulka[y][z]) {
                    if ( !aTabulka[x][z] ) {vysledok = false;}

                }
            }
        }
       }
       return vysledok;
    }
}
