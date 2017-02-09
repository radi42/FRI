/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datastructures.lists.LinkedList;

/**
 *
 * @author Andy
 */
public class LinkedListNode<E> {
    private E aData;
    private LinkedListNode<E> aNext;
    
    public LinkedListNode(E paData){
        aData = paData;
        aNext = null;
    }
    
    public E getData() {
        return aData;
    }
    
    public void setData(E paData) {
        aData = paData;
    }
    
    public LinkedListNode<E> getNext() {
        return aNext;
    }
    
    public void setNext (LinkedListNode<E> paNext) {
        aNext = paNext;
    }
}
