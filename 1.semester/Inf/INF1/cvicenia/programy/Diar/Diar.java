import java.util.ArrayList;

/**
 * Write a description of class Diar here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Diar
{
    //hned na zaciatku si nainicializujeme a vytvorime pole zaznamov
    private ArrayList <Zaznam> databaza = new ArrayList <Zaznam>();
    //a nejako si ho pomenujeme
    private String nazov;
    
    /**
     * vytvorime si instanciu diara
     */
    public Diar(String nazov){
        this.nazov = nazov;
    }
    
    /**
     * Zakladne metody pola
     */
    /**
     * pridaj zaznam
     * @param pricom v parametri sa odovzdava objekt, ktory sa ma pridat
     */
    public void add(Zaznam z){
        databaza.add(z);
    }
    
    /**
     * zisti zaznam na urcitej pozicii
     * @param poziciu odovzdava int parameter i 
     */
    public Zaznam get(int i){
        return databaza.get(i);
    }
    
    /**
     * zisti pocet zaznamov v databaze
     */
    public int kolkoZaznamov(){
        return databaza.size();
    }
    
    /**
     * zisti nazov diara
     */
    public String akoSaVolaDiar(){
        return nazov;
    }
    
    /**
     * zmen nazov diara
     */
    public void zmenNazovDiara(String nazov){
        this.nazov = nazov;
    }
    
    /**
     * no a zase to nechame vsetko vypisat cez toString
     */
    public String toString(){
        String s = "\n";
        for(int i = 0; i < kolkoZaznamov(); i++){
            s += get(i) + "\n";
        }
        return s;
    }
}
