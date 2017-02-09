package datastructures.tables.Sorts;

import datastructures.tables.ETable;

/**
 *
 * @author Andrej Šišila
 */
public class SelectSort<K> extends Sorter<K>{

    @Override
    public void sort(ISortableTable<K, Object> paTable, KeyComparer<K> paComparer) throws ETable {
        //tu treba napisat SelectSort
        int min;
        for(int i = 0; i < paTable.size(); i++){
            min = i;
            for (int j = i+1; j < paTable.size(); j++) {
                if(paComparer.firstIsLess(paTable.getKeyAtPosition(j), paTable.getKeyAtPosition(min)))
                    min = j;
            }
            paTable.swap(i, min);
        }
    }

}
