package zoo;

import lib.*;
import java.util.*;
import java.io.*;

public abstract class PrepravnyProstriedok implements Serializable
{
    //================================================ Atributy instancie ==
    protected ArrayList<Prepravitelny> pasazieri;
    protected Osoba vodic;              // osoba vodica prostriedku
    protected double maxPrepravnaVaha;  // kolko kg uvezie maximalne
    protected double aktualnaVaha;      // kolko kg mame nalozene

    //====================================================== Konstruktory ==
    /**
     * Konstruktor s pociatocnymi udajmi.
     * @param vodic vodic prepravneho prostriedku
     * @param maxPrepravnaVaha maximálna prepravná váha prostriedku
     */
    public PrepravnyProstriedok(Osoba vodic, double maxPrepravnaVaha) { 
        this.pasazieri = new ArrayList<>();
        this.vodic = vodic;
        this.maxPrepravnaVaha = maxPrepravnaVaha;
        this.aktualnaVaha = 0;
    }

    /**
     * Konstruktor s vodicom
     * @param vodic objekt vodica vozidla
     */
    public PrepravnyProstriedok(Osoba vodic) { this(vodic, 0); }

    /**
     * Konstruktor pre prazdne vozidlo
     */
    public PrepravnyProstriedok() { this(null, 0); }

    //================================================= Metody interfejsu ==
    public abstract String infoOVozidle();

    //================================================== Metody instancie ==
    //-------------------------------- Gettery a Settery --
    public ArrayList<Prepravitelny> getPasazieri() { return pasazieri; }
    public Osoba getVodic() { return vodic; }
    public double getMaxPrepravnaVaha() { return maxPrepravnaVaha; }
    public double getAktualnaVaha() { return aktualnaVaha; }

    public void setPasazieri(ArrayList<Prepravitelny> pasazieri) {
                                            this.pasazieri = pasazieri; }
    public void setVodic(Osoba vodic) { this.vodic = vodic; }
    public void setMaxPrepravnaVaha(double maxPrepravnaVaha) {
                                this.maxPrepravnaVaha = maxPrepravnaVaha; }
    public void setAktualnaVaha(double aktualnaVaha) {
                                        this.aktualnaVaha = aktualnaVaha; }

    //------------------------------------ Ostatné metódy --
    /**
     * Vytvori textovy zoznam prevazanych zvierat
     * @return text zoznamu
     */
    public String dajZoznamPasazierov() {        
        StringBuilder vysledok = new StringBuilder();

        vysledok.append("Zoznam nalozenych pasazierov \n");
        vysledok.append("**************************** \n");
        int i = 0;      // pomocne pocitadlo
        for( Prepravitelny x : pasazieri ) {
            vysledok.append( String.format(
                    "%5d. %-25s , objem = %8d  hmotnost = %8d \n",
                    ++i, x, x.poziadavkaObjemu(), x.poziadavkaVahy()));
        }
        vysledok.append("***** koniec zoznamu ******* \n");

        return vysledok.toString();
    }    

    /**
     * Naloženie živocícha na vozidlo.
     * @param ziv  vkladaný živocích
     * @return 
     */
    public boolean nalozZivocicha(Prepravitelny ziv) {
        double vahaZiv = ziv.poziadavkaVahy();
        //polymorfizmus cez rozhranie
        if ( aktualnaVaha + vahaZiv  > maxPrepravnaVaha){ 
            return false;            // do auta sa uz hmotnostne nezmesti
        } else{ 
            aktualnaVaha += vahaZiv; // aktualizovácia váhy auta
            pasazieri.add(ziv);
            return true;             // už je naložené do vozidla
        }
    } 

    /**
     * Vylozenie zivocicha z vozidla
     * @param index  index vykladaneho zivocicha
     * @return   vykladany zivocich
     */
    public Prepravitelny vylozZivocicha(int index) {
        if (index >= 0 && index < pasazieri.size()) { // index je v rozsahu
            Prepravitelny zasielka = pasazieri.remove(index);
            //-- polymorfizmus cez rozhrania
            double vahaPrepravovaneho = zasielka.poziadavkaVahy();
            //-- Aktualizacia vahy, bude znizena
            aktualnaVaha = aktualnaVaha - vahaPrepravovaneho;
            return zasielka;  
        } else { 
            return null;   //---------------- index je mimo platneho rozsahu
        }
    }

    /**
     * Textova informacia o vozidle
     * @return text informaci
     */
    @Override
    public String toString() {
        String formatStr = "[Vozidlo vedie vodič:%s,\nmá nosnosť:%10.2f kg,"
                         + " z toho naložené je:%10.2f kg %n";
        String retazec = String.format(formatStr, vodic,
                                                  maxPrepravnaVaha,
                                                  aktualnaVaha      );
        retazec = retazec+"------------";
        return retazec;   
    }

}

