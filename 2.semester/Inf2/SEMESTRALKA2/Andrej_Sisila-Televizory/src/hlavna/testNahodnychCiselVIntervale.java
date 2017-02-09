/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package hlavna;

import java.util.Random;

/**
 *
 * @author Andy
 */
public class testNahodnychCiselVIntervale {
    
    private static int aNahodneCislo;
    private static Random rng = new Random();
    
    public static void main(String[] args) {
        System.out.println("Generujem nahodne cisla triedou 'Random'");
        int i = 0;
        while(i < 10){
            System.out.println(generujNahodneCislaVIntervaleCezTrieduRandom() );
            i++;
        }
        System.out.println("=================================================");
        System.out.println("Generujem nahodne cisla triedou 'Math'");
        while(i < 20){
            System.out.println(generujNahodneCislaVIntervaleCezTrieduMath() );
            i++;
        }
    }
    
    private static int generujNahodneCislaVIntervaleCezTrieduRandom(){
        aNahodneCislo = rng.nextInt(4);
        return aNahodneCislo;
    }
    
    private static int generujNahodneCislaVIntervaleCezTrieduMath(){
        aNahodneCislo = (int) (4 * Math.random() );
        return aNahodneCislo;
    }
}
