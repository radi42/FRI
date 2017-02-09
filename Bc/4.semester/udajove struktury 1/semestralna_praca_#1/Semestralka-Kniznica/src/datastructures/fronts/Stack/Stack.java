package datastructures.fronts.Stack;

import datastructures.fronts.AbsFront;
import datastructures.fronts.EFront;
import datastructures.fronts.IFront;
import datastructures.lists.EList;
import datastructures.lists.LinkedList.LinkedList;
import java.io.Serializable;

/**
 *  LIFO
 * @author sisila
 */
public class Stack<E> extends AbsFront<E> implements IFront<E>, Serializable {
    
    public Stack(){
        super(new LinkedList());
    }

    @Override
    public void push(E paElement) throws EFront {
        try{
            aList.add(paElement);   //pridavame na zaciatok
        } catch (EList ex) {
            throw new EFront(ex.getMessage());
        }
    }

    @Override
    public E pop() throws EFront {
        try{
            return aList.deleteFromIndex(size() -1);    //vymazavame z konca
        } catch (EList ex) {
            throw new EFront(ex.getMessage());
        }
    }

    @Override
    public E peek() throws EFront {
        try {
            return aList.get(size() -1);    //kukneme na koniec
        } catch (EList ex) {
            throw new EFront(ex.getMessage());
        }
    }
    
    //iterator sa nachadza v triede AbsFront, lebo iterator pre Front a Stack je rovnaky
}
