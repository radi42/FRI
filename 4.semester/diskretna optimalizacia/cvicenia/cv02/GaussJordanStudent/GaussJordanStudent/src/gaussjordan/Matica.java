package gaussjordan;


/**
 *
 * @author Sisila
 */


public class Matica
{
    // atributy triedy Matica
    private int pocRia;        // aktualny pocet riadkov matice
    private int pocStl;        // aktualny pocet stlpcov matice (bez stlpca pravych stran)
    private double [][] pole;  // dvojrozmerne pole prvkov matice
    private int [] baza;       // baza - su tu ulozene indexy stlpcov, kde sa nachadza pivotovy prvok pre prislusny riadok 


    /**
     * Konstruktor triedy Matica - podiela sa na vytvarani instancii, inicializuje atributy
     * @param  paPocRia   maximalny (rezervovany) pocet riadkov matice
     * @param  paPocStl   maximalny (rezervovany) pocet stlpcov matice
     */
    public Matica(int paPocRia, int paPocStl)  // parametre - maximalny pocet riadkov a stlpcov matice
    {
        pocRia = paPocRia;                   // inicializuje pocet riadkov
        pocStl = paPocStl;                   // inicializuje pocet stlpcov
        pole = new double [pocRia][pocStl];  // vytvori pole = sustava rovnic - bude obsahovat 0.0
        baza = new int [pocRia];             // vytvori bazu - bude obsahovat 0
    }


    /**
     * Pocet riadkov matice
     * @return vrati aktualny pocet riadkov matice
     */
    public int pocetRiadkov()
    {
        return pocRia;
    }


    /**
     * Pocet stlpcov matice
     * @return vrati aktualny pocet stlpcov matice
     */
    public int pocetStlpcov()
    {
        return pocStl;
    }

    
    /**
     * Retazcova reprezentacia matice
     */
    public String toString()
    {
        String vysledok = "";
        for (int i=0; i<pocRia; i++)    //pre vsetky riadky
          {
          for (int j=0; j<pocStl; j++)  //pre vsetky stlpce
            vysledok = vysledok + String.format("%7.2f",pole[i][j]);
//          vysledok = vysledok + "\n";          // prida iba #10(LF) - nestaci pri ukladani do suboru
          vysledok = vysledok + '\015'+'\012';    // prida #13(CR) aj #10(LF)
          }
        return vysledok;
    }

    /**
     * Zobrazenie matice v terminalovom okne
     */
    public void zobraz()
    {
        for (int i=0; i<pocRia; i++)    //pre vsetky riadky
          {
          for (int j=0; j<pocStl+1; j++)  //pre vsetky stlpce
            System.out.printf("%7.2f",pole[i][j]);
          System.out.println();
          }
        System.out.println();
    }


    /**
     * Nacitanie rozmerov matice a prvkov matice z klavesnice
     */
    public void nacitajZKlavesnice()
    {
        java.util.Scanner citac = new java.util.Scanner(System.in);
        System.out.print("Pocet riadkov: ");
        pocRia = citac.nextInt();
        System.out.print("Pocet stlpcov (bez stlpca pravych stran): ");
        pocStl = citac.nextInt();
        for (int i=0; i<pocRia; i++)    //pre vsetky riadky
          for (int j=0; j<pocStl+1; j++)  //pre vsetky stlpce
            {
            System.out.print("Prvok["+i+","+j+"]=");
            pole[i][j] = citac.nextDouble();
            }
    }

    /**
     * Nacitanie rozmerov matice a prvkov matice zo suboru
     * @param  subor   nazov textoveho suboru, z ktoreho sa nacitavaju data
     */
    public void nacitajZoSuboru(String nazovSuboru) throws java.io.FileNotFoundException
    {
        // vytvorenie novej instancie triedy Scanner pre citanie z textoveho suboru
        java.util.Scanner citac = new java.util.Scanner(new java.io.File(nazovSuboru));
        pocRia = citac.nextInt();             // nacita cele cislo zo suboru
        pocStl = citac.nextInt();
        for (int i=0; i<pocRia; i++)          //pre vsetky riadky
          for (int j=0; j<pocStl+1; j++)      //pre vsetky stlpce
            pole[i][j] = citac.nextDouble();  // nacitanie realneho cisla zo suboru
        citac.close();
    }


    /**
     * Eliminacna metoda - postupujte podla navodu (nevymienajte riadky ani stlpce, uprava nad aj pod pivotom)
     */
    public void GJE() {
        for(int i=0; i<pocRia; i++) {
             for (int j=0; j<pocStl+1; j++) {
                 if(pole[i][j]!= 0) {
                    if(j == pocStl) {
                        baza[i] = -1;
                        return;
                    }
                    baza[i] = j;
                    double pivot = pole[i][j];
                    for(int k = 0;k<pocStl+1;k++) {
                        pole[i][k] = pole[i][k] / pivot;
                    }
                    for(int k = 0;k<pocRia ;k++) {
                        //urob pre kazdy iny riadok ako pivotovy
                        if(k!=i) {
                            double a = pole[k][j]*(-1);
                            for(int l=0;l<pocStl+1;l++) {
                                pole[k][l] = pole[k][l] + a*pole[i][l];
                            }
                        }
                    }
                    break;
                 }
             }
        }
    }

    public int PocetNenulovych(int IndexRiadku)
    {
        int pocet = 0;
        for (int j=0; j<pocStl+1; j++)
        {
            if (pole[IndexRiadku][j]!=0) pocet++;
        }
        return pocet;
    }

   
    public void VyhodnotRiesenie()
    {
        int pocet = 0;
        for(int i = 0;i<pocStl;i++) {
            if(baza[i] == -1) {
                System.out.print("Matica nema riesenie!" + "\n");
                return;
            }
            if(baza[i] == 0) {
                pocet++;
            }
        }
        if(pocet>1) {
            System.out.print("Matica ma nekonecne vela rieseni!" + "\n");
        }
        else {
            System.out.print("Matica ma prave 1 riesenie!" + "\n");
        }
    }
    

}

