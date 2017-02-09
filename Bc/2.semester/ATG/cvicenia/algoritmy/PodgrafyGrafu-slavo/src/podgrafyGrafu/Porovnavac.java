package podgrafyGrafu;

import java.util.Comparator;

/**
 * Porovnava cisla v poli a zoradzuje ich od najvacsieho po najmensi
 * @author Andrej Sisila
 */

public class Porovnavac implements Comparator<Integer>{
    public int compare(Integer i1, Integer i2) {
        if(i1.compareTo(i2) < 0) {
            return 1;
        } else if(i1.compareTo(i2) > 0) {
            return -1;
        }
        else {
            return 0;
        }
    }
}
