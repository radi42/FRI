
/**
 * Trieda Postupnosti
 * vsetky postupnosti jednotiek so zvyskom 0; predpokladam, ze nula je len jedna a len na konci
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
            s = "1" + s; //vzdy pridavame jednotky pred nulu
            System.out.println(s);
            pocet++;
        }
        //System.out.println("Pocet opakovani: " + pocet);
        return "";
    }
}
