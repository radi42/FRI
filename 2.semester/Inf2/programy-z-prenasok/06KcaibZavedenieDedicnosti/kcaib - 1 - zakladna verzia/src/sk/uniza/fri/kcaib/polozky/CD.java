package sk.uniza.fri.kcaib.polozky;

public class CD {

    private String aTitul;
    private String aAutor;
    private int aPocetSkladieb;
    private int aCelkovyCas; // v minutach
    private String aKomentar;

    public CD(String paTitul, String paAutor, int paPocetSkladieb, int paCelkovyCas) {
        aTitul = paTitul;
        aAutor = paAutor;
        aPocetSkladieb = paPocetSkladieb;
        aCelkovyCas = paCelkovyCas;
        aKomentar = null;
    }

    public String dajTitul() {
        return aTitul;
    }

    public String dajAutora() {
        return aAutor;
    }

    public int dajPocetSkladieb() {
        return aPocetSkladieb;
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
        System.out.println("CD:");
        System.out.println("    Autor: " + aAutor);
        System.out.println("    Titul: " + aTitul);
        System.out.println();
        System.out.println("    Pocet skladieb: " + aPocetSkladieb + " (celkovo " + aCelkovyCas + " minut)");
        if (aKomentar != null) {
            System.out.println();
            System.out.println("Komentar ku CD:");
            System.out.println(aKomentar);
        }
    }
}
