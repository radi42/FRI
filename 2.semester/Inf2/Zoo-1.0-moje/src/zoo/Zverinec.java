package zoo;

import java.util.ArrayList;

/**
 * Trieda Zverinec
 * 
 * @author Andrej Sisila
 * @version v3.18.2014
 */
public class Zverinec {
    
    private ArrayList<Zivocich> zvierata;
    private int kapacita;

    /**
     * Konstruktor
     * @param kapacita kapacita pola(zverinca)
     */
    public Zverinec(int kapacita) {
        this.zvierata = new ArrayList<>();
        this.kapacita = kapacita;
    }

    //getter setter pre zvierata
    public ArrayList<Zivocich> getZvierata() {
        return zvierata;
    }

    public void setZvierata(ArrayList<Zivocich> zvierata) {
        this.zvierata = zvierata;
    }

    //getter setter pre kapacitu
    public int getKapacita() {
        return kapacita;
    }

    public void setKapacita(int kapacita) {
        this.kapacita = kapacita;
    }
    
    /**
     * Pridava zviera
     * @param zv Zviera
     * @return naozaj pridalo?
     */
    public boolean pridajZviera(Zivocich zv){
        if(zvierata.size() < kapacita){
            zvierata.add(zv);
            return true;
        }
        else {return false;}
    }
    
    /**
     * Odstran zviera - zbytocna metoda :)
     * @param poradie
     * @return naozaj odstranilo?
     */
    public void odstranZviera(int poradie){
            zvierata.remove(poradie -1);
    }
    
    
    /**
     * @return vypis vsetky zvery v poli
     */
    public String getZoznam() {
        String zoznam = "";
        zoznam += "Kapacita zverinca je " + kapacita + "\n";
        zoznam += "Pocet vlozenych zvierat " + zvierata.size() + "\n" + "\n";
        
        for(int i = 0; i < zvierata.size(); i++){
            zoznam += "\n" + (i+1) + ": " + zvierata.get(i) + "\n";
        }
        return zoznam;
    }

    @Override
    public String toString() {
        return "Zverinec{" + "zviera=" + zvierata + ", kapacita=" + kapacita + '}';
    }
}