package kniznica.data;

import datastructures.lists.EList;
import datastructures.lists.LinkedList.LinkedList;
import java.io.Serializable;

/**
 *
 * @author Andrej Šišila
 */
public class ZotriedenyZoznam extends LinkedList<Kniha> implements Serializable{
    
    public ZotriedenyZoznam(){
        super();
    }
    
    /**
     * Metoda pridava do zoznamu knihu tak, ze triedi podla priezviska autora, 
     * mena autora a nazvu knihy v takomto poradi
     * @param paKniha vkladana kniha
     * @throws EList 
     */
    @Override
    public void add(Kniha paKniha) throws EList{
        if(super.getFirst() == null){
            super.add(paKniha);
        }
        else {
            String autorNazov = "";
            String dalsiAutorNazov = "";
            int velkost = size();
            
            for(int i=0; i < velkost; i++){
                autorNazov = paKniha.getAutorPriezvisko() + paKniha.getAutorMeno() + paKniha.getNazov();
                autorNazov.replace(" ", "");
                
                dalsiAutorNazov = get(i).getAutorPriezvisko() + get(i).getAutorMeno() + get(i).getNazov();
                dalsiAutorNazov.replace(" ", "");
                int stav = autorNazov.compareTo(dalsiAutorNazov);
                if(stav < 1){
                    super.insert(paKniha, i);
                    break;
                }
            }
            
            boolean najdena = false;
            for(int i=0; i < velkost; i++){
                if(paKniha == super.get(i))
                    najdena = true;
            }
            
            if(!najdena)
                super.add(paKniha);
        }
    }
}
