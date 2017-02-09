package monteCarloPackage;

import java.util.Random;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author sisila
 */
public class Main {
    private static double aX;
    private static double aY;
    
    //obdlznik
    private static double aX1 = 0.4;
    private static double aX2 = 0.7;
    private static double aY1 = 0.2;
    private static double aY2 = 0.8;
    
    private static int pocetTrafeni = 0;
    private static int pocetVsetkychPokusov = 10000;
    
    private static Random aRng;
    
    private static Random aRng1;
    private static Random aRng2;
    private static Random aRng3;
    
    public static void main(String[] args) {
        
        //odhadni plochu obdlznika pomocou pravdepodobnosti
        odhadniVelkostObdlznika(pocetVsetkychPokusov);
        System.out.println("Trafil som sa " + pocetTrafeni + " z 10000\n" + 
                "Pravdepodobnost trafenia (resp. priblizny odhad plochy " + 
                "obdlznika) je " + ((double)pocetTrafeni/pocetVsetkychPokusov) +
                "\n");
        
        
        //vypocitaj priemerny zisk (hospoarsky vysledok)
        aRng1 = new Random();
        aRng2 = new Random();
        aRng3 = new Random();
        
        double predajnaCena = 0.89;
        double nakupnaCena; //nahodna v urcitom intervale
        double vykupnaCena; //polovica z nakupnej ceny
        
        double dopytovaneMnozstvo;
        int objednaneMnozstvo = 100;
        
        double hospodarskyVysledok = 0;
        double sucetHospodarskychVysledkov = 0;
        
        for(int i = 0; i < 10000; i++){
            nakupnaCena = (0.7-0.4) * aRng1.nextDouble() + 0.4;
            vykupnaCena = (double)nakupnaCena / 2;
            //POZOR - NEPRETYPOVAVAT! - MEDZIVYPOCTY POCITAT CO NAJPRESNEJSIE BEZ ZAOKRUHLOVANIA!
            //dopytovaneMnozstvo = (int)(aRng2.nextDouble() + aRng3.nextDouble())*((110-70)/2)+70;
            dopytovaneMnozstvo = (aRng2.nextDouble() + aRng3.nextDouble())*((110-70)/2)+70; //pocet zakaznikov moze byt aj desatinny
            
            if(dopytovaneMnozstvo > objednaneMnozstvo) dopytovaneMnozstvo = objednaneMnozstvo;
            
            hospodarskyVysledok = 
                    predajnaCena * dopytovaneMnozstvo +
                    (objednaneMnozstvo - dopytovaneMnozstvo) * vykupnaCena - 
                    nakupnaCena * objednaneMnozstvo;
            
            sucetHospodarskychVysledkov += hospodarskyVysledok;
        }
        System.out.println("Priemerne zarobime " + (sucetHospodarskychVysledkov / 10000));
    }
    
    private static void odhadniVelkostObdlznika(int paPocetVsetkychPokusov){
        pocetVsetkychPokusov = paPocetVsetkychPokusov;
        
        aRng = new Random();
        for(int i = 0; i<pocetVsetkychPokusov; i++){
            aX = aRng.nextDouble();
            aY = aRng.nextDouble();
            
            if(aX >= aX1 && aX <= aX2 && aY >= aY1 && aY <= aY2){
                pocetTrafeni++;
            }
        }
    }
}
