/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package datastructures.priorityFronts.PriorityFrontLL;

import datastructures.lists.EList;
import datastructures.lists.LinkedList.LinkedList;
import datastructures.priorityFronts.EPriorityFront;
import datastructures.priorityFronts.IPriorityFront;
import java.util.Iterator;

/**
 * Prioritny front implementovany cez LinkedList (LL)
 * @author sisila
 */
public class PFListLL<E> implements IPriorityFront<E>{
    
    LinkedList<PFNodeLL<E>> aList;
    private int aLowestPriority;

    public PFListLL(){
        aList = new LinkedList<PFNodeLL<E>>();
        aLowestPriority = 0;
    }
    
    /**
     * vlozi uzol s danou prioritou na dany index tak, aby bol zoznam usporiadany
     * @param paElement
     * @param paPriority
     * @throws EPriorityFront 
     */
    @Override
    public void push(E paElement, int paPriority) throws EPriorityFront {
        PFNodeLL<E> newNode = new PFNodeLL<E>(paElement, paPriority);
        
        //ak je priorita nasledujuceho prvku vacsia ako najnizsia, nastav najnizsiu prioritu na toto cislo 
        //if(paPriority > aLowestPriority) aLowestPriority = paPriority;
        
        try{
            if(isEmpty()){
                try {
                aList.add(newNode);
                aLowestPriority = paPriority;
                } catch (EList ex) {
                    throw new EPriorityFront(ex.getMessage());
                }
            }
            else{
                if(paPriority > aLowestPriority){ 
                    //aList.insert(newNode, size());  //uloz na koniec
                    aList.add(newNode);     //uloz na koniec
                    aLowestPriority = paPriority;
                }
                else {
                    int index = 0;
                    while(index < size() && aList.get(index).getPriority() <= paPriority){ //zmazat rovna sa pre pridavanie s rovnakym indexom za prvok tj. aList.get(index).getPriority() <= paPriority
                        index++;
                    }
                    aList.insert(newNode, index);
                }
            }
        }
        catch(EList ex){
            throw new EPriorityFront(ex.getMessage());
        }
    }

    @Override
    /**
     * vyhadzuje prvok s najvyssou prioritou (vyhodenia)
     */
    public E pop() throws EPriorityFront {
        if(isEmpty())
            return null;
        else {
            try {
                return aList.deleteFromIndex(0).getData();
            } catch (EList ex) {
                throw new EPriorityFront(ex.getMessage());
            }
        }
    }

    @Override
    public E peek() throws EPriorityFront {
        if(isEmpty())
            return null;
        else {
            try {
                return aList.get(0).getData();
            } catch (EList ex) {
                throw new EPriorityFront(ex.getMessage());
            }
        }
    }

    @Override
    public boolean isEmpty() throws EPriorityFront {
        return size() == 0;
    }

    @Override
    public int size() throws EPriorityFront {
        try {
            return aList.size();
        } catch (EList ex) {
            throw new EPriorityFront(ex.getMessage());
        }
    }

    @Override
    public void clear() throws EPriorityFront {
        try {
            aLowestPriority = 0;
            aList.clear();
        } catch (EList ex) {
            throw new EPriorityFront(ex.getMessage());
        }
    }

    @Override
    public Iterator<E> iterator() {
        return new PFListIteratorLL<>(this);
    }
    
}
