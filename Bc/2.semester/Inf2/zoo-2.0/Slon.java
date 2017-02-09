  

/**
 * <h2>Trieda Slon</h2>
 * Slon je potomkom triedy Zivocich, je jeho specializaciou.
 * Z triedy Zivocich dedi vsetky metody a vnutorny stav (atributy),
 * ktory je pristupny ale len cez pristupove metody.
 * 
 * @author bene
 * @version 14.3.2012
 */
public class Slon extends Zivocich
{
    //================================================ Atributy instancie ==
    private double vaha;
    private int pocetZubov;

    //====================================================== Konstruktory ==
    /**
     * Konstruktor nastavi s pociatocnymi informaciami
     */
    public Slon(double vaha, int pocetZubov) {
        super("slon", "ohrada");
        nastavPocetZubov(pocetZubov);
        nastavVahu(vaha);
    }

    //================================================= Metody instancie ==
    //
    //------------------------------------------------ Gettery a Settery --
    public double dajVahu() { return vaha; }
    
    public int dajPocetZubov() { return pocetZubov; }
    
    public void nastavVahu(double vaha) { this.vaha = vaha; }
    
    public void nastavPocetZubov(int pocetZubov){ this.pocetZubov = pocetZubov; }

    //------------------------------------------------ Metody instancie --
    /** Textova infomacia o instancii slona
     * @return text informacie
     */
    @Override
    public String toString(){
        return super.toString()
             + " vaha: " +String.format("%.1f kg,", dajVahu())
             + " pocet zubov: " + dajPocetZubov() + ".";
    }
}
