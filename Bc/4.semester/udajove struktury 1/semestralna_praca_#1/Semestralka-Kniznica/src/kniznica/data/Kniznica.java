package kniznica.data;

import datastructures.fronts.Stack.Stack;
import datastructures.lists.ArrayList.ArrayList;
import datastructures.lists.EList;
import datastructures.fronts.EFront;
import datastructures.priorityFronts.EPriorityFront;
import java.io.Serializable;
import kniznica.Exception.EKniznica;

/**
 *
 * @author Andrej Šišila
 */
public class Kniznica implements Serializable{
    
    private ArrayList<Citatel> aCitatelia;
    //private ArrayList<Kniha> aKnihyVKniznici;
    private ZotriedenyZoznam aKnihyVKniznici;
    private Stack<Kniha> aVrateneKnihy;
    
    public Kniznica(){
        aCitatelia = new ArrayList<Citatel>();
        //aKnihyVKniznici = new ArrayList<Kniha>();
        aKnihyVKniznici = new ZotriedenyZoznam();
        aVrateneKnihy = new Stack<Kniha>();
    }
    
    public ArrayList<Citatel> getCitatelia(){
        return aCitatelia;
    }
    
//    public ArrayList<Kniha> getKnihyVKniznici(){
//        return aKnihyVKniznici;
//    }
    
    public ZotriedenyZoznam getKnihyVKniznici(){
        return aKnihyVKniznici;
    }
    
    public Stack<Kniha> getVrateneKnihy(){
        return aVrateneKnihy;
    }
    
    public void pridajKnihu(String paAutorMeno, String paAutorPriezvisko, String paNazov, int paRokVydania) throws EKniznica{
        try {
            aKnihyVKniznici.add(new Kniha(paAutorMeno, paAutorPriezvisko, paNazov, paRokVydania));
        } catch (EList ex) {
            throw new EKniznica("Nepodarilo sa " + ex.getMessage());
        }
    }
    
    public void pridajZaner(Kniha paKniha, String paNazovZanru) throws EKniznica{
        try {
            int index = aKnihyVKniznici.indexOf(paKniha);
            aKnihyVKniznici.get(index).pridajZaner(paNazovZanru);
        } catch (EList ex) {
            throw new EKniznica("Nepodarilo sa " + ex.getMessage());
        }
    }
    
    public ArrayList<Kniha> vsetkyKnihyDanehoZanru(String paNazovZanru) throws EKniznica{
        ArrayList<Kniha> zoznam = new ArrayList<Kniha>();
        try{
            for(int i=0; i < aKnihyVKniznici.size(); i++){
               for(int j=0; j < aKnihyVKniznici.get(i).getZaner().size(); j++){
                   if(aKnihyVKniznici.get(i).getZaner().get(j).contains(paNazovZanru))
                       zoznam.add(aKnihyVKniznici.get(i));
               }
            }
        
        } catch(EList ex){
             throw new EKniznica("Nepodarilo sa " + ex.getMessage());
        }
        
        return zoznam;
    }
    
    /**
     * 
     * @param paNazovKnihy je potrebne zadat presny nazov knihy
     */
    public ArrayList<Kniha> vyhladajKnihuPodlaNazvu(String paNazovKnihy) throws EKniznica{
        ArrayList<Kniha> zoznam = new ArrayList<Kniha>();
        try{
            for(int i=0; i < aKnihyVKniznici.size(); i++){
                if(aKnihyVKniznici.get(i).getNazov().toLowerCase().contains(paNazovKnihy.toLowerCase()))
                    zoznam.add(aKnihyVKniznici.get(i));
            }
        } catch(EList ex){
             throw new EKniznica("Nepodarilo sa " + ex.getMessage());
        }
        return zoznam;
    }
    
    public void registrovatNovehoCitatela(String paMeno, String paPriezvisko, int paVek) throws EKniznica{
        try {
            aCitatelia.add(new Citatel(paMeno, paPriezvisko, paVek));
        } catch (EList ex) {
            throw new EKniznica("Nepodarilo sa " + ex.getMessage());
        }
    }

    public void pozicatKnihu(Citatel paCitatel, Kniha paKniha) throws EKniznica{
        if(paKniha.getDostupna() == true){
            try {
                
                paKniha.setDostupna(false);
                paCitatel.setPocetPozicanychKnihTeraz(paCitatel.getPocetPozicanychKnihTeraz() +1);
                paCitatel.setPocetPozicanychKnihCelkovo(paCitatel.getPocetPozicanychKnihCelkovo() +1);
                paCitatel.getJehoKnihy().add(paKniha);
                
                if(paCitatel.getPocetCakajucichPoziadaviek() > 0)// && chceTutoKnihu)
                    paCitatel.setPocetCakajucichPoziadaviek(paCitatel.getPocetCakajucichPoziadaviek() -1);
                
            } catch (EList ex) {
                throw new EKniznica("Nepodarilo sa " + ex.getMessage());
            } catch (NullPointerException ex){
                throw new EKniznica("Kniha nemoze existovat " + ex.getMessage());
            }
        }
        else{
            try {
                paKniha.getZoznamCakatelov().push(paCitatel, paCitatel.getPrioritaCitatela());
                paCitatel.setPocetCakajucichPoziadaviek(paCitatel.getPocetCakajucichPoziadaviek() +1);
            } catch (EPriorityFront ex) {
                throw new EKniznica("Nepodarilo sa " + ex.getMessage());
            }
        }
        
    }
    
    public void vratitKnihu(Citatel paCitatel, Kniha paKniha) throws EKniznica{
        try {
            paKniha.setDostupna(false);
            aVrateneKnihy.push(paKniha);
            paCitatel.setPocetPozicanychKnihTeraz(paCitatel.getPocetPozicanychKnihTeraz() -1);
            paCitatel.getJehoKnihy().delete(paKniha);
                
        } catch (EFront ex) {
            throw new EKniznica("Nepodarilo sa " + ex.getMessage());
        } catch (EList ex) {
            throw new EKniznica("Nepodarilo sa " + ex.getMessage());
        }
    }
    
    public void spracujVsetkyVrateneKnihy() throws EKniznica{
        Kniha kontrolovanaKniha = null;
        Citatel cita = null;
        try{
            while(!aVrateneKnihy.isEmpty()){
                kontrolovanaKniha = aVrateneKnihy.pop();
                for(int i = 0; i < aKnihyVKniznici.size(); i++){
                    if(kontrolovanaKniha == aKnihyVKniznici.get(i)){
                        aKnihyVKniznici.get(i).setDostupna(true);
                        if(!aKnihyVKniznici.get(i).getZoznamCakatelov().isEmpty()){
                            cita = aKnihyVKniznici.get(i).getZoznamCakatelov().pop();
                            pozicatKnihu(cita, kontrolovanaKniha);
                        }
                    }
                }
            }
        } catch (EFront ex) {
            throw new EKniznica("Nepodarilo sa zasobnikovat" + ex.getMessage());
        } catch (EList ex) {
            throw new EKniznica("Nepodarilo sa kniznicovat" + ex.getMessage());
        } catch (EPriorityFront ex) {
            throw new EKniznica("Nepodarilo sa priorityfrontovat" + ex.getMessage());
        }
    }
    
    public ArrayList<Citatel> vyhladajCitatelaPodlaMaxPozicanychKnihCelkovo() throws EKniznica{
        try {
            //najprv najdi maximalny pocet pozicanych knih celkovo
            int maximum = 0;
            for(int i=0; i<aCitatelia.size(); i++){
                if(aCitatelia.get(i).getPocetPozicanychKnihCelkovo() >= maximum){
                    maximum = aCitatelia.get(i).getPocetPozicanychKnihCelkovo();
                }
            }
            
            //potom najdi citatelov, ktori splnaju pocet maximalny pocet celkovo pozicanych knih
            ArrayList<Citatel> zoznam = new ArrayList<Citatel>();
            for(int i=0; i<aCitatelia.size(); i++){
                if(aCitatelia.get(i).getPocetPozicanychKnihCelkovo() == maximum){
                    zoznam.add(aCitatelia.get(i));
                }
            }
            return zoznam;
        } catch (EList ex) {
            throw new EKniznica("Nepodarilo sa " + ex.getMessage());
        }
    }
    
    public ArrayList<Citatel> vyhladajCitatelaPodlaMaxPozicanychKnihAktualne() throws EKniznica{
        try {
            //najprv najdi maximalny pocet pozicanych knih aktualne
            int maximum = 0;
            for(int i=0; i<aCitatelia.size(); i++){
                if(aCitatelia.get(i).getPocetPozicanychKnihTeraz() >= maximum){
                    maximum = aCitatelia.get(i).getPocetPozicanychKnihTeraz();
                }
            }
            
            //potom najdi citatelov, ktori splnaju pocet maximalny pocet teraz pozicanych knih
            ArrayList<Citatel> zoznam = new ArrayList<Citatel>();
            for(int i=0; i<aCitatelia.size(); i++){
                if(aCitatelia.get(i).getPocetPozicanychKnihTeraz() == maximum){
                    zoznam.add(aCitatelia.get(i));
                }
            }
            return zoznam;
        } catch (EList ex) {
            throw new EKniznica("Nepodarilo sa " + ex.getMessage());
        }
    }
    
    public ArrayList<Citatel> vyhladajCitatelaPodlaMaxCakajucichPoziadaviek() throws EKniznica{
        try {
            //najprv najdi maximalny pocet cakajucich poziadaviek
            int maximum = 0;
            for(int i=0; i<aCitatelia.size(); i++){
                if(aCitatelia.get(i).getPocetCakajucichPoziadaviek() >= maximum){
                    maximum = aCitatelia.get(i).getPocetCakajucichPoziadaviek();
                }
            }
            
            //potom najdi citatelov, ktori splnaju pocet maximalny pocet cakajucich poziadaviek
            ArrayList<Citatel> zoznam = new ArrayList<Citatel>();
            for(int i=0; i<aCitatelia.size(); i++){
                if(aCitatelia.get(i).getPocetCakajucichPoziadaviek() == maximum){
                    zoznam.add(aCitatelia.get(i));
                }
            }
            return zoznam;
        } catch (EList ex) {
            throw new EKniznica("Nepodarilo sa " + ex.getMessage());
        }
    }
}
