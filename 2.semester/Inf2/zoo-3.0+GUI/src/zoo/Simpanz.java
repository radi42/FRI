package zoo;

import java.io.Serializable;

 

/**
 * <h2>Trieda Simpanz</h2>
 * Papagaj je potomkom triedy Zivocich, je jeho specializaciou.
 * Z triedy Zivocich dedi vsetky metody a vnutorny stav (atributy),
 * ktory je pristupny ale len cez pristupove metody.
 * 
 * @author bene
 * @version 14.3.2012
 */
public class Simpanz extends Zivocich implements Prepravitelny, Serializable {
    //---------------------------------------- Atributy instancie --
    private boolean cviceny;
    private double vaha;
    
    /**
     * Konstruktor pre instancie triedy Simpanz
     */
    public Simpanz(double vaha, boolean cviceny) {
        super("Simpanz", "Klietka");
        this.vaha = vaha;
        this.cviceny = cviceny;
    }

    public double dajVahu(){
        return vaha;
    }
    
    public boolean dajCviceny(){
        return cviceny;
    }
    
    public void nastavVahu(double vaha){
        this.vaha = vaha;
    }
    
    public void nastavCviceny(boolean cvic){
        this.cviceny = cvic;
    }
    
    @Override
    public double poziadavkaObjemu() {
        return 20;
    }
    
    public double poziadavkaVahy(){
        return dajVahu() + 40;
    };    
    
    @Override
    public String toString(){
        String str = (cviceny ? "" : "ne") + "cviceny.";
        return super.toString()
             + String.format(", vaha: %.1f kg, %s)", dajVahu(), str);
    }

}
