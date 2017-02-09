/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package datastructures.tables.BinarnySearchTree;

import datastructures.tables.ETable;
import datastructures.tables.ITable;
import datastructures.tables.Sorts.KeyComparer;
import datastructures.tables.TablePair;
import java.util.Iterator;

    
/**
 *
 * @author sisila
 */
public class BinarySearchTree<K,E> implements ITable<K,E>{
    
    private int aSize;
    protected BSTNode<K,E> aRoot;
    private KeyComparer<K> aComparer;
    
    public BinarySearchTree(KeyComparer<K> paComparer){
        aSize = 0;
        aComparer = paComparer;
    }

    private BSTNode<K,E> findNode(K paKey, boolean paAlwaysReturnNode) throws ETable{
        if(isEmpty())
            return null;
        
        BSTNode<K,E> node = aRoot;
        
        while(node != null && !aComparer.areEqual(paKey, node.getKey())){
            if(aComparer.firstIsLess(paKey, node.getKey())){
                if(paAlwaysReturnNode && node.getLeft() == null)
                    return node;
                node = node.getLeft();  //ak si mensi, ides do lava
            }
            else{
                if(paAlwaysReturnNode && node.getRight() == null)
                    return node;
                node = node.getRight(); //ak si vacsi, 
            }
        }
        
        return node;
    }
    
    private void joinLeft(BSTNode<K,E> paParent, BSTNode<K,E> paChild) throws ETable{
        if(paParent.getLeft() != null)
            throw new ETable("uz mam laveho");
        detach(paChild);
        paParent.setLeft(paChild);
        paChild.setParent(paParent);
    }
    
    private void joinRight(BSTNode<K,E> paParent, BSTNode<K,E> paChild) throws ETable{
        if(paParent.getRight() != null)
            throw new ETable("uz mam praveho");
        
        detach(paChild);
        paParent.setRight(paChild);
        paChild.setParent(paParent);
    }
    
    private void detach(BSTNode<K,E> paChild){
        if(!paChild.isRoot())
            if(paChild.isLeft() )
                paChild.getParent().setLeft(null);
            else
                paChild.getParent().setRight(null);

            paChild.setParent(null);
        }

    @Override
    public void insert(K paKey, E paElement) throws ETable {
        BSTNode<K,E> newNode = new BSTNode<>(paKey, paElement);
        
        if(isEmpty() ){
            aRoot = newNode;
        }
        else{
            BSTNode<K,E> parent = findNode(paKey, true);    //alwaysreturnnode musi vzdy vratit uzol, preto true
            if(!aComparer.areEqual(paKey, parent.getKey() )) {
                if(aComparer.firstIsGreater(paKey, parent.getKey() ))
                    //vacsie prvky su vzdy vpravo
                    joinRight(parent, newNode);
                else
                    //mensie su vzdy vlavo
                    joinLeft(parent, newNode);
            }
            else{
                throw new ETable("kluc nie je unikatny");
            }
        }
        aSize++;
    }
    
    @Override
    public E delete(K paKey) throws ETable {
//        while(){
//            
//        }
        return null;
    }
    
    @Override
    public E find(K paKey) throws ETable {
        return findNode(paKey, false).getElement();
    }

    @Override
    public void modify(K paKey, E paNewElement) throws ETable {
        findNode(paKey, false).setElement(paNewElement);
    }

    @Override
    public boolean containsKey(K paKey) throws ETable {
        return findNode(paKey, false) != null;
    }

    @Override
    public boolean isEmpty() throws ETable {
        return aSize == 0 || aRoot == null;
    }

    @Override
    public int size() throws ETable {
        return aSize;
    }

    @Override
    public void clear() throws ETable {
        aRoot = null;
    }

    @Override
    public Iterator<TablePair<K, E>> iterator() {
        return new BSTIterator<>(this);
    }
}