package tables.Sorts;

import tables.ETable;

/**
 *
 * @author Andrej Šišila
 */
public abstract class ElementSorter<E> extends Sorter<E>{
    
    /**
     * Sorter, ktory dokaze zoradit prvky tabulky na zaklade NEKLUCOVEHO atributu tj. atributu Elementu
     * Tejto metóde je teda jedno, aký typ kľúča a dát bude tabuľka (resp. komparátor) mať.
     * @param paTable
     * @param paComparer 
     */
    @Override
    public abstract void sort(ISortableTable paTable, KeyComparer paComparer);
    
    public abstract void sortElements(ISortableTable<Object,E> paTable, KeyComparer<E> paComparer) throws ETable;
}
