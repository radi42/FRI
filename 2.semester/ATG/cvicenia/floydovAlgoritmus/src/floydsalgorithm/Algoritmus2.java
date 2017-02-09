package floydsalgorithm;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.InputMismatchException;
import java.util.Scanner;
import javax.swing.JOptionPane;

/**
 *
 * @author Sisila
 */
public class Algoritmus2 {
    
    private int[][] c; // c je matica vzdialenosti
    private int[][] x; // x je matica predchodcov
    private int pocetVrcholov;
    private boolean maZaporneCislo = false;
    private final int n = Integer.MAX_VALUE - 100000; //pomyselne nekonecno
    
    /**
     * Konstruktor
     */
    public Algoritmus2(){
//Hard-coded zadania
//        Zadanie 1
//        pocetVrcholov = 4;
//        c = new int[][]{
//            {0, 3, n, 2 },
//            {n, 0, 2, n },
//            {1, n, 0, n },
//            {n, n, 4, 0 }
//        };
        
//        Zadanie 2 - z prednasky
//       pocetVrcholov = 5;
//        c = new int[][]{
//            {0, 6, 3, 2, n },
//            {n, 0, 5, n, n },
//            {n, n, 0, n, 7 },
//            {n, 3, n, 0, 4 },
//            {1, n, n, n, 0}
//        };
        
        nacitajMaticuZoSuboru();
        vytvorMaticuX();
        test();
        
        if(maZaporneCislo)
            vytvorMaticuVzdialenosti();
        else
            vytvorMaticuVzdialenostiZaporne();
        
        vypisMatice();
    }
    
    /**
     * Metoda vytvorMaticuVzdialenosti
     * 
     * ak sa v matici vyskytuju iba kladne cisla
     */
    public void vytvorMaticuVzdialenosti(){
        for(int k = 0; k < pocetVrcholov; k++){             //riadiaci index pre riadok/stlpec
            for(int i = 0; i < pocetVrcholov; i++){         //index riadku
                for(int j = 0; j < pocetVrcholov; j++){     //index stlpca
                    
                    if(k == i || k == j) continue;          //nemen prvky v riadiacom riadku a stlpci
                    if(i == j)                              //preskoc prvky hlavnej diagonaly
                        continue;
                    if(c[i][k] == n || c[k][j] == n)        //preskoc tie riadky, kde sa v riadiacom stlpci nachadza nekonecno a tie stlpce, kde sa v riadiacom riadku nachadza nekonecno
                        continue;
                    if(c[i][j] > c[i][k] + c[k][j]){
                        c[i][j] = c[i][k] + c[k][j];
                        x[i][j] = x[k][j];
                    }
                }
            }
        }
    }
    
    /**
     * Metoda vytvorMaticuVzdialenosti
     * 
     * ak sa v matici vyskytuju iba kladne cisla >=0
     */
    public void vytvorMaticuVzdialenostiZaporne(){
        for(int k = 0; k < pocetVrcholov; k++){             //riadiaci index pre riadok/stlpec
            for(int i = 0; i < pocetVrcholov; i++){         //index riadku
                for(int j = 0; j < pocetVrcholov; j++){     //index stlpca
                    
                    if(k == i || k == j) continue;          //nemen prvky v riadiacom riadku a stlpci

                    if(c[i][k] == n || c[k][j] == n)        //preskoc tie riadky, kde sa v riadiacom stlpci nachadza nekonecno a tie stlpce, kde sa v riadiacom riadku nachadza nekonecno
                        continue;
                    if(c[i][j] > c[i][k] + c[k][j]){
                        c[i][j] = c[i][k] + c[k][j];
                        x[i][j] = x[k][j];
                    }
                }
            }
        }
    }

    private void vypisMatice() {
        System.out.println("Matica C");
        for(int i = 0; i < pocetVrcholov; i++){
            for(int j = 0; j < pocetVrcholov; j++){
                System.out.printf("%15d",c[i][j]);
            }
            System.out.println();
        }
        
        System.out.println("==================================================="
                + "===================================================");
        System.out.println("Matica X");
        for(int i = 0; i < pocetVrcholov; i++){
            for(int j = 0; j < pocetVrcholov; j++){
                System.out.printf("%15d",x[i][j]);
            }
            System.out.println();
        }
    }

    private void nacitajMaticuZoSuboru() {
        String subor = JOptionPane.showInputDialog(null, "Zadajte nazov suboru so zadanim");
        File f = new File(subor);
        Scanner scan = null;
        try {
            scan = new Scanner(f);
        } catch (FileNotFoundException ex) {
            JOptionPane.showMessageDialog(null, "Nepodarilo sa najst subor\n" + ex);
            System.exit(0);
        }
        
        pocetVrcholov = scan.nextInt();
        c = new int[pocetVrcholov][pocetVrcholov];
        x = new int[pocetVrcholov][pocetVrcholov];
        String cislo = "";
        for(int i = 0; i < pocetVrcholov; i++){
            for(int j = 0; j < pocetVrcholov; j++){
                cislo = scan.next();
                
                //tolkoto vynimiek trebalo osetrit aby som zo suboru do prvku pola nacital nekonecno
                try{
                c[i][j] = Integer.parseInt(cislo);
                }catch(InputMismatchException ex){
                    if(cislo.equals("n") )
                        c[i][j] = n;
                }catch(NumberFormatException ex){
                    if(cislo.equals("n") )
                        c[i][j] = n;
                }
            }
        }
    }

    /**
     * inicializacia matice X
     */
    private void vytvorMaticuX() {
        for(int i = 0; i < pocetVrcholov; i++){
            for(int j = 0; j < pocetVrcholov; j++){
                if(i == j)
                    x[i][j] = i;
                if(c[i][j] != n)
                    x[i][j] = i;
                else
                    x[i][j] = n;
            }
        }
    }

    /**
     * metoda test zistuje pritomnost zapornych cisel v matici C
     */
    private void test() {
        int cislo = 0;
        for(int i = 0; i < pocetVrcholov; i++){
            for(int j = 0; j < 0; j++){
                cislo = c[i][j];
                if(cislo < 0){
                    System.out.println("zadanie obsahuje zaporne cislo. menime aj hlavnu diagonalu");
                    maZaporneCislo = true;
                    break;
                }
            }
        }
    }
    
}
