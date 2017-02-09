/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package datastructures.fronts.Front;

import datastructures.fronts.AbsFront;
import datastructures.fronts.EFront;
import datastructures.fronts.IFront;
import datastructures.lists.ArrayList.ArrayList;
import datastructures.lists.EList;
import datastructures.lists.LinkedList.LinkedList;
import java.util.Iterator;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * FIFO
 * @author sisila
 */
public class Front<E> extends AbsFront<E> implements IFront<E>{
    
    public Front(){
        super(new LinkedList());
    }
    
    /**
     * zlozitost O(1)
     * @param paElement
     * @throws EFront 
     */
    @Override
    public void push(E paElement) throws EFront {
        try{
            aList.add(paElement);   //pridavame na zaciatok
        } catch (EList ex) {
            throw new EFront(ex.getMessage());
        }
    }

    /**
     * zlozitost O(1)
     * @return
     * @throws EFront 
     */
    @Override
    public E pop() throws EFront {
        try{
            return aList.deleteFromIndex(0);    //vymazavame zo zaciatku
        } catch (EList ex) {
            throw new EFront(ex.getMessage());
        }
    }

    /**
     * zlozitost O(1)
     * @return
     * @throws EFront 
     */
    @Override
    public E peek() throws EFront {
        try {
            return aList.get(0);    //kukneme na zaciatok
        } catch (EList ex) {
            throw new EFront(ex.getMessage());
        }
    }
    
    //iterator sa nachadza v triede AbsFront, lebo iterator pre Front a Stack je rovnaky
}
