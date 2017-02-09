/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package datastructures.lists.LinkedList;

import data.Person;
import datastructures.lists.EList;
import datastructures.lists.IList;

import java.util.Iterator;

/**
 *
 * @author Andy
 * @param <E>
 */
public class LinkedList<E> implements IList<E> {
  private LinkedListNode<E> aFirst;
  private LinkedListNode<E> aLast;
  private int aSize;
  
  public LinkedList(){
   aFirst=null;
   aLast=null;
   aSize=0;
  }

    public LinkedList(Class<Person> aClass) {
        
    }
    @Override
    public void add(E paElement) throws EList {
       if(aLast == null){
          aLast=new LinkedListNode<E>(paElement);
          aFirst=aLast;
       }
       else{
         aLast.setNext(new LinkedListNode<E>(paElement));
         aLast=aLast.getNext();
       }
       aSize++;
    }

    @Override
    public void insert(E paElement, int paIndex) throws EList {
        
        aSize++;
    }

    @Override
    public E delete(E paElement) throws EList {
        aSize--;
        return null;
    }

    @Override
    public E deleteFromIndex(int paIndex) throws EList {
        if(aSize > 1 && paIndex < aSize -1){
            LinkedListNode<E> predchodca = getNodeFromindex(paIndex -1);
            LinkedListNode<E> nasledovnik = getNodeFromindex(paIndex +1);
            predchodca.setNext(nasledovnik);
        }
        aSize--;
        return null;
    }

    @Override
    public int indexOf(E paElement) throws EList {       
        LinkedListNode<E> node = aFirst;
        int index = 0;
        while(node != null){
            if(node.getData() == paElement) return index;
            else {
                index++;
                node = node.getNext();
            }
        }
        
        return -1;
    }

    @Override
    public E get(int paIndex) throws EList {
//        if(aSize >= 0 && paIndex < aSize){
//            LinkedListNode<E> node = aFirst;
//            for(int i = 0; i < paIndex; i++){
//                node = node.getNext();
//            }
//            return node.getData();
//        }
//        else {
//            throw new EList("Index out of bounds");
//        }
        return getNodeFromindex(paIndex).getData();
    }

    @Override
    public void set(int paIndex, E paElement) throws EList {
//        if(aSize >= 0 && paIndex < aSize){
//            LinkedListNode<E> node = aFirst;
//            for(int i = 0; i < paIndex; i++){
//                node = node.getNext();
//            }
//            node.setData(paElement);
//        }
//        else {
//            throw new EList("Index out of bounds");
//        }
        getNodeFromindex(paIndex).setData(paElement);
    }

    @Override
    public int size() throws EList {
       return aSize;
    }

    @Override
    public void clear() throws EList {
        aSize = 0;
        aFirst = null;
        aLast = null;
    }
    
    /**
     * Jakubove
     * @param paIndex
     * @return
     * @throws EList 
     */
    public LinkedListNode<E> findNode(int paIndex) throws EList{
//        if(paIndex>=0&&paIndex<=aSize){
//          LinkedListNode<E> node=aFirst;
//          for (int i = 0; i <= paIndex; i++) {
//              node=node.getNext();
//          }
//          return node;
//      }
//      else{throw new EList("Index out of bounds");}
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
    public LinkedListNode<E> getFirst(){
        return aFirst;
    }

    @Override
    public Iterator<E> iterator() {
        return new LinkedListIterator<>(this);
    }
    
    /**
     * metoda pre get set insert delete deleteFromIndex
     * predchadzajuci ukazuje na pridavany a pridavany ukazuje na nasledujuci
     * @param paIndex na akej pozicii
     * @return vracia uzol (node)
     * @throws EList 
     */
    private LinkedListNode<E> getNodeFromindex(int paIndex) throws EList{
        if(aSize >= 0 && paIndex < aSize){
            LinkedListNode<E> node = aFirst;
            for(int i = 0; i < paIndex; i++){
                node = node.getNext();
                return node;
            }
        }
        else {
            throw new EList("Index out of bounds");
        }
        return null;
    }
    
    
    //ako to prelinkovat
    //P         N
    //      I
    //P.next = I.dext
}
