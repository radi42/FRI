package pkg2_semestralna_praca_do_filip_kubala;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;

/**
 * @author Filip Kubala
 */
final class Batoh {
    private final int[] aVysledneRiesenie;              //vektor pozostávajúci z 0 a 1 na n-tom mieste predstavuje ci sa n-ty predmet nachadza v batohu
    private final Prvok[] aPrvky;                       //samotné pole prvkov
    private final int aKapacitaBatohu;                  //K=15000
    private final int aCelkovyPocPrvkov;                //n=500
    private final int aMaxPocPrvkovVBatohu;             //r=300
    private int aAktualHmotPrvkovVBatohu = 0;           //kolko majú prvky v batohu aktuálnu hmotnosť
    private int aAktualCenaPrvkovVBatohu = 0;           //hodnota účelovej funkcie
    private int aAktualPocPrvkovVBatohu = 0;            //kolko prvkov v batohu aktualne mám
    private int aPrevis;                                //Previs nad maximálnou kapacitou batohu
    
    //Atributy vymennej heuristiky
    private ArrayList<Prvok> aZaradene;
    private ArrayList<Prvok> aNezaradene;

    
    Batoh(int paCelkovyPocetPrvkov, int paMaxPocetPrvkovVBatohu, int paKapacitaBatohu) {
        aPrvky = new Prvok[paCelkovyPocetPrvkov];
        nacitaj(paCelkovyPocetPrvkov);
        aVysledneRiesenie = new int[paCelkovyPocetPrvkov];
        aKapacitaBatohu = paKapacitaBatohu;
        aPrevis = aAktualHmotPrvkovVBatohu - aKapacitaBatohu;
        aCelkovyPocPrvkov = paCelkovyPocetPrvkov;
        aMaxPocPrvkovVBatohu = paMaxPocetPrvkovVBatohu;
        
        for(int i = 0; i < paCelkovyPocetPrvkov; i++){
            aVysledneRiesenie[i] = 1; //zaciatocne nepripustne riesenie kedy je v batohu kazdy predmet
            aAktualHmotPrvkovVBatohu += aPrvky[i].dajHmotnostPrvku();
            aAktualCenaPrvkovVBatohu += aPrvky[i].dajCenuPrvku();
            aAktualPocPrvkovVBatohu++;
        }
    }
    
    public int dajMaxPocPrvkovVBatohu(){
        return aMaxPocPrvkovVBatohu;
    }
    
    public int dajAktualHmotPrvkovVBatohu(){
        return aAktualHmotPrvkovVBatohu;
    }
    
    /**
     * @return hodnota ucelovej funkcie
     */
    public int dajAktualCenaPrvkovVBatohu(){
        return aAktualCenaPrvkovVBatohu;
    }
    
    /**
     * @return kolko prvkov je v batohu
     */
    public int dajAktualPocPrvkovVBatohu(){
        return aAktualPocPrvkovVBatohu;
    }
    
    /**
     * @return hodnota previsu
     */
    public int dajPrevis(){
        return aPrevis;
    }
    
    public String dajStart(){
        String riesenie = "";
        //vypis vysledny vektor
        for (int i = 0; i < aMaxPocPrvkovVBatohu; i++) {
            riesenie += aVysledneRiesenie[i] + " ";
        }
        riesenie += String.format("%n");
        
        //vypis previs, volnu kapacitu a hodnotu ucelovej funkcie
        riesenie += String.format("%s %d %n", "Hodnota ucelovej funkcie = ", dajAktualCenaPrvkovVBatohu() );
        riesenie += String.format("%s %d %n", "Pocet prvkov v batohu = ", dajAktualPocPrvkovVBatohu() );
        riesenie += String.format("%s %d %n", "Hmotnost batoha = ", dajAktualHmotPrvkovVBatohu() );
        riesenie += String.format("%s %d %n", "Previs = ", dajPrevis() );
        riesenie += String.format("%s %d %n", "Volna kapacita = ", (-dajPrevis() ) );
        return riesenie;
    }
    
    /**
     * naplni pole aPrvky zo suborov
     * @param paPocetPrvkov kolko riadkov ma kazdy subor; subory musia mat rovnaky pocet riadkov
     */
    public void nacitaj (int paPocetPrvkov) {
        File suborHmotnost = new File("data\\H6_a.txt");
        File suborCena = new File("data\\H6_c.txt");
        int nacitanaHmotnost;
        int nacitanaCena;
        
        try(Scanner nacitavacHmotnosti = new Scanner(suborHmotnost)){
            try(Scanner nacitavacCeny = new Scanner(suborCena)) {
                for(int i = 0; i < paPocetPrvkov; i++){
                    nacitanaHmotnost = nacitavacHmotnosti.nextInt();
                    nacitanaCena = nacitavacCeny.nextInt();
                    aPrvky[i] = new Prvok(nacitanaHmotnost, nacitanaCena);
                }
                nacitavacCeny.close();
            }catch(FileNotFoundException ex){
                System.out.println("Súbor s cenami prvkov sa nepodarilo nájsť!");
            }
            nacitavacHmotnosti.close();
        }catch(FileNotFoundException ex){
            System.out.println("Súbor s hmotnosťami prvkov sa nepodarilo nájsť!");
        }
    }
    
    /**
     * @return index prvku s najmensim pomerom cena/hmotnost pre dualnu heuristiku Last Admissible
     */
    private int dajIndexPrvkuSNajmensimPomeromDualna(){
        float min = 100000;
        //uchovávanie doteraz najmenšieho
        //nájdeného minima pomerov z prvkov v batohu
        
        int indexPrvku = 0;
        //pamätá si index alebo pozíciu prvku ktorý má
        //najmenší pomer z doteraz neodstránených prvkov z batoha
        
        for(int i = 0; i < aCelkovyPocPrvkov;i++){
            if(aVysledneRiesenie[i] == 1){
                if(aPrvky[i].dajPomerCenaHmotnostPrvku() <= min){
                    min = aPrvky[i].dajPomerCenaHmotnostPrvku();
                    indexPrvku = i;
                }
            }
        }
        return indexPrvku;
    }
    
    /**
     * kontroluje, ci su splnene vsetky strukturalne podmienky v zadani
     * @return splnene/nesplnene
     */
    private boolean splnaStruktPodmienky(){
        return ( (aAktualPocPrvkovVBatohu <= aMaxPocPrvkovVBatohu) && (aAktualHmotPrvkovVBatohu <= aKapacitaBatohu) );
    }
    
    /**
     * Dualna heuristika s vyhodnostnymi koeficientmi
     * Last Admissible 
     * @return vysledny vektor rieseni
     */
    public int[] dualnaHeuristika() {
        int vyhodeny;
        while(!splnaStruktPodmienky() || aPrevis >= 0){
            vyhodeny = dajIndexPrvkuSNajmensimPomeromDualna();
            aVysledneRiesenie[vyhodeny] = 0;
            aAktualHmotPrvkovVBatohu -= aPrvky[vyhodeny].dajHmotnostPrvku();
            aAktualCenaPrvkovVBatohu -= aPrvky[vyhodeny].dajCenuPrvku();
            aAktualPocPrvkovVBatohu--;
            aPrevis = aAktualHmotPrvkovVBatohu - aKapacitaBatohu;
        }
        return aVysledneRiesenie;
    }
    
    /**
     * Inicializacia vymennej heuristiky
     * @param pole vysledny vektor riesenia z dualnej heuristiky
     */
    public void initVymenna(int[] pole){
        aZaradene = new ArrayList<Prvok>();
        aNezaradene = new ArrayList<Prvok>();
        
        for(int i = 0; i < aCelkovyPocPrvkov; i++){
            aPrvky[i].nastavIndexZVektoraRieseniDH(i);
            if(pole[i] == 1)
                aZaradene.add(aPrvky[i]);
            else
                aNezaradene.add(aPrvky[i]);
        }
    }
    
    /**
     * @return index prvku s najmensim pomerom cena/hmotnost pre First Admissible
     */
    public int[] vymennaHeuristika(){
        boolean jeVymenaPripustna = false;
        boolean jeVymenaVhodna = false;
        int hmotnost = 0;
        int novaCenaBatohu = 0;
        
        do{
            for (int i = 0; i < aZaradene.size(); i++) {
                for (int j = 0; j < aNezaradene.size(); j++) {
                    //Pripustna? kapacita batoha sa nesmie prekrocit
                    hmotnost = aZaradene.get(i).dajHmotnostPrvku() - aNezaradene.get(j).dajHmotnostPrvku();
                    jeVymenaPripustna = hmotnost >= 0;

                    //Vhodna? maximalizujeme cenu, teda ocakavame, ze vkladany prvok bude mat vyssiu cenu nez uz pritomny v batohu
                    jeVymenaVhodna = aNezaradene.get(j).dajCenuPrvku() > aZaradene.get(i).dajCenuPrvku();
                    
                    if(jeVymenaPripustna && jeVymenaVhodna){
                        //vymen
                        aVysledneRiesenie[aZaradene.get(i).dajIndexVoVektoreRieseniDH()] = 0;
                        aVysledneRiesenie[aNezaradene.get(j).dajIndexVoVektoreRieseniDH()] = 1;
                        
                        //aktualizuj potrebne hodnoty batohu
                        aAktualHmotPrvkovVBatohu = 0;
                        novaCenaBatohu = 0;
                        for (int k = 0; k < aCelkovyPocPrvkov; k++) {
                            if(aVysledneRiesenie[k] == 1){
                                novaCenaBatohu += aPrvky[k].dajCenuPrvku();
                                aAktualHmotPrvkovVBatohu += aPrvky[k].dajHmotnostPrvku();
                            }   
                        }
                        
                        //aktualizuj polia zaradenych a nezaradenych prvkov
                        aZaradene.add(aNezaradene.get(j) );
                        aNezaradene.remove(j);
                        aNezaradene.add(aZaradene.get(i) );
                        aZaradene.remove(i);
                    }
                }
            }
            //doslo po vymene k zlepseniu (zvyseniu) hodnoty ucelovej funkcie (ceny batohu)?
            if(aAktualCenaPrvkovVBatohu < novaCenaBatohu){
                aAktualCenaPrvkovVBatohu = novaCenaBatohu;
                novaCenaBatohu = 0;
            }
            else break;
        }
        while(true);
        
        aPrevis = aAktualHmotPrvkovVBatohu - aKapacitaBatohu;
        
        return aVysledneRiesenie;
    }
}