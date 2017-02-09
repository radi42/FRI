/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package datastructures.priorityFronts.PriorityFrontAL;

import datastructures.lists.ArrayList.ArrayListIterator;
import java.util.Iterator;

/**
 *
 * @author sisila
 */
public class PFListIteratorAL<E> implements Iterator<E>{

    private ArrayListIterator<PFNodeAL<E>> aIterator;
    
    public PFListIteratorAL(PFListAL<E> paPFList){
        aIterator = (ArrayListIterator<PFNodeAL<E>>)paPFList.aList.iterator();
    }
    
    
    
    @Override
    public boolean hasNext() {
        return aIterator.hasNext();
    }

    @Override
    public E next() {
        PFNodeAL<E> node = aIterator.next();
        return node.getData();
    }

    @Override
    public void remove() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
