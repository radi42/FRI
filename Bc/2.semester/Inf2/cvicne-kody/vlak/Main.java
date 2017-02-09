
/**
 * Testovacia trieda - overenie funkcnosti vytvoreneho projektu
 */
public abstract class Main
{
    public static void main(String [] args)
    {
        System.out.print('\f');
        Spoj mojVlak = new Spoj("Expres - Povazan");
        naplnenieLinky(mojVlak);

        java.util.Scanner citac = new java.util.Scanner(System.in);
        int vystup, nastup;

        mojVlak.vlozJazduVlaku();

        System.out.print(mojVlak);
        
        int maxVyst = mojVlak.dajStanicu(0).dajPocetVyst();
        int maxNast = mojVlak.dajStanicu(0).dajPocetNast();
        int iVyst = 0;
        int iNast = 0;
        for (int i=0; i<mojVlak.dajPocetStanic(); i++) {
            int x = mojVlak.dajStanicu(i).dajPocetVyst();
            if (maxVyst <x ) {
                maxVyst = x;
                iVyst = i;
            }
            x = mojVlak.dajStanicu(i).dajPocetNast();
            if (maxNast <x ) {
                maxNast = x;
                iNast = i;
            }
        }
        Stanica st = mojVlak.dajStanicu(iVyst);
        System.out.println("\nNajviac vystupilo " + st.dajPocetVyst()
                          +" cestujucich v stanici " + st.dajNazov());
        st = mojVlak.dajStanicu(iNast);
        System.out.println("Najviac nastupilo " + st.dajPocetNast()
                          +" cestujucich v stanici " + st.dajNazov());

        int suma = 0;
        for (int i=0; i<mojVlak.dajPocetStanic(); i++) {
            suma += mojVlak.dajStanicu(i).dajPocetNast();
        }
        System.out.println("Vlak odviezol " + suma + " cestujucich");
    }



//---------------------------------------------------------------------------
//***************************************************************************
    private static void naplnenieLinky(Spoj x) {
        x.pridajStanicu(new Stanica("Zilina", new Cas(8, 28, 0)));
        x.pridajStanicu(new Stanica("Pov.Bystrica", new Cas(9, 20, 0)));
//         x.pridajStanicu(new Stanica("Puchov", new Cas(9, 45, 0)));
        x.pridajStanicu(new Stanica("Trencin", new Cas(10, 51, 0)));
//         x.pridajStanicu(new Stanica("N.Mesto nad Vahom", new Cas(11, 35, 0)));
//         x.pridajStanicu(new Stanica("Piestany", new Cas(11, 48, 0)));
        x.pridajStanicu(new Stanica("Trnava", new Cas(12, 03, 0)));
        x.pridajStanicu(new Stanica("Bratislava", new Cas(12, 22, 0)));
    }
}
