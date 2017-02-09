package zoo;

import java.io.Serializable;
import java.util.ArrayList;
import lib.Osoba;

/**
 *
 * @author Andy
 */
public abstract class PrepravnyProstriedok implements Serializable{
    protected ArrayList<Prepravitelny> pasazieri;
    protected Osoba vodic;
    protected double maxPrepravnaVaha;
    protected double aktualnaVaha;
    
    /**
     * Konstruktor s pociatocnymi udajmi
     * @param vodic vodic vozidla
     * @param maxPrepravnaVaha vahovy limit
     */
    public PrepravnyProstriedok(Osoba vodic, double maxPrepravnaVaha){
        this.pasazieri = new ArrayList<>();
        this.vodic = vodic;
        this.maxPrepravnaVaha = maxPrepravnaVaha;
        this.aktualnaVaha = 0;
    }
    
    /**
     * abstraktna metoda infoOVozidle
     * musi byt implementovana v dedenych triedach
     * @return Stringovy retazec informacii o vozidle
     */
    public abstract String infoOVozidle();

    public ArrayList<Prepravitelny> getPasazieri() {
        return pasazieri;
    }

    public void setPasazieri(ArrayList<Prepravitelny> pasazieri) {
        this.pasazieri = pasazieri;
    }

    public Osoba getVodic() {
        return vodic;
    }

    public void setVodic(Osoba vodic) {
        this.vodic = vodic;
    }

    public double getMaxPrepravnaVaha() {
        return maxPrepravnaVaha;
    }

    public void setMaxPrepravnaVaha(double maxPrepravnaVaha) {
        this.maxPrepravnaVaha = maxPrepravnaVaha;
    }

    public double getAktualnaVaha() {
        return aktualnaVaha;
    }

    public void setAktualnaVaha(double aktualnaVaha) {
        this.aktualnaVaha = aktualnaVaha;
    }
    
    
    //Metody
    
    /**
     * 
     * @return zoznam pasazierov
     */
    public String dajZoznamPasazierov(){
        StringBuilder sb = new StringBuilder();
        
        sb.append("Zoznam nalozenych pasazierov %n");
        sb.append("%n");
        int i = 0; //pomocne pocitadlo
        for(Prepravitelny prep : pasazieri){
            sb.append(String.format("%5d. %-25s objem = %8d hmotnost = %8d"));
        }
        return sb.toString().replace(",", "");
    }
    
    /**
     * naloz zivocicha do vozidla
     * @param ziv nakladany zivocich
     * @return nalozeny/nenalozeny
     */
    public boolean nalozZivocicha(Prepravitelny ziv){
        double vahaZiv = ziv.poziadavkaVahy();
        if(aktualnaVaha + vahaZiv > maxPrepravnaVaha){
            return false;
        }else{
            aktualnaVaha += vahaZiv;
            pasazieri.add(ziv);
            return true;
        }
    }
    
    /**
     * vyloz zivocicha
     * @return 
     */
    public Prepravitelny vylozZivocicha(int index){
        if(index >= 0 && index < pasazieri.size() ){
            Prepravitelny zasielka = pasazieri.remove(index);
            //dynamicka premenna vahaPrepraveneho - polymorfizmus cez interface
            double vahaPrepraveneho = zasielka.poziadavkaVahy();
            aktualnaVaha = aktualnaVaha - vahaPrepraveneho;
            return zasielka;
        }else{
            return null;
        }
    }
    
    @Override
    public String toString() {
        String formatStr = "[Vozidlo vedie sofer: " + vodic.getMeno() + " " 
                + vodic.getPriezvisko() + "%n"
                +"Vozidlo ma nosnost " + getMaxPrepravnaVaha()
                + " z toho nalozene je " + getAktualnaVaha()+ "]";
        return null;
    }
}
