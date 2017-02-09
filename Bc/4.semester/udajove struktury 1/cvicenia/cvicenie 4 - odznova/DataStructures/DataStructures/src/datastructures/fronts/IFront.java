package datastructures.fronts;

/**
 * Interface to work with both fronts and stacks.
 * @author Michal Varga
 * @param <E> type of elements stored in the front (stack).
 */
public interface IFront<E> extends Iterable<E> {
    /**
     * Pushes element into front (stack).
     * @param paElement element to push into front (stack).
     * @throws EFront 
     */
    public void push(E paElement) throws EFront;
    /**
     * Removes and returns an element pushed as first (last) into front (stack).     
     * @return popped element. If no elements are present, return null.
     * @throws EFront 
     */
    public E pop() throws EFront;
    /**
     * Peeks an element that will be return by calling the next pop method. 
     * This method does not remove the element from the structure!
     * @return an element that will be return by calling the next pop method.
     * @throws EFront 
     */
    public E peek() throws EFront;
    /**
     * Test whether the front (stack) is empty (no elements are present).
     * @return True, if front (stack) is empty, false otherwise.
     * @throws EFront 
     */
    public boolean isEmpty() throws EFront;
    /**
     * Return number of elements presented in front (stack).
     * @return number of elements presented in front (stack).
     * @throws EFront 
     */
    public int size() throws EFront;
    /**
     * Clears the front(stack) by removing all its elements.
     * @throws EFront 
     */
    public void clear() throws EFront; 
}
