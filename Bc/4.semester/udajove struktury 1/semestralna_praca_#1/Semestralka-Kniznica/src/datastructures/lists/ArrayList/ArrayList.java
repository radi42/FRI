package datastructures.lists.ArrayList;

import datastructures.lists.EList;
import datastructures.lists.IList;
import java.io.Serializable;
import java.util.Iterator;



/**
 *
 * @author Andrej Šišila
 * @param <E> genericky typ prvku pola
 */
public class ArrayList<E> implements IList<E>, Serializable {
    
    private static final int MINIMAL_CAPACITY = 4;
    
    private int aSize;
    private int aCapacity;
    private E[] aElements;
    
    public ArrayList(){
        aCapacity = MINIMAL_CAPACITY;
        aSize = 0;
        aElements = (E[]) new Object[aCapacity]; //importovat triedu Object
    }
    
    private void realokujPole(){
        int newCapacity = aCapacity * 2;
        aCapacity = newCapacity;
        E[] newElements = (E[]) new Object[aCapacity];
        System.arraycopy(aElements, 0, newElements, 0, aSize);  //prekopiruj pole aElements od indexu 0 do noveho pola newElements od indexu nula po velkost
        aElements = newElements;    //aElements bude nove pole newElements
    }
    
    private boolean isValid(int paIndex) {
        return (paIndex < aSize);
    }
    
    @Override
    /**
     * Pridava prvok do pola
     * Ak sa prvok do pola nezmesti, vytvori sa nove vacsie pole
     * Pole sa zvacsuje exponencialne (2^n)
     */
    public void add(E paElement) throws EList {
        if (aSize < aCapacity) {            //aSize = 0, aCapacity = 4 tj index posledneho prvku je 3
            aElements[aSize++] = paElement; //aSize = 1
        }
        else {
            realokujPole();
            aElements[aSize++] = paElement; //no a prvok, ktory sa do stareho pola nevosiel, hodime na nasledujucu poziciu v novom poli
        }
    }
  
    @Override
    /**
     * TODO - doimplementovat
     * Vlozi prvok na urcitu poziciu v poli, pricom zachova ostatne prvky
     */
    public void insert(E paElement, int paIndex) throws EList {
        if(!(isValid(paIndex) || paIndex == aSize))
            throw new EList("Invalid index");
        if(aSize == aCapacity) {
            aCapacity *= 2;
            E[] newElements = (E[]) new Object[aCapacity];
            System.arraycopy(aElements, 0, newElements, 0, aSize);
            aElements = newElements;
        }
        System.arraycopy(aElements, paIndex, aElements, paIndex +1, aSize - paIndex); //namiesto zlozitosti n mame jednotkovu zlozitost
        aElements[paIndex] = paElement;
        aSize++;
    }

    @Override
    /**
     * ked podlezieme kapacitu tak shrinkneme (zmensime) pole
     * vyuziva indexOf - alebo aj nie :P
     * zistime index prvku, vymazeme ho a poposuvame prvky dolava, ak je nutne zmensime pole
     */
    public E delete(E paElement) throws EList {
        //zisti index prvku
        for(int i = 0; i < aSize; i++){
            if(aElements[i] == paElement){
                //pouzi metodu deleteFromIndex a vrat vymazany prvok
                return deleteFromIndex(i);
            }
        }
        
        //prvok neexistuje
        return null;
    }

    @Override
    /**
     * vymazeme prvok na danom indexe a poposuvame prvky, ak je nutne zmensime pole
     * TODO - doimplementovat - HOTOVO
     */
    public E deleteFromIndex(int paIndex) throws EList {
        //vymaz prvok na danom indexe
        E vymazany = aElements[paIndex];
        aElements[paIndex] = null;
        aSize--;
        System.arraycopy(aElements, paIndex +1, aElements, paIndex, aSize - paIndex);
        
        //ak je mozne, preloz ich do mensieho pola
        if((aSize == (aCapacity / 2) && (aCapacity /2) >= MINIMAL_CAPACITY)){
            aCapacity /= 2;
            E[] newElements = (E[]) new Object[aCapacity];
            System.arraycopy(aElements, 0, newElements, 0, aSize);
            aElements = newElements;
        }
        return vymazany;
    }

    @Override
    /**
     * zisti index prvku
     */
    public int indexOf(E paElement) throws EList {
        for(int i = 0; i < aSize; i++) {
            if (aElements[i] == paElement) {
                return i;
            }
        }
        return -1;
    }

    @Override
    /**
     * Vracia prvok na danom indexe
     */
    public E get(int paIndex) throws EList {
        if (paIndex < aSize) return aElements[paIndex];
        else throw new EList("Index out of bounds.");
    }

    @Override
    /**
     * Prepise prvok v poli na danej pozicii urcitou hodnotou
     */
    public void set(int paIndex, E paElement) throws EList {
        if (paIndex < aCapacity){
            aElements[paIndex] = paElement;
        }
        else {
            throw new EList("Index out of bounds.");
        }
    }

    @Override
    /**
     * Vracia velkost pola
     */
    public int size() throws EList {
        return aSize;
    }

    @Override
    /**
     * Vymazava vsetky prvky v poli
     * Ekvivalent metody originalneho ArrayListu "removeAll"
     */
    public void clear() throws EList {
        while(aSize > 0) {             //aSize = 5 tj 5 prvkov v poli, posledny prvok na indexe 4
                aSize--;                    //aSize = 4 tj index posledneho prvku
                aElements[aSize] = null;    //vymaz tento prvok
        }
        E[] newElements;
        newElements = (E[]) new Object[aCapacity];
        aElements = newElements;
        aCapacity = MINIMAL_CAPACITY;
    }

    @Override
    /**
     * vytvorenie iteratora (prstu)
     */
    public Iterator<E> iterator() {
        return new ArrayListIterator<E>(this);
    }
    
}
