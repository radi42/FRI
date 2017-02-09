/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package datastructures.fronts;

import datastructures.lists.EList;
import datastructures.lists.IList;
import java.util.Iterator;

/**
 *
 * @author sisila
 */
public abstract class AbsFront<E> {
    protected IList<E> aList;
    
    protected AbsFront(IList<E> paList){
        aList = paList;
    }
    
    public int size() throws EFront{
        try{
            return aList.size();
        }
        catch (EList ex){
            throw new EFront(ex.getMessage());
        }
    }
    
    public boolean isEmpty() throws EFront {
        return size() == 0;
    }
    
    public void clear() throws EFront{
        try{
            aList.clear();
        }
        catch (EList ex){
            throw new EFront(ex.getMessage());
        }
    }
    
    //iterator sa nachadza v triede AbsFront, lebo iterator pre Front a Stack je rovnaky
    public Iterator<E> iterator() {
        return aList.iterator();
    }
}
