package datastructures.priorityFronts;

/**
 *
 * @author Michal Varga
 * @param <E> type of elements stored in priortiy front.
 */
public interface IPriorityFront<E> extends Iterable<E> {
    /**
     * Pushes element into front.
     * @param paElement element to push into priority front.      
     * @param paPriority priority of element.
     * @throws EPriorityFront 
     */
    public void push(E paElement, int paPriority) throws EPriorityFront;
    /**
     * Removes and returns an element wtih the highest priority.
     * @return an element wtih the highest priority
     * @throws EPriorityFront 
     */
    public E pop() throws EPriorityFront;
    /**
     * Peeks an element that will be return by calling the next pop method. 
     * This method does not remove the element from the structure!
     * @return an element that will be return by calling the next pop method.
     * @throws EPriorityFront 
     */
    public E peek() throws EPriorityFront;
    /**
     * Test whether the priority front is empty (no elements are present).
     * @return True, if priority front is empty, false otherwise.
     * @throws EPriorityFront 
     */
    public boolean isEmpty() throws EPriorityFront;
    /**
     * Return number of elements presented in priority front.
     * @return number of elements presented in priority front.
     * @throws EPriorityFront 
     */
    public int size() throws EPriorityFront;
    /**
     * Clears the front(stack) by removing all its elements.
     * @throws EPriorityFront
     */
    public void clear() throws EPriorityFront;    
}
