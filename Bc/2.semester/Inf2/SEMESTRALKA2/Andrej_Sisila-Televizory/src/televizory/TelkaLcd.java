package televizory;

import java.io.IOException;
/**
 *
 * @author Andy
 */
public class TelkaLcd extends Telka{
    
    private boolean aLedkovy;

    public TelkaLcd(int paCena, int paUhlopriecka, boolean paZapnuty, boolean paLedkovy) {
        super(paCena, paUhlopriecka, paZapnuty);
        aLedkovy = paLedkovy;
    }
    
    public TelkaLcd(int paCena, int paUhlopriecka, boolean paLedkovy) {
        super(paCena, paUhlopriecka);
        aLedkovy = paLedkovy;
    }
    
    @Override
    public String vypis(){
        String tvInfo = String.format("%s %n", "LCD Televizor");
        tvInfo += String.format("%s", super.vypis() );
        tvInfo += String.format("%20s %s %n", "LED LCD ", (aLedkovy ? "Ano" : "Nie") );
        return tvInfo;
    }
    
    @Override
    public String toString(){
        return vypis();
    }
    
//    public String zapisTxt2(){
//        String tvInfo = "";
//        tvInfo += " " + TelkaLcd.class.getName().replace("televizory.", "");
//        tvInfo += " " + super.zapisTxt2();
//        tvInfo += " " + aLedkovy;
//        tvInfo += String.format("%n");
//        return tvInfo;
//    }
    
    public String zapisData() throws IOException{
        String tvInfo = "";
//        tvInfo += " " + TelkaLcd.class.getName().replace("televizory.", "");
        tvInfo += " " + getClass().getName();
        tvInfo += super.zapisData();
        
        tvInfo += aLedkovy;
        tvInfo += String.format("%n");
        return tvInfo;
    }
}
