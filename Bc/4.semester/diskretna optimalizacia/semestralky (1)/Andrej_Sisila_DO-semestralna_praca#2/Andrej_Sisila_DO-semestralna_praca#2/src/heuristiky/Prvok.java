package heuristiky;

/**
 * Trieda Prvok
 * @author Andrej Šišila
 */
public class Prvok {
    private final int aHmotnost;
    private final int aCena;
    private final float aPomerCenaHmotnost;
    private int aIndexVoVektoreRieseniDH = -1;   //vychadzame z pripustneho riesenia, ktore vypocitala dualna heuristika (DH). Index -1 je priradeny umyselne, pretoze ak by nastala chyba, algoritmus spadne. Hodnota tohto atributu sa zmeni v metode 'initVymenna' v triede Batoh

    Prvok(int paHmotnost, int paCena) {
        aHmotnost = paHmotnost;
        aCena = paCena;
        aPomerCenaHmotnost = (float)aCena / aHmotnost;
    }
    
    public int dajHmotnostPrvku(){
        return aHmotnost;
    }
    
    public int dajCenuPrvku(){
        return aCena;
    }
    
    public float dajPomerCenaHmotnostPrvku(){
        return aPomerCenaHmotnost;
    }
    
    public int dajIndexVoVektoreRieseniDH(){
        return aIndexVoVektoreRieseniDH;
    }
    
    public void nastavIndexZVektoraRieseniDH(int paIndexVoVektoreRieseniDH){
        aIndexVoVektoreRieseniDH = paIndexVoVektoreRieseniDH;
    }
}
