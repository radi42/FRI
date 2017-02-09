package zoo;
import java.io.Serializable;
import lib.*;

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
public final class Papagaj extends Zivocich implements Prepravitelny, Serializable
{
    //---------------------------------------- Atributy instancie --
    private String aMeno;    // meno papagaja
    private double aVaha;    // vaha papagaja
    private String aFarba;   // farba bude vyjadrena nazvom farby

    /**
     * Konstruktor nastavi 
     */
    // zivocich si v konstruktore pyta int pocet
    // papagaj ma 2 atributy: vaha a farba
    // vstupy do konstruktora budu vsetky 3
    public Papagaj(String paMeno, Datum paDatNar, double paVaha, String paFarba) {
        super("Papagaj", "Voliera", paDatNar);   // volanie konstruktora predka
        this.aMeno = paMeno;    // nastavenie nazvu zivocicha
        this.aFarba = paFarba;  // nastavenie farby
        this.aVaha = paVaha;    // nastavenie vahy
    }

    public double dajVahu(){
        return aVaha;
    }

    public String dajFarbu(){
        return aFarba;
    }

    public void nastavVahu(double vaha){
        this.aVaha = vaha;
    }

    public void nastavFarbu(String farba){
        this.aFarba = farba;
    }

    @Override
    public double poziadavkaObjemu() {
        return 10;
    }

    public double poziadavkaVahy(){
        return dajVahu();
    }

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
