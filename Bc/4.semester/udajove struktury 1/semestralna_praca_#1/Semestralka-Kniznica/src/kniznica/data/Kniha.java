package kniznica.data;

import datastructures.lists.ArrayList.ArrayList;
import datastructures.lists.EList;
import datastructures.priorityFronts.EPriorityFront;
import datastructures.priorityFronts.PriorityFrontLL.PFListLL;
import java.io.Serializable;

/**
 *
 * @author Andrej Šišila
 */
public class Kniha implements Serializable{
    
    private String aAutorMeno;
    private String aAutorPriezvisko;
    private String aNazov;
    private int aRokVydania;
    private ArrayList<String> aZaner;
    private boolean aDostupna;
    private PFListLL<Citatel> aZoznamCakatelov;
    
    public Kniha(String paAutorMeno, String paAutorPriezvisko, String paNazov, int paRokVydania){
        aAutorMeno = paAutorMeno;
        aAutorPriezvisko = paAutorPriezvisko;
        aNazov = paNazov;
        aRokVydania = paRokVydania;
        aZaner = new ArrayList<String>();
        aDostupna = true;
        aZoznamCakatelov = new PFListLL<Citatel>();
    }
    
    public String getAutorMeno(){
        return aAutorMeno;
    }
    
    public String getAutorPriezvisko(){
        return aAutorPriezvisko;
    }
    
    public String getNazov(){
        return aNazov;
    }
    
    public int getRokVydania(){
        return aRokVydania;
    }
    
    public ArrayList<String> getZaner() throws EList{
        return aZaner;
    }
    
    public boolean getDostupna(){
        return aDostupna;
    }
    
    public PFListLL<Citatel> getZoznamCakatelov(){
        return aZoznamCakatelov;
    }
    
    //#########################################################################

    public void setAutorMeno(String paAutorMeno) {
        aAutorMeno = paAutorMeno;
    }
    
    public void setAutorPriezvisko(String paAutorPriezvisko) {
        aAutorMeno = paAutorPriezvisko;
    }

    public void setNazov(String aNazov) {
        this.aNazov = aNazov;
    }

    public void setRokVydania(int aRokVydania) {
        this.aRokVydania = aRokVydania;
    }
    
    public void pridajZaner(String paNazovZanru) throws EList{          
        aZaner.add(paNazovZanru);
    }

    public void setDostupna(boolean paDostupna) {
        aDostupna = paDostupna;
    }
    
    public void pridajCakatela(Citatel paCakatel) throws EPriorityFront{
        aZoznamCakatelov.push(paCakatel, paCakatel.getPrioritaCitatela());
    }
    
    private String vypisZanre() throws EList{
        String zanre = "";
        try{
            if(aZaner.size() == 0){
                return zanre = "nedefinovany";
            }
            else{
                for(int i=0; i < aZaner.size() - 1; i++)
                    zanre += aZaner.get(i) + "▪";
                zanre += aZaner.get(aZaner.size() - 1);     //posledny zaner nech sa vypisuje bez medzery a ciarky
                return zanre;
            }
        } catch(EList ex1){
            throw new EList(ex1.getMessage());
        }
    }
    
    @Override
    public String toString(){
        String kniha = "";
        try {
            kniha += getAutorPriezvisko() + " █ " + getAutorMeno() + " █ " + getNazov() + " █ " + getRokVydania() + " █ ";
            kniha += vypisZanre() + " █ ";
            kniha += getDostupna() ? "dostupna" : "pozicana/vratena";
            return kniha;
        } catch (EList ex) {
            return null;
        }
    }
}
