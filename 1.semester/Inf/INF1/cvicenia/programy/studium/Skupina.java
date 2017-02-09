
/**
 * Write a description of class Skupina here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Skupina
{
    private Student[] studenti; //pole udajoveho typu Student! - zoznam studentov //mozno deklarovat ako private ArrayList<Student>
    private int pocetStud; //pocet studentov
    //private String odbor;
    private String nazovKruzku;
   
    //public Skupina (int kapacitaStudentov, String odbor, String nazovKruzku) {
    public Skupina (int kapacitaStudentov, String nazovKruzku) {
       studenti = new Student [kapacitaStudentov];
       pocetStud = 0;
       //this.odbor = odbor;
       this.nazovKruzku = nazovKruzku;
    }
    
    
    //Gettery
    
    public int size() {
        return pocetStud;
    }
    
    public String getNazovKruzku() {
        return nazovKruzku;
    }
    
    public int getPocetStud() {
        return pocetStud;
    }
    
    public Student get(int index) {
        //existuje student na danom indexe?
        if (index < 0 && index >= pocetStud) {
            Student studentBackup = studenti[index];
            return studenti[index];
        }
        return null;
    }
    
    //Settery
    
    public void setNazovKruzku(String nazovKruzku) {
        this.nazovKruzku = nazovKruzku;
    }
    
    public boolean set(int index, Student st) {
        if (index < 0 && index >= pocetStud) {
            return false;
        }
        else {
            studenti[index] = st;
            return true;
        }
    }
    
    //Metody
    
    //pri pridavani studenta testovat naplnenost pola - ak kapacita je prekrocena, 
    public boolean add(Student st) {
       if (pocetStud >= 0 && pocetStud < studenti.length) {
           studenti[pocetStud++] = st; //pocet studentov sa zmeni az PO vykonani tohto prikazu
           return true;
        }
        else {
            return false;
        }
    }
    
    public boolean delete(int index) {
        if (index < 0 && index >= pocetStud) {
            //kazdeho studenta presun o jeden index dozadu od danej hodnoty
            studenti[index] = null; //pocet studentov sa zmeni az PO vykonani tohto prikazu       
            pocetStud--;
        
            int pozicia = index; //vytvorim si pocitadlo pesniciek
            for (int i = index; i < studenti.length -1; i++) {
               studenti[i] = studenti[i+1];
            }
            return true;
        }
        else {
            return false;
        }
    }
    
    public String toString() {
        String s = "";
            if (pocetStud > 0) {
                switch (pocetStud) {
                    case 1:
                        s = " student)"; break;
                    case 2: case 3: case 4:
                        s = " studenti)"; break;
                    default:
                        s = " studentov";
                }
                
                for (int i = 0; i < pocetStud; i++) {
                    s = s + "\n-- " + (i+1) + "\n-- " + studenti[i];
                }
            }
        return "Skupina: " + nazovKruzku + ", (" + (pocetStud == 0 ? "zatial bez studentov)" : pocetStud + s );
    }
}