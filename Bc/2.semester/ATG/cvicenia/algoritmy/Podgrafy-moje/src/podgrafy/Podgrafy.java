package podgrafy;

import java.util.Scanner;
import java.util.ArrayList;
/**
 * Trieda Podgrafy
 * zistuje pocet podgrafov z mnoziny vrcholov s prislusnym stupnom
 * @author Andy
 */
public class Podgrafy {

    //static ArrayList <Integer> vrcholCislo = new ArrayList <Integer>();
    
    public static void main(String[] args) {
//        System.out.print("Zadajte stupne vrcholov: ");
//        Scanner scan = new Scanner(System.in);
//        String vrcholy = scan.nextLine();
        String vrcholy = "222111";
        
        StringBuilder zmenVrchol = new StringBuilder(vrcholy);
        int skrtnute;
        //usporiadaj pole integerov od najvacsieho po najmensi
        char cislo;
        for(int i = 0; i > vrcholy.length(); i++ ){
            for(int j = 0; j < vrcholy.length(); j++ ){
                if(Character.getNumericValue(vrcholy.charAt(i) ) 
                        < Character.getNumericValue(vrcholy.charAt(i) ) ){
                    //cislo = Character.getNumericValue(vrcholy.charAt(i) );
                    cislo = vrcholy.charAt(i);
                    zmenVrchol.setCharAt(i, zmenVrchol.charAt(j) );
                    zmenVrchol.setCharAt(j, cislo );
                }
                
            }
        }
        
        //skrtni cislo na prvom mieste zlava (prekvapivo ma index 0)
        skrtnute = 0;              
            
        //nastav skrtnuty prvok na nulu
        zmenVrchol.setCharAt(skrtnute, '0');
        System.out.println(vrcholy.charAt(0) );
        System.out.println(zmenVrchol.toString() );
        
        /*cislo, ktore bolo skrtnute udava pocet dalsich cifier, 
          od ktorych treba odpocitat jednotku
          bolo by fajn hodit to do cyklu*/
       
//        char c = vrcholy.charAt(skrtnute);
//        int i;
//        
//        skrtnute++;
//        i = skrtnute;
//        c = vrcholy.charAt(i);
//        zmenVrchol.setCharAt(i, (char) (c-1));
//        
//        i++;
//        c = vrcholy.charAt(i);
//        zmenVrchol.setCharAt(i, (char) (c-1));
//        
//        //priebezne vypisujeme, co sa udialo :o
//        System.out.println(zmenVrchol.toString() );
        
        //odcitavanie cisla, len v cykle
        char c = vrcholy.charAt(skrtnute);
        int poZnak = Character.getNumericValue(c);
        int od = skrtnute +1;
        for(int i = od; i <= poZnak; i++){
            c = vrcholy.charAt(i);
            zmenVrchol.setCharAt(i, (char) (c-1));
        }
        System.out.println(zmenVrchol.toString() );
        
        //vypocitaj faktorial velkosti pola
        
        System.out.println(faktorial(vrcholy.length() ) );
    }
    
    public static int faktorial(int n) {
        int opakovania = n;
        for(int cislo = 2; cislo < opakovania; cislo++){
            n = n * cislo;
        }
        
        return n;
    }
}
