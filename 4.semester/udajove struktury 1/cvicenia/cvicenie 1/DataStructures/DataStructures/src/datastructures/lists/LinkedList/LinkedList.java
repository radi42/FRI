/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datastructures.lists.LinkedList;

import datastructures.lists.EList;
import datastructures.lists.IList;
import java.util.Iterator;

/**
 *
 * @author Andy
 */
public class LinkedList<E> implements IList<E> {

    private LinkedListNode<E> aFirst;
    private LinkedListNode<E> aLast;
    private int aSize;
    
    public LinkedList() {
        aFirst = null;
        aLast = null;
        aSize = 0;
    }
    
    @Override
    /**
     * 
     */
    public void add(E paElement) throws EList {
        if (aLast == null) { //alebo ak size je 0
            aLast = new LinkedListNode<E> (paElement);
            aFirst = aLast;
        }
        else {
            aLast.setNext(new LinkedListNode<E> (paElement));
            aLast = aLast.getNext();
        }
        aSize++;
    }

    @Override
    public void insert(E paElement, int paIndex) throws EList {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public E delete(E paElement) throws EList {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public E deleteFromIndex(int paIndex) throws EList {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int indexOf(E paElement) throws EList {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public E get(int paIndex) throws EList {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void set(int paIndex, E paElement) throws EList {
        
    }

    @Override
    public int size() throws EList {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void clear() throws EList {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Iterator<E> iterator() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
