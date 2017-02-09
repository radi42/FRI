/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package prednaska3;

/**
 * Trieda Stvorec
 * 
 * vytvara stvorec
 * @author Andy
 */
public class Stvorec implements Obrazec{
    private double strana;
    
    public Stvorec(double strana){
        this.strana = strana;
    }
    
    /**
     *
     * @return obvod stvorca
     */
    @Override
    public double obvod(){
        return (4 * strana);
    }
    
    /**
     * 
     * @return obsah stvorca
     */
    @Override
    public double obsah(){
        return strana * strana;
    }
    
    @Override
    public String toString(){
        return String.format("Stvorec     (r =%5.2f)", strana);
    }
}
