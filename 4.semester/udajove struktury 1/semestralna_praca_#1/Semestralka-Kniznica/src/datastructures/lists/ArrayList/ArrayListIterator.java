package datastructures.lists.ArrayList;

import datastructures.lists.EList;
import java.io.Serializable;
import java.util.Iterator;

/**
 *
 * @author Andrej Šišila
 */
public class ArrayListIterator<E> implements Iterator<E>, Serializable {

    ArrayList<E> aList;
    int aIndex;
    public ArrayListIterator(ArrayList<E> paList) {
        aList = paList;
        aIndex = -1;
    }
        
    @Override
    /**
     * mame dalsi prvok?
     */
    public boolean hasNext() {
        try {
            return aIndex < aList.size() - 1;
        } catch (EList ex) {
            return false;
        }
        
    }

    @Override
    /**
     * vratim to, co sa na tom mieste nachadza a posuniem sa prstom o jedno dalej
     */
    public E next() {
        aIndex++;
        try {
            return aList.get(aIndex);
        } catch (EList ex) {
            return null;
        }
    }

    @Override
    public void remove() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    
}
