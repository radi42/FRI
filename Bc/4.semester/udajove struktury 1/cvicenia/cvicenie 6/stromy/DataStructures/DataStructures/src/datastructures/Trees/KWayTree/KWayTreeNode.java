/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package datastructures.Trees.KWayTree;

import datastructures.lists.EList;
import datastructures.lists.LinkedList.LinkedList;
import datastructures.trees.ETree;
import datastructures.trees.ITreeNode;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author sisila
 */
public class KWayTreeNode<E> implements ITreeNode<E>{
    
    private E aData;
    private ITreeNode<E> aParent;    //mohol by byt aj typu ITreeNode - potom moze byt Parentom hocijaka trieda implementujuca rozhranie ITreeNode
    private LinkedList<ITreeNode<E>> aChildren;

    public KWayTreeNode(E paData) {
        //this.aData = aData;
        aData = paData;
        aParent = null;
        aChildren = new LinkedList<>();
    }
    
    @Override
    public E getData() throws ETree {
        return aData;
    }

    @Override
    public ITreeNode<E> getParent() throws ETree {
        return aParent;
    }

    @Override
    public void setParent(ITreeNode<E> paParent) throws ETree {
        aParent = (KWayTreeNode<E>) paParent;
    }

    @Override
    public ITreeNode<E> getBrother(int paOrder) throws ETree {
        if(isRoot())
            return null;
        else{
            return aParent.getChild(paOrder);
        }
    }

    @Override
    public ITreeNode<E> getChild(int paOrder) throws ETree {
        try {
            return aChildren.get(paOrder);
        } catch (EList ex) {
            throw new ETree(ex.getMessage());
        }
    }

    @Override
    public void addChild(ITreeNode<E> paChild) throws ETree {
        try {
            aChildren.add(paChild);
        } catch (EList ex) {
            throw new ETree("addChild failed: " + ex.getMessage());
        }
    }

    @Override
    public void deleteChild(ITreeNode<E> paChild) throws ETree {
        try {
            aChildren.delete(paChild);
        } catch (EList ex) {
            throw new ETree(ex.getMessage());
        }
    }

    @Override
    public boolean isRoot() throws ETree {
        return aParent == null;
    }

    @Override
    public boolean isLeaf() throws ETree {
        return degree() == 0;
    }

    @Override
    public int degree() throws ETree {
        try {
            return aChildren.size();
        } catch (EList ex) {
            throw new ETree(ex.getMessage());
        }
    }

    /**
     * 
     * @return ako sme hlboko v strome
     * @throws ETree 
     */
    @Override
    public int level() throws ETree {
        int count = 0;
        ITreeNode<E> parent = aParent;
        while(parent != null){
            count++;
            parent = parent.getChild(count);
        }
        return count;
    }
    
    /**
     * ternarny operator vracia vyraz, if - else nevracia nic
     * @return data, typ (koren/vrchol/list), degree, level
     */
    public String toString(){
        //pre nullove data treba specialny vypis
        if(aData == null){
            try {
                return  (isLeaf() ? "[Leaf] " : "[Parent] ") +
                        (isRoot() ? "[Root] " : "[nonRoot] ") + 
                        ("level = " + level() + " ")+
                        ("degree = " + degree());
            } catch (ETree ex) {
                return "blee";
            }
        }
        else{
            try {
                return aData.toString() + 
                        (isLeaf() ? "[Leaf] " : "[Parent] ") +
                        (isRoot() ? "[Root] " : "[nonRoot] ") + 
                        ("level = " + level() + " ")+
                        ("degree = " + degree());
            } catch (ETree ex) {
                return aData.toString();
            }
        }        
        
    }
    
}
