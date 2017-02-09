package televizory;

import java.io.IOException;

/**
 * Trieda TelkaCrt
 * 
 * 
 * @author Andrej Šišila
 */
public class TelkaCrt extends Telka{

    private boolean aStereo;
    
    /**
     * Parametricky konstruktor
     * 
     * @param paCena int cena televizora
     * @param paUhlopriecka int rozmer uhlopriecky
     * @param paZapnuty boolean zapnuty/vypnuty
     * @param paStereo boolean bud s jednym alebo s dvoma reproduktormi
     */
    public TelkaCrt(int paCena, int paUhlopriecka, boolean paZapnuty, boolean paStereo) {
        super(paCena, paUhlopriecka, paZapnuty);
        aStereo = paStereo;
    }
    
    /**
     * Parametricky konstruktor - pretazeny
     * 
     * @param paCena int cena televizora
     * @param paUhlopriecka int rozmer uhlopriecky
     * @param paStereo boolean bud s jednym alebo s dvoma reproduktormi
     */
    public TelkaCrt(int paCena, int paUhlopriecka, boolean paStereo) {
        super(paCena, paUhlopriecka);
        aStereo = paStereo;
    }
    
    @Override
    public String vypis(){
        String tvInfo = String.format("%s %n", "CRT Televizor");
        tvInfo += String.format("%s", super.vypis() ); // volanie rodicovskej metody vypis
        tvInfo += String.format("%20s %s %n", "Stereo ", (aStereo ? "Ano" : "Nie") );
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
        tvInfo += aStereo;
        tvInfo += String.format("%n");
        return tvInfo;
    }
}
