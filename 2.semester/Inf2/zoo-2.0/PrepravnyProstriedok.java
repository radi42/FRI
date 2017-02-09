 

import lib.*;
import java.util.*;
import java.io.*;

public abstract class PrepravnyProstriedok implements Serializable
{
    //================================================ Atributy instancie ==
    private ArrayList<Prepravitelny> nalozeniPasazieri;
    private Osoba vodic;              // osoba vodica prostriedku
    private double maxPrepravnaVaha;  //kolko kg uvezie maximalne
    private double aktualnaVaha;      //kolko kg mame nalozene

    //====================================================== Konstruktory ==
    /**
     * Konstruktor s pociatocnymi udajmi
     * @param vodic vodic prepravneho prostriedku
     * @param kapacita vozidla
     */
    public PrepravnyProstriedok(Osoba vodic, double maxPrepravnaVaha) { 
        this.nalozeniPasazieri = new ArrayList<Prepravitelny>();
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
    public abstract double dajKapacituObjemu();

    public abstract double dajKapacituVahy();    

    public abstract int dajKapacituPoctu();

    //================================================== Metody instancie ==
    //
    //------------------------------------------------- Gettery a Settery --
    public double getMaxPrepravnaVaha() { return maxPrepravnaVaha; }

    public double getAktualnaVaha() { return aktualnaVaha; }

    public void setAktualnaVaha() { this.aktualnaVaha = aktualnaVaha; }

    /**
     * Vytvori textovy zoznam prevazanych zvierat
     * @return text zoznamu
     */
    public String dajZoznamPasazierov() {        
        StringBuilder vysledok = new StringBuilder();

        vysledok.append("Zoznam nalozenych pasazierov \n");
        vysledok.append("**************************** \n");
        int i = 0;      // pomocne pocitadlo
        for( Prepravitelny x : nalozeniPasazieri ) {
            vysledok.append( String.format(
                    "%5d. %-25s , objem = %8d  hmotnost = %8d \n",
                    ++i,
                    x,
                    x.poziadavkaObjemu(),
                    x.poziadavkaVahy() ) );
        }
        vysledok.append("***** koniec zoznamu ******* \n");

        return vysledok.toString();
    }    

    /**
     * Nalozenie zivocicha na vozidlo
     * @param ziv  vkladany zivocich
     */
    public boolean nalozZivocicha(Prepravitelny ziv) {
        double vahaZiv = ziv.poziadavkaVahy();
        //polymorfizmus cez rozhranie
        if ( aktualnaVaha + vahaZiv  > maxPrepravnaVaha){ 
            return false;  //do auta sa uz hmotnostne nezmesti
        } else{ 
            aktualnaVaha = aktualnaVaha + vahaZiv;
            // musim aktualizovat vahu auta, bude zvysena
            nalozeniPasazieri.add(ziv);
            return true;  //uz je nalozene do vozidla
        }
    } 

    /**
     * Vylozenie zivocicha z vozidla
     * @param index  index vykladaneho zivocicha
     * @return   vykladany zivocich
     */
    public Prepravitelny vylozZivocicha(int index) {
        if (index >= 0 && index < nalozeniPasazieri.size()) {
            // index je v platnom rozsahu
            Prepravitelny zasielka = nalozeniPasazieri.remove(index);
            //-- polymorfizmus cez rozhrania
            double vahaPrepravovaneho = zasielka.poziadavkaVahy();
            //-- Aktualizacia vahy, bude znizena
            aktualnaVaha = aktualnaVaha - vahaPrepravovaneho;
            return zasielka;  
        } else { 
            return null;  // index je mimo platneho rozsahu
        }
    }

    /**
     * Textova informacia o vozidle
     * @return text informaci
     */
    public String toString() {
        String formatStr = "[Vozidlo vedie sofer:%s,\nma nosnost:%10.2f kg"
                         + " z toho nalozene je:%10.2f kg %n";
        String retazec = String.format(formatStr, vodic.toString(),
                                                  maxPrepravnaVaha,
                                                  aktualnaVaha      );
        int poc = 0;
        for(Prepravitelny zasielka: nalozeniPasazieri) {
            Zivocich zviera = (Zivocich)zasielka;
            // polymorfizmus cez dedicnost
            retazec += String.format("%4d: %s%n", ++poc, zviera.toString());
        }
        retazec = retazec+"------------";   
        return retazec;   
    }

}

