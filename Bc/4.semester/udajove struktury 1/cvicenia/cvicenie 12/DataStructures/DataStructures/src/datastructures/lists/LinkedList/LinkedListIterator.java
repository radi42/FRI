/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package datastructures.lists.LinkedList;

import datastructures.lists.EList;
import java.util.Iterator;

/**
 *
 * @author Andy
 */
public class LinkedListIterator<E> implements Iterator<E> {

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
        //posun prsts
        E data = aCurrent.getData();
        aCurrent = aCurrent.getNext();
        return data;
    }

    @Override
    public void remove() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
