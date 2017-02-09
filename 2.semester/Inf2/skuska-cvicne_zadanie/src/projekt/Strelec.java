package projekt;

/**
 *
 * @author Andy
 */
public class Strelec extends Osoba{

    private int aNastrel;

    public Strelec(int paRokNarodenia, String paMeno, int paNastrel) {
        super(paRokNarodenia, paMeno);
        aNastrel = paNastrel;
    }

    public int getaNastrel() {
        return aNastrel;
    }

    public void setaNastrel(int aNastrel) {
        this.aNastrel = aNastrel;
    }
    
    @Override
    public int vykonnostnaTrieda() {
        if(getaNastrel() <= 100 && getaNastrel() >= 96){
            return 1;
        }
        if(getaNastrel() <= 95 && getaNastrel() >= 91){
            return 2;
        }
        if(getaNastrel() <= 90 && getaNastrel() >= 86){
            return 3;
        }
        else{
            return 0;
        }
    }
    
    @Override
    public String zapisDoSuboru() {
        String infoS = "";
        infoS += String.format("%s %n", "strelec");
        infoS += String.format("%d %n", aNastrel);
        infoS += super.zapisDoSuboru();
        return infoS;
    }
    
    @Override
    public String vypis() {
        String vypisS = "";
        vypisS += super.vypis();
        vypisS += "strelec, " + "nastrel " + aNastrel + " bodov";
        return vypisS;
    }
}
