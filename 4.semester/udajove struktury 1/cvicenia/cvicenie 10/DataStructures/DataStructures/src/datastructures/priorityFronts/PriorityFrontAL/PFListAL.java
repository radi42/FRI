/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package datastructures.priorityFronts.PriorityFrontAL;

import datastructures.lists.ArrayList.ArrayList;
import datastructures.lists.EList;
import datastructures.lists.LinkedList.LinkedList;
import datastructures.priorityFronts.EPriorityFront;
import datastructures.priorityFronts.IPriorityFront;
import java.util.Iterator;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Prioritny fron implementovany cez ArrayList (AL)
 * @author sisila
 */
public class PFListAL<E> implements IPriorityFront<E>{
    
    private int aSize;
    ArrayList<PFNodeAL<E>> aList;
    private int aLowestPriority;
    
    private PFNodeAL<E> otec;     //index / 2 celociselne
    private PFNodeAL<E> synLavy;  //index * 2
    private PFNodeAL<E> synPravy; //index * 2 + 1

    public PFListAL(){
        aList = new ArrayList<PFNodeAL<E>>();
        aLowestPriority = 0;
    }
    
    @Override
    public void push(E paElement, int paPriority) throws EPriorityFront {
        PFNodeAL<E> newNode = new PFNodeAL<E>(paElement, paPriority);
        
        //indexovat od jednotky!!!
    }

    @Override
    public E pop() throws EPriorityFront {
        if(isEmpty())
            return null;
        else
            return null;
    }

    @Override
    public E peek() throws EPriorityFront {
        if(isEmpty())
            return null;
        else {
            return null;
        }
    }

    @Override
    public boolean isEmpty() throws EPriorityFront {
        return size() == 0;
    }

    @Override
    public int size() throws EPriorityFront {
        return aSize;
    }

    @Override
    public void clear() throws EPriorityFront {
        aLowestPriority = 0;
        try {
            aList.deleteFromIndex(1);
        } catch (EList ex) {
            throw new EPriorityFront(ex.getMessage());
        }
    }

    @Override
    public Iterator<E> iterator() {
        return new PFListIteratorAL<>(this);
    }
    
}
