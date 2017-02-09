package datastructures.trees;

import datastructures.lists.IList;

/**
 * Interface for work with trees.
 * @author Michal Varga
 * @param <E> type of elements stored in the tree.
 */
public interface ITree<E> {
    /**
     * Test whether the tree is empty (no elements are present).
     * @return True, if tree is empty, false otherwise.
     * @throws ETree 
     */
    public boolean isEmpty() throws ETree; 
    /**
     * Return number of elements presented in tree.
     * @return number of elements presented in tree.
     * @throws ETree 
     */
    public int size() throws ETree; 
    /**
     * Clears the tree by removing all its elements.
     * @throws ETree
     */
    public void clear() throws ETree; 
    /**
     * Inserts the element into the root of the tree.
     * @param paElement new element to store in the root. 
     * @throws ETree 
     */
    public void insertRoot(E paElement) throws ETree; 
    /**
     * Returns the root of the tree.
     * @return the root of the tree.
     * @throws ETree 
     */
    public ITreeNode<E> getRoot() throws ETree; 
    /**
     * Removes the root of the tree.
     * @return data of deleted root node.
     * @throws ETree 
     */
    public E deleteRoot() throws ETree; 
    /**
     * Inserts new element into tree as a leaf of the parent.
     * @param paElement new element to store in the leaf.
     * @param paParent parent of the leaf.
     * @throws ETree 
     */
    public void insertLeaf(E paElement, ITreeNode<E> paParent) throws ETree;    
    /**
     * Removes a child of the parent.
     * @param paParent parent of the child.
     * @param paOrder order of the child.
     * @return data of removed child node.
     * @throws ETree 
     */
    public E deleteChild(ITreeNode<E> paParent, int paOrder) throws ETree;
    /**
     * Test whether tree is complete. All levels (except the last one) of the tree are 
     * full. The last level is fullfilled from the left.
     * @return true, if tree is complete, false otherwise.
     * @throws ETree 
     */
    public boolean isComplete() throws ETree;
    /**
     * Test whether tree is balanced. Levels of the leafs of the tree differ by +/-1.
     * @return true, if tree is balanced, false otherwise.
     * @throws ETree 
     */
    public boolean isBalanced() throws ETree;
    /**
     * returns list of the tree nodes as the pre-order sequence.
     * @return list of the tree nodes as the pre-order sequence.
     * @throws ETree
     */
    public IList<ITreeNode<E>> preOrder() throws ETree;    
    /**
     * returns list of the tree nodes as the post-order sequence.
     * @return list of the tree nodes as the post-order sequence.
     * @throws ETree
     */
    public IList<ITreeNode<E>> postOrder() throws ETree;
    /**
     * returns list of the tree nodes as the level-order sequence.
     * @return list of the tree nodes as the level-order sequence.
     * @throws ETree
     */
    public IList<ITreeNode<E>> levelOrder() throws ETree;
}
