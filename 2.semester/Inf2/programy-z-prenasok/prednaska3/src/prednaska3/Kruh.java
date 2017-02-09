/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package prednaska3;

/**
 * Trieda Kruh
 * 
 * vytvara kruh
 * @author Andy
 */
public class Kruh implements Obrazec{
    private double polomer;
    
    /**
     * Konstruktor
     * @param polomer polomer kruhu v desatinnom cisle
     */
    public Kruh(double polomer){
        this.polomer = polomer;
    }
    
    /**
     *
     * @return obvod kruhu
     */
    @Override
    public double obvod(){
        return Math.PI * Math.pow(polomer, 2);
    }
    
    /**
     * 
     * @return obsah kruhu
     */
    @Override
    public double obsah(){
        return 2 * Math.PI * polomer;
    }
    
    @Override
    public String toString(){
        return String.format("Kruh        (r =%5.2f)", polomer);
    }
}
