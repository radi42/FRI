package sk.uniza.fri.kcaib.polozky;

public class CD extends AudiovizualneDielo {

    private String aAutor;
    private int aPocetSkladieb;

    public CD(String paTitul, String paAutor, int paPocetSkladieb, int paCelkovyCas) {
        super(paTitul, paCelkovyCas);

        aAutor = paAutor;
        aPocetSkladieb = paPocetSkladieb;
    }

    public String dajAutora() {
        return aAutor;
    }

    public int dajPocetSkladieb() {
        return aPocetSkladieb;
    }

    public void vypis() {
        System.out.println("CD:");
        System.out.println("    Autor: " + aAutor);
        System.out.println("    Titul: " + this.dajTitul());
        System.out.println();
        System.out.println("    Pocet skladieb: " + aPocetSkladieb + " (celkovo " + this.dajCelkovyCas() + " minut)");

        this.vypisKomentar();
    }
}
