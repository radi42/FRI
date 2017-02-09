package televizory;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;

/**
 *
 * @author Andy
 */
public class TelkaPlazma extends Telka{
    
    private boolean a3D_obraz; //podporuje telvizor trojrozmerne zobrazovanie?

    public TelkaPlazma(int paCena, int paUhlopriecka, boolean paZapnuty, boolean pa3D_obraz) {
        super(paCena, paUhlopriecka, paZapnuty);
        a3D_obraz = pa3D_obraz;
    }
    
    public TelkaPlazma(int paCena, int paUhlopriecka, boolean pa3D_obraz) {
        super(paCena, paUhlopriecka);
        a3D_obraz = pa3D_obraz;
    }
    
    @Override
    public String vypis(){
        String tvInfo = String.format("%s %n", "Plazmovy televizor");
        tvInfo += String.format("%s", super.vypis() );
        tvInfo += String.format("%20s %s %n", "3D obraz: ", (a3D_obraz ? "Podporovany" : "Nie") );
        return tvInfo;
    }
    
    @Override
    public String toString(){
        return vypis();
    }
    
//    public String zapisTxt2(){
//        String tvInfo = "";
//        tvInfo += " " + TelkaPlazma.class.getName().replace("televizory.", "");
//        tvInfo += " " + super.zapisTxt2();
//        
//        tvInfo += " " + a3D_obraz;
//        tvInfo += String.format("%n");
//        return tvInfo;
//    }
    
    public String zapisData() throws IOException{
        String tvInfo = "";
//        tvInfo += " " + TelkaPlazma.class.getName().replace("televizory.", "");
        tvInfo += " " + TelkaPlazma.class.getName();
        tvInfo += super.zapisData();
        
        tvInfo += a3D_obraz;
        tvInfo += String.format("%n");
        return tvInfo;
    }
}
