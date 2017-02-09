package televizory;

import java.io.DataOutputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

/**
 *
 * @author Andy
 */
public abstract interface ITelka {
    
    String prepniProgramNahodne();
    
    String vypis();
    
//    void zapisTxt();
//    String zapisTxt2();
//    void zapisData(DataOutputStream dis);
    String zapisData() throws IOException;
    
    
    @Override
    String toString();
    
    //gettery pre atributy
    int getCena();
    int getUhlopriecka();
    boolean isZapnuty();
    
    //settery pre atributy
    void setCena(int cena);
    void setZapnuty(boolean zapnuty);
}
