package zoo;


/**
 * Write a description of class Papagaj here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Papagaj extends Zivocich
{
    //farba, vaha, meno
    /**
     * Atributy su typu "protected" - pristupne maximalne v ramci balicka
     */
    protected String farba;
    protected double vaha;
    protected boolean cviceny;
    
    /**
     * Konstruktor
     * dedi konstruktor triedy zivocich
     */
    public Papagaj(String farba, double vaha, boolean cviceny){
        //ako sa prikazom 'this' pristupuje k atributon triedy, tak sa prikazom 'super' vola konstruktor
        //nadradenej (rodicovskej) triedy
        super("Papagaj", "Pavilon Pauchov"); //Cast konstruktora Simpanza tvori konstruktor
        this.farba = farba;
        this.vaha = vaha;
        this.cviceny = cviceny;
    }
    
    //Gettery
    public String getFarba(){return farba; }
    public double getVaha(){return vaha; }
    public boolean jeCviceny(){return cviceny; }
    
    //Settery
    public void setFarba(String farba){this.farba = farba;; }
    public void setVaha(double vaha){this.cviceny = cviceny; }
    public void setCviceny(boolean cviceny){this.vaha = vaha;; }
    
    /**
     * metoda toString
     */
    @Override
    public String toString(){
        return super.toString()
            + ", Vaha: " + String.format("%.1f", getVaha() ) + " kg, "
            + getFarba() 
            + (cviceny ? "" : "ne") + "cviceny.";
    }
}
