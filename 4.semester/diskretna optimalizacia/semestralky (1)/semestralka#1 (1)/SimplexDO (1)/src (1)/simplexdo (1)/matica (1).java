package simplexdo;

/**
 * @author Filip
 */
public class matica {

    private int pocStruktPodm;        // aktualny pocet podmienok v modeli (bez pomocneho riadku)
    private int pocPrem;        // aktualny pocet stlpcov matice - pocet premennych (bez stlpca pravych stran a stlpca x0)
    private final double[][] simplexovaMatica;  // simplexova tabulka - hodnoty  (m+1 riadkov, n+2 stlpcov)
    private final double[] x;     // vysledok - krajny bod
    private final int[] Baza;       // baza - su tu ulozene indexy stlpcov, kde sa nachadza pivotovy prvok pre prislusny riadok 
    private int pivotovyRiadok;          // pivotovy riadok
    private int pivotovyStlpec;          // pivotovy stlpec
    private boolean NemaOpt;      //false = nasli sme optimalne riesenie, true = este sme optimum nenasli
    private boolean NemaRies;     //false = nasli sme pivota, true = nenasli sme pivota = koncime

    public matica(int paPocRia, int paPocStl) // parametre - maximalny pocet riadkov a stlpcov matice
    {
        pocStruktPodm = paPocRia;                   // inicializuje pocet riadkov modelu (strukt.podmienky)
        pocPrem = paPocStl;                   // inicializuje pocet stlpcov (premennych - bez stlpca x0 a pravej strany)
        simplexovaMatica = new double[pocStruktPodm + 1][pocPrem + 2];      // vytvori maticu a
        x = new double[pocStruktPodm + 1];           // vytvori pole pre riesenie
        Baza = new int[pocStruktPodm + 1];              // vytvori bazu - indexy bazicnych premennych
    }

    public int getPocStruktPodm(){
        return pocStruktPodm;
    }
    
    public int getPocPrem(){
        return pocPrem;
    }
    
    public void zobraz() {
        System.out.println("Simplexova tabulka: ");
        for (int i = 0; i < pocStruktPodm + 1; i++) //pre vsetky riadky
        {
            for (int j = 0; j < pocPrem + 1; j++) //pre vsetky stlpce
            {
                System.out.printf("%8.2f", simplexovaMatica[i][j]);
            }
            System.out.print(" | ");
            System.out.printf("%8.2f", simplexovaMatica[i][pocPrem + 1]);
            System.out.println();
        }

        System.out.println("Hodnota UF: " + simplexovaMatica[0][pocPrem + 1]);
        System.out.print(" | ");
        for (int i = 1; i < pocStruktPodm + 1; i++) {
            System.out.print("x[" + Baza[i] + "] = ");
            System.out.printf("%8.2f", simplexovaMatica[i][pocPrem + 1]);
            System.out.print(" | ");
        }
        System.out.println();
        System.out.println();

    }

    public void nacitajZoSuboru(String nazovSuboru) throws java.io.FileNotFoundException {
        // vytvorenie novej instancie triedy Scanner pre citanie z textoveho suboru
        java.util.Scanner citac = new java.util.Scanner(new java.io.File(nazovSuboru));
        pocStruktPodm = citac.nextInt();
        pocPrem = citac.nextInt();
        double coPrecital;
        for (int i = 0; i < pocStruktPodm + 1; i++) { //pre vsetky riadky
            simplexovaMatica[i][0] = 0;
            for (int j = 1; j < pocPrem + 2; j++){ //pre vsetky stlpce
                coPrecital = citac.nextDouble();
                simplexovaMatica[i][j] = coPrecital;  // nacitanie hodnoty prvku zo suboru
            }
        }
        simplexovaMatica[0][0] = 1;    //nastavenie hodnoty v pomocnom riadku v stlpci x0
        Baza[0] = 0;       //nastavenie bazy v pomocnom riadku

        for (int i = 1; i < pocStruktPodm + 1; i++) //pre vsetky riadky nacita bazu
        {
            Baza[i] = citac.nextInt();
        }

        citac.close();
    }

    public void SimpexovaMetoda() {
        //hlavny cyklus simplexovej metody
        while (NemaOpt == false) {
            NemaOpt = StlpcovePravidlo();
            if (NemaOpt != true) {
                NemaRies = RiadkovePravidlo();
                if (NemaRies != true) {
                    PivotovaTransformacia();
                }
                zobraz();
            }
        }

        if (NemaRies) {
            System.out.println("Uloha nema riesenie z dovodu neohranicenosti!");
        }

    }

    public boolean StlpcovePravidlo() {
        double max = 0.0;
        pivotovyStlpec = 0;
        for (int x = 1; x <= pocPrem; x++) {
            if (simplexovaMatica[0][x] > max) {
                max = simplexovaMatica[0][x];
                pivotovyStlpec = x;
            }
        }
        return max == 0.0;
    }

    public boolean RiadkovePravidlo() {
        pivotovyRiadok = 0;
        double piv = 1000000.0;
        for (int x = 1; x <= pocStruktPodm; x++) {
            if (simplexovaMatica[x][pivotovyStlpec] > 0.0) {
                double pom = simplexovaMatica[x][pocPrem + 1] / simplexovaMatica[x][pivotovyStlpec];
                if (pom < piv) {
                    piv = pom;
                    pivotovyRiadok = x;
                }
            }
        }

        //SEM DOPLNTE KOD - RIADKOVE PRAVIDLO
        // navratova hodnota: TRUE - ak sa nenasiel pivotovy riadok, inak FALSE
        if (piv == 1000000.0) {
            return true;
        }
        Baza[pivotovyRiadok] = pivotovyStlpec;
        return false;
    }

    public void PivotovaTransformacia() {
        double piv = simplexovaMatica[pivotovyRiadok][pivotovyStlpec];
        for (int i = 0; i <= pocPrem + 1; i++) { //vydeli komplet cely riadok, kde sa pivot nachadza pivotom
            simplexovaMatica[pivotovyRiadok][i] = simplexovaMatica[pivotovyRiadok][i] / piv;
        }
        for (int i = 0; i <= pocStruktPodm; i++) {
            if (i != pivotovyRiadok) {
                double pivot = simplexovaMatica[i][pivotovyStlpec];
                for (int j = 1; j <= pocPrem + 1; j++) {
                    simplexovaMatica[i][j] += ((-1) * pivot) * simplexovaMatica[pivotovyRiadok][j];
                }
            }
        }
    }
}