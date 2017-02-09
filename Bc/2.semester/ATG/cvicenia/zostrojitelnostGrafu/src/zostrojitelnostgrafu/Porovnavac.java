package zostrojitelnostgrafu;

import java.util.Comparator;

/**
 * Trieda Porovnavac
 * 
 * Porovnava dve cisla a zoradzuje ich od najvacsieho po najmensi
 * @author Andy
 */
public class Porovnavac implements Comparator<Integer>{
    
    public int compare(Integer i1, Integer i2){
        if(i1 < i2) return 1;
        if(i1 == i2) return 0;
        else return -1;
    }
}
