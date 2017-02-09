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
import datastructures.lists.LinkedList.LinkedList;
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
    private int aCardinality;

    public KWayTree(int paCardinality) {
        aRoot = null;
        aCardinality = paCardinality;
    }

    @Override
    public boolean isEmpty() throws ETree {
        return aRoot == null;
    }

    public int size(ITreeNode<E> paNode) throws ETree{
        int result = 1;
        for(int i = 0; i < paNode.degree(); i++)
            result += size(paNode.getChild(i));
        return result;
    }
    
    @Override
    public int size() throws ETree {
        try {
            return preOrder().size();
        } catch (EList ex) {
            return 0;
        }
    }

    @Override
    public void clear() throws ETree {
        aRoot = null;
    }

    @Override
    public void insertRoot(E paElement) throws ETree {
        KWayTreeNode<E> newRoot = new KWayTreeNode<E>(paElement, aCardinality);
        
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
        KWayTreeNode<E> newLeaf = new KWayTreeNode<>(paElement, aCardinality);
        
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
    
    private void preOrder(ITreeNode<E> paNode, IList<ITreeNode<E>> paList) throws ETree{
        try{
            paList.add(paNode); //spracujem seba
            //a potom spracujem potomkov
            for(int i = 0; i < paNode.degree(); i++){
                preOrder(paNode.getChild(i), paList);
            }
        }
        catch(EList ex){
            throw new ETree("preOrder failed: " + ex.getMessage());
        } 
    }

    @Override
    public IList<ITreeNode<E>> preOrder() throws ETree {
        IList<ITreeNode<E>> result = new ArrayList<>();
        if(!isEmpty()){
            preOrder(getRoot(), result);
        }
        return result;
    }
    
    /**
     * 
     * @param paNode
     * @param paList
     * @throws ETree 
     */
    private void postOrder(ITreeNode<E> paNode, IList<ITreeNode<E>> paList) throws ETree{
        try{
            //spracuj potomkov
            for(int i = 0; i < paNode.degree(); i++){
                postOrder(paNode.getChild(i), paList);
            }
            //a potom seba
            paList.add(paNode);
        }
        catch(EList ex){
            throw new ETree("postOrder failed: " + ex.getMessage());
        }
    }

    @Override
    public IList<ITreeNode<E>> postOrder() throws ETree {
        IList<ITreeNode<E>> result = new ArrayList<>();
        if(!isEmpty()){
            postOrder(getRoot(), result);
        }
        return result;
    }
    
    @Override
    public IList<ITreeNode<E>> levelOrder() throws ETree {
        Front<ITreeNode<E>> front = new Front<ITreeNode<E>>();    //buffer
        KWayTreeNode<E> pom_vrchol = aRoot;     //zacni od korena
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
