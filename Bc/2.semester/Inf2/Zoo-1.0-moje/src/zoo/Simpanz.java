package zoo;


/**
 * Trieda Simpanz
 * 
 * Trieda, ktora dedi z triedy Zivocich vsetky atributy a metody
 * Je specializaciou triedy zivocich
 * @author Andrej Sisila
 * @version 3.13.2014
 */

//hlavicka triedy na rozsirenie triedy Simpanz o triedu Zivocich
//extends sluzi ako prikaz dedenia z urcitej triedy

public class Simpanz extends Zivocich implements Prepravitelny
{
    /**
     * Atributy su typu "protected" - pristupne maximalne v ramci balicka
     */
    protected boolean cviceny;
    protected double vaha;
    
    /**
     * Konstruktor
     * dedi konstruktor triedy zivocich
     */
    public Simpanz(double vaha, boolean cviceny){
        //ako sa prikazom 'this' pristupuje k atributon triedy, tak sa prikazom 'super' vola konstruktor
        //nadradenej (rodicovskej) triedy
        super("Simpanz", "Pavilon 1"); //Cast konstruktora Simpanza tvori konstruktor 
        this.vaha = vaha;
        this.cviceny = cviceny;
    }
    
    //Gettery
    public boolean jeCviceny(){return cviceny; }
    public double getVaha(){return vaha; }
    
    //Settery
    public void setCviceny(boolean cviceny){this.vaha = vaha;; }
    public void setVaha(double vaha){this.cviceny = cviceny; }
    
    //metody
    /**
     * metoda poziadavka objemu je len ilustracny priklad
     * @return objem zvierata
     */ 
    @Override
    public double poziadavkaObjemu() {
        return 50;
    }

    /**
     * 
     * @return vracia vahu celkovo tj. vahova rezerva + klietka
     */
    @Override
    public double poziadavkaVahy() {
        return getVaha() + 40;
    }
    /**
     * metoda toString
     */
    @Override
    public String toString(){
        return super.toString()
            + ", Vaha: " + String.format("%.1f", getVaha() ) + " kg, "
            + (cviceny ? "" : "ne") + "cviceny.";
    }
}
