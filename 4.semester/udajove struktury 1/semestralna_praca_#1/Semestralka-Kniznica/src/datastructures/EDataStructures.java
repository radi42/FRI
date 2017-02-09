package datastructures;

import java.io.Serializable;

/**
 *
 * @author Michal Varga
 */
public class EDataStructures extends Exception implements Serializable{
    
    public EDataStructures(String paMessage) {
        super(paMessage);
    }
    
}
