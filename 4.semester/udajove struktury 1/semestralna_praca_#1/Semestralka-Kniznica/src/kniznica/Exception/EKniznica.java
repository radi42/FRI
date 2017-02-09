package kniznica.Exception;

import java.io.Serializable;

/**
 *
 * @author Andrej Šišila
 */
public class EKniznica extends Exception implements Serializable{
    public EKniznica(String paMessage){
        super(paMessage);
    }
}
