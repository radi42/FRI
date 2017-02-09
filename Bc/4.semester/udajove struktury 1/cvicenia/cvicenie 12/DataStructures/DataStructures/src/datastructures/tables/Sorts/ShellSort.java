package datastructures.tables.Sorts;

import datastructures.tables.ETable;

/**
 *
 * @author Andrej Šišila
 */
public class ShellSort<K> extends Sorter<K>{

    /**
     * ShellSort algoritmus
     * @param paTable
     * @param paComparer
     * @throws ETable 
     */
    @Override
    public void sort(ISortableTable<K, Object> paTable, KeyComparer<K> paComparer) throws ETable {
        //refaktorovany ShellSort zo zdroja: http://stackoverflow.com/questions/4833423/shell-sort-java-example
        int inner, outer;
        K temp;
        //find initial value of h
        int h = 1;
        while (h <= paTable.size() / 3)
          h = h * 3 + 1; // (1, 4, 13, 40, 121, ...)

        while (h > 0) // decreasing h, until h=1
        {
          // h-sort the file
          for (outer = h; outer < paTable.size(); outer++) {
            temp = paTable.getKeyAtPosition(outer);
            inner = outer;
            // one subpass (eg 0, 4, 8)
            while (inner > h - 1 && paComparer.firstIsLess(temp, paTable.getKeyAtPosition(inner - h) ) ) {
              paTable.swap(inner, inner - h);
              inner -= h;
            }
          }
          h = (h - 1) / 3; // decrease h
        }
    }
}
