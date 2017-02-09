package projekt;

/**
 *
 * @author Andy
 */
public class Turista extends Osoba{

    private int aPrejdeneKm;
    
    public Turista(int paRokNarodenia, String paMeno, int paPrejdeneKm) {
        super(paRokNarodenia, paMeno);
        aPrejdeneKm = paPrejdeneKm;
    }

    public int getaPrejdeneKm() {
        return aPrejdeneKm;
    }

    public void setaPrejdeneKm(int aPrejdeneKm) {
        this.aPrejdeneKm = aPrejdeneKm;
    }
    
    @Override
    public int vykonnostnaTrieda() {
        if(2014 - super.getRokNarodenia() < 35){
            if(getaPrejdeneKm() > 200){
                return 1;
            }
            if(getaPrejdeneKm() <= 200 && getaPrejdeneKm() > 100){
                return 2;
            }
            else{
                return 0;
            }
        }
        
        else{
            if(getaPrejdeneKm() > 100){
                return 1;
            }
            if(getaPrejdeneKm() <= 100 && getaPrejdeneKm() > 50){
                return 2;
            }
            else{
                return 0;
            }
        }
    }
    
    @Override
    public String zapisDoSuboru() {
        String infoT = "";
        infoT += String.format("%s %n", "turista");
        infoT += String.format("%d %n", aPrejdeneKm);
        infoT += super.zapisDoSuboru();
        return infoT;
    }
    
    @Override
    public String vypis() {
        String vypisT = "";
        vypisT += super.vypis();
        vypisT += "turista, " + "presiel " + aPrejdeneKm + " km";
        return vypisT;
    }
}
