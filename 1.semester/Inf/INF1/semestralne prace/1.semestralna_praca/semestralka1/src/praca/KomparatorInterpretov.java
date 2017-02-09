package praca;

import java.util.Comparator;

/**
 * Trieda Komparator Interpretov
 * porovnava skladby podla interpretov abecedne od A po Z
 * @author Andy
 */

/**
 * Medoda porovnavajuca interpretov
 */
public class KomparatorInterpretov implements Comparator<Pesnicka>{
    public int compare(Pesnicka p1, Pesnicka p2) {
        if(p1.getInterpret().compareTo(p2.getInterpret()) > 0) {
            return 1;
        } else if(p1.getInterpret().compareTo(p2.getInterpret()) < 0) {
            return -1;
        }
        else {
            return 0;
        }
    }
}
