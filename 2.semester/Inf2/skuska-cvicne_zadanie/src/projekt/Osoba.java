package projekt;

/**
 *
 * @author Andy
 */
public class Osoba implements IVykonnostnySportovec{

    private int aRokNarodenia;
    private String aMeno;

    public Osoba(int paRokNarodenia, String paMeno) {
        aRokNarodenia = paRokNarodenia;
        aMeno = paMeno;
    }

    public int getRokNarodenia() {
        return aRokNarodenia;
    }

    public void setRokNarodenia(int aRokNarodenia) {
        this.aRokNarodenia = aRokNarodenia;
    }

    public String getMeno() {
        return aMeno;
    }

    public void setMeno(String aMeno) {
        this.aMeno = aMeno;
    }

    

    
    
    @Override
    public int vykonnostnaTrieda() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String zapisDoSuboru() {
        String info = "";
        info += String.format("%s %n", aMeno);
        info += String.format("%d", aRokNarodenia);
        return info;
    }

    @Override
    public String vypis() {
        String vypis = "";
        vypis += aMeno + ", nar. " + aRokNarodenia + ", ";
        return vypis;
    }
    
}
