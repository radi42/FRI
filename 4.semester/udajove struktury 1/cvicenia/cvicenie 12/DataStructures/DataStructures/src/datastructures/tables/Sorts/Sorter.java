/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datastructures.tables.Sorts;

import datastructures.tables.ETable;

/**
 * Sorts the table.
 * @author Michal Varga
 * @param <K> type of the key of elements stored in the table.
 */
public abstract class Sorter<K> {
    
    public abstract void sort(ISortableTable<K,Object> paTable, KeyComparer<K> paComparer) throws ETable;
    
}
