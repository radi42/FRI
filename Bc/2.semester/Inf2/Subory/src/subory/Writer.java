package subory;

import java.io.PrintWriter;
import java.io.FileNotFoundException;

/**
 *
 * @author sisila
 */
public class Writer{ 

    public void zapisovac(String menoSuboru) throws FileNotFoundException {
        PrintWriter pw = new PrintWriter(menoSuboru);

        pw.println("Do suboru sme zapisali tieto riadky: ");
        pw.println(29.95);
        pw.println("Hotovo");
        System.out.println("Subor uspesne ulozeny!");
        pw.close();
    }
    
    public static void main(String[] args) throws FileNotFoundException{
        Writer w = new Writer();
        w.zapisovac("Vystup.txt");
    }
}
