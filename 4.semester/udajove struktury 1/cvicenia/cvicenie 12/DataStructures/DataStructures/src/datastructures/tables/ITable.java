package datastructures.tables;

/**
 * Interface for work with tables. 
 * @author Michal Varga
 * @param <K> type of the key of elements stored in the table.
 * @param <E> type of elements stored in the table.
 */
public interface ITable<K,E> extends Iterable<TablePair<K,E>>{
    /**
     * Inserts an element with given key into the table. If table already
     * contains given key, an exception is thrown.
     * @param paKey key of inserted element.
     * @param paElement inserted element.
     * @throws ETable 
     */
    public void insert(K paKey, E paElement) throws ETable;
    /**
     * Removes an element with given key.
     * @param paKey key of the element to be removed.
     * @return removed element with given key. If no matching element was found, return null.
     * @throws ETable 
     */
    public E delete(K paKey) throws ETable;
    /**
     * Find an element with given key.
     * @param paKey key of searching element.
     * @return element with given key. If no matching element was found, return null.
     * @throws ETable 
     */
    public E find(K paKey) throws ETable;
    /**
     * Modifies entry of the table with given key. Entry must exist, otherwise
     * an exception is thrown.
     * @param paKey key of entry.
     * @param paNewElement new value of the entry with given key.
     * @throws ETable 
     */
    public void modify(K paKey, E paNewElement) throws ETable;    
    /**
     * Test whether table contains given key.
     * @param paKey tested key.
     * @return true, if a table contains the key, false otherwise.
     * @throws ETable 
     */
    public boolean containsKey(K paKey) throws ETable;
    /**     
     * Test whether the table is empty (no elements are present).
     * @return True, if table is empty, false otherwise.
     * @throws ETable 
     */
    public boolean isEmpty() throws ETable;
    /**
     * Return number of elements presented in table.
     * @return number of elements presented in table.
     * @throws ETable 
     */
    public int size() throws ETable;
    /**
     * Clears the table.
     * @throws ETable
     */
    public void clear() throws ETable; 
}
