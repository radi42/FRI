package maticazosuboru;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.Scanner;

/**
 * Trieda MaticoveOperacie
 * Cita a vykonava jednoduche matematicke operacie s maticami
 */

class MaticoveOperacie{
    
    int[][] matica;
    int riadky = 0;
    int stlpce = 0;
    
    FileReader fr;
    Scanner scan;
    
    /**
     * Konstruktor Matice
     * @param x pocet riadkov matice
     * @param y pocet stlpcov matice
     */
    public MaticoveOperacie(int x, int y){
        matica = new int[x][y];
    }
    
    /**
     * Konstruktor
     * @param x riadky
     * @param y stlpce
     * @param nazovSub nazov textoveho suboru
     */
    public MaticoveOperacie(int x, int y, String nazovSub) throws FileNotFoundException{
        matica = new int[x][y];
        nazovSub = "matrix.txt";
//        FileReader fr = new FileReader(nazovSub);
//        Scanner scan = new Scanner(fr);
    }
    
    /**
     * Metoda citaj nacita maticu zo suboru do pola
     * @throws FileNotFoundException
     * @param nazov citaneho suboru
     */
    public void citaj(String nazov) throws FileNotFoundException{
        FileReader fr = new FileReader(nazov);
        Scanner scan = new Scanner(fr);
        //alternativne riesenie - Trieda File vykonava tu istu funkciu ako FileReader (Otvara subor)
//        File f = new File("matrix.txt");
//        Scanner scan = new Scanner(f);
        this.riadky = scan.nextInt();
        this.stlpce = scan.nextInt();
        
        for(int i = 0; i < this.riadky; i++){
            for(int j = 0; j < this.stlpce; j++){
                matica[i][j] = scan.nextInt();
            }
        }
        
    }
    
    /**
     * Metoda vypisPrvky vytlaci hodnoty ulozene do matice na terminal
     */
    public void vypisPrvky(){
//        for(int i = 0; i < riadky; i++){
//            for(int j = 0; j < stlpce; j++){
//                System.out.print(Integer.toString(matica[i][j] ) + "   ");
//            }
//            System.out.println();
//        }
        String vypis = "";
        for(int i = 0; i < riadky; i++){
            for(int j = 0; j < stlpce; j++){
               vypis += vypis.format("%-5d",matica[i][j]);
            }
            vypis += vypis.format("%n");
        }
        System.out.print(vypis);
    }
    
    /**
     * Metoda scitajRiadok
     * scitaj prvky v riadku
     */
    public int scitajRiadok(){
        int sucet = 0;
        int[]zozSuctov = new int[riadky];
        zozSuctov[riadky-1] = matica[riadky-1][stlpce-1];
        sucet = zozSuctov[riadky-1];
        int nasobenie = 273*875;
        sucet += nasobenie;
        return sucet;
    }
}