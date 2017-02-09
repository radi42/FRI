package televizory;

import java.io.IOException;

/**
 * Trieda Telka
 * Rodicovska trieda, ktora obsahuje vsetky spolocne atributy potomkov
 * 
 * @author Andrej Šišila
 */
public abstract class Telka implements ITelka{
    
    private int aCena;
    private int aUhlopriecka;
    private String[] aProgramy = {"Jednotka", "Dvojka", "Markiza", "Jojka"}; //pole s pevne zadanymi hodnotami; polozky reprezentuju televizne kanaly
    private String aAktualnyProgram;
    private boolean aZapnuty;

    /**
     * Parametricky konstruktor
     * 
     * @param paCena int cena televizora
     * @param paUhlopriecka int rozmer uhlopriecky
     * @param paZapnuty boolean zapnuty/vypnuty
     */
    public Telka(int paCena, int paUhlopriecka, boolean paZapnuty) {
        this.aCena = paCena;
        this.aUhlopriecka = paUhlopriecka;
        this.aZapnuty = paZapnuty;
        this.aAktualnyProgram = null;
    }
    
    /**
     * Parametricky konstruktor - pretazeny
     * televizor je defaultne vypnuty (atribut aZapnuty je nastaveny na false),
     * pretoze do predajne nemoze prijst zapnuty
     * 
     * @param paCena int cena televizora
     * @param paUhlopriecka int rozmer uhlopriecky 
     */
    public Telka(int paCena, int paUhlopriecka) {
        this.aCena = paCena;
        this.aUhlopriecka = paUhlopriecka;
        this.aZapnuty = false; //je od zaciatku vypnuty
        this.aAktualnyProgram = null;
    }
    
    //Gettery==================================================================
    @Override
    public int getCena() {return aCena; }

    @Override
    public int getUhlopriecka() {return aUhlopriecka; }

    public String[] getProgramy() {return aProgramy; }

    public String getAktualnyProgram() {return aAktualnyProgram; }

    @Override
    public boolean isZapnuty() {return aZapnuty; }
    
    //Settery==================================================================
    /**
     * nastavuje cenu tv
     * @param aCena 
     */
    @Override
    public void setCena(int paCena) {
        this.aCena = paCena;
    }
    
    /**
     * zapina/vypina tv
     * @param aZapnuty 
     */
    @Override
    public void setZapnuty(boolean paZapnuty) {
        this.aZapnuty = paZapnuty;
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
            int nahoda = (int) (aProgramy.length * Math.random() ); //malo by vygenerovat cislo od 0 do pocet programov (defaultne od 0-3)
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
    
    /**
     * @return metoda vracia to iste co metoda vypis()
     */
    @Override
    public String toString(){
        return vypis();
    }
    
    /**
     * @return predpriprava spolocnych atributov vsetkych potomkov, ktore sa maju zapisat do suboru
     */
    @Override
    public String zapisData() throws IOException{
        String tvInfo = "";
        tvInfo += String.format("%n");
        tvInfo += aCena;
        tvInfo += String.format("%n");
        tvInfo += aUhlopriecka;
        tvInfo += String.format("%n");
        return tvInfo;
    }
}
