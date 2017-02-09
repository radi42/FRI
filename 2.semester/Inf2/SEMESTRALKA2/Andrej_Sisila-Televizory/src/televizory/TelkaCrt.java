package televizory;

import java.io.IOException;

/**
 *
 * @author Andy
 */
public class TelkaCrt extends Telka{

    private boolean aStereo; //ma televizor jeden alebo dva repraky
    
    public TelkaCrt(int paCena, int paUhlopriecka, boolean paZapnuty, boolean paStereo) {
        super(paCena, paUhlopriecka, paZapnuty);
        aStereo = paStereo;
    }
    
    public TelkaCrt(int paCena, int paUhlopriecka, boolean paStereo) {
        super(paCena, paUhlopriecka);
        aStereo = paStereo;
    }
    
    @Override
    public String vypis(){
        String tvInfo = String.format("%s %n", "CRT Televizor");
        tvInfo += String.format("%s", super.vypis() );
        tvInfo += String.format("%20s %s %n", "Stereo ", (aStereo ? "Ano" : "Nie") );
        return tvInfo;
    }
    
    @Override
    public String toString(){
        return vypis();
    }
    
//    public String zapisTxt2(){
//        String tvInfo = "";
//        tvInfo += " " + TelkaCrt.class.getName().replace("televizory.", "");
//        tvInfo += " " + super.zapisTxt2();
//        tvInfo += " " + aStereo;
//        tvInfo += String.format("%n");
//        return tvInfo;
//    }
    
    public String zapisData() throws IOException{
        String tvInfo = "";
//        tvInfo += " " + TelkaCrt.class.getName().replace("televizory.", "");
        tvInfo += " " + getClass().getName();
        tvInfo += super.zapisData();
        tvInfo += aStereo;
        tvInfo += String.format("%n");
        return tvInfo;
    }
}
