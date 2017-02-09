package tables.SortedSequenceTable;

import datastructures.lists.ArrayList.ArrayList;
import datastructures.lists.EList;
import tables.ETable;
import tables.ITable;
import tables.NonsortedSequenceTable.NonsortedSeqenceTable;
import tables.Sorts.KeyComparer;
import tables.TablePair;


/**
 *
 * @author Andrej Šišila
 */
public class SortedSeqenceTable<K,E> extends NonsortedSeqenceTable<K, E> implements ITable<K,E>{

    private KeyComparer<K> aComparer;
    
    public SortedSeqenceTable(KeyComparer<K> paComparer){
        super();
        aComparer = paComparer;
    }
    
    @Override
    public void insert(K paKey, E paElement) throws ETable {
        try {
            if(isEmpty()){
                super.insert(paKey, paElement);
            }
            int index = bisection(paKey, 0, size() -1, true);
            if(!aComparer.areEqual(paKey, aTableElements.get(index).getKey() ) ){
                if(aComparer.firstIsGreater(paKey, aTableElements.get(index).getKey() ) )
                    index++;
                aTableElements.insert(new TablePair<>(paKey, paElement), index);
            }
            
        } catch (EList ex) {
            throw new ETable("chyba insertu " + ex.getMessage() );
        }
        
    }
    
    
//    @Override
//    public E delete(K paKey) throws ETable {
//        int index = indexOfKey(paKey);
//        try {
//            if(index != -1){
//                return aTableElements.deleteFromIndex(index).getElement();
//            }
//            else{
//                throw new ETable("chyba deleteu: kluc neexistuje");
//            }
//        } catch (EList ex) {
//            throw new ETable("chyba findu " + ex.getMessage() );
//        }
//    }
    
    //bisekcia
    protected int indexOfKey(K paKey) throws ETable{
        return bisection(paKey, 0, size() -1, false);
    }
    
    /**
     * 
     * @param paKey
     * @param paAlwaysReturnIndex sluzi iba pre insert(): vrati index na ktorom som skoncil aj napriek tomu, ze sa kluc v tabulke nenasiel: false ak sa nasiel, True ak nie; ci sa prvok v poli nachadza
     * @return 
     */
    private int bisection(K paKey, int paFrom, int paTo, boolean paAlwaysReturnIndex) throws ETable{
        try {
            //mam slusny interval
            if (paTo < paFrom)
                return -1;
            
            int midIndex = (paFrom + paTo) / 2;
            K midKey = aTableElements.get(midIndex).getKey();
            
            if (aComparer.areEqual(paKey, midKey) ){
                return midIndex;
            }
            else if(paFrom == paTo){
                return (paAlwaysReturnIndex) ? midIndex : -1;
            }
            else if(aComparer.firstIsLess(paKey, midKey)){
                //ak si mensi, hod sa dolava
                return bisection(paKey, paFrom, midIndex, paAlwaysReturnIndex);
            }
            else {
                //ak si vacsi, hod sa doprava; intervaly sa navzajom neprekryvaju tj. su disjunktne
                return bisection(paKey, midIndex +1, paTo, paAlwaysReturnIndex);
            }
        } catch (EList ex) {
            return -1;
        }
          
    }
}