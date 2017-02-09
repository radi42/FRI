/**
 * pouzivame projekt (subor) Datum.java, ktory sa nachadza v hlavnom priecinku projektu studium
 */
/**
 * Studijne skupiny
 * 
 * @author Andrej Sisila
 * @version v1.0
 */
public class Osoba
{
    /**
     * Atributy triedy
     * meno, priezvisko - String
     * datumNar - Datum - vyuzijeme triedu, ktoru sme naprogramovali v minulosti
     */
    private String meno;
    private String priezvisko;
    private Datum datumNar;
    private String bydlisko;
    
    /**
     * Parametricky konstruktor
     */
    public Osoba (String meno, String priezvisko, Datum datumNar, String bydlisko) {
        this.meno = meno;
        this.priezvisko = priezvisko;
        this.datumNar = datumNar;
        this.bydlisko = bydlisko;
        datumNar = new Datum(datumNar.getDen(), datumNar.getMesiac(), datumNar.getRok() );
    }
    
    /**
     * Konstruktor bezparametricky
     */
    public Osoba () {
        this("Milan", "Nagy", new Datum (4, 6, 1994), "");
    }
        
    //konstruktory + gettery + settery
    
    /**
     * Gettery
     */
    public String getMeno() {
        return meno;
    }
    
    public String getPriezvisko() {
        return priezvisko;
    }
    
    public String getBydlisko() {
        return bydlisko;
    }
    
    public Datum getDatumNar() {
        return datumNar;
    }
    
    
    
    /**
     * Settery
     */
    public void setMeno(String meno) {
        this.meno = meno;
    }
    
    public void setPriezvisko(String priezvisko) {
        this.priezvisko = priezvisko;
    }
    
    public void getBydlisko(String bydlisko) {
        this.bydlisko = bydlisko;
    }
    
    public void setDatum(Datum datumNar) {
        this.datumNar = datumNar;
    }
    
    /**
     * Pretazena metoda toString
     */
    public String toString() {
        return "Detaily osoby: " + meno + " " + priezvisko + " " + datumNar;
    }
}