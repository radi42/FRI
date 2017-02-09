package hoddvomikockami;
import java.util.Scanner;

/**
 * 
 * @author Andy
 */
public class Main {

    
    public static void main(String[] args) {
        System.out.println("Zadajte pocet pokusov: ");
        Scanner scan = new Scanner(System.in);
        int maxPocetPokusov = scan.nextInt();
        Kocky k = new Kocky(maxPocetPokusov);
    }
    
}
