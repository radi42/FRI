/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sk.uniza.fri.kcaib.polozky;

/**
 *
 * @author janik
 */
public class DVD extends AudiovizualneDielo {

    private String aReziser;

    public DVD(String paTitul, String paReziser, int paCelkovyCas) {
        super(paTitul, paCelkovyCas);

        aReziser = paReziser;
    }

    public String dajRezisera() {
        return aReziser;
    }

    public void vypis() {
        System.out.println("DVD:");
        System.out.println("    Reziser: " + aReziser);
        
        super.vypis();
    }
}
