package hoddvomikockami;

import java.util.ArrayList;
import java.util.Collections;

/**
 * Trieda Kocky
 * 
 * program simuluje hadzanie dvomi kockami
 * na obidvoch kockach musi padnut sestka
 * ulohou programu je vyhodnotit, na kolky pokus sa nam podari hodit sestku
 * @author Andrej Sisila
 */
class Kocky {
    
    private int pocetHodov = 0;
    private int pocetPokusov = 1000;
    private int cisloPokusu = 0;
    private int dice_1;
    private int dice_2;
    private final ArrayList<Integer> pokusy;
    
    /**
     * Konstruktor
     * @param pocetPokusov udava maximalny pocet pokusov
     */
    public Kocky(int pocetPokusov){
        pokusy = new ArrayList<>();
        this.pocetPokusov = pocetPokusov;
        
        //opakuj metodu tolko krat, kolko je zadane
        while(cisloPokusu < pocetPokusov){
            dice_1 = 0;
            dice_2 = 0;
            vyhodnot();
            cisloPokusu++;
            
        }
        
        vypisPokusy();
        priemernaDlzkaPokusu();
    }

    /**
     * @return vygenerovane nahodne cislo v rozsahu od 1 do 6
     */
    private int generujNahodu() {
        int cislo = 1 + (int)(Math.random() * (6) );
        return cislo;
    }

    /**
     * logicka metoda vyhodnot
     * zistuje, na kolky pokus sa nam podarilo hodit cislo 6 na oboch kockach
     * prida pocet hodov do pola pokusov
     */
    private void vyhodnot() {

            if(dice_1 == 6 && dice_2 == 6){
                pocetHodov++;
                pokusy.add(pocetHodov);
                pocetHodov = -1; //vynuluj pocitadlo pokusov a ukonci metodu
            }
            if(dice_1 != 6 && dice_2 == 6){
                dice_1 = generujNahodu();
                pocetHodov++;
                vyhodnot();
            }
            if(dice_1 == 6 && dice_2 != 6){
                dice_2 = generujNahodu();
                pocetHodov++;
                vyhodnot();
            }
            if(dice_1 != 6 && dice_2 != 6){
                dice_1 = generujNahodu();
                dice_2 = generujNahodu();
                pocetHodov++;
                vyhodnot();
            }
    }

    /**
     * vypisuje na kolky pokus sa nam podarilo hodit cislo 6 na oboch kockach
     * ignoruje
     */
    private void vypisPokusy() {
        int vyskyt;
        for(int i = 0; i < pokusy.size(); i++){
            vyskyt = Collections.frequency(pokusy, i);
            if(vyskyt != 0){
            System.out.println("Sestku sme na " + i + ". pokus hodili " 
                                + vyskyt + " krat");
            }
        }
    }
    
    private void priemernaDlzkaPokusu() {
        double priemer = 0;
        for(int i = 0; i < pokusy.size(); i++){
            priemer += pokusy.get(i);  
        }
        priemer = (double)priemer / (double)pocetPokusov;
        System.out.println("\n\nPriemerna dlzka pokusu je: " + priemer + " hodov");
    }
}
