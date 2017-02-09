package montecarlo;

import java.util.Random;

public class MonteCarlo {

    /**
     * Výpočet obsahu (plochy) obdĺžnika v štvorci 1x1 s použitím
     * metódy Monte Carlo.
     */
    
    public static void main(String[] args) {  
       Random genNasad = new Random();
       Random genX = new Random(genNasad.nextInt());  
       Random genY = new Random(genNasad.nextInt());
       
       final int pocetPokusov = 10000000;
       int uspech = 0;     
       
       final double minX = 0.3;
       final double maxX = 0.6;
       final double minY = 0.1;
       final double maxY = 0.7;
       double x;
       double y;
       
       for (int i = 0; i < pocetPokusov; i++)
       {
         x = genX.nextDouble();
         y = genY.nextDouble();
         
         if ((x >= minX) && (x <= maxX) && (y >= minY) && (y <= maxY))
             uspech++;
       }
       System.out.println("*************************************************");       
       System.out.println("-------------------------------------------------");
       // pozor na celočíselné delenie - použiť pretypovanie na double alebo float
       System.out.println("Odhad obsahu obdĺžnika: " + (double)(uspech) / pocetPokusov);
       System.out.println("-------------------------------------------------");   
       System.out.println("*************************************************");       
    }
}