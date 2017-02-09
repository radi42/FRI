
/**
 * Student
 * 
 * @author Andrej Sisila
 * @version v1.0
 */
public class Student
{
    private Osoba clovek; //asociacia - priradenie vopred vytvorenej triedy atributu
    private Predmet[] predmety;
    private String odbor; //zatial String
    private int rocnik; // datum 
    private int pocetPredmetov; 
    
    /**
     * Konstruktor Parametricky
     */
    public Student (Osoba clovek, String odbor, int rocnik){
        this.clovek = clovek;
        this.odbor = odbor;
        this.rocnik = rocnik;
        pocetPredmetov = 0;
    }
    
    /**
     * Konstruktor Menej parametrov - bez rocnika
     */
    public Student (Osoba clovek, String odbor){
        this(clovek, odbor, 0);
    }
    
    
    /**
     * Gettery
     */
    public Osoba getClovek() {
        return clovek;
    }
    
    public String getOdbor() {
        return odbor;
    }
    
    public int getRocnik() {
        return rocnik;
    }
    
    
    /**
     * Settery
     */
    public void setOdbor(String odbor) {
        this.odbor = odbor;
    }
    
    public void setRocnik(int rocnik) {
        this.rocnik = rocnik;
    }
    
    
    
    
    
    /**
     * Predmety studenta
     */
    
    /**
     * Gettery
     */
    public Predmet get(int index) {
        //existuje student na danom indexe?
        if (index < 0 && index >= pocetPredmetov) {
            Predmet predmetBackup = predmety[index];
            return predmety[index];
        }
        return null;
    }
    
    public int getPocetPredmetov() {
        return pocetPredmetov;
    }
    
    /**
     * Setter
     */
    public boolean set(int index, Predmet pr) {
        if (index < 0 && index >= pocetPredmetov) {
            return false;
        }
        else {
            predmety[index] = pr;
            return true;
        }
    }
    /**
     * Metody
     */
    //Pridaj predmet
    public boolean add(Predmet pr) {
       if (pocetPredmetov < 0 && pocetPredmetov >= predmety.length) {
           predmety[pocetPredmetov++] = pr; //pocet studentov sa zmeni az PO vykonani tohto prikazu
           return true;
        }
        else {
            return false;
        }
    }
    
    //Vymaz predmet
    public boolean delete(int index) {
        if (index < 0 && index >= pocetPredmetov) {
            //kazdeho studenta presun o jeden index dozadu od danej hodnoty
            predmety[index] = null; //pocet studentov sa zmeni az PO vykonani tohto prikazu       
            pocetPredmetov--;
        
            int pozicia = index; //vytvorim si pocitadlo pesniciek
            for (int i = index; i < predmety.length -1; i++) {
               predmety[i] = predmety[i+1];
            }
            return true;
        }
        else {
            return false;
        }
        
    }
    
    /**
     * Pretazena toString metoda
     */
    public String  toString() {
        String s = clovek + " -student odboru: " + odbor + " ";
        s += (rocnik == 0)  ? ("este nestuduje") : (rocnik + ". rocnik");
        return s;
        //return ("Osoba - podrobnosti: " + clovek.getMeno() + " " + clovek.getPriezvisko() );
    }
}