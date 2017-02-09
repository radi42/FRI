/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sk.uniza.fri.kcaib.polozky;

/**
 *
 * @author janik
 */
public class DVD implements IAudiovizualneDielo {

    private String aTitul;
    private String aReziser;
    private int aCelkovyCas; // v minutach
    private String aKomentar;

    public DVD(String paTitul, String paReziser, int paCelkovyCas) {
        aTitul = paTitul;
        aReziser = paReziser;
        aCelkovyCas = paCelkovyCas;
        aKomentar = null;
    }

    public String dajTitul() {
        return aTitul;
    }

    public String dajRezisera() {
        return aReziser;
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

    public void vypis() {
        System.out.println("DVD:");
        System.out.println("    Reziser: " + aReziser);
        System.out.println("    Titul: " + aTitul);
        System.out.println();
        System.out.println("    Celkovy cas " + aCelkovyCas + " minut");
        if (aKomentar != null) {
            System.out.println();
            System.out.println("Komentar ku DVD:");
            System.out.println(aKomentar);
        }
    }
}
