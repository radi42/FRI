import java.io.FileReader;
import java.util.Scanner;
import java.io.FileNotFoundException;
/**
 * Trieda Reader
 * 
 * @author andrej 
 */
public class Reader
{
    public static void main()
    throws FileNotFoundException
    {
        Reader read = new Reader();
        read.citac("subor1.txt");
    }
    
    public void citac(String nazov)
    throws FileNotFoundException
    {
        FileReader fr = new FileReader(nazov);
        Scanner sc = new Scanner(fr);
        int x = 1;
        while (sc.hasNextLine())
        {
            String riadok = sc.nextLine();
            System.out.println(x + ". " + riadok);
            x++;
        }
        sc.close();
    }
}
