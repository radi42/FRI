package semestralka;

import gui.MainFrame;
import exception.ETabulka;
import datastructures.lists.ArrayList.ArrayList;
import datastructures.lists.EList;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;
import tables.BinarnySearchTree.BinarySearchTree;
import tables.ETable;
import tables.NonsortedSequenceTable.NonsortedSeqenceTable;
import tables.SortedSequenceTable.SortedSeqenceTable;
import tables.Sorts.StringComparer;

/**
 * Krajina tvoria okresy
 * @author Andrej Šišila
 */
public class Krajina {
    
//    private SortedSeqenceTable<String,Okres> aTabOkresov;   //tabulka okresov; <Kluc bude nazov okresu, data bude cely Okres>
    private NonsortedSeqenceTable<String,Okres> aTabOkresov;   //tabulka okresov; <Kluc bude nazov okresu, data bude cely Okres>
    private NonsortedSeqenceTable<String,Sidlo> aSidlaKrajiny;      //tabulka cisto len sidiel, ktore budem triedit
    
    private ArrayList<Okres> aArrayOkresov;
    
    private BinarySearchTree<String,Sidlo> aStromSidiel;
    private BinarySearchTree<String,Okres> aStromOkresov;
    
    //zorad prvky tabulky
    //vyhladaj v tabulke
    
    public Krajina(){
//        aTabOkresov = new SortedSeqenceTable(new StringComparer() );
        aTabOkresov = new NonsortedSeqenceTable();
        aSidlaKrajiny = new NonsortedSeqenceTable();
        aArrayOkresov = new ArrayList<Okres>();
        aStromSidiel = new BinarySearchTree<String,Sidlo>(new StringComparer() );
        aStromOkresov = new BinarySearchTree<String,Okres>(new StringComparer() );
    }
    
//    public SortedSeqenceTable<String,Okres> getTabOkresov(){
//        return aTabOkresov;
//    }
    public NonsortedSeqenceTable<String,Okres> getTabOkresov(){
        return aTabOkresov;
    }
    
    public NonsortedSeqenceTable<String,Sidlo> getSidlaKrajiny(){
        return aSidlaKrajiny;
    }
    
    public ArrayList<Okres> getArrayOkresov(){
        return aArrayOkresov;
    }
    
    public BinarySearchTree<String,Sidlo> getStromSidiel(){
        return aStromSidiel;
    }
    
    public BinarySearchTree<String,Okres> getStromOkresov(){
        return aStromOkresov;
    }

    public void pridajOkres(Okres paOkres) throws ETabulka {
        try {
            aTabOkresov.insert(paOkres.getNazovOkresu(), paOkres);
        } catch (ETable ex) {
            throw new ETabulka("Nepodarilo sa vlozit okres do tabulky okresov" + ex.getMessage() );
        }
    }
    
    public void pridajSidloDoKrajiny(Sidlo paSidlo) throws ETabulka{
        try {
            aSidlaKrajiny.insert(paSidlo.getNazovSidla(), paSidlo);
        } catch (ETable ex) {
            //throw new ETabulka("Nepodarilo sa vlozit sidlo do krajiny " + ex.getMessage() );
            JOptionPane.showMessageDialog(null, MainFrame.getKolkyRiadok(), "Mesidž", JOptionPane.INFORMATION_MESSAGE);
        }
    }

    public void pridajOkresDoArrayOkresov(Okres paOkres) throws ETabulka {
        try {
            aArrayOkresov.add(paOkres);
        } catch (EList ex) {
            throw new ETabulka("Nepodarilo sa vlozit okres do array okresov" + ex.getMessage() );
        }
    }
    
    public void pridajSidloDoStromuSidiel(Sidlo paSidlo) throws ETabulka{
        try {
            aStromSidiel.insert(paSidlo.getNazovSidla(), paSidlo);
        } catch (ETable ex) {
            throw new ETabulka("Chyba v strome sidiel " + ex.getMessage() );
        }
    }
    
    public void pridajOkresDoStromuOkresov(Okres paOkres) throws ETabulka{
        try {
            aStromOkresov.insert(paOkres.getNazovOkresu(), paOkres);
        } catch (ETable ex) {
            throw new ETabulka("Chyba v strome okresov " + ex.getMessage() );
        }
    }
}
