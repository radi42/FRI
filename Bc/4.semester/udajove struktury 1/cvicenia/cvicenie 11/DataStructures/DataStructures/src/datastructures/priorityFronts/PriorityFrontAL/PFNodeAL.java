/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package datastructures.priorityFronts.PriorityFrontAL;

/**
 *
 * @author sisila
 */
public class PFNodeAL<E>{
    private E aData;
    private int aPriorita;
        
    PFNodeAL(E paData, int paPriorita){
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
