import java.util.*; //pridame kniznicujava.utils
/**
 * trieda VstupyAVystupy
 * 
 * @author Andrej Sisila
 * @version v1.1 (7. 10. 2013)
 */

public class VstupyAVystupy
{
    public static void main(String[] args) //volame hlavnu metodu
    {
        // lokalne premenne
        //vstup cez klavesnicu
        Scanner klav = new Scanner(System.in); //vytvorenie skenera na snimanie znakov z klavesnice s parametrom System.in
        
        System.out.print("\fZadaj prve cislo: "); int a = klav.nextInt();
        
        System.out.print("Zadaj druhe cislo: "); int b = klav.nextInt();
        
        klav.nextLine(); // ked prechadzam z citania cisel na citanie samotnych riadkov (nextInt na nextLine, jeden riadok musim pridat)
        System.out.print("Vloz meno a priezvisko: "); String celeMeno = klav.nextLine();
        
        Dvojica d = new Dvojica(a, b);
        
        System.out.println("\n\t** Tu su vysledky ** \n\t********************");
        System.out.println("Sucet je " + a + b + " --- chybny vstup"); //85 => zretazenie
        System.out.println("Sucet je " + d.dajSucet() ); //13
        System.out.println("Sucet je " + (a + b) );
        System.out.println("Sucet je " + a + b );
        //System.out.println("Sucet cisel " + a + " a " + b + " je " + (a + b) );
        System.out.println("Sucin cisel je " + d.dajSucin());
        System.out.println("Rozdiel cisel je " + d.dajRozdiel());
        System.out.println("Podiel je " + d.dajPodiel() ); //1
        System.out.println("Realny podiel je " + d.dajDoublePodiel() ); //1.6
        System.out.println("Zvysok po deleni je " + d.dajZvysokPoDeleni());
        System.out.println("Druha odmocnina cisla a je " + d.dajDruhuOdmocninu_a());
        System.out.println("Druha odmocnina cisla b je " + d.dajDruhuOdmocninu_b());
        System.out.println("Druha mocnina cisla a je " + d.dajDruhuMocninu_a());
        System.out.println("Druha mocnina cisla b je " + d.dajDruhuMocninu_b());
        System.out.println("Vysledok po vydeleni vacsieho cisla mensim je " + d.podelVacsieMensim() );
        System.out.println("\nMoje meno je " + celeMeno);
    }
}
