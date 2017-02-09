/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package datastructures.lists.LinkedList;

import datastructures.lists.EList;
import java.util.Iterator;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Andy
 */
public class LinkedListIterator<E> implements Iterator<E> {

    private LinkedList<E> aLinkedList;
    private LinkedListNode<E> aCurrent;
    
    public LinkedListIterator (LinkedList<E> paLinkedList){
        aLinkedList = paLinkedList;
        aCurrent = null;
    }
    
    @Override
    public boolean hasNext() {
        try{
            if(aLinkedList.size() == 0)
                return false;
            else
                return aCurrent == null || aCurrent.getNext() != null;
        } catch (EList ex) {
            return false;
        }
//        try {
//            //ak je size nulova, tak je to false
//            return( (aLinkedList.size()) > 0 && (aCurrent == null || aCurrent.getNext() != null));
//        } catch (EList ex) {
//            Logger.getLogger(LinkedListIterator.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return false;
    }

    @Override
    public E next() {
        //chod dalej
        if (aCurrent != null){
            aCurrent = aCurrent.getNext();
            return aCurrent.getData();
        }
        else{
            aCurrent = aLinkedList.getFirst();
            return aCurrent.getData();
        }
    }

    @Override
    public void remove() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
