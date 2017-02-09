
import java.util.Random;

/**
 *
 * @author sisila
 */
public class OdhadPi {

    public static void main(String[] args) {
        double x = 0;
        double y = 0;
        //stred kruhu
        double x0 = 0.5;
        double y0 = 0.5;
        double polomerKruhu = 0.5;
        int pocetUspechov = 0;
        int pocetReplikacii = 100000000;   //pocet replikacii by mal byt rovny cislu, aby bol odhad pi presny na 6 desatinnych miest
                
        Random rngX = new Random();
        Random rngY = new Random();
        
        for (int i = 0; i < pocetReplikacii; i++) {
            x = rngX.nextDouble();
            y = rngY.nextDouble();

            if ((Math.pow((x-x0), 2) + Math.pow((y-y0), 2)) < Math.pow(polomerKruhu, 2)) {
                pocetUspechov++;
            }
        }
        
        System.out.println("Odhad hodnoty pi\n");
        double odhadPi = pocetUspechov / Math.pow(polomerKruhu, 2);
        odhadPi = odhadPi / pocetReplikacii;
        System.out.println(odhadPi);
        System.out.println("Chyba\n");
        System.out.println(Math.PI - odhadPi);
    }
    
}
