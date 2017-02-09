/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package kruskalovalgoritmus;

/**
 * Trieda Vrchol
 * 
 * @author Andy
 */
public class Vrchol {
    
    private int cisloVrchola;
    private int cisloKomponentu;

    /**
     * Konstruktor
     * @param cisloVrchola cislo vrchola v grafe
     */
    public Vrchol(int cisloVrchola) {
        this.cisloVrchola = cisloVrchola;
        this.cisloKomponentu = cisloVrchola; //cislo komponentu, v ktorom sa vrchol na zaciatku nachadza je rovnaky ako cislo vrcholu
    }

    //Gettery===================================

    public int getCisloVrchola() {
        return cisloVrchola;
    }

    public int getCisloKomponentu() {
        return cisloKomponentu;
    }
    
    //Settery====================================
    public void setCisloKomponentu(int cisloKomponentu) {
        this.cisloKomponentu = cisloKomponentu;
    }
    
    public String vypisVrchol(){
        return String.valueOf(cisloVrchola);
    }
    
    public String vypisVrcholAKomponent(){
        return String.valueOf(cisloVrchola) + "   " + cisloKomponentu;
    }
}
