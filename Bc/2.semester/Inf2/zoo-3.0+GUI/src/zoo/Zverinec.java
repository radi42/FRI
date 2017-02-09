package zoo;

import java.io.Serializable;
import java.util.ArrayList;
/**
 * <h2>Trieda Zverinec</h2>
 * 
 * @author bene
 * @version 22.3.2012
 */
public class Zverinec implements Serializable
{
    //================================================== Atribúty inštancie ==
    //-- Zoznam pre ukladanie potomkov typu Zivocich
    private ArrayList<Zivocich> zvierata;
    //-- max. pocet objektov v zozname
    private int kapacita;

    //======================================================== Konštruktory ==
    /**
     * Konstruktor instancie Zverinec - spociatku bude prazdny
     * @param kapacita zoznamu zvierat
     */
    public Zverinec(int kapacita) {
        this.kapacita = kapacita;
        zvierata = new ArrayList<>();
    }

    //==================================================== Metódy inštancie ==
    //------------------------------------ Gettery-Settery --
    public ArrayList<Zivocich> getZvierata() { return zvierata; }
    public int                 getKapacita() { return kapacita; }
    public void setKapacita(int kapacita)       { this.kapacita = kapacita; }
    public void setZvierata(ArrayList<Zivocich> zvierata)
                                                { this.zvierata = zvierata; }

    //------------------------------------- Ostatné metódy --
    /**
     * Pridá zviera do zverinca.
     * POred pridaním skontroluje, či nie je plný zverinec
     * @param zviera    pridávané zviera
     * @return 
     */
    public boolean pridajZviera(Zivocich zviera) {
        if (zvierata.size()<kapacita) {
            return zvierata.add(zviera);
        } else {
            return false;
        }
    }

    /**
     * Textova informacia o zverinci
     * @return text informacie
     */
    @Override
    public String toString(){
        String s = "**** Zverinec: " + "Kapacita = " + getKapacita() + " ****\n";
        int poc = zvierata.size();
        String s2 = " Má " + poc;
        switch (poc) {
            case 1: s2 += " zviera:"; break;
            case 2: case 3: case 4: s2 += " zvieratá:"; break;
            default: s2 += " zvierat:";
        }
        s += ( poc == 0 ? " Žiadne zviera." : s2) + "\n";
        for (int i = 0; i < poc; i++){
            s += String.format("%5d- %s\n", i,  zvierata.get(i));
        }
        return s;
    }
    
    /**
     * zapis data do suboru
     */
    public String zapisZveryTxt(){
        String zvery = "";
        for(Zivocich ziv : zvierata){
            zvery += String.format("%s $s", ziv.nazovDruhu + " ");
            zvery += String.format("%s $s", ziv.umiestnenie + " ");
            zvery += String.format("%s $s", ziv.datNar + " ");
            
            if(ziv instanceof Blcha){
                ziv = (Blcha) ziv;
                zvery += (Blcha)ziv;
            }
            
            if(ziv instanceof Papagaj){
                
            }
            
            if(ziv instanceof Simpanz){
                
            }
            
            if(ziv instanceof Slon){
                
            }
        }
        
        return zvery;
    }
}
