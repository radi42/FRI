/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package datastructures.tables.NonsortedSequenceTable;

import datastructures.lists.ArrayList.ArrayList;
import datastructures.lists.EList;
import datastructures.lists.IList;
import datastructures.lists.LinkedList.LinkedList;
import datastructures.tables.ETable;
import datastructures.tables.ITable;
import datastructures.tables.Sorts.KeyComparer;
import datastructures.tables.TablePair;
import java.util.Iterator;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author sisila
 */
public class NonsortedSeqenceTable<K,E> implements ITable<K,E>{

    protected IList<TablePair<K,E>> aTableElements;
    
    public NonsortedSeqenceTable(){
        aTableElements = new ArrayList<>();     //implicitna implementacia
        //aTableElements = new LinkedList<>();  //explicitna implementacia
    }
    
    @Override
    public void insert(K paKey, E paElement) throws ETable {
        int index = indexOfKey(paKey);
        try {
            if(!containsKey(paKey)){
                aTableElements.add(new TablePair<>(paKey, paElement));
            }
            else{
                throw new ETable("chyba insertu: kluc uz existuje ");
            }
        } catch (EList ex) {
            throw new ETable("chyba insertu " + ex.getMessage() );
        }
    }

    @Override
    public E delete(K paKey) throws ETable {
        int index = indexOfKey(paKey);
        try {
            if(index != -1){
                E deleted = aTableElements.get(index).getElement();
                aTableElements.deleteFromIndex(index);  //efektivnejsie: ak pracujeme s arraylistom treba swapovat tj.: vymen posledny prvok s tym, ktory sa maze, a vymaz posledny; kedze je to neutriedene; je to takto napisane aby sme to mohli pouzit aj na array- aj na linkedlist
                return deleted;
            }
            else{
                throw new ETable("chyba deleteu: kluc neexistuje");
            }
        } catch (EList ex) {
            throw new ETable("chyba findu " + ex.getMessage() );
        }
    }

    @Override
    public E find(K paKey) throws ETable {
        int index = indexOfKey(paKey);
        try {
            return (index != -1 ? aTableElements.get(index).getElement() : null);
        } catch (EList ex) {
            throw new ETable("chyba findu " + ex.getMessage() );
        }
    }

    @Override
    public void modify(K paKey, E paNewElement) throws ETable {
        int index = indexOfKey(paKey);
        try {
            if(index != -1){
                aTableElements.get(index).setElement(paNewElement);
            }
            else{
                throw new ETable("chyba modifyu: kluc " + paKey + " nexistuje ");
            }
        } catch (EList ex) {
            throw new ETable("chyba modifyu " + ex.getMessage() );
        }
    }

    protected int indexOfKey(K paKey) throws ETable{
        try{
            //index kluca
            for (int i = 0; i < size(); i++)
                if(aTableElements.get(i).getKey().equals(paKey) ) //== porovnava vonkajsok (miesto v pamati), equals porovnava aj vnitornosti; pre spravne vysledky treba porovnavat bud cez komparator alebo cez equals()
                    return i;
            }
        catch (EList ex){
            throw new ETable("chyba indexOfu " + ex.getMessage() );
        }
        //nenasiel sa
        return -1;
    }
    
    @Override
    public boolean containsKey(K paKey) throws ETable {
        return indexOfKey(paKey) != -1;
    }

    @Override
    public boolean isEmpty() throws ETable {
        return (size() == 0);
    }

    @Override
    public int size() throws ETable {
        try {
            return aTableElements.size();
        } catch (EList ex) {
            throw new ETable("Chyba sizeu" + ex.getMessage() );
        }
    }

    @Override
    public void clear() throws ETable {
        try {
            aTableElements.clear();
        } catch (EList ex) {
            throw new ETable("Chyba clearu" + ex.getMessage() );
        }
    }

    @Override
    public Iterator<TablePair<K, E>> iterator() {
        return aTableElements.iterator();
    }
    
    private void swap(int paIndex1, int paIndex2){
        
    }
}
