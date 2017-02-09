
import java.util.ArrayList;

/**
 * Tarryho algorytmus na konstrukciu takeho sledu v grafe g = (V, H), ktory
 * zacina v lubovolnom vrchole s patri V, prejde vsetkymi hranami komponentu
 * grafu G a skonci vo vrchole s.
 * @author Dobroslav Grygar
 */
class TarryhoAlgoritmus {
    
    private final boolean[][] aZadanie;
    private final int aPocetVrcholov;
    private ArrayList<Hrana> aInformacieHrany;
    private ArrayList<Vrchol> aInformacieVrcholy;
    private int aAktualnyVrchol;
    
    /**
     * Konstruktor ma za ulohu inicializovate premenne
     * Pouziva sa aj na zadavanie matic grafov.
     */
    public TarryhoAlgoritmus(){
        
        aInformacieHrany = new ArrayList<Hrana>();
        aInformacieVrcholy = new ArrayList<Vrchol>();
        
        // Pri pouziti niektoreho zo zadania, alebo pridaji vlastneho
        // je NUTNE zadat spravne cislo poctu vrcholov!
        aPocetVrcholov = 4;
        
        // Zadanie1... ma cesty... 4 vrcholy pospajane "do okola"    
        
        aZadanie = new boolean[][]{
            {false, true, false, true},
            {true, false, true, false},
            {false, true, false, true},
            {true, false, true, false}
        };
        
        
        // Zadanie2... nema cesty... trojuholnik + 1 osamoteny bod
        /*
        aZadanie = new boolean[][]{
            {false, false, false, false},
            {false, false, true, true},
            {false, true, false, true},
            {false, true, true, false}
        };
        */
        
        
        // Zadanie3... ma cesty... trojuholnik + 1 bod spojeny s jednym bodom v trojuholniu
        /*
        aZadanie = new boolean[][]{
            {false, false, false, true},
            {false, false, true, true},
            {false, true, false, true},
            {true, true, true, false}
        };
        */
        
        // Zadanie 4... ma cesty... 10 vrcholov vseliako pospajanych
        /*
        aZadanie = new boolean[][]{
            {false, true, false, false, true, false, false, false, false, false},
            {true, false, true, true, false, false, false, false, false, false},
            {false, true, false, false, false, true, false, false, false, false},
            {false, true, false, false, false, false, true, true, false, false},
            {true, false, false, false, false, false, false, false, false, false},
            {false, false, true, false, false, false, false, false, false, false},
            {false, false, false, true, false, false, false, true, false, false},
            {false, false, false, true, false, false, true, false, true, true},
            {false, false, false, false, false, false, false, true, false, false},
            {false, false, false, false, false, false, false, true, false, false}
        };
        */
        
        // Zadanie 5.... nema cesty... 4 vrcholy, ale 1 cesta je jednosmerna a neda sa obist
        
//        aZadanie = new boolean[][]{
//            {false, true, true, false},
//            {true, false, true, true},
//            {true, true, false, false},
//            {false, false, false, false}
//        };
        
        this.nacitajHodnoty();
        this.vykonajVypocet();
        
    }
    
    /**
     * Metoda nacita hodnoty z matice do ArrayListov.
     * Vytvori ArrayList hran a ArrayList vrcholov.
     */
    private void nacitajHodnoty(){
        
        for(int i=0; i < aPocetVrcholov; i++){
            
            aInformacieVrcholy.add(new Vrchol());
            
            for(int j = 0; j < aPocetVrcholov; j++){
                
                if(aZadanie[i][j] == true){
                    aAktualnyVrchol = i;
                    aInformacieHrany.add(new Hrana(i, j));
                } 
            }
        }
    }
    
    /**
     * Metoda zistuje ktorou hranou ma prejist.
     * Prednostne pouziva hrany, ktore nie su oznacene ako hrany prveho pristupu.
     * Metodu dokoncenie zavola az po prechode vsetkymi hranami (ak je to mozne).
     */
    private void vykonajVypocet(){
        
        Boolean mozemPouzitPrvyPristup = true;
        for (Hrana tato2 : aInformacieHrany) {
            if(tato2.dajVrchol1() == aAktualnyVrchol && tato2.dajPouzitie() == false && tato2.dajPrvyPristup() == false){
                mozemPouzitPrvyPristup = false;
                break;
            }
        }
            
        for (Hrana tato : aInformacieHrany) {
            
            if(tato.dajVrchol1() == aAktualnyVrchol && tato.dajPouzitie() == false 
                    && tato.dajPrvyPristup() == false && mozemPouzitPrvyPristup == false){
                
                this.vypis(tato);
                this.prejdiHranu(tato);
                
            }else if(tato.dajVrchol1() == aAktualnyVrchol && tato.dajPouzitie() == false 
                    && tato.dajPrvyPristup() == true && mozemPouzitPrvyPristup == true){
                
                this.vypis(tato);
                this.prejdiHranu(tato);
            }
        }
        this.dokoncenie();
    }
    
    /**
     * Metoda vykonava presun po hrane, meni aAktualnyVrchol, nastavuje objavenie vrcholu,
     * zastavuje hrany prveho pristupu a znovu (rekurzivne) vola metodu vykonajVypocet.
     */
    private void prejdiHranu(Hrana paTato){
        
        Hrana tato = paTato;
        aAktualnyVrchol = tato.dajVrchol2();
        tato.setPouzitie(true);
        
        if (aInformacieVrcholy.get(aAktualnyVrchol).dajObjavenie()== false){
            aInformacieVrcholy.get(aAktualnyVrchol).setaObjavenie(true);
            
            for (Hrana taDruha : aInformacieHrany) {
                
                if(taDruha.dajVrchol1() == tato.dajVrchol2() && taDruha.dajVrchol2() == tato.dajVrchol1()){
                    taDruha.setPrvyPristup(true);
                    break;
                }
            }
        }
        this.vykonajVypocet();
    }
    
    /**
     * Metoda zisti ci boli pri prechadzani prejdene vsetky vrcholy a hrany a vypise vysledok.
     */
     private void dokoncenie(){
         //Kontrola: Kazdy vrchol musi byt objaveny
        for(Vrchol jedenZoVsetkach : aInformacieVrcholy){
            if (jedenZoVsetkach.dajObjavenie() == false){
                System.out.println(" ");
                System.out.println("Nepodarilo sa skontolovat vsetky vrcholy!");
                System.out.println("Neexistuje cesta medzi kazdymi dvoma vrcholmi.");
                System.exit(0);
            } 
        }
        //Kontrola: Kazda hrana musi byt prejdena
        for (Hrana jednaZoVsetkych : aInformacieHrany){
            if (jednaZoVsetkych.dajPouzitie() == false){
                System.out.println(" ");
                System.out.println("Nepodarilo sa skontolovat vsetky hrany!");
                System.out.println("Neexistuje cesta medzi kazdymi dvoma vrcholmi.");
                System.exit(0);
            }
        }
        System.out.println(" ");
        System.out.println("Podarilo sa skontrolovat vsetky vrcholy!");
        System.out.println("Existuje cesta medzi kazdymi dvoma vrcholmi.");
        System.exit(0);
     }
    
     /**
     * Metoda sluziaca na vypis postupu riesenia.
     */
    private void vypis(Hrana paHrana){
        System.out.println("Aktulany vrchol: " + aAktualnyVrchol);
        System.out.println("Prechod hranou: " + paHrana.toString());
    }
}