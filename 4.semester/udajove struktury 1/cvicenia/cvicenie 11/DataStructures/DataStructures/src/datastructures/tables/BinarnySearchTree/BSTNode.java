/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package datastructures.tables.BinarnySearchTree;

import datastructures.tables.TablePair;

/**
 *
 * @author sisila
 */
public class BSTNode<K,E> {
    
    private TablePair<K,E> aPair;
    private BSTNode<K,E> aParent;
    private BSTNode<K,E> aLeft;
    private BSTNode<K,E> aRight;

    public BSTNode(K paKey, E paData) {
        aPair = new TablePair<>(paKey, paData);
        aParent = aLeft = aRight = null;
    }

    public TablePair<K, E> getPair() {
        return aPair;
    }

    public void setPair(TablePair<K, E> aPair) {
        this.aPair = aPair;
    }
    
    public K getKey(){
        return aPair.getKey();
    }
    
    public void setElement(E paElement){
        aPair.setElement(paElement);
    }
    
    public E getElement(){
        return aPair.getElement();
    }

    public BSTNode<K, E> getLeft() {
        return aLeft;
    }

    public void setLeft(BSTNode<K, E> aLeft) {
        this.aLeft = aLeft;
    }

    public BSTNode<K, E> getRight() {
        return aRight;
    }

    public void setRight(BSTNode<K, E> aRight) {
        this.aRight = aRight;
    }

    public BSTNode<K, E> getParent() {
        return aParent;
    }

    public void setParent(BSTNode<K, E> aParent) {
        this.aParent = aParent;
    }

    public boolean isLeft(){
        return !isRoot() && aParent.getLeft() == this;  //this - uzol sa sam seba spyta, ci je lavym synom
    }
    
    public boolean isRight(){
        return !isRoot() && aParent.getRight() == this;
    }
    
    public boolean isRoot(){
        return aParent == null;
    }
    
    public boolean hasParent(){
        return aParent != null;
    }
    
    public boolean hasLeft(){
        return aLeft != null;
    }
    
    public boolean hasRight(){
        return aRight != null;
    }
}
