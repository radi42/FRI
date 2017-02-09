/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package datastructures.lists.LinkedList;

/**
 *
 * @author Andy
 * @param <E>
 */
public class LinkedListNode<E> {
    private E aData;
    private  LinkedListNode<E> aNext;

    public LinkedListNode(E paData) {
        aData = paData;
        aNext = null;
    }
    
    public E getData(){
     return aData;
    }
    
    public void setData(E paData){
     aData=paData;
    }
    
    public LinkedListNode<E> getNext(){
      return aNext;
    }
    
    public void setNext(LinkedListNode<E> paNext){
      aNext=paNext;
    }
    
}
