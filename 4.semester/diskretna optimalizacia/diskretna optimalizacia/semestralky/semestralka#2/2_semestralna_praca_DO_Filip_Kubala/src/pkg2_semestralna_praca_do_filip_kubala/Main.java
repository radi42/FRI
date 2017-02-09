package pkg2_semestralna_praca_do_filip_kubala;

/**
 * @author Filip Kubala
 */
public class Main {
    private static final int aPocPrvkov = 500;
    private static final int aMaxPocPrvkov = 300;
    private static final int aKapacita = 15000;
    private static Batoh batohA;
    private static Batoh batohB;

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        batohA = new Batoh(aPocPrvkov, aMaxPocPrvkov, aKapacita);
        
        
        System.out.println("Pociatocny stav batohu:");
        System.out.println(batohA.dajStart() );  //vypise startovacie riesenie
        int[] poleA = new int[aPocPrvkov];
        poleA = batohA.vypocitajPoA();
        System.out.println("Stav batohu po aplikovani Last Admissible strategie dualnej heuristiky:");
        System.out.println(vypisRiesenieA(poleA) );
        
        batohB = new Batoh(aPocPrvkov, aMaxPocPrvkov, aKapacita);
        int[] poleB = new int[aPocPrvkov];
        poleB = batohB.vypocitajPoB();
        System.out.println("Stav batohu po aplikovani First Admissible strategie dualnej heuristiky:");
        System.out.println(vypisRiesenieB(poleB) );
    }   

    private static String vypisRiesenieA(int[] pole) {
        String riesenie = "";
        //vypis vysledny vektor
        for (int i = 0; i < aPocPrvkov; i++) {
            riesenie += pole[i] + " ";
        }
        riesenie += "\n";
        
        //vypis previs, volnu kapacitu a hodnotu ucelovej funkcie
        riesenie += "Hodnota ucelovej funkcie = " + batohA.dajAktualCenaPrvkovVBatohu() + "\n";
        riesenie += "Pocet prvkov v batohu = " + batohA.dajAktualPocPrvkovVBatohu() + "\n";
        riesenie += "Hmotnost batoha = " + batohA.dajAktualHmotPrvkovVBatohu() + "\n";
        riesenie += "Previs = " + batohA.dajPrevis() +"\n";
        riesenie += "Volna kapacita = " + (-batohA.dajPrevis() ) + "\n";
        return riesenie;
    }
    
    private static String vypisRiesenieB(int[] pole) {
        String riesenie = "";
        //vypis vysledny vektor
        for (int i = 0; i < aPocPrvkov; i++) {
            riesenie += pole[i] + " ";
        }
        riesenie += "\n";
        
        //vypis previs, volnu kapacitu a hodnotu ucelovej funkcie
        riesenie += "Hodnota ucelovej funkcie = " + batohB.dajAktualCenaPrvkovVBatohu() + "\n";
        riesenie += "Pocet prvkov v batohu = " + batohB.dajAktualPocPrvkovVBatohu() + "\n";
        riesenie += "Hmotnost batoha = " + batohB.dajAktualHmotPrvkovVBatohu() + "\n";
        riesenie += "Previs = " + batohB.dajPrevis() +"\n";
        riesenie += "Volna kapacita = " + (-batohB.dajPrevis() ) + "\n";
        return riesenie;
    }
}