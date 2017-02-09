
/**
 * Write a description of class Predmet here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Predmet
{
    //naprogramovat podobne ako studenta - rovnake metody gettery a settery
    private String nazovPredmetu;
    private double skuska; //hodnotenie skusky - A=1, B-1.5, C=2, D=2.5, E = 3, F=3.5=nevyhovel
    private Datum datumSkusky;
    private int pocetKreditov;
    
    public Predmet(String nazovPredmetu, double skuska, Datum datumSkusky, int pocetKreditov) {
        this.nazovPredmetu = nazovPredmetu;
        this.skuska = skuska;
        this.datumSkusky = datumSkusky;
        this.pocetKreditov = pocetKreditov;
    }
    
    /**
     * Gettery
     */
    public String getNazovPredmetu() {
        return nazovPredmetu;
    }
    
    public double getSkuska() {
        return skuska;
    }
    
    public Datum getDatumSkusky() {
        return datumSkusky;
    }
    
    public int getPocetKreditov() {
        return pocetKreditov;
    }
    
    /**
     * Settery
     */
    public void setNazovPredmetu(String nazovPredmetu) {
        this.nazovPredmetu = nazovPredmetu;
    }
    
    //nastav naraz hodnotenie skusky aj datum skusky
    public void setSkuskaPlusDatum(double skuska, Datum datumSkusky) {
        this.skuska = skuska;
        this.datumSkusky = datumSkusky;
    }
    
    public void setPocetKreditov(int pocetKreditov) {
        this.pocetKreditov = pocetKreditov;
    }
    
    /**
     * toString
     */
    public String toString() {
        return "Nazov predmetu: " + nazovPredmetu + "--" + "Hodnotenie skusky: " + skuska + "--" + 
                "Datum skusky: " + datumSkusky + "--" + "Pocet kreditov: " + pocetKreditov;
    }
}
