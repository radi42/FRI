package montecarlo2;

import java.util.Random;

public class SpecialitaMonteCarlo {

    /**
     * Použitie metódy Monte Carlo pre výpočet odhadu hospodárskeho výsledku
     * pri predaji regionálnej špeciality.
     * 
     * cenaNakup ~ rovnomerné spojité rozdelenie <0.4, 0.7)
     * dopyt ~ trojuholníkové spojité rozdelenie s parametrami min =70, modus = 90, max = 110)
     */
    
    public static void main(String[] args) {
      final int objednane = 80;          //objednané množstvo
      final double cenaPredaj = 0.89;    //predajná cena
      final int pocetPokusov = 10000000;
      
      double cenaVykup;                  //cena za spätné odkúpenie nepredaných kusov 
      double cenaNakup;                  //cena za ktorú nakupujeme výrobky
      double dopyt;                      //koľko sú zákazníci ochotní kúpiť
      double predane;                    //koľko výrobkov predáme 
      double vysledok;                   //hospodársky výsledok jedného dňa
      double vysledokCelkovy = 0;        //suma výsledkov
      double vysledokCelkovyMocnina = 0; //suma druhých mocnín výsledkov

      
      Random genNasad = new Random();
      Random genCenaNakup = new Random(genNasad.nextInt());
      Random genDopyt1 = new Random(genNasad.nextInt());
      Random genDopyt2 = new Random(genNasad.nextInt());
      
      // experimenty
      for (int i = 0; i < pocetPokusov; i++)
      {
        cenaNakup = 0.4 + genCenaNakup.nextDouble() * 0.3;
        cenaVykup = cenaNakup / 2;
        
        dopyt = 70 + 20 * (genDopyt1.nextDouble() + genDopyt2.nextDouble());
        predane = Math.min(dopyt, objednane);
        
        vysledok = predane * cenaPredaj + (objednane - predane) * cenaVykup -
                   objednane * cenaNakup;
        
        vysledokCelkovy += vysledok;
        vysledokCelkovyMocnina += Math.pow(vysledok, 2);
      }
      
      System.out.println("*****************************************************");       
      System.out.println("-----------------------------------------------------");      
      
      double priemerVysledku = vysledokCelkovy / pocetPokusov;
      System.out.println("Odhad priemerného hospodárskeho výsledku: " + priemerVysledku);
      
    
      double odhadSmerOdchylky = Math.sqrt((((double)1 / (pocetPokusov - 1))*vysledokCelkovyMocnina) 
                                           - Math.pow(((double)1 / (pocetPokusov - 1))*vysledokCelkovy, 2));
      System.out.println("Odhad smerodajnej odchýlky: " + odhadSmerOdchylky);      

      
      // polovičná šírka 95% obojstranného intervalu spoľahlivosti
      double polSirkaIS = (1.96 * odhadSmerOdchylky) / Math.sqrt(pocetPokusov);
      System.out.println("Polovičná šírka 95% intervalu spoľahlivosti: " + polSirkaIS);
      
      // dolná hranica intervalu spoľahlivosti
      System.out.println("Dolná hranica 95% intervalu spoľahlivosti: " + (priemerVysledku - polSirkaIS));
      
      // horná hranica intervalu spoľahlivosti
      System.out.println("Horná hranica 95% intervalu spoľahlivosti: " + (priemerVysledku + polSirkaIS));
    
      System.out.println("-----------------------------------------------------");   
      System.out.println("*****************************************************");        
    }
}