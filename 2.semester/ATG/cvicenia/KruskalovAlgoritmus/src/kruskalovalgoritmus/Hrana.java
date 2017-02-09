/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package kruskalovalgoritmus;

/**
 * Trieda Hrana
 * @author Andy
 */
public class Hrana {
    
    private Vrchol zaciatocnyVrchol, koncovyVrchol;
    private int cenaHrany;
    
    /**
     * Uplny konstruktor
     * @param zaciatocnyVrchol zaciatocny vrchol hrany
     * @param koncovyVrchol koncovy vrchol hrany
     * @param cenaHrany ohodnotenie hrany
     */
    public Hrana(Vrchol zaciatocnyVrchol, Vrchol koncovyVrchol, int cenaHrany) {
        this.zaciatocnyVrchol = zaciatocnyVrchol;
        this.koncovyVrchol = koncovyVrchol;
        this.cenaHrany = cenaHrany;
    }

    public Vrchol getZaciatocnyVrchol() {
        return zaciatocnyVrchol;
    }

    public Vrchol getKoncovyVrchol() {
        return koncovyVrchol;
    }

    public int getCenaHrany() {
        return cenaHrany;
    }
    
    public String vypisHrana(){
        return zaciatocnyVrchol.vypisVrchol() + " " + koncovyVrchol.vypisVrchol() + " " + cenaHrany;
    }
}
