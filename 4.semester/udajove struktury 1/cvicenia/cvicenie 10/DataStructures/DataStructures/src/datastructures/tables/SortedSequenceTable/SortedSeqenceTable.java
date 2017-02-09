/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package datastructures.tables.SortedSequenceTable;

import datastructures.lists.ArrayList.ArrayList;
import datastructures.lists.EList;
import datastructures.tables.ETable;
import datastructures.tables.ITable;
import datastructures.tables.NonsortedSequenceTable.NonsortedSeqenceTable;
import datastructures.tables.TablePair;
import java.util.Iterator;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author sisila
 */
public class SortedSeqenceTable<K,E> extends NonsortedSeqenceTable<K, E> implements ITable<K,E>{

    private ArrayList<TablePair<K,E>> sortedTab;
    
    public SortedSeqenceTable(){
        sortedTab = new ArrayList<>();
    }
    
    @Override
    public void insert(K paKey, E paElement) throws ETable {
        try {
            if(isEmpty()){
                super.insert(paKey, paElement);
            }
            else{
                int index = bisection(paKey, 0, size() -1, true);
                K key = aTableElements.get(index).getKey();
                if(paKey > key) //porovnavac objektov
                    index++;
                //ak je kluc vacsi, insertni prvok za neho
                if(index != -1 && aTableElements.get(index).getKey() != paKey)

                    aTableElements.insert(new TablePair<>(paKey, paElement), index);
                else{
                    throw new ETable("chyba insertu: kluc uz existuje ");
                }
            }
        } catch (EList ex) {
            throw new ETable("chyba insertu " + ex.getMessage() );
        }
    }
    
    //bisekcia
    protected int indexOfKey(K paKey) throws ETable{
        return bisection(paKey, 0, size() -1, false);
    }
    
    /**
     * 
     * @param paKey
     * @param paAlwaysReturnIndex vrati index aj napriek tomu, ze sa kluc v tabulke nenasiel: false ak sa nasiel, True ak nie
     * @return 
     */
    private int bisection(K paKey, int paFrom, int paTo, boolean paAlwaysReturnIndex) throws ETable{
        return -1;
    }
}