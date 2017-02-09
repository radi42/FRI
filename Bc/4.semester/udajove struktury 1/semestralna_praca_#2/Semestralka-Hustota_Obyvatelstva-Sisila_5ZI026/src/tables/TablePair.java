package tables;

/**
 *
 * @author Michal Varga
 * @param <K> type of the key.
 * @param <E> type of the element.
 */
public class TablePair<K,E> {
    
    private final K aKey;
    private E aElement;
    
    public TablePair(K paKey, E paElement) {
        aKey = paKey;
        aElement = paElement;
    }
    
    public K getKey() {
        return aKey;
    }
    
    public E getElement() {
        return aElement;
    }
    
    public void setElement(E paElement) {
        aElement = paElement;
    }
    
}
