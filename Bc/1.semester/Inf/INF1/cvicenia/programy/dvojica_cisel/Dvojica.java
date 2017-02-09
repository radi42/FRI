public class Dvojica //obycajne su triedy verejne
{
    //deklaracia premennych: druh - typ - nazov
    private int a;
    private int b;

    //vytvorime konstruktor
    public Dvojica(int a, int b)
    {
        this.a = a; //this - odvolavanie sa na atribut
        this.b = b;
        
    }
    
    //bezparametricky konstruktor
    public Dvojica()
    {
        this(4, 5);
    }

    //definujeme metody
    //sucet
    public int dajSucet() 
    {
        return a + b; //vrati hodnotu operacie (suctu)
    }

    //rozdiel
    public int dajRozdiel()
    {
        return a - b;
    }

    //sucin
    public int dajSucin()
    {
        return a * b;
    }

    //podiel
    public int dajPodiel() // 8, 5
    {
        return a / b;         // 1
    }
    
    public double dajDoublePodiel() // 8, 5
    {
        return (double)(a) / b;               // pretypujeme jednu z premennych - vysledok bude potom typu double nie int
    }

    public int dajZvysokPoDeleni()
    {
        return a % b;
    }

    public double dajDruhuOdmocninu_a()
    {
        return Math.sqrt(a);
    }

    public double dajDruhuOdmocninu_b()
    {
        return Math.sqrt(b);
    }

    public int dajDruhuMocninu_a()
    {
        return a * a;
    }

    public int dajDruhuMocninu_b()
    {
        return b * b;
    }    
    
    /**
     * b-ta mocnina cisla A
     */
    public int bMocninaZCislaA()
    {
        int mocnina;
        mocnina = a;
        int i;      
        for ( i = 1; i < b; i++)
        {
             mocnina = mocnina*mocnina;
        }
        return mocnina;
    }
    
   
    public float podelVacsieMensim()
    {
        if ( b <= a )
        {
            return a / b;
        }
        else
        {
            return b / a;
        }
    }

    
    public static void main(String[] args)
    {
        Dvojica d = new Dvojica(8, 4); //vytvorili sme lokalnu premennu d kde volame objekt Dvojica
        System.out.println("\fSucet cisel je " +  /*a + " a " + b */ + d.dajSucet()); // \f na zaciatku string retazca vymaze terminal a vypise hodnotu d.metoda do terminalu
        System.out.println("Sucin cisel je " + d.dajSucin());
        System.out.println("Rozdiel cisel je " + d.dajRozdiel());
        System.out.println("Podiel cisel je " + d.dajPodiel());
        System.out.println("Realny podiel cisel je " + d.dajDoublePodiel());
        System.out.println("Zvysok po deleni je " + d.dajZvysokPoDeleni());
        System.out.println("Druha odmocnina cisla a je " + d.dajDruhuOdmocninu_a());
        System.out.println("Druha odmocnina cisla b je " + d.dajDruhuOdmocninu_b());
        System.out.println("Druha mocnina cisla a je " + d.dajDruhuMocninu_a());
        System.out.println("Druha mocnina cisla b je " + d.dajDruhuMocninu_b());

        System.out.println("Vysledok po vydeleni vacsieho cisla mensim je " + d.podelVacsieMensim() );
        //System.out.println("B-ta mocnina z A je " + d.bMocninaZCislaA());
        
    }
}