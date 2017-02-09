package simplexdo;

/**
 * @author Filip
 */
public class main {

   public static void main(String [] args) throws java.io.FileNotFoundException
   {
        // vytvorenie novej instancie triedy Scanner pre citanie z textoveho suboru
        java.util.Scanner citac = new java.util.Scanner(new java.io.File("bbb.txt") );
        int riadky = citac.nextInt();
        int stlpce = citac.nextInt();
        citac.close();
        matica mat = new matica(riadky,stlpce);
        mat.nacitajZoSuboru("aaa.txt");    //   nacitanie suboru zo suboru
        System.out.print('\f');             //   vycisti terminal (prazdne okno)
        System.out.println("Matica po nacitani:");
        mat.zobraz();
        mat.SimpexovaMetoda();
        mat.zobraz();
   }
}