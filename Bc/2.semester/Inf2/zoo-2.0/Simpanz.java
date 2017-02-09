  

/**
 * <h2>Trieda Papagaj</h2>
 * Papagaj je potomkom triedy Zivocich, je jeho specializaciou.
 * Z triedy Zivocich dedi vsetky metody a vnutorny stav (atributy),
 * ktory je pristupny ale len cez pristupove metody.
 * 
 * @author bene
 * @version 14.3.2012
 */
public class Simpanz extends Zivocich implements Prepravitelny
{
    //================================================ Atributy instancie ==
    private String meno;    // meno simpanza
    private boolean cviceny;
    private double vaha;
    
    //====================================================== Konstruktory ==
    /**
     * Konstruktor pre instancie triedy Simpanz
     */
    public Simpanz(double vaha, boolean cviceny) {
        super("Simpanz", "Klietka");
        this.vaha = vaha;
        this.cviceny = cviceny;
    }

    //================================================= Metody instancie ==
    //
    //------------------------------------------------ Gettery a Settery --
    public double dajVahu(){ return vaha; }
    
    public boolean dajCviceny(){ return cviceny; }
    
    public void nastavVahu(double vaha){ this.vaha = vaha; }
    
    public void nastavCviceny(boolean cvic){ this.cviceny = cvic; }
    
    public double poziadavkaObjemu(){ return 50*getPocetKoncatin(); };
    
    public double poziadavkaVahy(){ return dajVahu(); };    

    //------------------------------------------------ Metody instancie --
    /**
     * Textova infomacia o instancii simpanza
     * @return text informacie
     */
    @Override
    public String toString(){
        return super.toString()
             + " vaha: " + String.format("%.1f, kg, ", dajVahu())
             + (cviceny ? "" : "ne") + " cviceny.";
    }
}
