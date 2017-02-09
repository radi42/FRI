package zoo;


/**
 * Trieda Had
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Had extends Zivocich
{
    protected double dlzka;
    protected double vaha;
    protected boolean jedovaty;
    
    /**
     * Konstruktor
     */
    public Had(double dlzka, double vaha, boolean jedovaty){
        super("Had", "Hadi Pavilon");
        this.dlzka = dlzka;
        this.vaha = vaha;
        this.jedovaty = jedovaty;
    }
    
    //gettery
    public double getDlzka(){
        return dlzka;
    }
    
    public double getVaha(){
        return vaha;
    }
    
    public boolean getJedovaty(){
        return jedovaty;
    }
    
    //settery
    public void setDlzka(double dlzka){
        this.dlzka = dlzka;
    }
    
    public void setVaha(double vaha){
        this.vaha = vaha;
    }
    
    public void setJedovaty(boolean jedovaty){
        this.jedovaty = jedovaty;
    }
    
    /**
     * prekryty toString
     */
    public String toString(){
        return super.toString()
            + ", Vaha: " + String.format("%.1f", getVaha() ) + " kg, "
            + "Dlzka: " + String.format("%.1f", getDlzka() ) + " cm, "
            + (jedovaty ? "" : "ne") + "jedovaty.";
    
    }
}
