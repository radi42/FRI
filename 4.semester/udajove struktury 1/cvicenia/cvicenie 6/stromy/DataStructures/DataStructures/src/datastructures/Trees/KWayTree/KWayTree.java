/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package datastructures.Trees.KWayTree;

import datastructures.fronts.EFront;
import datastructures.fronts.Front.Front;
import datastructures.lists.ArrayList.ArrayList;
import datastructures.lists.EList;
import datastructures.lists.IList;
import datastructures.trees.ETree;
import datastructures.trees.ITree;
import datastructures.trees.ITreeNode;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author sisila
 */
public class KWayTree<E> implements ITree<E>{
    
    private KWayTreeNode<E> aRoot;

    public KWayTree(ITreeNode<E> paRoot) {
        aRoot = (KWayTreeNode<E>) paRoot;
    }

    @Override
    public boolean isEmpty() throws ETree {
        return aRoot == null;
    }

    @Override
    public int size() throws ETree {
        return 0;
    }

    @Override
    public void clear() throws ETree {
        aRoot = null;
    }

    @Override
    public void insertRoot(E paElement) throws ETree {
        KWayTreeNode<E> newRoot = new KWayTreeNode<E>(paElement);
        
        if(!(isEmpty())){
            newRoot.addChild(aRoot);    //ja som novy root
            aRoot.setParent(newRoot);   //ja som tvoj rodic
        }
        aRoot = newRoot;
    }

    @Override
    public ITreeNode<E> getRoot() throws ETree {
        return aRoot;
    }

    @Override
    public E deleteRoot() throws ETree {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void insertLeaf(E paElement, ITreeNode<E> paParent) throws ETree {
        KWayTreeNode<E> newLeaf = new KWayTreeNode<>(paElement);
        
        //zretazim novy uzol s rodicom
        paParent.addChild(newLeaf);
        newLeaf.setParent(paParent);
    }

    @Override
    public E deleteChild(ITreeNode<E> paParent, int paOrder) throws ETree {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean isComplete() throws ETree {
        return false;
    }

    @Override
    public boolean isBalanced() throws ETree {
        return false;
    }

    @Override
    public IList<ITreeNode<E>> preOrder() throws ETree {
        return null;
    }

    @Override
    public IList<ITreeNode<E>> postOrder() throws ETree {
        return null;
    }

    @Override
    public IList<ITreeNode<E>> levelOrder() throws ETree {
        Front<ITreeNode<E>> front = new Front<ITreeNode<E>>();    //buffer
        KWayTreeNode<E> pom_vrchol = new KWayTreeNode<E>(aRoot.getData());     //zacni od korena
        ArrayList<ITreeNode<E>> list = new ArrayList<ITreeNode<E>>(); //finalna postupnost vrcholov
        
        //vloz koren do frontu
        try {
            front.push(pom_vrchol);
        } catch (EFront ex) {
            throw new ETree(ex.getMessage());
        }
        
        //vytvor poradie vrcholov v strome zlava doprava po urovniach od korena
        try {            
            while(!(front.isEmpty())){
                pom_vrchol = (KWayTreeNode<E>) front.pop();
                list.add(pom_vrchol);
                
                //pushni kazdeho syna do fronty
                //syn.pom_vrchol = front.push(syn);
                int degree = pom_vrchol.degree();
                for(int i = 0; i < pom_vrchol.degree(); i++){
                    front.push( (KWayTreeNode<E>) pom_vrchol.getChild(i));
                }
            }
        } catch (EFront ex) {
            Logger.getLogger(KWayTree.class.getName()).log(Level.SEVERE, null, ex);
        } catch (EList ex) {
            Logger.getLogger(KWayTree.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return list;
    }
    
}
