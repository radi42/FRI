import java.io.FileReader;
import java.util.Scanner;
import java.io.FileNotFoundException;
/**
 * Trieda Matice
 * 
 * @author samo 
 * @version beta
 */
public class Matice
{
    private int[][] matica;
    private int stlpce;
    private int riadky;
    
    /**
     * Staticka metoda main, vykonava hlavny program
     */
    public static void main()
    throws FileNotFoundException
    { 
        Matice mat = new Matice(100,100);
        mat.nacitajMaticu("matica.txt");
        mat.vypisMaticu();
    }
    
    /**
     * Konstruktor triedy Matice
     */
    public Matice(int x, int y)
    {
        matica = new int[x][y];
    }
    
    /**
     * Metoda pre nacitanie matice z textoveho suboru a jej ulozenie do pola
     */
    public void nacitajMaticu(String nazov)
    throws FileNotFoundException
    {
        FileReader fr = new FileReader(nazov);
        Scanner sc = new Scanner(fr);
        this.stlpce = sc.nextInt();
        this.riadky = sc.nextInt();
        for (int i = 1; i <= riadky; i++){
            for (int j = 1; j <= stlpce; j++){
                matica[j][i] = sc.nextInt();
            }
        }
        sc.close();
    }
    
    /**
     * Metoda pre vypis matice na terminal
     */
    public void vypisMaticu()
    {
        System.out.print("\f");
        for (int i = 1; i <= riadky; i++)
        {
            for (int j = 1; j <= stlpce; j++)
                System.out.print(matica[j][i] + " ");
            System.out.println();
        }
    }
    
    /**
     * Vrati sucet vsetkych prvkov matice
     */
    public int getSucetPrvkov()
    {
        int sucet = 0;
        for (int i = 1; i <= riadky; i++)
            for (int j = 1; j <= stlpce; j++)
                sucet += matica[j][i];
        return sucet;
    }
    
    /**
     * Vrati vektor suctov riadkov matice
     */
    public int[] getSuctyRiadkov()
    {
        int[] sucet = new int[riadky];
        for (int i = 1; i <= riadky; i++)
        {
            sucet[riadky] = 0;
            for (int j = 1; j <= stlpce; j++)
            {
                sucet[riadky] += matica[riadky][stlpce];
            }
        }
        return sucet;
    }
    
    /**
     * Metoda vrati prvok matice v danom riadku a danom stlpci
     */
    public int getPrvok(int riadok, int stlpec)
    {
        return matica[stlpec][riadok];
    }
    
    /**
     * Metoda prepise prvok matice v danom riadku a danom stlpci
     * Neprepisuje textovy subor "matice.txt", iba maticu nacitanu v poli
     */
    public void setPrvok(int riadok, int stlpec, int prvok)
    {
        matica[stlpec][riadok] = prvok;
    }
    
    /**
     * Metoda toString
     */
    public String toString()
    {
        return "Matica s poctom riadkov " + riadky + " a poctom stlpcov " + stlpce;
    }
}