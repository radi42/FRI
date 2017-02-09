
/**
 * Trieda postupnosti
 * vsetky postupnosti jednotiek so zvyskom 0
 * 
 * @author Anrej Sisila
 * @version v1.0
 */
public class Potupnosti
{
    private int pocJedn; //pocet jednotiek    
    
    public Potupnosti(int pocJedn) {
        this.pocJedn = pocJedn;
    }
    
    public Potupnosti() {
        this.pocJedn = 20;
    }
    
    public String toString() {
        int pocet = 0; //nastavime pocet opakovani na 0
        String s = "0"; //do tejto premennej ukladame vsetky kombinacie postupnosti
        
        for(int i = 0; i < pocJedn; i++) {
            s = "1" + s;
            System.out.println(s);
            pocet++;
        }
        //System.out.println("Pocet opakovani: " + pocet);
        return "";
    }
}
