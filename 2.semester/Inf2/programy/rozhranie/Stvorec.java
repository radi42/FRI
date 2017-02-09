package rozhranie;

/**
 * Trieda Stvorec
 * 
 * implementacia interface Zobrazitelny
 * 
 * @author Andrej Sisila
 * @version 2014.3.4 yyyy.mm.dd
 */

public class Stvorec implements Zobrazitelny
{
    private int stranaA;    //dlzka strany stvorca

    /**
     * konstruktor
     */
    public Stvorec(int stranaA)
    {
        this.stranaA = stranaA;
    }

    /**
     * getter na stranuA
     */
    public int getStranaA(){
        return stranaA;
    }

    /**
     * setter na stranuA
     */
    public void setStranaA(int stranaA){
        this.stranaA = stranaA;
    }

    /**
     * povinna metoda nakresliSa
     */
    public void nakresliSa() {
         System.out.print("\f");
         //plny stvorec
        for(int i = 0; i < stranaA; i++){
             for(int j = 0; j < stranaA; j++){
                 System.out.print("* ");
                }
             System.out.println();
             
        }
        System.out.println("Obvod stvorca je: " + dajObvod() + " znakov stvorcovych");
    }

    /**
     * vracia obvod stvorca
     * @return obvod
     */
    public double dajObvod() {
        int obvod = 4 * getStranaA();
        return obvod;
    }
}
