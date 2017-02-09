package datastructures.lists.LinkedList;

import datastructures.lists.EList;
import datastructures.lists.IList;
import java.io.Serializable;

import java.util.Iterator;

/**
 *
 * @author Andrej Šišila
 * @param <E> genericky typ prvku pola
 */
public class LinkedList<E> implements IList<E>, Serializable {
      LinkedListNode<E> aFirst;
      private LinkedListNode<E> aLast;
      private int aSize;
  
  public LinkedList(){
       aFirst=null;
       aLast=null;
       aSize=0;
  }

    @Override
    public void add(E paElement) throws EList {
       if(aLast == null){
          aLast=new LinkedListNode<E>(paElement);
          aFirst=aLast;
       }
       else{
         aLast.setNext(new LinkedListNode<E>(paElement));
         aLast=aLast.getNext();
       }
       aSize++;
    }
    
    private boolean isValid(int paIndex){
        return paIndex >= 0 || paIndex < aSize;
    }
    
    @Override
    public void insert(E paElement, int paIndex) throws EList {
        //Je platny index
        //Nie
        if( !(isValid(paIndex)) ){
            throw new EList("Index out of bounds");
        }
        //Ano
        else{
            //je Index rovny Poctu?
            //Ano -vkladame na kraj pola
            if(paIndex == aSize){
                add(paElement);
            }
            //Nie - vkladame do vnutra pola
            else{
                //vytvor novy uzol
                LinkedListNode<E> uzol = new LinkedListNode<E>(paElement);
                
                //Pridanie na zaciatok treba urobit specialne
                //Pridavame na zaciatok
                if(paIndex == 0){
                    uzol.setData(paElement);
                    uzol.setNext(aFirst);
                    aFirst = uzol;
                }
                //Nepridavame na zaciatok tj. pridavame dovnutra 
                else {
                    LinkedListNode<E> predchodca = getNodeFromindex(paIndex-1);
                    uzol.setNext(predchodca.getNext());
                    predchodca.setNext(uzol);
                }
                aSize++;
            }
        }
    }

    @Override
    public E delete(E paElement) throws EList {
        LinkedListNode<E> mazany = null;
        int index = indexOf(paElement);
        if(index == -1){
            return null;
        }
        else{
            mazany = getNodeFromindex(index);
        }
        return deleteFromIndex(index);
    }

    @Override
    public E deleteFromIndex(int paIndex) throws EList {
        LinkedListNode<E> mazany = getNodeFromindex(paIndex);
        //Je platny index
        //Nie
        if(!(isValid(paIndex)) ){
            throw new EList("Index out of bounds");
        }
        //Ano
        else{
            //Mazem zo zaciatku?
            //Ano
            if(paIndex == 0){
                mazany = aFirst;
                aFirst = aFirst.getNext();
                
                //Posledny mazany
                //Ano
                if(aLast == mazany){
                    aLast = null;
                }
                //Nie
                else{
                    //nerob nic
                }
            }
            //Nie
            else{
                //prelinkuj
                LinkedListNode<E> predchodca = getNodeFromindex(paIndex -1);
                mazany = predchodca.getNext();
                predchodca.setNext(mazany.getNext());
                
                //Posledny mazany
                //Ano
                if(aLast == mazany){
                    aLast = predchodca;
                }
                else{
                    //nerob nic
                }
            }
            aSize--;
        }
        return mazany.getData();
    }

    @Override
    public int indexOf(E paElement) throws EList {       
        LinkedListNode<E> node = aFirst;
        int index = 0;
        while(node != null){
            if(node.getData() == paElement) return index;
            else {
                index++;
                node = node.getNext();
            }
        }
        
        return -1;
    }

    @Override
    public E get(int paIndex) throws EList {
        return getNodeFromindex(paIndex).getData();
    }

    @Override
    public void set(int paIndex, E paElement) throws EList {
        getNodeFromindex(paIndex).setData(paElement);
    }

    @Override
    public int size() throws EList {
       return aSize;
    }

    @Override
    public void clear() throws EList {
        aSize = 0;
        aFirst = null;
        aLast = null;
    }
    
    public LinkedListNode<E> getFirst(){
        return aFirst;
    }

    @Override
    public Iterator<E> iterator() {
        return new LinkedListIterator<>(this);
    }
    
    /**
     * metoda pre get set insert delete deleteFromIndex
     * predchadzajuci ukazuje na pridavany a pridavany ukazuje na nasledujuci
     * @param paIndex na akej pozicii
     * @return vracia uzol (node)
     * @throws EList 
     */
    private LinkedListNode<E> getNodeFromindex(int paIndex) throws EList{
        if(aSize >= 0 && paIndex < aSize){
            LinkedListNode<E> node = aFirst;
            for(int i = 0; i < paIndex; i++){
                node = node.getNext();
            }
            return node;
        }
        else {
            throw new EList("Index out of bounds");
        }
    }
    
}