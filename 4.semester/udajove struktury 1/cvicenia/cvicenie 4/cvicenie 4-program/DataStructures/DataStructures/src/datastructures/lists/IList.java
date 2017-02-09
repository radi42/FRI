package datastructures.lists;

import java.util.Iterator;

/**
 * Interface to work with lists.
 * @author Michal Varga
 * @param <E> type of elements stored in the list.
 */
public interface IList<E> extends Iterable<E>{
    /**
     * Add an element at the end of the list.
     * @param paElement new element to store in the list.
     * @throws EList 
     */
    public void add(E paElement) throws EList;
    /**
     * Inserts an element at the specified position defined by index.
     * @param paElement new element to store in the list.
     * @param paIndex index new element's position.
     * @throws EList 
     */
    public void insert(E paElement, int paIndex) throws EList;
    /**
     * Delete specified element. Delete only the first occurance of the element.
     * @param paElement element to be removed from the list.
     * @return Deleted element. If element is not present in the list, return null.
     * @throws EList 
     */
    public E delete(E paElement) throws EList;
    /**
     * Delete element from given index.
     * @param paIndex index of element which should be removed.
     * @return Deleted element.
     * @throws EList 
     */
    public E deleteFromIndex(int paIndex) throws EList;
    /**
     * Returns index of tested element.
     * @param paElement tested element.
     * @return index of tested element. If element is not present in the list, return -1.
     * @throws EList 
     */
    public int indexOf(E paElement) throws EList;
    /**
     * Gets an element at specified index.
     * @param paIndex index of element.
     * @return element at specified index.
     * @throws EList 
     */
    public E get(int paIndex) throws EList;
    /**
     * Overwrites an element at specified index.
     * @param paIndex index of element.
     * @param paElement new element.
     * @throws EList 
     */
    public void set(int paIndex, E paElement) throws EList;   
    /**
     * Return number of elements presented in list.
     * @return number of elements presented in list.
     * @throws EList 
     */
    public int size() throws EList;
    /**
     * Clears the list by removing all its elements.
     * @throws EList 
     */
    public void clear() throws EList; 
    
    /**
     * http://docs.oracle.com/javase/7/docs/api/java/lang/Iterable.html
     * @return iterator.
     */
    
    @Override
    public Iterator<E> iterator();
    //for () each
}
