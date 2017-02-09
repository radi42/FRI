package semestralka;

import exception.ETabulka;
import java.util.logging.Level;
import java.util.logging.Logger;
import tables.SortedSequenceTable.SortedSeqenceTable;
import tables.TablePair;

/**
 * Sidlo sa sklada z Roku a Poctu Obyvatelov v danom Roku
 * @author Andrej Šišila
 */
public class Sidlo {
    
    private String aNazovSidla;
    private float [] aHustotyObyv;  //96 + i; na nultej pozicii bude rok '96, zvysne roky vypocitame ako 96+i:  96+0    96+1    ... 96+19 = 2015
    
    private Okres aOkresPointer;    //moze sa hodit smernik na okres
    private int aRokNajmensiehoPoctuObyvatelovSidla;
    private int aRokNajvacsiehoPoctuObyvatelovSidla;
    private float aPrirastokAbs;
    private float aPrirastokPerc;

    public Sidlo(String paNazov) {
        aNazovSidla = paNazov;
        aHustotyObyv = new float[19];
    }
    
    //nech to rata
    
    public void setNazovSidla(String paNazovSidla){
        aNazovSidla = paNazovSidla;
    }
    
    public void pridajZaznamDoHustotyObyv(int paIndex, float paHustota){
        aHustotyObyv[paIndex] = paHustota;
    }
    
    public String getNazovSidla(){
        return aNazovSidla;
    }
    
    public float[] getHustotyObyv(){
        return aHustotyObyv;
    }
    
    public void setOkresSidla(Okres paOkresPointer){
        aOkresPointer = paOkresPointer;
    }
    
    public Okres getOkresSidla(){
        return aOkresPointer;
    }
    
    public int getRokNajmensiehoPoctuObyvatelovSidla(){
        return aRokNajmensiehoPoctuObyvatelovSidla;
    }
    
    public int getRokNajvacsiehoPoctuObyvatelovSidla(){
        return aRokNajvacsiehoPoctuObyvatelovSidla;
    }
    
    public float getPrirastokAbs(){
        return aPrirastokAbs;
    }
    
    public float getPrirastokPerc(){
        return aPrirastokPerc;
    }
    
    /**
     * nie je to celkom pocet obyvatelov, je to hustota obyvatelstva
     * alebo tiez relativne vzaty pocet obyvatelov
     * @param paRok
     * @return
     * @throws ETabulka 
     */
    public float getPocetObyvatelovSidlaVDanomRoku(int paRok) throws ETabulka{
        if(paRok >= 1996 && paRok <= 2014)
            return aHustotyObyv[paRok-1996];
        else
            throw new ETabulka("Rok nie je v rozmedzi od 1996 do 2014");
    }
    
    public int vypocitajRokNajvacsiehoPoctuObyvatelovSidla(){
        int rok = 0;
        float maximum = 0;
        int dlzkaPola = aHustotyObyv.length;    //debuggovacia premenna
        for (int i = 0; i < aHustotyObyv.length; i++) {
            if(maximum < aHustotyObyv[i]){
                maximum = aHustotyObyv[i];
                aRokNajvacsiehoPoctuObyvatelovSidla = i + 1996;
            }
        }
        return aRokNajvacsiehoPoctuObyvatelovSidla;
    }
    
    public int vypocitajRokNajmensiehoPoctuObyvatelovSidla(){
        int rok = 0;
        float minimum = Float.MAX_VALUE;
        int dlzkaPola = aHustotyObyv.length;    //debuggovacia premenna
        for (int i = 0; i < aHustotyObyv.length; i++) {
            if(minimum > aHustotyObyv[i]){
                minimum = aHustotyObyv[i];
                aRokNajmensiehoPoctuObyvatelovSidla = i + 1996;
            }
        }
        return aRokNajmensiehoPoctuObyvatelovSidla;
    }
    
    public float vypocitajAbsolutnyPrirastok(int paRokOd, int paRokDo) throws ETabulka{
//        //premenne sluziace na debuggovacie ucely
//        boolean rokOdOK = paRokOd >= 1996 && paRokOd <= 2014;
//        boolean rokDoOK = paRokDo >= 1996 && paRokDo <= 2014;
//        boolean rokOdMensiRovnyRokDo = paRokOd <= paRokDo;
        if(paRokOd >= 1996 && paRokOd <= 2014 && paRokDo >= 1996 && paRokDo <= 2014 && paRokOd < paRokDo){
            aPrirastokAbs = 0;
            int indexOd = paRokOd - 1996;
            int indexDo = paRokDo - 1996;
            aPrirastokAbs= aHustotyObyv[indexDo] - aHustotyObyv[indexOd];
            return aPrirastokAbs;
        }
        else{
            throw new ETabulka("Zadali ste nepovoleny rok alebo ste si prehodili zaciatocny a koncovy rok");
        }
    }
    
    public float vypocitajPercentualnyPrirastok(int paRokOd, int paRokDo) throws ETabulka{
        if(paRokOd >= 1996 && paRokOd <= 2014 && paRokDo >= 1996 && paRokDo <= 2014 && paRokOd < paRokDo){
            aPrirastokPerc = 0;
            int indexOd = paRokOd - 1996;
            int indexDo = paRokDo - 1996;

            float sucetHustot = 0;
            for (int i = 0; i < aHustotyObyv.length; i++) {
                sucetHustot += aHustotyObyv[i];
            }
            float priemernaHustota = sucetHustot / aHustotyObyv.length;

            aPrirastokPerc = vypocitajAbsolutnyPrirastok(paRokOd, paRokDo) / priemernaHustota;
            return aPrirastokPerc;
        }
        else{
            throw new ETabulka("Zadali ste nepovoleny rok alebo ste si prehodili zaciatocny a koncovy rok");
        }
    }
    
    public String toString(){
        try {
            String info = "";
            info += "Okres: " + aOkresPointer.getNazovOkresu() + " ▐ " +
                    "Najviac obyvatelov bolo roku " + getRokNajvacsiehoPoctuObyvatelovSidla()+ " ▐ " +
                    "Najmenej obyvatelov bolo roku " + getRokNajmensiehoPoctuObyvatelovSidla() + " ▐ " +
                    "Absolutny prirastok " + vypocitajAbsolutnyPrirastok(1996, 2014) + " ▐ " +
                    "Percentualny prirastok " + vypocitajPercentualnyPrirastok(1996, 2014);
            return info;
        } catch (ETabulka ex) {
            System.out.println("Zadali ste nepovoleny rok alebo ste si prehodili zaciatocny a koncovy rok");
        }
        return null;
    }
}
