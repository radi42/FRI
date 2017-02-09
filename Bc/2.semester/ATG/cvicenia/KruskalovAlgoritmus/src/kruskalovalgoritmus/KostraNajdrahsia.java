/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package kruskalovalgoritmus;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Scanner;

/**
 * Trieda KostraNajdrahsia
 * 
 * @author Andy
 */
public class KostraNajdrahsia {
    private ArrayList<Vrchol> vrcholy;
    private ArrayList<Hrana> hrany;
    private ArrayList<Hrana> postupnost;

    /**
     * Konstruktor pre Najdrahsiu kostru
     * @throws FileNotFoundException 
     */
    public KostraNajdrahsia() throws FileNotFoundException {
        vrcholy = new ArrayList<Vrchol>(Arrays.asList(new Vrchol(1), new Vrchol(2), new Vrchol(3), new Vrchol(4), new Vrchol(5), new Vrchol(6), new Vrchol(7) ) );
        hrany = new ArrayList<Hrana>();
        postupnost = new ArrayList<Hrana>();
        
        komponentVrchola();
        naplnHrany();
        usporiadajHranyPodlaCenyOdNajvacsej();
        testVypis();
        najdiKostru();
        vypisKostruLacna();
    }
    
    /**
     * Krok 1
     * napln hrany zo zadania (txt subor)
     * @throws FileNotFoundException ak by subor neexistoval
     */
    public void naplnHrany() throws FileNotFoundException{
        File f = new File("graf.txt");
        Scanner scan = new Scanner(f);
        
        int zacV = 0; //zaciatocny vrchol
        int koncV = 0; //koncovy vrchol
        int cena = 0; //cena hrany
        
        while(scan.hasNext() ){
            zacV = scan.nextInt();
            Vrchol vrcholZ = vrcholy.get(zacV-1);
            
            koncV = scan.nextInt();
            Vrchol vrcholK = vrcholy.get(koncV-1);
            
            cena = scan.nextInt();
            hrany.add(new Hrana(vrcholZ, vrcholK, cena) );
        }
        scan.close();
    }
    
    /**
     * Krok 1 - pokracovanie
     * usporiadaj hrany od najvacsej po namensiu
     */
    private void usporiadajHranyPodlaCenyOdNajvacsej() {
        Collections.sort(hrany, new PorovnavacHranOdNajvacsej() );
    }
    
    /**
     * Krok 2
     * inicializuj komponenty vrcholu na cislo vrcholu
     */
    public void komponentVrchola(){
        for(Vrchol v : vrcholy){
            v.setCisloKomponentu(v.getCisloVrchola() );
        }
    }
    
    /**
     * Krok 3
     * metoda najdi kostru
     * 
     * hlada kostru v grafe podla konstruktora
     */
    public void najdiKostru(){
        int kj = 0;
        int ku = 0;
        int kv = 0;
        
        for(int i = 0; i <= hrany.size() -1; i++){
            //ak sa cisla komponentov rovnaju, vyhod hranu z grafu
            ku = hrany.get(i).getZaciatocnyVrchol().getCisloKomponentu();
            kv = hrany.get(i).getKoncovyVrchol().getCisloKomponentu();
            
            if(ku == kv ){
                hrany.remove(i);
                continue;
            }
            
            if(ku != kv ){
                postupnost.add(hrany.get(i) ); //zarad hranu do kostry
                for(int j = 0; j < vrcholy.size(); j++){ //pre vsetky vrcholy
                    kj = vrcholy.get(j).getCisloKomponentu();
                    if(kj == kv){   //take, ze komponent vrchola sa rovna komponentu koncoveho vrchola hrany
                        vrcholy.get(j).setCisloKomponentu(ku); //nastav komponent vrchola na komponent zaciatocneho vrchola
                    }
                }
            }
        }
    }
    
    /**
     * vypis zadanie
     */
    private void testVypis() {
        System.out.println("Zadanie\n"
                + "ZV - Zaciatocny Vrchol, K - Komponent\n"
                + "KV - Koncovy Vrchol, CH - Cena Hrany\n");
        System.out.println("ZV  K   KV  K   CH");
        for(Hrana h : hrany){
            System.out.println(h.getZaciatocnyVrchol().vypisVrcholAKomponent() +
                    "   " + h.getKoncovyVrchol().vypisVrcholAKomponent() +
                    "   " + h.getCenaHrany() );
        }
    }
    
    /**
     * Krok 3 - vypis
     */
    private void vypisKostruLacna() {
        int cenaKostry = 0;
        System.out.println("=====================================");
        System.out.println("Hrany najdrahsej kostry grafu: ");
        System.out.println("Pocet hran kostry: " + postupnost.size() );
        for(Hrana kostrickovska : postupnost){
            System.out.println(kostrickovska.vypisHrana() );
            cenaKostry += kostrickovska.getCenaHrany();
        }
        System.out.println("Celkova cena najdrahsej kostry je " + cenaKostry);
    }
}