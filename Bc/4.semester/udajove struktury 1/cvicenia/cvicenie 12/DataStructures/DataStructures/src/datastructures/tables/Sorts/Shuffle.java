/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datastructures.tables.Sorts;

import datastructures.tables.ETable;
import java.util.Random;

/**
 *
 * @author Michal Varga
 */
public class Shuffle extends Sorter {

    @Override
    public void sort(ISortableTable paTable, KeyComparer paComparer) throws ETable {
        Random rand = new Random();
        
        for(int i = 0; i < paTable.size(); i++) {
            int i1 = rand.nextInt(paTable.size());
            int i2 = rand.nextInt(paTable.size());
            if (i1 != i2)
                paTable.swap(i1, i2);
        }
    }


    
}
