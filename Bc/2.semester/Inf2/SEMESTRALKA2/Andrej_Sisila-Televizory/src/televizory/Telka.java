package televizory;

import java.io.DataOutputStream;
import java.io.IOException;
import java.util.Random;
/**
 * 
 * @author Andy
 */
public class Telka implements ITelka{
    
    private int aCena;
    private int aUhlopriecka;
    private String[] aProgramy = {"Jednotka", "Dvojka", "Markiza", "Jojka"};
    private String aAktualnyProgram;
    private boolean aZapnuty;

    public Telka(int paCena, int paUhlopriecka, boolean paZapnuty) {
        this.aCena = paCena;
        this.aUhlopriecka = paUhlopriecka;
        this.aZapnuty = paZapnuty; //je od zaciatku vypnuty
        this.aAktualnyProgram = null;
    }
    
    /**
     * pretazeny konstruktor - tv je defaultne vypnuty (atribut aZapnuty je nastaveny na false)
     * @param paCena
     * @param paUhlopriecka 
     */
    public Telka(int paCena, int paUhlopriecka) {
        this.aCena = paCena;
        this.aUhlopriecka = paUhlopriecka;
        this.aZapnuty = false; //je od zaciatku vypnuty
        this.aAktualnyProgram = null;
    }
    
//    public abstract void zapisTxt();
    
    //Gettery==================================================================
    public int getCena() {return aCena; }

    public int getUhlopriecka() {return aUhlopriecka; }

    public String[] getProgramy() {return aProgramy; }

    public String getAktualnyProgram() {return aAktualnyProgram; }

    public boolean isZapnuty() {return aZapnuty; }
    
    //Settery==================================================================
    /**
     * nastavuje cenu tv
     * @param aCena 
     */
    public void setCena(int aCena) {
        this.aCena = aCena;
    }
    
    /**
     * zapina/vypina tv
     * @param aZapnuty 
     */
    public void setZapnuty(boolean aZapnuty) {
        this.aZapnuty = aZapnuty;
    }
    
    //Implementovane metody ===================================================
    /**
     * prepne na nahodny program - ekvivalent setteru pre atribut aAktualnyProgram
     * @return cislo nahodneho programu v poli
     */
    @Override
    public String prepniProgramNahodne() {
        if(!aZapnuty){
            return "Neda sa prepnut program - Televizor vypnuty";
        }else{
            Random rng = new Random();
            int nahoda = (int) (aProgramy.length * Math.random() ); //malo by vygenerovat cislo od 0 do pocet programov (defaultne od 0-3)
//            int nahoda = rng.nextInt(4);
            aAktualnyProgram = aProgramy[nahoda];
            return aAktualnyProgram;
        }
    }
    
    /**
     * @return vrati informacie o televizore
     */
    @Override
    public String vypis() {
        String tvInfo = String.format("%20s %d %s %n", "Uhlopriecka", aUhlopriecka, "cm");
        tvInfo += String.format("%20s %s %n", "Je zapnuty?",(aZapnuty ? "Ano" : "Je vypnuty") );
        tvInfo += String.format("%20s %s %n", "Aktualny program: ",(aZapnuty ? aAktualnyProgram : "Je vypnuty") );
        tvInfo += String.format("%20s %d %n", "Cena: ", aCena);
        return tvInfo;
    }
    
    @Override
    public String toString(){
        return vypis();
    }
    
//    /**
//     * 
//     * @return 
//     */
//    public String zapisTxt2() {
//        String tvInfo = "";
//        tvInfo += " " + aCena;
//        tvInfo += " " + aUhlopriecka;
//        tvInfo += " " + aZapnuty;
//        return tvInfo;
//    }
    
    /**
     * 
     * @return 
     */
    @Override
    public String zapisData() throws IOException{
        String tvInfo = "";
        tvInfo += String.format("%n");
        tvInfo += aCena;
        tvInfo += String.format("%n");
        tvInfo += aUhlopriecka;
        tvInfo += String.format("%n");
        tvInfo += aZapnuty;
        tvInfo += String.format("%n");
        return tvInfo;
    }
}
