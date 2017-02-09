import java.io.*;
import java.util.*;
/**
 * Trieda Copy
 * 
 * @author samo
 * @version beta
 */
public class Copy
{
    public static void main()
    throws FileNotFoundException
    {
        Copy cc = new Copy();
        cc.kopirujDoRetazca("copy1.txt","copy2.txt");
    }
    
    public static void kopiruj(String subor1, String subor2)
    throws FileNotFoundException
    {
        FileReader fr = new FileReader(subor1);
        Scanner sc = new Scanner(fr);
        PrintWriter pv = new PrintWriter(subor2);
        int i = 1;
        while (sc.hasNextLine())
        {
            String riadok = sc.nextLine();
            //String s = String.format("*** %3d *** %s", i, riadok);
            //pv.println(s);
            pv.println(i + ". " + riadok);
            i++;
        }
        sc.close();
        pv.close();
    }
    
    public static void kopirujDoRetazca(String subor1, String subor2)
    throws FileNotFoundException
    {
        FileReader fr = new FileReader(subor1);
        Scanner sc = new Scanner(fr);
        PrintWriter pv = new PrintWriter(subor2);
        int i = 1;
        String retazec = "";
        while (sc.hasNextLine())
        {
            String riadok = sc.nextLine();
            retazec += i + ". " + riadok + "%n";
            i++;
        }
        pv.println(retazec);
        sc.close();
        pv.close();
    }
}
