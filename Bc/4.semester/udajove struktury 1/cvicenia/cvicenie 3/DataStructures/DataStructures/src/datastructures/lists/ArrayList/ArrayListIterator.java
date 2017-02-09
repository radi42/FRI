/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package datastructures.lists.ArrayList;

import datastructures.lists.EList;
import java.util.Iterator;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author sisila
 */
public class ArrayListIterator<E> implements Iterator<E> {

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
     * posuniem sa prstom o jedno dalej a vratim to, co sa na tom mieste nachadza
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
