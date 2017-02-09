/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datastructures.tables.Sorts;

/**
 *
 * @author Michal Varga
 */
public class IntegerComparer extends KeyComparer<Integer> {

    /**
     * Compares given keys.
     * @param paKey1 first key to compare.
     * @param paKey2 second key to compare.
     * @return  
     *  - 0 if keys have the same value;
     *  - negative number, if value of first key is less than value of second key;
     *  - positive number, if value of first key is greater than value of second key.
     */
    @Override
    public int compare(Integer paKey1, Integer paKey2) {
        return paKey1.compareTo(paKey2); 
    }
    
}
