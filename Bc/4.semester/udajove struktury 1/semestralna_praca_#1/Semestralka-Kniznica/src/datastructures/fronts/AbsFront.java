package datastructures.fronts;

import datastructures.lists.EList;
import datastructures.lists.IList;
import java.io.Serializable;
import java.util.Iterator;

/**
 *
 * @author Andrej Šišila
 */
public abstract class AbsFront<E>  implements Serializable{
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
