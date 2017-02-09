/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sk.uniza.fri.kcaib.polozky;

/**
 *
 * @author janik
 */
public abstract class AudiovizualneDielo {

    private String aTitul;
    private int aCelkovyCas; // v minutach
    private String aKomentar;

    public AudiovizualneDielo(String paTitul, int paCelkovyCas) {
        aTitul = paTitul;
        aCelkovyCas = paCelkovyCas;
        aKomentar = null;
    }

    public String dajTitul() {
        return aTitul;
    }

    public int dajCelkovyCas() {
        return aCelkovyCas;
    }

    public String dajKomentar() {
        return aKomentar;
    }

    public void pridajKomentar(String paKomentar) {
        if (aKomentar == null) {
            aKomentar = paKomentar;
        } else {
            aKomentar = aKomentar + "\n" + paKomentar;
        }
    }

    public abstract void vypis();

    protected void vypisKomentar() {
        if (aKomentar != null) {
            System.out.println(aKomentar);
        }
    }
}
