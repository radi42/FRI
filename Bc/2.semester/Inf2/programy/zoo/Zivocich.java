package zoo;

import lib.Datum;
/**
 * Trieda Zivocich
 * 
 * @author Andrej Sisila
 * @version v3.11.2014
 */
public class Zivocich
{
    protected String nazovDruhu;
    protected String umiestnenie;
    protected Datum datNar;

    /**
     * Konstruktor - plny
     */
    public Zivocich(String nazovDruhu, String umiestnenie, Datum datNar){
        this.nazovDruhu = nazovDruhu;
        this.umiestnenie = umiestnenie;
        this.datNar = datNar;
    }

    /**
     * Konstruktor - testovaci - pretazeny
     */
    public Zivocich(String nazovDruhu, String umiestnenie){
        this(nazovDruhu, umiestnenie, null);
    }

    //Gettery

    public String getNazovDruhu() {return nazovDruhu;}
    public String getUmiestnenie() {return umiestnenie;}
    public Datum getDatNar() {return datNar;}

    //Settery

    public void setNazovDruhu(String nazovDruhu) {this.nazovDruhu = nazovDruhu;}
    public void setUmiestnenie(String umiestnenie) {this.umiestnenie = umiestnenie;}
    public void setDatum(Datum datNar) {this.datNar = datNar;}

    /**
     * toString
     * vypis vlastnost
     */
    public String toString(){
//     return 
//         nazovDruhu 
//         + " Datum narodenia: "
        String prvaCast = "";
        prvaCast = String.format("%-11s, %s", nazovDruhu, "Datum narodenia ");
        prvaCast += (datNar == null ? "neuvedeny" : datNar)
        + " Umiestnenie: " + umiestnenie;
        return prvaCast.replace(",", " ");
    }
}
