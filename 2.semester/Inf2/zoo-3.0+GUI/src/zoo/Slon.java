package zoo;

import java.io.Serializable;

 

/**
 * <h2>Trieda Slon</h2>
 * Slon je potomkom triedy Zivocich, je jeho specializaciou.
 * Z triedy Zivocich dedi vsetky metody a vnutorny stav (atributy),
 * ktory je pristupny ale len cez pristupove metody.
 * 
 * @author bene
 * @version 14.3.2012
 */
public class Slon extends Zivocich implements Serializable
{
    //---------------------------------------- Atributy instancie --
    private double vaha;
    private int dlzkaChobota;

    /**
     * Konstruktor nastavi 
     */
    public Slon(double vaha, int dlzkaChobota) {
        super("slon", "ohrada");
        setDlzkaChobota(dlzkaChobota);
        setVahu(vaha);
    }

    public double dajVahu() {
        return vaha;
    }
    
    public int dajDlzkaChobota() {
        return dlzkaChobota;
    }
    
    public void setVahu(double vaha) {
        this.vaha = vaha;
    }
    
    public void setDlzkaChobota(int dlzkaChobota){
        this.dlzkaChobota = dlzkaChobota;
    }
        
    @Override
    public String toString(){
        return super.toString()
             + " vaha: " +String.format("%.1f kg,", dajVahu())
             + " dlzka chobota: " + dajDlzkaChobota() + ".";
    }
}
