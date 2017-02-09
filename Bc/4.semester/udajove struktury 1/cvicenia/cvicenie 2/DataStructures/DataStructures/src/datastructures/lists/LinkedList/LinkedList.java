/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datastructures.lists.LinkedList;

import datastructures.lists.EList;
import datastructures.lists.IList;
import java.lang.reflect.Array;
import java.util.Iterator;

/**
 *
 * @author Andy
 */
public class LinkedList<E> implements IList{
    
    private int aSize;
    private E [] aElements;
    private Class<E> aElementClass;
    private E aFirst;
    private E aLast;
    
    public LinkedList(Class<E> paElementClass){
        aElementClass = paElementClass;
        aElements = (E[])Array.newInstance(paElementClass, aSize);
        //aFirst
        aSize = 0;
    }

    @Override
    public void add(Object paElement) throws EList {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void insert(Object paElement, int paIndex) throws EList {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Object delete(Object paElement) throws EList {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Object deleteFromIndex(int paIndex) throws EList {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int indexOf(Object paElement) throws EList {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Object get(int paIndex) throws EList {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void set(int paIndex, Object paElement) throws EList {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int size() throws EList {
        return aSize;
    }

    @Override
    public void clear() throws EList {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Iterator iterator() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
