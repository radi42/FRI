package dijkstra;

import java.io.FileNotFoundException;
import java.io.File;
import java.io.IOException;
import java.util.Scanner;
import javax.swing.JOptionPane;

/**
 * Vykonavac algoritmu
 * 
 * Google: Dijkstra Gordon Freeman
 * vid
 * http://ruminatron5000.wordpress.com/tag/gordon-freeman/
 * http://ruminatron5000.files.wordpress.com/2010/06/dijkstra_is_freeman1.jpg
 * 
 * @author Andy
 */
public class Main {

    private static Dijkstra aGordonFreeman = new Dijkstra();
    private static Scanner scan;
    
    
    public static void main(String[] args) throws FileNotFoundException, IOException {
//        zadanieZoZdrojaku();
        zadanieZoSuboru();

        vypisZadanie();
        vypis();
    }
    
    /**
     * vypise postup
     */
    private static void vypis() {
        String start = "Bratislava";
        String ciel = "Kosice";
        System.out.println("");
        System.out.println("Hladam cestu z bodu " + start + " do bodu " + ciel);
        
        for(String entry : aGordonFreeman.findPath(start, ciel) ){
            System.out.println(entry);
        }
        System.out.println("Dlzka cesty je " + aGordonFreeman.getPossiblyBetterDistance() );
    }
    
    /**
     * nacita zadanie zo zdrojoveho kodu
     */
    private static void zadanieZoZdrojaku() {
        aGordonFreeman.addEdge("Bratislava", "Trnava", 5);
        aGordonFreeman.addEdge("Trnava", "Nitra", 5);
        aGordonFreeman.addEdge("Bratislava", "Nitra", 9);
        aGordonFreeman.addEdge("Trnava", "Trencín", 8);
        aGordonFreeman.addEdge("Trencín", "Zilina", 8);
        aGordonFreeman.addEdge("Zilina", "Banska Bystrica", 9);
        aGordonFreeman.addEdge("Zilina", "Presov", 25);
        aGordonFreeman.addEdge("Nitra", "Banska Bystrica", 13);
        aGordonFreeman.addEdge("Presov", "Kosice", 3);
        aGordonFreeman.addEdge("Banska Bystrica", "Kosice", 25);
        aGordonFreeman.addEdge("Bratislava", "Banska Bystrica", 22);
    }
    
    /**
     * nacita zadanie zo suboru
     */
    private static void zadanieZoSuboru() {
        otvorZadanie();
        citajZadanie();
    }

    private static void otvorZadanie() {
        try{
            scan = new Scanner(new File("maticaIncidencna.txt") );
        }catch(Exception e){
            JOptionPane.showMessageDialog(null, "Subor neexistuje");
        }
    }

    private static void citajZadanie() {
        String uzol_1;  //prvy bod
        String uzol_2;  //druhy bod
        String cenaHrany;  //vzdialenost dvoch bodov
        
        while(scan.hasNext() ){
            uzol_1 = scan.next();
            uzol_2 = scan.next();
            cenaHrany = scan.next();
            aGordonFreeman.addEdge(uzol_1, uzol_2, Integer.parseInt(cenaHrany) );
        }
    }
    
    private static void vypisZadanie() {
        otvorZadanie();
        String uzol_1;  //prve mesto
        String uzol_2;  //druhe mesto
        String cenaHrany;  //vzdialenost dvoch miest
        
        while(scan.hasNext() ){
            uzol_1 = scan.next();
            uzol_2 = scan.next();
            cenaHrany = scan.next();
            System.out.println(String.format("%s %s %s", uzol_1, uzol_2, cenaHrany) );
        }
        System.out.println("");
    }

    
    
}
