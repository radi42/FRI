import java.util.ArrayList;
import javax.swing.JOptionPane;
/**
 * Vytvor dvojice 20 ziakov
 * Nezalezi na tom, ci je ziak A so ziakom B alebo ziak B so ziakom A, nezalezi na ich umiestneni v rade
 * 
 * @author Anrej Sisila
 *  @version v1.0
 */
public class Ziaci
{
    private int pocZiak;
    private ArrayList <Dvojica> dvojiceZiakov; //pole dvojic zo ziakov
    private Dvojica dvojica;

    /**
     * Parametricky konstruktor
     * @param pocZiak datovy typ int, nastavuje pocet ziakov na celociselnu hodnotu
     */
    public Ziaci(int pocZiak) {
        this.pocZiak = pocZiak;
        dvojiceZiakov = new ArrayList <Dvojica>(); //vytvori sa pole Dvojic
    }

    public Ziaci() {
        this.pocZiak = 999;
        dvojiceZiakov = new ArrayList <Dvojica>();
    }
    
    //metoda zistuje pocet ziakov
    public int getPocetZiakov(){
        return pocZiak;
    }
    
    
    //metoda nastavuje pocet ziakov
    public void setPocetZiakov(int pocZiak){
        if(pocZiak >= 2){
            this.pocZiak = pocZiak;
        }else{
            JOptionPane.showMessageDialog(null,
                "Zaporny pocet osob je nezmysel. Zadajte kladnu hodnotu ziakov (najmenej 2)",
                "Inane dialog",
                JOptionPane.ERROR_MESSAGE);
        }
    }
    
    //metoda naplna pole ziakov cislami; kazde cislo reprezentuje jedneho ziaka
    //prvy z dvojice ma index i, druhy index j
    private void naplnDvojiceZiakmi(){        
            int pocet = 0;

            for(int i = 0; i < pocZiak; i++){
                for(int j = 0; j < pocZiak; j++){
                    if(i > j || i==j){
                        continue;
                    }else{
                        dvojiceZiakov.add(new Dvojica(i+1, j+1));
                        System.out.println(dvojiceZiakov.get(pocet) );
                        pocet++;
                    }
                }
            }
            System.out.println("Pocet opakovani cyklu: " + pocet);
            System.out.println("Existuje " + pocet + " rieseni" );
    }
    
    //vytvorit si pole ktore bude obsahovat dvojice
    public String toString() {
        naplnDvojiceZiakmi();
        return "";
    }
}
