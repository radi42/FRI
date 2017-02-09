package zoo;


/**
 * Trieda Papagaj
 * 
 * vlastnosti papagaja
 * @author Andrej Sisila 
 * @version v3.18.2014
 */

//final v signature triedy znamena, ze sa z triedy neda dedit
public final class Papagaj extends Zivocich implements Prepravitelny
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
    
    //metody
    /**
     * metoda poziadavka objemu je len ilustracny priklad
     * @return objem zvierata
     */ 
    @Override
    public double poziadavkaObjemu() {
        return 20;
    }

    /**
     * 
     * @return vracia vahu celkovo tj. vahova rezerva + klietka
     */
    @Override
    public double poziadavkaVahy() {
        return getVaha();
    }
    
    /**
     * metoda toString
     */
    @Override
    public String toString(){
        return super.toString()
            + ", Vaha: " + String.format("%.1f", getVaha() ) + " kg, "
            + getFarba() + ", "
            + (cviceny ? "" : "ne") + "cviceny.";
    }
}
