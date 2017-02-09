/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package prednaska3;

/**
 * Trieda Obdlznik
 * 
 * vytvara obdlznik
 * @author Andy
 */
public class Obdlznik implements Obrazec{
    private double stranaA;
    private double stranaB;
    
    /**
     * konstruktor
     * @param stranaA rozmer A
     * @param stranaB rozmer B
     */
    public Obdlznik(double stranaA, double stranaB){
        this.stranaA = stranaA;
        this.stranaB = stranaB;
    }
    
     /**
     *
     * @return obvod obdlznika
     */
    @Override
    public double obvod(){
        return ( (2 * stranaA) + (2 *stranaB) );
    }
    
    /**
     * 
     * @return obsah obdlznika
     */
    @Override
    public double obsah(){
        return stranaA * stranaB;
    }
    
    @Override
    public String toString(){
        return String.format("Obdlznik    (a = %2.2f, b = %2.2f)",
                stranaA, stranaB);
    }
}
