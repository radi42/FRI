  

/**
 * <h2>Trieda Papagaj</h2>
 * Papagaj je potomkom triedy Zivocich, je jeho specializaciou.
 * Klucove slovo final v deklaracii triedy oznacuje,
 * ze tato trieda nemoze mat viac potomkov.
 * Z triedy Zivocich dedi vsetky metody a vnutorny stav (atributy),
 * ktory je pristupny ale len cez pristupove metody.
 * 
 * @author bene
 * @version 14.3.2012
 */
public final class Papagaj extends Zivocich  implements Prepravitelny        
{
    //---------------------------------------- Atributy instancie --
    private String meno;    // meno papagaja
    private double vaha;    // vaha papagaja
    private String farba;   // farba bude vyjadrena nazvom farby

    /**
     * Konstruktor nastavi 
     */
    // zivocich si v konstruktore pyta int pocet
    // papagaj ma 2 atributy: vaha a farba
    // vstupy do konstruktora budu vsetky 3
    public Papagaj(String meno, int pocetKoncatin, double vaha, String farba) {
        super("Papagaj", "Voliera", pocetKoncatin);   // volanie konstruktora predka
        this.meno = meno;    // nastavenie nazvu zivocicha
        this.farba = farba;  // nastavenie farby
        this.vaha = vaha;    // nastavenie vahy
    }

    public double dajVahu(){
        return vaha;
    }

    public String dajFarbu(){
        return farba;
    }

    public void nastavVahu(double vaha){
        this.vaha = vaha;
    }

    public void nastavFarbu(String farba){
        this.farba = farba;
    }

    public double poziadavkaObjemu(){
        return 5*KOEF_OBJEMU;
    }

    public double poziadavkaVahy(){
        return dajVahu();
    }

    //------------------------------------------------ Metody instancie --
    /**
     * Textova informacia o danej instancii
     * Vyuzijeme metodu predka toString a pridame atributy papagaja.
     * Ak by sme nenapisali super.toString, metoda by sa zacyklila
     */
    @Override       // prekrytie danej metody predka
    public String toString() {
        return super.toString()
             + " vaha: " + String.format("%.1f kg,", dajVahu())
             + " farba: " + dajFarbu() + ".";
    }
}
