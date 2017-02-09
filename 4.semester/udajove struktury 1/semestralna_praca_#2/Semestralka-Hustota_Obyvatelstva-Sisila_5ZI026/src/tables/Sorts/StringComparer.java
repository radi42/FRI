package tables.Sorts;

/**
 *
 * @author Andrej Šišila
 */
public class StringComparer extends KeyComparer<String>{

    @Override
    public int compare(String paKey1, String paKey2) {
        return paKey1.compareTo(paKey2);
    }

}
