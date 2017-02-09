package zoo;


/**
 * Trieda Slon
 * 
 * vlastnosti slona
 * @author Andrej Sisila 
 * @version v3.18.2014
 */
public class Slon extends Zivocich
{
    //dlzka chobota, vaha
    protected double dlzkaChobota;
    protected double vaha;
    protected boolean cviceny;
    
    public Slon(double dlzkaChobota, double vaha, boolean cviceny){
        super("Slon", "Pavilon Indo-Africky");
        this.dlzkaChobota = dlzkaChobota;
        this.vaha = vaha;
        this.cviceny = cviceny;
    }
    
    //gettery
    public double getDlzkaChobota(){return dlzkaChobota;}
    public double getVaha(){return vaha;}
    public boolean getCviceny(){return cviceny;}
    
    //settery
    public void setDlzkaChobota(double dlzkaChobota){this.dlzkaChobota = dlzkaChobota;}
    public void setVaha(double vaha){this.vaha = vaha;}
    public void setCviceny(boolean cviceny){this.cviceny = cviceny;}
    
    public String toString(){
        return super.toString() 
            + ", Vaha: " + String.format("%.1f", getVaha() ) + " kg,"
            + (cviceny ? "" : "ne") + "cviceny.";
    }
}
