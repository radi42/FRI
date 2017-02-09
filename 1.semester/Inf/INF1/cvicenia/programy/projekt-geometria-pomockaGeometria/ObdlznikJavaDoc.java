// ************* Priklad na pouzitie komentarov *****************

// Tu by sa pripadne mali importovat triedy z "packages" (balikov kniznic),
//             okrem niektorych vynimiek, napr java.lang, ...

import java.util.Scanner;   // import  triedy Scanner
// import java.util.*;      // import vsetkych tried balika util
// (! nie tried z podbalikov balika util !!!)

//******** Nasleduje dokumentacny komentár triedy *********
// Mozete pouzivat tzv. tagy jazyka HTML.
// Napriklad <h3> ... </h2> vytvara jeden z moznych nadpisov
//           <br> je vlozenie noveho riadku
//           <b>..</b>= tucne pismo, <i>..</i>= kurziva, <u>..</u>= podciarknutie...
// riadky zacinajuce znakom @... su definiciami atributov projektu...

/**
<h2>Trieda Obdlznik.</h2>
<br> - tu sa pripadne dopise <b>dalsi riadok</b>
<br> - <u>tu sa pripadne dopise</u> este <i>dalsi riadok</i>
 * 
 * @author Stefan Kovalik - doplnil Miroslav Benedikovic
 * @version V-0.1   (4.9.2009) - oktober 2013
 */
public class ObdlznikJavaDoc
{
    //---------------------------------------------------- Atributy instancii 
    private int a, b;         // sirka a dlzka obdlznika

    /**
     * Konstruktor triedy Obdlznik s parametrami
     * - vytvori obdlznik s danymi rozmermi <br>
     * nieco 1<br>
     * nieco 2<br>
     * @param a   sirka obdlznika<br>
     * nieco 3<br>
     * nieco 4<br>
     * @param b   vyska obdlznika<br>
     * nieco naposledy
     */
    public ObdlznikJavaDoc(int a, int b)  // Parametre sa mozu volat rovnako ako artibuty
    {
        // inicializacia rozmerov obdlznika
        this.a = a;   // this.    - spristupnenie atributu tej istej instancie
        this.b = b;
    }

    /**
     * Bezparametricky konstruktor triedy Obdlznik 
     * <br>vytvori "prazdny" obdlznik s rozmermi 0,0
     */
    public ObdlznikJavaDoc() {
        // Inicializacia rozmerov obdlznika
        // a = 0; b = 0;    // <<-- takto by sa to nemalo robit
        this(0,0);          // asi takto by sa to malo robit takto;
        // this(...)  - volanie konstruktora tej istej triedy)
    }

    /**
     * Vrati obsah obdlznika
     */
    public int obsah() {
        return a*b;
    }

    /**
     * Vrati velkost uhlopriecky obdlznika 
     */
    public float uhlopriecka() {
        int pomocna;
        pomocna = a*a + b*b;
        //          int pomocna = a*a + b*b;   //== alternativa - sucasne
        //   deklaracia i inicializacia
        return  (float) Math.sqrt(pomocna);  // volanie metody sqrt abstraktnej triedy Math 

        //        return Math.sqrt( (double) (a*a + b*b) );  // pripadne pretypovanie argumentu,
        //     ak by to bolo nutne
    }

    // Prekryta metoda pre textovu informaciu o instancii
    @Override
    public String toString() {
        return  "sirka: " + a + " vyska: " + b;

    }

    /**
     * Aplikacna metoda pre start aplikacie
     */
    public static void main(String[] args) {
        System.out.println("\f\t**** Priklad na obdlznik ****");

        Scanner sc = new Scanner(System.in); // Zadanie objektu scanner

        // Zadavanie rozmerov obdlznika
        System.out.println("Zadaj 1.rozmer");
        int a = sc.nextInt();
        System.out.println("Zadaj 2.rozmer");
        int b = sc.nextInt();
        ObdlznikJavaDoc o = new ObdlznikJavaDoc(a,b); // referencia s vytvorenou instanciou

        // Vypisy a volanie metod
        System.out.println("Obsah obdlznika je: " + o.obsah()); 
        System.out.println("Uhlopriecka obdlznika je: " + o.uhlopriecka());

        System.out.println("Obdlznik " + o);

        System.out.println("\n\t**** Koniec ****");

    }
}

