package prednaska3;

/**
 * Trieda Program
 * 
 * vypisuje na terminal vysledky metod
 * @author Andy
 */
public class Program {

    public static void main(String[] args) {
        Objednavka material = new Objednavka(100);
        
        // valec dlzky 2 m, polomer 0.2 m, z oboch stran uzavrety
        material.vloz(new Kruh(0.2) ); //horna podstava
        material.vloz(new Kruh(0.2) ); //dolna podstava
        material.vloz(new Obdlznik(2, 2 * Math.PI * 0.2) ); //plast valca
        
        // hranol, dno – stvorec s hranou 0.5 m, vyska 1 m, bez vrchnaka
        material.vloz(new Stvorec(0.5) );
        material.vloz(new Obdlznik(4 * 0.5, 1) );
        
        double spotreba = material.spotrebaMaterialu();
        double rez = material.dlzkaRezu();
        double cenaMaterialu = spotreba * Objednavka.CENA_MATERIALU;
        double cenaRezania = rez * Objednavka.CENA_REZANIA;
        
        System.out.println("Objednavka\f");
        System.out.println(material);
        System.out.printf("%30s  %6.2f m2 (%5.2f EUR/m2)\n",
                          "Celkova spotreba materialu =",spotreba,
                           Objednavka.CENA_MATERIALU);
        System.out.printf("%30s  %6.2f m2 (%5.2f EUR/m2)\n",
                          "Celkova cena rezania =",rez,
                           Objednavka.CENA_REZANIA);
        System.out.printf("%30s  %6.2f EUR \n",
                          "Cena za rezanie materialu  =", cenaRezania);
        System.out.printf("%30s  %6.2f EUR \n",
                          "Cena za kupu materialu  =", cenaMaterialu);
        System.out.printf("%30s  %6.2f EUR \n",
                          "Celkova cena objednavky =", 
                          cenaRezania + cenaMaterialu);
        
//        (material instanceof Objednavka) ? System.out.println("Ano") : System.out.println("Nie");
        System.out.println();
        if(material instanceof Objednavka) {System.out.println("Ano, material je instanciou triedy Objednavka"); }
        else System.out.println("Nie, material nie je instanciou triedy Objednavka");

    }
    
}
