/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package tables.BinarnySearchTree;

import datastructures.lists.EList;
import datastructures.lists.LinkedList.LinkedList;
import java.util.Iterator;
import java.util.logging.Level;
import java.util.logging.Logger;
import tables.ETable;
import tables.TablePair;

/**
 *
 * @author sisila
 */
public class BSTIterator<K,E> implements Iterator<TablePair<K,E>>{
    
    private LinkedList<TablePair<K,E>> aList;
    private Iterator<TablePair<K,E>> aIterator;
    
    public BSTIterator(BinarySearchTree<K,E> paTree){
        aList = new LinkedList<>();
        populateList(paTree.aRoot);
        aIterator = aList.iterator();
    }
    
    /**
     * InOrder - vsetko prehladaj vlavo -> koren -> prehladaj vsetko vpravo
     * @param paNode 
     */
    private void populateList(BSTNode<K,E> paNode){
        if(paNode != null) {
            try {
                populateList(paNode.getLeft() );
                aList.add(paNode.getPair());
                populateList(paNode.getRight() );
            } catch (EList ex) {
                
            }
        }
    }

    @Override
    public boolean hasNext() {
        return aIterator.hasNext();
    }

    @Override
    public TablePair<K,E> next() {
        return aIterator.next();
    }

    @Override
    public void remove() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
