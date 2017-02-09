 

import java.io.*;
/**
 * Trieda Ryba - popis.
 * 
 * @author Bene
 * @version V-1-0  [20.3.2013]
 */
public class Ryba extends Zivocich implements Serializable
{
    //pridame nove = nezdedene atributy
    private double vaha;
    private double dlzka;
    private boolean dravec;

    //konstruktor musime prekryt
    public Ryba(int pocetKoncatin, double vaha, double dlzka, boolean dravec) {
        super("Ryba", "Akvarium" ); //volanie konstruktora rodica
        this.vaha   = vaha;
        this.dlzka  = dlzka;
        this.dravec = dravec;
        //zmenime nazovDruhu inak by sme mali povodny nazov ="Zivocich"
        //neda sa vstupit do rodicovskeho private parametra => pouzijeme metodu
        setNazovDruhu("Ryba"); 
    }

    public String stringAtrib() {
        return String.format( "%s%n%d %8.2f %b", getNazovDruhu(),
                              getPocetKoncatin(), vaha, dlzka, dravec );
    }

//     /**
//      * Textova informacia o instancii - verzia c. 1 -
//      */
//     @Override
//     public String toString() { 
//         String pom = "";
//         if (dravec == false) { pom = "nie"; }
//         pom += " je"; 
//         String retazec = super.toString()
//             + String.format(" vaha:%8.2f kg, dlzka:%8.2cm a %s dravec)",
//                             vaha, dlzka, pom );
//         return retazec;   
//     }
    
    /**
     * Textova informacia o instancii - verzia c. 2 -
     */
    @Override
    public String toString() { 
        return super.toString()
            + String.format(" vaha:%8.2f kg, dlzka:%8.2f cm; %s dravec)",
                            vaha, dlzka, (dravec ? "" : "nie ") + "je"     );
    }
    
    //---------------------------------------------- metody potomka --
    public void setVaha(double novaVaha) { vaha = novaVaha; }
    
    public double getVaha() { return vaha; }
    
    public void setDlzka(double novaDlzka) { dlzka = novaDlzka; }
    
    public double getDlzka() { return dlzka; }
    
    public void setDravec(boolean dravec) { this.dravec = dravec; }
    
    public boolean getDravec() { return dravec; }
}
