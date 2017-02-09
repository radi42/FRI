package datastructures.lists.LinkedList;

import java.io.Serializable;
import java.util.Iterator;

/**
 *
 * @author Andrej Šišila
 */
public class LinkedListIterator<E> implements Iterator<E>, Serializable {

    private LinkedList<E> aLinkedList;
    private LinkedListNode<E> aCurrent;
    
    public LinkedListIterator (LinkedList<E> paLinkedList){
        aLinkedList = paLinkedList;
        aCurrent = aLinkedList.aFirst;
    }
    
    @Override
    public boolean hasNext() {
        //mas dalsi
        return aCurrent != null;
    }

    @Override
    public E next() {
        //posun prst
        E data = aCurrent.getData();
        aCurrent = aCurrent.getNext();
        return data;
    }

    @Override
    public void remove() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
