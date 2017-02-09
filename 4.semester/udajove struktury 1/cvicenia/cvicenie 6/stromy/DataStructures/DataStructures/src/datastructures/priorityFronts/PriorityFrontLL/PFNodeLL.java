/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package datastructures.priorityFronts.PriorityFrontLL;

/**
 *
 * @author sisila
 */
public class PFNodeLL<E>{
    private E aData;
    private int aPriorita;
        
    PFNodeLL(E paData, int paPriorita){
        aData = paData;
        aPriorita = paPriorita;
    }
    
    public E getData(){
        return aData;
    }
    
    public int getPriority(){
        return aPriorita;
    }
}
