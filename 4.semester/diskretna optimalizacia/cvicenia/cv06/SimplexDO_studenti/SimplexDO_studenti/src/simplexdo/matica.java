/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package simplexdo;

/**
 *
 * @author Misho
 */
public class matica
{
    private int m;        // aktualny pocet podmienok v modeli (bez pomocneho riadku)
    private int n;        // aktualny pocet stlpcov matice - pocet premennych (bez stlpca pravych stran a stlpca x0)
    private double [][] a;  // simplexova tabulka - hodnoty  (m+1 riadkov, n+2 stlpcov)
    private double [] x;     // vysledok - krajny bod
    private int [] B;       // baza - su tu ulozene indexy stlpcov, kde sa nachadza pivotovy prvok pre prislusny riadok 
    private int r;          // pivotovy riadok
    private int s;          // pivotovy stlpec
    private boolean NemaOpt;      //false = nasli sme optimalne riesenie, true = este sme optimum nenasli
    private boolean NemaRies;     //false = nasli sme pivota, true = nenasli sme pivota = koncime



    public matica(int paPocRia, int paPocStl)  // parametre - maximalny pocet riadkov a stlpcov matice
    {
        m = paPocRia;                   // inicializuje pocet riadkov modelu (strukt.podmienky)
        n = paPocStl;                   // inicializuje pocet stlpcov (premennych - bez stlpca x0 a pravej strany)
        a = new double [m+1][n+2];      // vytvori maticu a
        x = new double [m+1];           // vytvori pole pre riesenie
        B = new int [m+1];              // vytvori bazu - indexy bazicnych premennych
    }




    /**
     * Zobrazenie matice v terminalovom okne
     */
    public void zobraz()
    {
        System.out.println("Simplexova tabulka: ");
        for (int i=0; i<m+1; i++)    //pre vsetky riadky
          {  
          for (int j=0; j<n+1; j++)  //pre vsetky stlpce
            System.out.printf("%8.2f",a[i][j]);
          System.out.print(" | ");
          System.out.printf("%8.2f",a[i][n+1]);
          System.out.println();
          }
        
        
        System.out.println("Hodnota UF: "+a[0][n+1]);
        System.out.print(" | ");
        for (int i=1; i<m+1; i++) {
            System.out.print("x["+B[i]+"] = ");
            System.out.printf("%8.2f",a[i][n+1]);
            System.out.print(" | ");
        }
          System.out.println();
          System.out.println();
        
    }


 
    public void nacitajZoSuboru(String nazovSuboru) throws java.io.FileNotFoundException
    {
        // vytvorenie novej instancie triedy Scanner pre citanie z textoveho suboru
        java.util.Scanner citac = new java.util.Scanner(new java.io.File(nazovSuboru));
        m = citac.nextInt();             
        n = citac.nextInt();
        for (int i=0; i<m+1; i++) { //pre vsetky riadky
          a[i][0]=0;        
          for (int j=1; j<n+2; j++)      //pre vsetky stlpce
            a[i][j] = citac.nextDouble();  // nacitanie hodnoty prvku zo suboru
        }
        a[0][0]=1;    //nastavenie hodnoty v pomocnom riadku v stlpci x0
        B[0]=0;       //nastavenie bazy v pomocnom riadku
       
        for (int i=1; i<m+1; i++)      //pre vsetky riadky nacita bazu
            B[i] = citac.nextInt();
        
        citac.close();
    }

    
   public void SimpexovaMetoda(){
       //hlavny cyklus simplexovej metody
       while (NemaOpt == false) {
           NemaOpt = StlpcovePravidlo();
           if (NemaOpt!=true) 
                {
                    NemaRies = RiadkovePravidlo();
                    if (NemaRies!=true) PivotovaTransformacia();   
                    zobraz();
                }
       }
  
       if (NemaRies) 
       {
            System.out.println("Uloha nema riesenie z dovodu neohranicenosti!");
       }
           
   } 

   public boolean StlpcovePravidlo(){
       //SEM DOPLNTE KOD - STLPCOVE PRAVIDLO
       // navratova hodnota: TRUE - ak sa nenasiel pivotovy stlpec, inak FALSE
      return true;
       
   } 
   
   public boolean RiadkovePravidlo(){
       //SEM DOPLNTE KOD - RIADKOVE PRAVIDLO
       // navratova hodnota: TRUE - ak sa nenasiel pivotovy riadok, inak FALSE
       return true; 
   } 
   
   public void PivotovaTransformacia(){
       //SEM DOPLNTE KOD - PIVOTOVA TRANSFORMACIA
       
   } 

}