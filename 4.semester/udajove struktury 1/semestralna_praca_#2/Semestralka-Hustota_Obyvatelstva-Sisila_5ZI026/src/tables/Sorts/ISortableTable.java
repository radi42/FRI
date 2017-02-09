package tables.Sorts;

import tables.ETable;
import tables.ITable;

/**
 * Interface for tables supporting sorting. Table must be able to provide information
 * about the position of its keys.
 * @author Michal Varga
 * @param <K> type of the key of elements stored in the table.
 * @param <E> type of elements stored in the table.
 */
public interface ISortableTable<K,E> extends ITable<K,E> {
    /**
     * Swaps pairs of (Key,Element) between positions paPosition1 and paPosition2.
     * @param paPosition1 position of the first pair to swap.
     * @param paPosition2 position of the second pair to swap.
     * @throws datastructures.tables.ETable 
     */
    public void swap(int paPosition1, int paPosition2) throws ETable;
    /**
     * Move pair of (Key,Element) from paPositionFrom to paPositionTo.
     * Method removes the pair from its origin position and inserts it into new destination position.
     * Pairs between origin and new position are moved to fill the gap.
     * @param paFromPosition origin position of moved element.
     * @param paToPosition destination position of moved element.
     * @throws datastructures.tables.ETable 
     */
    public void move(int paFromPosition, int paToPosition) throws ETable;
    /**
     * Returns key at given position in the table.
     * @param paPosition position of key.
     * @return key at given position in the table.
     * @throws datastructures.tables.ETable
     */
    public K getKeyAtPosition(int paPosition) throws ETable;
    
    /**
     * Returns element at given position in the table.
     * @param paPosition position of element.
     * @return element at given position in the table.
     * @throws datastructures.tables.ETable
     */
    public E getElementAtPosition(int paPosition) throws ETable;
}
