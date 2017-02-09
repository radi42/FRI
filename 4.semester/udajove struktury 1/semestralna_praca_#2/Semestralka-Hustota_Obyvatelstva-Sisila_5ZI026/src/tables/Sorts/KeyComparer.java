/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tables.Sorts;

/**
 * Compares the keys of table.
 * @author Michal Varga
 * @param <K> type of keys.
 */
public abstract class KeyComparer<K> {
    
    /**
     * Compares given keys.
     * @param paKey1 first key to compare.
     * @param paKey2 second key to compare.
     * @return  
     *  - 0 if keys have the same value;
     *  - negative number, if value of first key is less than value of second key;
     *  - positive number, if value of first key is greater than value of second key.
     */
    public abstract int compare(K paFirst, K paSecond);
    
    public boolean areEqual(K paFirst, K paSecond) {
        return compare(paFirst,paSecond) == 0;
    }
    
    public boolean firstIsLess(K paFirst, K paSecond) {
        return compare(paFirst, paSecond) < 0;
    }
    
    public boolean firstIsGreater(K paFirst, K paSecond) {
        return compare(paFirst, paSecond) > 0;
    }
}
