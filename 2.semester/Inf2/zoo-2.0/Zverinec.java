 

import java.util.ArrayList;
import java.io.*;
/**
 * <h2>Trieda Zverinec</h2>
 * 
 * @author bene
 * @version 22.3.2012
 */
public class Zverinec implements Serializable
{
    //======================================================= Atributy instancie ==
    //-- Zoznam pre ukladanie potomkov typu Zivocich
    private ArrayList<Zivocich> zvierata;
    //-- max. pocet objektov v zozname
    private int kapacita;

    //============================================================= Konstruktory ==
    /**
     * Konstruktor instancie Zverinec - spociatku bude prazdny
     * @param kapacita zoznamu zvierat
     */
    public Zverinec(int kapacita) {
        this.kapacita = kapacita;
        zvierata = new ArrayList<Zivocich>();
    }

    //======================================================== Metody instancie ==
    /**
     * Getter vrati kapacitu zverinca
     */
    public int getKapacita() { return kapacita; }

    /**
     * Vrati pocet zivocichov v zverinci
     * @return  pocet zvierat v zverinci
     */
    public int getPocetZivocichov() { return zvierata.size(); }

    /**
     * Pridanie zivocicha na koniec kontajneru
     * @param z     vkladany zivocich
     * @return  true - bol zivocich vlozeny<br>false - inac
     */
    public boolean add(Zivocich z) {  
        if (kapacita > zvierata.size()) {
            zvierata.add(z);
            return true;        // akcia bola uspesna
        } else
            return false;       // nepodarilo sa vlozit - kontajner bol plny
    }

    /**
     * Spristupi zivocicha na i-tej pozicii.
     * @param i  index daneho zivocicha
     * @return  spristupneny zivocich
     */
    public Zivocich getZivocich(int i){
        if (i >= 0 && i < zvierata.size()) {  // index musi byt v platnom rozsahu  
            return zvierata.get(i);
        }
        else return null;   // index je mimo platny rozsah
    }
    
    /**
     * Odstrani zivocicha na danom indexe zo zverinca
     * @param i  index daneho zivocicha
     * @return  odstraneny zivocich, alebo<br>null - ak neexistuje
     */
    public Zivocich odstranZivocicha(int i) {
        if (i >= 0 && i < zvierata.size()){
            return zvierata.remove(i);
        }
        else return null;
    }

    /**
     * Textova informacia o zverinci
     * @return text informacie
     */
    @Override
    public String toString(){
        String s = "**** Zverinec: " + "Kapacita = " + getKapacita() + " ****\n";
        int poc = getPocetZivocichov();
        String s2 = " Ma " + poc;
        switch (poc) {
            case 1: s2 += " zviera:"; break;
            case 2: case 3: case 4: s2 += " zvierata:"; break;
            default: s2 += " zvierat:";
        }
        s += ( poc == 0 ? " ziadne zviera." : s2) + "\n";
        for (int i = 0; i < poc; i++){
            s += String.format("%5d- %s\n", i + 1,  zvierata.get(i));
        }
        return s;
    }    
}
