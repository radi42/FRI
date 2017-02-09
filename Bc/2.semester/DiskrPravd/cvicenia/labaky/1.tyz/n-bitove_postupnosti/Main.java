import java.util.Scanner;
/**
 * Trieda Main
 * Vypisuje vsetky potrebne kombinacie dvojic medzi ziakmi
 * 
 * @author Andrej Sisila
 * @version v1.0
 */
public abstract class Main
{
    static Potupnosti post;
    
    private static void vypis(String s){
        System.out.print(s);
    }
    
    public static void main(String[] args) {
        Scanner scan = new Scanner(System.in);
        vypis("Zadajte pocet jednotiek: ");
        int jednotky = scan.nextInt();
        post = new Potupnosti(jednotky); //vytvorime novu instanciu triedy Ziaci bezparametrickym konstruktorom
        //ktoru priradime referencnej premennej
        vypis(post.toString() ); //nechame vypisat prepisanu metodu toString v triede 
    }
}
