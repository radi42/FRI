package tarrysalgorithm;

import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.io.FileReader;
import java.util.Scanner;

/**
 * Trieda Algoritmus
 * V tejto triede je implementovany Tarryho algoritmus.
 * urcuje pocet vrcholov v lubovolnom grafe G = (V, H) pricom prejde vsetky
 * hrany komponentov
 * zaciname aj koncime v tom istom bode
 * @author Dobroslav Grygar - Refactored by Andrej Sisila :P
 */
public class Algoritmus {
    private boolean[][] maticaSusednosti;
    private ArrayList<Vrchol> vrcholy;
    private int pocetVrcholov;
    private ArrayList<Hrana> hrany;
    private int aktualnyVrchol;
    
    public Algoritmus() throws FileNotFoundException{
        vrcholy = new ArrayList<Vrchol>();
        hrany = new ArrayList<Hrana>();
        aktualnyVrchol = 0;
        
        /**
         * Zadanie 1.
         * Graf o styroch vrcholoch
         * TRUE znamena, ze dva vrcholy su spojene
         * FALSE znamena, ze dva vrcholy su izolovane
         * toto zadanie je mozne najst aj v subore zadanie1.txt
         */
//        maticaPrilahlosti = new boolean[][]{  
//                {true, false, true, true},
//                {false, true, true, true},
//                {true, true, true, true},
//                {true, true, true, true}
//            };
        
        nacitajMaticuPrilahlosti();
        nacitajHodnoty();
        vyhodnot();
        }
    
    public void nacitajMaticuPrilahlosti() throws FileNotFoundException{
        FileReader fr = new FileReader("maticaPrilahlosti.txt");
        Scanner scan = new Scanner(fr);
        pocetVrcholov = scan.nextInt();
        maticaSusednosti = new boolean[pocetVrcholov][pocetVrcholov];
        
        int cislo;
        for(int riadok = 0; riadok < pocetVrcholov; riadok++){
            
            
            //ak je v subore cislo 1, hodnota na prislusnom mieste v matici bude true,
            //ak 0, false
            
                for(int stlpec = 0; stlpec < pocetVrcholov; stlpec++){
                    cislo = scan.nextInt();
                    if (cislo == 1){
                        maticaSusednosti[riadok][stlpec] = true;
                    }
                    if (cislo == 0){
                        maticaSusednosti[riadok][stlpec] = false;
                }
            }
        }
    }
    
    /**
     * obsahuje cykly na naplnenie poli vrcholov a hran
     */
    private void nacitajHodnoty(){
        for(int a = 0; a < pocetVrcholov; a++){
            vrcholy.add(new Vrchol()); //do pola vrcholov pridaj vrcholy 1, 2, 3, ..., pocetVrcholov -1
            
            for(int b = 0; b < pocetVrcholov; b++){
                if(a == b) continue; //jeden vrchol nemoze tvorit hranu
                if(maticaSusednosti[a][b] == true){ //ak je v matici true
                    aktualnyVrchol = a;
                    hrany.add(new Hrana(a, b));
                }
                else continue;
            }
        }
    }
    
    /**
     * metoda vyhodnot()
     * rozhoduje, po ktorej hrane pojdeme
     * uprednostnujeme tie, ktore NIE SU hranami prveho pristupu
     * iba ak prejde VSETKYMI vrcholmi, zavola sa metoda na dokoncenie
     */
    public void vyhodnot(){
        //mozeme pouzit hranu aj ked je prveho pristupu?
        boolean trebaPouzitPrvyPristup = true;
        
        //oznac kazdu hranu, ze nemoze pouzit prvy pristup
        for(Hrana hr : hrany){
            if(hr.getZaciatokVrchol() == aktualnyVrchol){
                if(hr.isJePrvehoPristupu() == false){ //ak hrana nie je hranou prveho pristupu
                    if(hr.isBolaPouzita() == false){ //ak hrana este nebola pouzita v opacnom smere
                        trebaPouzitPrvyPristup = false; //netreba pouzit hranu prveho pristupu, pretoze sa nou este len prvy krat prejde :P
                        break;
                    }
                }
            }
        }
        
        
        for(Hrana hr2 : hrany){
            //Podmienka: Kazdu hranu prejdi prave raz v kazdom smere
            if(hr2.getZaciatokVrchol() == aktualnyVrchol){
                if(hr2.isJePrvehoPristupu() == false){ //ak hrana nie je hranou prveho pristupu
                    if(hr2.isBolaPouzita() == false){ //ak hrana este nebola pouzita v opacnom smere
                        if(trebaPouzitPrvyPristup == false){ //a nemusis pouzit prvy pristup
                            vypis(hr2); //vypis, na ktorom vrchole sa nachadzame a ktoru hranu prechadzame
                            prejdiHranu(hr2); //prejdi po hrane z vrchola do vrchola
                            
                        }
                    }
                }
            }
            //Podmienka: Hranu prveho pristupu mozes pouzit iba vtedy, ak niet inej moznosti
            else if(hr2.getZaciatokVrchol() == aktualnyVrchol){
                if(hr2.isJePrvehoPristupu() == true){ //ak hrana nie je hranou prveho pristupu
                    if(hr2.isBolaPouzita() == false){ //ale nebola pouzita v opacnom smere
                        if(trebaPouzitPrvyPristup == true){ //mozes ju pouzit v opacnom smere
                            vypis(hr2);
                            prejdiHranu(hr2);
                        }
                    }           
                }
            }
        }
        overit();
    }

    /**
     * prechadza aktualnu hranu, zistuje ci bol vrchol objaveny, obmedzuje pohyb
     * po hranach prveho pristupu
     * @param hr hrana, ktorej vlastnosti kontrolujeme a odovzdavame ju metode vyhodnot
     * 
     * BUG: nespravne vyhodnocuje, ci bola hrana prejdena a ci bola prveho pristupu (vsetky hrany su FALSE)
     */
    private void prejdiHranu(Hrana hr) {
        aktualnyVrchol = hr.getKoniecVrchol();      //a nastav aktualny vrchol na koncovy vrchol hrany
        //hr.setBolaPouzita(true);                    //nastav jej pouzitie na "true"
        hr.setJePrvehoPristupu(true);               //nastav ze je prveho pristupu
        
        if(vrcholy.get(aktualnyVrchol).somObjaveny() == false){
            vrcholy.get(aktualnyVrchol).setObjaveny(true);
            
            
            for(Hrana hrana2 : hrany){
                if(hrana2.getZaciatokVrchol() == hr.getKoniecVrchol() ){
                    if(hrana2.getKoniecVrchol() == hr.getZaciatokVrchol() ){
                        //hrana2.setJePrvehoPristupu(true);
                        hrana2.setBolaPouzita(true);
                        break;
                    }
                }
            }
        }
        vyhodnot();
    }

    /**
     * metoda overit kontroluje, ci boli vsetky vrcholy objavene
     * vypisuje vysledok procesu
     */
    private void overit() {
        for(Vrchol vrchol1 : vrcholy){
            if(vrchol1.somObjaveny() == false){
                System.out.println("\nGraf obsahuje nepreskumane vrcholy! "
                        + "Pravdepodobne sa preskumal iba komponent grafu");
                System.out.println("Aspon jeden vrchol nema v takomto grafe cestu");
                System.exit(0);
            }
        }
        System.out.println("\nUspech! Vsetky hrany boli prejdene a vsetky vrcholy"
                + " boli objavene. Existuje sled medzi vsetkymi vrcholmi grafu.");
        System.exit(0);
    }
    
    /**
    * vypise, ako algoritmus prechadzal hranami
    */
    public void vypis(Hrana hr){
        System.out.println("Aktualny vrchol: " + aktualnyVrchol);
        System.out.println("Prechod hranou " + hr.toString() );
        System.out.println("");
    }
}
