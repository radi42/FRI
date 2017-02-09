import javax.swing.JOptionPane;
/**
 * Trieda Stanica
 * podava informacie o vlastnostiach stanice a cestujucich
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Stanica
{
    private String nazov;       //nazov stanice - podla mesta
    private int pocetNastupuj;  //nastupujuci cestujuci
    private int pocetVystupuj;  //vystupujuci cestujuci
    private int pocetCestuj;    //celkovy pocet cestujucich vo vlaku
    private Cas cas;            //kedy prisiel vlak na stanicu
    //private int kapacita;
    
    
    public Stanica(String nazov, Cas cas){
        this.nazov = nazov;
        this.cas = cas;
    }
    
    
    public Stanica(String nazov, int pocetNastupuj, int pocetVystupuj, int pocetCestuj, Cas cas){
        this.nazov = nazov;
        this.pocetNastupuj = pocetNastupuj;
        this.pocetVystupuj = pocetVystupuj;
        this.pocetCestuj = pocetCestuj;
        this.cas = cas;
    }
    
    //gettery
    public String getNazov(){
        return nazov;
    }
    
    public int getPocetNastupuj(){
        return pocetNastupuj;
    }
    
    public int getpocetVystupuj(){
        return pocetVystupuj;
    }
    
    public int getPocetCestuj(){
        return pocetCestuj;
    }
    
    public Cas getCas(){
        return cas;
    }
    
    //settery
    public void setNazov(String nazov){
        this.nazov = nazov;
    }
    
    public void setPocetNastupuj(int pocetNastupuj){
        this.pocetNastupuj = pocetNastupuj;
    }
    
    public void setPocetVystupuj(int pocetVystupuj){
        this.pocetVystupuj = pocetVystupuj;
    }
    
    public void setPocetCestuj(int pocetCestuj){
        this.pocetCestuj = pocetCestuj;
    }
    
    public void setCas(Cas cas){
        this.cas = cas;
    }
    
    // metody
    //uprav pocet nastupujucich
    public void nastup(int pocetNastupuj){
        pocetCestuj += pocetNastupuj;
        this.pocetNastupuj = pocetNastupuj;
    }
    
    //uprav pocet cestujucich pri vystupovani
    public void vystup(int pocetVystupuj){
        if(pocetCestuj >= pocetVystupuj){
            this.pocetVystupuj = pocetVystupuj;
        }else{
            JOptionPane.showMessageDialog(null,
            "Nemoze vystupit viac ako je celkovy pocet cestujucich!",
            "Inane dialog",
            JOptionPane.ERROR_MESSAGE);
        }
    }
    
    //prekryta metoda toString
    public String toString(){
        return "Vitajte na stanici " + getNazov() + ". Nastupilo " + getPocetNastupuj() + " cestujucich, "
        + "vystupilo " + getpocetVystupuj() + " cestujucich. Vo vlaku sa teraz nachadza "
        + getPocetCestuj() + " cestujucich";
    }
}
