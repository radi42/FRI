package televizory;

import java.io.IOException;

/**
 * Trieda TelkaLcd
 * 
 * 
 * @author Andrej Šišila
 */
public class TelkaLcd extends Telka{
    
    private boolean aLedkovy;
    
    /**
     * Parametricky konstruktor
     * 
     * @param paCena int cena televizora
     * @param paUhlopriecka int rozmer uhlopriecky
     * @param paZapnuty boolean zapnuty/vypnuty
     * @param paLedkovy boolean ci obsahuje televizor LED obrazovku
     */
    public TelkaLcd(int paCena, int paUhlopriecka, boolean paZapnuty, boolean paLedkovy) {
        super(paCena, paUhlopriecka, paZapnuty);
        aLedkovy = paLedkovy;
    }
    
    /**
     * Parametricky konstruktor - pretazeny
     * 
     * @param paCena int cena televizora
     * @param paUhlopriecka int rozmer uhlopriecky
     * @param paLedkovy boolean ci obsahuje televizor LED obrazovku
     */
    public TelkaLcd(int paCena, int paUhlopriecka, boolean paLedkovy) {
        super(paCena, paUhlopriecka);
        aLedkovy = paLedkovy;
    }
    
    @Override
    public String vypis(){
        String tvInfo = String.format("%s %n", "LCD Televizor");
        tvInfo += String.format("%s", super.vypis() ); // volanie rodicovskej metody vypis
        tvInfo += String.format("%20s %s %n", "LED LCD ", (aLedkovy ? "Ano" : "Nie") );
        return tvInfo;
    }
    
    @Override
    public String toString(){
        return vypis();
    }
    
    @Override
    public String zapisData() throws IOException{
        String tvInfo = "";
        tvInfo += " " + getClass().getName();
        tvInfo += super.zapisData(); // volanie rodicovskej metody zapisData
        tvInfo += super.isZapnuty();
        tvInfo += String.format("%n");
        tvInfo += aLedkovy;
        tvInfo += String.format("%n");
        return tvInfo;
    }
}
