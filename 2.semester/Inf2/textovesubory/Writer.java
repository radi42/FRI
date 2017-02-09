import java.io.PrintWriter;
import java.io.FileNotFoundException;
/**
 * Trieda Writer
 * 
 * @author samo 
 * @version beta
 */
public class Writer
{
    public static void main()
    throws FileNotFoundException
    {
        PrintWriter pv = new PrintWriter("subor2.txt");
        pv.println("woafhvb");
        pv.close();
    }
}
