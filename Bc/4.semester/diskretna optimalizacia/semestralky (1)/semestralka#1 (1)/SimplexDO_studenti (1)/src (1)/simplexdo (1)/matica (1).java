package simplexdo;

/**
 * @author Kolektív
 */
public class matica {

    private int aPocetStruktPodm;        // aktualny pocet podmienok v modeli (bez pomocneho riadku)
    private int aPocetPrem;        // aktualny pocet stlpcov matice - pocet premennych (bez stlpca pravych stran a stlpca x0)
    private double[][] aSimplexovaMatica;  // simplexova tabulka - hodnoty  (m+1 riadkov, n+2 stlpcov)
    private double[] aKrajnyBod;     // vysledok - krajny bod
    private int[] aBaza;       // baza - su tu ulozene indexy stlpcov, kde sa nachadza pivotovy prvok pre prislusny riadok 
    private int aPivotovyRiadok;          // pivotovy riadok
    private int aPivotovyStlpec;          // pivotovy stlpec
    private boolean aNemaOpt;      //false = nasli sme optimalne riesenie, true = este sme optimum nenasli
    private boolean aNemaRies;     //false = nasli sme pivota, true = nenasli sme pivota = koncime

    public matica(int paPocRia, int paPocStl) // parametre - maximalny pocet riadkov a stlpcov matice
    {
        aPocetStruktPodm = paPocRia;                   // inicializuje pocet riadkov modelu (strukt.podmienky)
        aPocetPrem = paPocStl;                   // inicializuje pocet stlpcov (premennych - bez stlpca x0 a pravej strany)
        aSimplexovaMatica = new double[aPocetStruktPodm + 1][aPocetPrem + 2];      // vytvori maticu a
        aKrajnyBod = new double[aPocetStruktPodm + 1];           // vytvori pole pre riesenie
        aBaza = new int[aPocetStruktPodm + 1];              // vytvori bazu - indexy bazicnych premennych
    }

    /**
     * Zobrazenie matice v terminalovom okne
     */
    public void zobraz() {
        System.out.println("Simplexova tabulka: ");
        for (int i = 0; i < aPocetStruktPodm + 1; i++) //pre vsetky riadky
        {
            for (int j = 0; j < aPocetPrem + 1; j++) //pre vsetky stlpce
            {
                System.out.printf("%8.2f", aSimplexovaMatica[i][j]);
            }
            System.out.print(" | ");
            System.out.printf("%8.2f", aSimplexovaMatica[i][aPocetPrem + 1]);
            System.out.println();
        }

        System.out.println("Hodnota UF: " + aSimplexovaMatica[0][aPocetPrem + 1]);
        System.out.print(" | ");
        for (int i = 1; i < aPocetStruktPodm + 1; i++) {
            System.out.print("x[" + aBaza[i] + "] = ");
            System.out.printf("%8.2f", aSimplexovaMatica[i][aPocetPrem + 1]);
            System.out.print(" | ");
        }
        System.out.println();
        System.out.println();
    }

    public void nacitajZoSuboru(String nazovSuboru) throws java.io.FileNotFoundException {
        // vytvorenie novej instancie triedy Scanner pre citanie z textoveho suboru
        java.util.Scanner citac = new java.util.Scanner(new java.io.File(nazovSuboru));
        aPocetStruktPodm = citac.nextInt();
        aPocetPrem = citac.nextInt();
        for (int i = 0; i < aPocetStruktPodm + 1; i++) { //pre vsetky riadky
            aSimplexovaMatica[i][0] = 0;
            for (int j = 1; j < aPocetPrem + 2; j++) //pre vsetky stlpce
            {
                aSimplexovaMatica[i][j] = citac.nextDouble();  // nacitanie hodnoty prvku zo suboru;
            }
        }
        aSimplexovaMatica[0][0] = 1;    //nastavenie hodnoty v pomocnom riadku v stlpci x0
        aBaza[0] = 0;       //nastavenie bazy v pomocnom riadku

        for (int i = 1; i < aPocetStruktPodm + 1; i++) //pre vsetky riadky nacita bazu
        {
            aBaza[i] = citac.nextInt();
        }

        citac.close();
    }

    public void SimpexovaMetoda() {
        //hlavny cyklus simplexovej metody
        while (aNemaOpt == false) {
            aNemaOpt = StlpcovePravidlo();
            if (aNemaOpt != true) {
                aNemaRies = RiadkovePravidlo();
                if (aNemaRies != true) {
                    PivotovaTransformacia();
                }
                zobraz();
            }
        }
        if (aNemaRies) {
            System.out.println("Uloha nema riesenie z dovodu neohranicenosti!");
        }
    }

    public boolean StlpcovePravidlo() {
        double max = 0.0;
        aPivotovyStlpec = 0;
        for (int x = 1; x <= aPocetPrem; x++) {
            if (aSimplexovaMatica[0][x] > max) {
                max = aSimplexovaMatica[0][x];
                aPivotovyStlpec = x;
            }
        }
        if (max == 0.0) {
            return true;
        }
        return false;
    }

    public boolean RiadkovePravidlo() {
        aPivotovyRiadok = 0;
        double piv = 1000000.0;
        for (int x = 1; x <= aPocetStruktPodm; x++) {
            if (aSimplexovaMatica[x][aPivotovyStlpec] > 0.0) {
                double pom = aSimplexovaMatica[x][aPocetPrem + 1] / aSimplexovaMatica[x][aPivotovyStlpec];
                if (pom < piv) {
                    piv = pom;
                    aPivotovyRiadok = x;
                }
            }
        }
        if (piv == 1000000.0) {
            return true;
        }
        aBaza[aPivotovyRiadok] = aPivotovyStlpec;
        return false;
    }

    public void PivotovaTransformacia() {
        double piv = aSimplexovaMatica[aPivotovyRiadok][aPivotovyStlpec];
        for (int i = 0; i <= aPocetPrem + 1; i++) {
            aSimplexovaMatica[aPivotovyRiadok][i] = aSimplexovaMatica[aPivotovyRiadok][i] / piv;
        }
        for (int i = 0; i <= aPocetStruktPodm; i++) {
            if (i != aPivotovyRiadok) {
                double pivot = aSimplexovaMatica[i][aPivotovyStlpec];
                for (int j = 1; j <= aPocetPrem + 1; j++) {
                    aSimplexovaMatica[i][j] += ((-1) * pivot) * aSimplexovaMatica[aPivotovyRiadok][j];
                }
            }
        }
    }
}