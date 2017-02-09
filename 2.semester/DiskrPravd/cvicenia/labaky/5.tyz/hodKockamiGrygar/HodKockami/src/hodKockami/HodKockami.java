
package hodKockami;

import java.util.Scanner;

/**
 * Hádžeme naraz 2 kocky. Ak na oboch padne (6,6) končíme, ak na jednej 6, 
 * tak druhou hádžeme, kým aj na tej druhej padne 6. Spočítame koľko sme 
 * urobili hodov (alebo dvojhodov), kým boli na oboch kockách šestky. 
 * Počet hodov bude dĺžka pokusu. Program takychto pokusov urobi N
 * a spocita priemernu dlzku pokusu.
 * 
 * @author Dobroslav Grygar
 */
public class HodKockami {
    
    private final int aPocetPokusov;
    private String aKocka1String;
    private String aKocka2String;
    private int aKocka1;
    private int aKocka2;
    private int aPokusy;
    private long aSucetPokusov;
    private Scanner aCitac;
    
    public HodKockami(){
        
        aPocetPokusov = this.nacitajKonzolu();
        aSucetPokusov = 0;
        
        for(int i = 1; i <= aPocetPokusov; i++){
            aKocka1String = "Postupnost hodov prvou kockou : ";
            aKocka2String = "Postupnost hodov druhou kockou: ";
            aKocka1 = 0;
            aKocka2 = 0;
            aPokusy = -1;
            System.out.println("Pokus cislo " + i + ".");
            this.urobTest();
        }
        this.dokonci();
    }
    
    private int nacitajKonzolu(){
        
        aCitac = new Scanner(System.in);
        System.out.println("Zadajte pozadovany pocet testov:");
        System.out.print("> ");
        
        int vstup = aCitac.nextInt();
        
        System.out.println("");
        
        return vstup;
    }
    
    private void urobTest(){
        
        aPokusy++;
        
        if(aKocka1 != 6 && aKocka2 != 6){
            
            aKocka1 = this.urobRandom();
            aKocka2 = this.urobRandom();
            
            aKocka1String += " " + aKocka1;
            aKocka2String += " " + aKocka2;
            
            this.urobTest();
            
        } else if(aKocka1 != 6){
            
            aKocka1 = this.urobRandom();
            
            aKocka1String += " " + aKocka1;
            
            this.urobTest();
            
        } else if(aKocka2 != 6){
            
            aKocka2 = this.urobRandom();
            
            aKocka2String += " " + aKocka2;
            
            this.urobTest();
            
        } else{
            
            aSucetPokusov += aPokusy;
            this.vypis();
        }
    }
    
    private void vypis(){
        System.out.println(aKocka1String);
        System.out.println(aKocka2String);
        System.out.println("Pocet pokusov: " + aPokusy);
        System.out.println("");
    }
    
    private void dokonci(){
        
        double priemer = (((double)aSucetPokusov) / ((double)aPocetPokusov));
        
        System.out.println("Pocet vykonanych pokusov: " + aPocetPokusov);
        System.out.println("Priemerna dlzka pokusu  : " + priemer);
    }
    
    private int urobRandom(){
        int nahodneCislo = 1 + (int)(Math.random()*6);
        return nahodneCislo;
    }
}