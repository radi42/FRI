package televizory;

import java.io.IOException;

/**
 * Trieda TelkaPlazma
 * 
 * 
 * @author Andrej Šišila
 */
public class TelkaPlazma extends Telka{
    
    private boolean a3D_obraz;

    /**
     * Parametricky konstruktor
     * 
     * @param paCena int cena televizora
     * @param paUhlopriecka int rozmer uhlopriecky
     * @param paZapnuty boolean zapnuty/vypnuty
     * @param pa3D_obraz boolean podpora 3D zobrazovania
     */
    public TelkaPlazma(int paCena, int paUhlopriecka, boolean paZapnuty, boolean pa3D_obraz) {
        super(paCena, paUhlopriecka, paZapnuty);
        a3D_obraz = pa3D_obraz;
    }
    
    /**
     * Parametricky konstruktor - pretazeny
     * 
     * @param paCena int cena televizora
     * @param paUhlopriecka int rozmer uhlopriecky
     * @param pa3D_obraz boolean podpora 3D zobrazovania
     */
    public TelkaPlazma(int paCena, int paUhlopriecka, boolean pa3D_obraz) {
        super(paCena, paUhlopriecka);
        a3D_obraz = pa3D_obraz;
    }
    
    @Override
    public String vypis(){
        String tvInfo = String.format("%s %n", "Plazmovy televizor");
        tvInfo += String.format("%s", super.vypis() ); // volanie rodicovskej metody vypis
        tvInfo += String.format("%20s %s %n", "3D obraz: ", (a3D_obraz ? "Podporovany" : "Nie") );
        return tvInfo;
    }
    
    @Override
    public String toString(){
        return vypis();
    }
    
    @Override
    public String zapisData() throws IOException{
        String tvInfo = "";
        tvInfo += " " + TelkaPlazma.class.getName();
        tvInfo += super.zapisData(); // volanie rodicovskej metody zapisData
        tvInfo += super.isZapnuty();
        tvInfo += String.format("%n");
        tvInfo += a3D_obraz;
        tvInfo += String.format("%n");
        return tvInfo;
    }
}
