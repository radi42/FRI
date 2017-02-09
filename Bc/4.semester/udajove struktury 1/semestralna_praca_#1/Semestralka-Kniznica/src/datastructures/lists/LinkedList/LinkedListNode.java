package datastructures.lists.LinkedList;

import java.io.Serializable;

/**
 *
 * @author Andrej Šišila
 */
public class LinkedListNode<E> implements Serializable{
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
