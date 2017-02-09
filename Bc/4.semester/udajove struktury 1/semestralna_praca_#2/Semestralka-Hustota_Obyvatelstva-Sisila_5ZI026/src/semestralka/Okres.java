package semestralka;

import exception.ETabulka;
import datastructures.lists.ArrayList.ArrayList;
import datastructures.lists.EList;
import java.util.logging.Level;
import java.util.logging.Logger;
import tables.ETable;
import tables.NonsortedSequenceTable.NonsortedSeqenceTable;
import tables.SortedSequenceTable.SortedSeqenceTable;
import tables.Sorts.StringComparer;
import tables.TablePair;

/**
 * Okres tvoria Sidla
 * @author Andrej Šišila
 */
public class Okres {
    
    private String aNazovOkresu;
    private NonsortedSeqenceTable<String,Sidlo> aSidlaOkresu; //neutriedena tabulka sidiel; <Kluc bude nazov Sidla, Data budu samotne sidlo>
    private SortedSeqenceTable<String,Sidlo> aSidlaOkresuZotriedene;    //sluzi na abecedny vypis sidiel okresu
    private ArrayList<Sidlo> aArraySidielOkresu;
    
    private int aRokNajmensiehoPoctuObyvatelovSidla;
    private int aRokNajvacsiehoPoctuObyvatelovSidla;
    private float aPrirastokAbsOkresu;
    private float aPrirastokPercOkresu;
    private float [] aPolePoctuObyvatelovOkresu;
    
    public Okres(String paNazov){
        aNazovOkresu = paNazov;
        aSidlaOkresu = new NonsortedSeqenceTable<String,Sidlo>();
        aSidlaOkresuZotriedene = new SortedSeqenceTable<String,Sidlo>(new StringComparer());
        aArraySidielOkresu = new ArrayList<Sidlo>();
        aPolePoctuObyvatelovOkresu = new float [19];
    }
    
    public void setNazov(String paNazov){
        aNazovOkresu = paNazov;
    }
    
    public void pridajSidloDoOkresu(Sidlo paSidlo) throws ETabulka{
        try {
            aSidlaOkresu.insert(paSidlo.getNazovSidla(), paSidlo);
        } catch (ETable ex) {
            throw new ETabulka("Nepodarilo sa pridat sidlo do okresu");
        }
    }
    
    public void pridajSidloDoOkresuVAbecednomPoradi(Sidlo paSidlo) throws ETabulka{
        try {
            aSidlaOkresuZotriedene.insert(paSidlo.getNazovSidla(), paSidlo);
        } catch (ETable ex) {
            throw new ETabulka("Nepodarilo sa pridat sidlo do okresu");
        }
    }
    
    public String getNazovOkresu(){
        return aNazovOkresu;
    }
    
    public NonsortedSeqenceTable<String,Sidlo> getSidlaOkresu(){
        return aSidlaOkresu;
    }
    
    public SortedSeqenceTable<String,Sidlo> getSidlaOkresuZotriedene(){
        return aSidlaOkresuZotriedene;
    }
    
    public ArrayList<Sidlo> getArraySidielOkresu(){
        return aArraySidielOkresu;
    }
    
    public int getRokNajmensiehoPoctuObyvatelovSidla(){
        return aRokNajmensiehoPoctuObyvatelovSidla;
    }
    
    public int getRokNajvacsiehoPoctuObyvatelovSidla(){
        return aRokNajvacsiehoPoctuObyvatelovSidla;
    }
    
    public float getPrirastokAbsOkresu(){
        return aPrirastokAbsOkresu;
    }
    
    public float getPrirastokPercOkresu(){
        return aPrirastokPercOkresu;
    }
    
    public float[] getPolePoctuObyvatelovOkresu(){
        return aPolePoctuObyvatelovOkresu;
    }
    
    public float getPocetObyvatelovOkresuVDanomRoku(int paRok) throws ETabulka{
        if(paRok >= 1996 && paRok <= 2014)
            return aPolePoctuObyvatelovOkresu[paRok-1996];
        else
            throw new ETabulka("Rok nie je v rozmedzi od 1996 do 2014");
    }
    
    /**
     * @return vypis sidiel v abecednom poradi (lebo tak su uz v Exceli :P)
     */
    @Override
    public String toString(){
        String zoznamSidiel = "";
        try {
            for(TablePair<String, Sidlo> s : aSidlaOkresu){

                    zoznamSidiel += s.getElement().getNazovSidla() + " ▐ " +
                            s.getElement().getOkresSidla().aNazovOkresu + " ▐ " +
                            s.getElement().getRokNajvacsiehoPoctuObyvatelovSidla()+ " ▐ " +
                            s.getElement().getRokNajmensiehoPoctuObyvatelovSidla() + " ▐ " +
                            s.getElement().vypocitajAbsolutnyPrirastok(1996, 2014) + " ▐ " + 
                            s.getElement().vypocitajPercentualnyPrirastok(1996, 2014) + " ►►► ";
            }
        } catch (ETabulka ex) {
                System.out.println("Zadali ste nepovoleny rok alebo ste si prehodili zaciatocny a koncovy rok");    //ja viem, nemalo by sa to odchytavat tu
        }
        return zoznamSidiel;
    }
    
    /**
     * * metoda sa musi volat az po dokonceni metody "naplnPolePoctuObyvatelovOkresu"!!! inak to bude blbnut a davat nespravne vysledky
     * @return
     * @throws ETabulka 
     */
    public int vypocitajRokNajvacsiehoPoctuObyvatelovOkresu() throws ETabulka{
        //naplnPolePoctuObyvatelovOkresu();
        
        float maximum = 0;
        for (int i = 0; i < 19; i++) {
            if(maximum < aPolePoctuObyvatelovOkresu[i]){
                maximum = aPolePoctuObyvatelovOkresu[i];
                aRokNajvacsiehoPoctuObyvatelovSidla = i + 1996;
            }
        }
        return aRokNajvacsiehoPoctuObyvatelovSidla;
    }
    
    /**
     * metoda sa musi volat az po dokonceni metody "naplnPolePoctuObyvatelovOkresu"!!! inak to bude blbnut a davat nespravne vysledky
     * @return
     * @throws ETabulka 
     */
public int vypocitajRokNajmensiehoPoctuObyvatelovOkresu() throws ETabulka{
        //naplnPolePoctuObyvatelovOkresu();
        
        float minimum = Float.MAX_VALUE;
        for (int i = 0; i < 19; i++) {
            if(minimum > aPolePoctuObyvatelovOkresu[i]){
                minimum = aPolePoctuObyvatelovOkresu[i];
                aRokNajmensiehoPoctuObyvatelovSidla = i + 1996;
            }
        }
        return aRokNajmensiehoPoctuObyvatelovSidla;
    }
    
    /**
     * vola sa PRED vykonanim metod vypocitajRokNajvacsiehoPoctuObyvatelovOkresu a vypocitajRokNajmensiehoPoctuObyvatelovOkresu
     */
    public void naplnPolePoctuObyvatelovOkresu() throws ETabulka{
        aPolePoctuObyvatelovOkresu = null;              //stare pole sa vymaze
        aPolePoctuObyvatelovOkresu = new float [19];    //a nahradi sa nanovo vypocitanym
        float [] hustotyObyvBak = new float [19];
        try{    
            for (int i = 0; i < 19; i++) {  //pre kazdy rok
                for (int j = 0; j < aSidlaOkresu.size(); j++) { //pre kazdu obec v danom okrese
                    hustotyObyvBak = aSidlaOkresu.find(aArraySidielOkresu.get(j).getNazovSidla() ).getHustotyObyv();    //ziskaj pole rokov a hustot obyvatelstva
                    aPolePoctuObyvatelovOkresu[i] += hustotyObyvBak[i];      //inkrementuj pocet obyvatelov
                }
            }
        } catch (ETable ex) {
            throw new ETabulka("Chyba tabulky");
        } catch (EList ex) {
            throw new ETabulka("ArrayList zblbol");
        }
    }

    /**
     * pridaj sidlo aj do arraylistu pre sukromne ucely okresu (jednoduchsie pristupovanie k sidlam)
     * @param paSidlo
     * @throws ETabulka 
     */
    public void pridajSidloDoArraySidielOkresu(Sidlo paSidlo) throws ETabulka {
        try {
            aArraySidielOkresu.add(paSidlo);
        } catch (EList ex) {
            throw new ETabulka("Nepodarilo sa pridat sidlo do ArrayListu sidiel");
        }
    }
    
    public float vypocitajAbsolutnyPrirastok(int paRokOd, int paRokDo) throws ETabulka{
        if(paRokOd >= 1996 && paRokOd <= 2014 && paRokDo >= 1996 && paRokDo <= 2014 && paRokOd < paRokDo){
            aPrirastokAbsOkresu = 0;
            for(TablePair<String, Sidlo> town : aSidlaOkresu){
                town.getElement().vypocitajAbsolutnyPrirastok(paRokOd, paRokDo);    //najprv prepocitaj
                aPrirastokAbsOkresu += town.getElement().getPrirastokAbs();         //potom scitaj
            }
            return aPrirastokAbsOkresu;
        } else {
            throw new ETabulka("Zadali ste nepovoleny rok alebo ste si prehodili zaciatocny a koncovy rok");
        }
    }
    
    public float vypocitajPercentualnyPrirastok(int paRokOd, int paRokDo) throws ETabulka{
        if(paRokOd >= 1996 && paRokOd <= 2014 && paRokDo >= 1996 && paRokDo <= 2014 && paRokOd < paRokDo){
            aPrirastokPercOkresu = 0;
            
            float sucetHustotOkresu = 0;
            for (int i = 0; i < aPolePoctuObyvatelovOkresu.length; i++) {
                sucetHustotOkresu += aPolePoctuObyvatelovOkresu[i];
            }
            float priemernaHustota = sucetHustotOkresu / aPolePoctuObyvatelovOkresu.length;

            aPrirastokPercOkresu = vypocitajAbsolutnyPrirastok(paRokOd, paRokDo) / priemernaHustota;
            return aPrirastokPercOkresu;
        } else {
            throw new ETabulka("Zadali ste nepovoleny rok alebo ste si prehodili zaciatocny a koncovy rok");
        }
    }
}
