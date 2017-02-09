
import java.util.ArrayList;

public class Preteky {
    private ArrayList<Pretekar> aPretekari;
    private int aStartovacieCislo = 100;
    
    public Preteky(){
        aPretekari = new ArrayList<>();
    }
    
    public int dajPocetVsetkychPretekarov(){
        return aPretekari.size();
    }
    
    public int dajIndexPretekaraPodlaMena(String paMeno){
        int cisloPretekara = -1;
        for (int i = 0; i < aPretekari.size(); i++) {
            boolean menaSaRovnaju = aPretekari.get(i).getMeno() == paMeno;
            if(menaSaRovnaju){
                cisloPretekara = i;
                return cisloPretekara;
            }
        }
        return cisloPretekara;
    }
    
    public int dajNoveStartovacieCislo(){
        int cislo = aStartovacieCislo;
        aStartovacieCislo++;
        return cislo;
    }
    
    public int pridajPretekara(String paMenoPretekara){
        Pretekar pretekar = null;
        pretekar = new Pretekar(paMenoPretekara, dajNoveStartovacieCislo());
        aPretekari.add(pretekar);
        return (pretekar != null) ? pretekar.dajStartovneCislo() : -1;
    }
    
    public int dajIndexPretekara(int paStartovacieCislo){
        int cisloPretekara = -1;
        for (int i = 0; i < aPretekari.size(); i++) {
            if(aPretekari.get(i).dajStartovneCislo() == paStartovacieCislo){
                cisloPretekara = i;
            }
        }
        return cisloPretekara;
    }
    
    
    public Pretekar dajPretekara(int paStartovacieCislo){
        int cisloPretekara = -1;
        for (int i = 0; i < aPretekari.size(); i++) {
            if(aPretekari.get(i).dajStartovneCislo() == paStartovacieCislo){
                cisloPretekara = i;
            }
        }
        return cisloPretekara != -1 ? aPretekari.get(cisloPretekara) : null;
    }
    
    public Pretekar dajPretekaraNaIndexe(int paIndex){
        if(paIndex < 0 || paIndex >= aPretekari.size()) return null;
        else return aPretekari.get(paIndex);
    }
    
    @Override
    public String toString(){
        String vyhodnotenie = "Pretekaju\n";
        
        for (Pretekar p : aPretekari) {
            vyhodnotenie += p.dajStartovneCislo() + ". " + p.toString() +"\n";
        }
        
        return vyhodnotenie;
    }
    
    public void nastavCasPretekarovi(int paStartovneCislo, int paCas){
        int cisloPretekara = dajIndexPretekara(aStartovacieCislo);
        if(cisloPretekara != -1) aPretekari.get(cisloPretekara).setCasBehu(paCas);
    }
    
    public void nastavCasPretekaroviPodlaIndexu(int paIndex, int paCas){
        aPretekari.get(paIndex).setCasBehu(paCas);
    }
    
    public void nastavStrelbuPretekarovi(int paStartovneCislo, Strelba paStrelba){
        int cisloPretekara = dajIndexPretekara(aStartovacieCislo);
        if(cisloPretekara != -1) aPretekari.get(cisloPretekara).vlozStrelbu(paStrelba);
    }
    
    public Pretekar najdiVitaza(){
        int najlepsiCas = Integer.MAX_VALUE;
        Pretekar pretekar = null;
        for (Pretekar p : aPretekari){
            if(p.dajCelkovyCas() < najlepsiCas && p.pretekarDobeholDoCiela()){
                najlepsiCas = p.dajCelkovyCas();
                pretekar = p;
            }
        }
        return pretekar;
    }
}
