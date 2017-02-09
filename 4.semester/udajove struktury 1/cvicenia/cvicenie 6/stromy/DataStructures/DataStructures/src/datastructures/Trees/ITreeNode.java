/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datastructures.trees;

/**
 * Interface for work with tree node.
 * @author Michal Varga
 * @param <E> type of elements stored in the tree.
 */
public interface ITreeNode<E> {
    /**
     * Gets the data of tree node.
     * @return data of tree node.
     * @throws datastructures.trees.ETree
     */
    public E getData() throws ETree;
    /**
     * Gets a parent node.
     * @return parent node.
     * @throws datastructures.trees.ETree
     */
    public ITreeNode<E> getParent() throws ETree;
    /**
     * Sets a parent node.
     * @param paParent new parent node.
     * @throws ETree 
     */
    public void setParent(ITreeNode<E> paParent) throws ETree;
    /**
     * Gets a brother of the node.
     * @param paOrder order of the brother in the parent's node.
     * @return paOrder-th brother of the node specified by the element.     
     * @throws datastructures.trees.ETree     
     */    
    public ITreeNode<E> getBrother(int paOrder) throws ETree;
    /**
     * Gets a child of the node.     
     * @param paOrder order of the child.
     * @return paOrder-th child of the node.
     * @throws datastructures.trees.ETree
     */
    public ITreeNode<E> getChild(int paOrder) throws ETree;
    /**
     * Adds child to the node.
     * @param paChild new child.
     * @throws ETree 
     */
    public void addChild(ITreeNode<E> paChild) throws ETree;    
    /**
     * Removes node's child 
     * @param paChild removed child.
     * @throws ETree 
     */
    public void deleteChild(ITreeNode<E> paChild) throws ETree;
    /**
     * Test whether node is a root.
     * @return true, if node is root, false otherwise.
     * @throws datastructures.trees.ETree
     */
    public boolean isRoot() throws ETree;
    /**
     * Test whether node is a leaf.
     * @return true, if node is leaf, false otherwise.
     * @throws datastructures.trees.ETree
     */
    public boolean isLeaf() throws ETree;
    /**
     * Return degree (number of children) of the node.
     * @return degree of the node.
     * @throws datastructures.trees.ETree 
     */
    public int degree() throws ETree;
    /**
     * Return level (depth in the tree) of the node.
     * @return level of the node.
     * @throws datastructures.trees.ETree
     */
    public int level() throws ETree;
    /**
     * Return String representation of the node.
     * @return String representation of the node. 
     */
    @Override
    public String toString();
}
