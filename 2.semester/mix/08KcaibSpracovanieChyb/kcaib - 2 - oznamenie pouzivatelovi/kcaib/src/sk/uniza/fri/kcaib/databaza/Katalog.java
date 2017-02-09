package sk.uniza.fri.kcaib.databaza;

import java.util.ArrayList;
import java.util.Collection;
import sk.uniza.fri.kcaib.polozky.AudiovizualneDielo;

public class Katalog implements IKatalog {

    private ArrayList<AudiovizualneDielo> aZoznamPoloziek;

    public Katalog() {
        aZoznamPoloziek = new ArrayList<AudiovizualneDielo>();
    }

    public void pridaj(AudiovizualneDielo paNoveCD) {
        aZoznamPoloziek.add(paNoveCD);
    }

    public void vypisPolozky() {
        for (AudiovizualneDielo cd : aZoznamPoloziek) {
            cd.vypis();
            System.out.println("==============================================");
        }
    }

    public void pridajZoznam(Collection<AudiovizualneDielo> paZoznam) {
        for (AudiovizualneDielo dielo : paZoznam) {
            this.pridaj(dielo);
        }
    }

    public void vymaz(String paTitul) {
        if (paTitul == null || paTitul.isEmpty()) {
            System.out.println("Titul musi byt zadany!");
        } else {
            AudiovizualneDielo polozka = this.vyhladaj(paTitul);

            if (polozka == null) {
                System.out.println("Titul nie je v katalogu!");
            } else {
                aZoznamPoloziek.remove(polozka);
            }

        }
    }

    private AudiovizualneDielo vyhladaj(String paTitul) {
        for (AudiovizualneDielo polozka : aZoznamPoloziek) {
            if (polozka.dajTitul().equals(paTitul)) {
                return polozka;
            }
        }

        return null;
    }
}
