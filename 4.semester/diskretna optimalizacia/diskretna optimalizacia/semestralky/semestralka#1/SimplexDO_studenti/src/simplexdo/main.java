package simplexdo;

/**
 * @author Filip Kubala
 */
public class main {

   public static void main(String [] args) throws java.io.FileNotFoundException {
       String nazSub = "test.txt";
        java.util.Scanner citac = new java.util.Scanner(new java.io.File(nazSub));
        int riadky = citac.nextInt();
        int stlpce = citac.nextInt();
        citac.close();
	matica mat;
	mat = new matica(riadky,stlpce);
	System.out.print('\f');
        mat.nacitajZoSuboru(nazSub);
        
        System.out.println("Matica po nacitani:");
        mat.zobraz();
        
        mat.SimpexovaMetoda();
        
        mat.zobraz(); 
	}
}