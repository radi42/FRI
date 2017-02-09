package datastructures.priorityFronts.PriorityFrontLL;

import datastructures.lists.LinkedList.LinkedListIterator;
import java.io.Serializable;
import java.util.Iterator;

/**
 *
 * @author Andrej Šišila
 */
public class PFListIteratorLL<E> implements Iterator<E>, Serializable{

    private LinkedListIterator<PFNodeLL<E>> aIterator;
    
    public PFListIteratorLL(PFListLL<E> paPFList){
        aIterator = (LinkedListIterator<PFNodeLL<E>>)paPFList.aList.iterator();
    }
    
    
    
    @Override
    public boolean hasNext() {
        return aIterator.hasNext();
    }

    @Override
    public E next() {
        PFNodeLL<E> node = aIterator.next();
        return node.getData();
    }

    @Override
    public void remove() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
