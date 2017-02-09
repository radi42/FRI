package lib;

/**
 *
 * @author Andrej Sisila
 */
public class Osoba {
    private String meno;
    private String priezvisko;
    private Datum datNar;

    public Osoba(String meno, String priezvisko, Datum datNar) {
        this.meno = meno;
        this.priezvisko = priezvisko;
        this.datNar = datNar;
    }

    public Osoba(String meno, String priezvisko) {
        this.meno = meno;
        this.priezvisko = priezvisko;
    }

    //Gettery
    public String getMeno() {
        return meno;
    }

    public String getPriezvisko() {
        return priezvisko;
    }
    
    public Datum getDatNar() {
        return datNar;
    }
    
    
    //Settery
    public void setMeno(String meno) {
        this.meno = meno;
    }

    public void setPriezvisko(String priezvisko) {
        this.priezvisko = priezvisko;
    }
    
    public void setDatNar(Datum datNar) {
        this.datNar = datNar;
    }

    @Override
    public String toString() {
        return "Osoba{" + "meno=" + meno + ", priezvisko=" + priezvisko + ", datNar=" + datNar + '}';
    }
}
