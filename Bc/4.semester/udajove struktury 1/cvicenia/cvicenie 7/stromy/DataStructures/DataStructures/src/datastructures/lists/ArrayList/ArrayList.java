/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package datastructures.lists.ArrayList;

import datastructures.lists.EList;
import datastructures.lists.IList;
import java.lang.reflect.Array;
import java.util.Iterator;



/**
 *
 * @author sisila
 * @param <E> genericky typ prvku pola
 */
public class ArrayList<E> implements IList<E> {
    
    private static final int MINIMAL_CAPACITY = 4;
    
    private int aSize;
    private int aCapacity;
    private E[] aElements;
    private final Class<E> aElementClass;

    public ArrayList(Class<E> paElementClass){
        aCapacity = MINIMAL_CAPACITY;
        aSize = 0;
        aElementClass = paElementClass;
        aElements = (E[])Array.newInstance(paElementClass, aCapacity); //vytvorenie generickeho pola
        //alebo aElements = (E()) new Object[aCapacity]; a importovat triedu Object
    }
    
    public ArrayList(){
        aCapacity = MINIMAL_CAPACITY;
        aSize = 0;
        aElementClass = null;
        aElements = (E[]) new Object[aCapacity]; //importovat triedu Object
    }
    
    private void realokujPole(){
        int newCapacity = aCapacity * 2;
        aCapacity = newCapacity;
        //E[] newElements = (E[])Array.newInstance(aElementClass, newCapacity); //vytvor nove pole dvojnasobnej kapacity
        E[] newElements = (E[]) new Object[aCapacity];
        System.arraycopy(aElements, 0, newElements, 0, aSize);  //prekopiruj pole aElements od indexu 0 do noveho pola newElements od intedxu nula po velkost
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

//    @Override
//    /**
//     * TODO - doimplementovat - HOTOVO
//     * Vlozi prvok na urcitu poziciu v poli, pricom zachova ostatne prvky
//     * moja implementacia
//     */
//    public void insert(E paElement, int paIndex) throws EList {
//        if (aSize < aCapacity) {
//            if (paIndex < aSize) {  //paIndex < aSize < aCapacity
//                for (int i = aSize; i >= paIndex; i--){
//                    aElements[i] = aElements[i-1];
//                }
//                set(paIndex, paElement);
//                aSize++;
//            }
//                
//            if (paIndex == aSize) { //paIndex == aSize < aCapacity
//                add(paElement);
//            }
//            
//            if (paIndex > aSize){   //paIndex > aSize < aCapacity
//                throw new UnsupportedOperationException("Pole musi byt suvisle."); //To change body of generated methods, choose Tools | Templates.
//            }
//        }
//        //nastane vtedy ked napr. aCapacity je 4 a zaroven aSize je 4. 
//        //v momente pridania prvku do pola bude aSize = 9 ale aCapacity = 8 tj. aSize > aCapacity
//        else {
//            realokujPole();
//            for (int i = aSize; i > paIndex; i--){
//                aElements[i] = aElements[i-1];
//            }
//            set(paIndex, paElement);
//            aSize++;
//        }
//    }
    
    @Override
    /**
     * TODO - doimplementovat
     * Vlozi prvok na urcitu poziciu v poli, pricom zachova ostatne prvky
     * implementacia na cviceni
     */
    public void insert(E paElement, int paIndex) throws EList {
        if(!(isValid(paIndex) || paIndex == aSize))
            throw new EList("Invalid index");
        if(aSize == aCapacity) {
            //lepsia implementacia metody realokujPole()
            aCapacity *= 2;
            //E[] newElements = (E[])Array.newInstance(aElementClass, aCapacity); //vytvor nove pole dvojnasobnej kapacity
            E[] newElements = (E[]) new Object[aCapacity];
            System.arraycopy(aElements, 0, newElements, 0, aSize);  //prekopiruj pole aElements od indexu 0 do noveho pola newElements od intedxu nula po velkost
            aElements = newElements;    //aElements bude nove pole newElements
        }
        System.arraycopy(aElements, paIndex, aElements, paIndex +1, aSize - paIndex); //namiesto zlozitosti n mame jednotkovu zlozitost
        aElements[paIndex] = paElement;
        aSize++;
    }

    @Override
    /**
     * ked podlezieme kapacitu tak shrinkneme (zmensime) pole
     * TODO - doimplementovat - HOTOVO
     * vyuziva indexOf - alebo aj nie :P
     * zistime index prvku, vymazeme ho a poposuvame prvky dolava, ak je nutne zmensime pole
     */
    public E delete(E paElement) throws EList {
        //zisti index prvku
        for(int i = 0; i < aSize; i++){
            if(aElements[i] == paElement){
                //pouzi metodu deleteFromIndex
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
        
        //utras prvky - dva sposoby
        //1. sposob - funguje ale pomale v profilery
//        for(int i = paIndex; i < aSize; i++){
//            aElements[i] = aElements[i+1];
//        }
        
        //2. sposob funguje, rychlejsie v profileri (ale hadze vynimku)
        System.arraycopy(aElements, paIndex +1, aElements, paIndex, aSize - paIndex);
        
        //ak je mozne, preloz ich do mensieho pola
        if((aSize == (aCapacity / 2) && (aCapacity /2) >= MINIMAL_CAPACITY)){
            aCapacity /= 2;
            //E[] newElements = (E[])Array.newInstance(aElementClass, aCapacity); //vytvor nove pole dvojnasobnej kapacity
            E[] newElements = (E[]) new Object[aCapacity];
            System.arraycopy(aElements, 0, newElements, 0, aSize);  //prekopiruj pole aElements od indexu 0 do noveho pola newElements od intedxu nula po velkost            System.arra
            aElements = newElements;    //aElements bude nove pole newElements
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
     * TODO - doimplementovat - HOTOVO
     * Vracia prvok na danom indexe
     */
    public E get(int paIndex) throws EList {
        if (paIndex < aSize) return aElements[paIndex];
        else throw new EList("Index out of bounds.");
    }

    @Override
    /**
     * TODO - doimplementovat - HOTOVO
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
     * TODO - doimplementovat - HOTOVO
     * Vymazava vsetky prvky v poli
     * Ekvivalent metody originalneho ArrayListu "removeAll"
     */
    public void clear() throws EList {
        while(aSize > 0) {             //aSize = 5 tj 5 prvkov v poli, posledny prvok na indexe 4
                aSize--;                    //aSize = 4 tj index posledneho prvku
                aElements[aSize] = null;    //vymaz tento prvok
        }
        E[] newElements;
        //newElements = (E[])Array.newInstance(aElementClass, MINIMAL_CAPACITY); //vytvorenie generickeho pola
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
