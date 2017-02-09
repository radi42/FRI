
/**
 * Trieda Main
 * Vypisuje vsetky potrebne kombinacie dvojic medzi ziakmi
 * 
 * @author Andrej Sisila
 * @version v1.0
 */
public abstract class Main
{
    static Ziaci schueler;
    
    private static void vypis(String s){
        System.out.print(s);
    }
    
    public static void main(String[] args) {
        schueler = new Ziaci(); //vytvorime novu instanciu triedy Ziaci bezparametrickym konstruktorom
        //ktoru priradime referencnej premennej
        vypis(schueler.toString() ); //nechame vypisat prepisanu metodu toString v triede 
    }
}
