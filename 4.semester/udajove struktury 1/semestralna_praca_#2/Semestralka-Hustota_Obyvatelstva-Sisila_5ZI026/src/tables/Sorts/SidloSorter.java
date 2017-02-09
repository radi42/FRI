package tables.Sorts;

import java.util.logging.Level;
import java.util.logging.Logger;
import tables.ETable;

/**
 *
 * @author Andrej Šišila
 */
public class SidloSorter<Sidlo> extends ElementSorter<Sidlo>{

    @Override
    public void sort(ISortableTable paTable, KeyComparer paComparer) {
        try {
            sortElements(paTable, paComparer);
        } catch (ETable ex) {
            System.out.println("Triedenie sidiel sa pokazilo");
        }
    }

    /**
     * 
     * @param paTable
     * @param paComparer
     * @throws ETable 
     */
    @Override
    public void sortElements(ISortableTable<Object, Sidlo> paTable, KeyComparer<Sidlo> paComparer) throws ETable {
        //refaktorovany ShellSort zo zdroja: http://stackoverflow.com/questions/4833423/shell-sort-java-example smrncnuty pseudokodom
        int inner, outer;
        Sidlo temp;
        //find initial value of h
        int h = 1;
        while (h <= paTable.size() / 3)
          h = h * 3 + 1; // (1, 4, 13, 40, 121, ...)

        while (h > 0) // decreasing h, until h=1
        {
          // h-sort the file
          for (outer = h; outer < paTable.size(); outer++) {
            temp = paTable.getElementAtPosition(outer);
            inner = outer;
            // one subpass (eg 0, 4, 8)
            while (inner > h - 1 && paComparer.firstIsLess(temp, paTable.getElementAtPosition(inner - h) ) ) {
              paTable.swap(inner, inner - h);
              inner -= h;
            }
          }
          h = (h - 1) / 3; // decrease h
        }
    }
}
