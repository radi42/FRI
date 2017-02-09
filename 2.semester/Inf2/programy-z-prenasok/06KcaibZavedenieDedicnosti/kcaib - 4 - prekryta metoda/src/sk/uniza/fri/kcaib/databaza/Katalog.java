package sk.uniza.fri.kcaib.databaza;

import java.util.ArrayList;
import sk.uniza.fri.kcaib.polozky.IAudiovizualneDielo;

public class Katalog {

    private ArrayList<IAudiovizualneDielo> aZoznamPoloziek;

    public Katalog() {
        aZoznamPoloziek = new ArrayList<IAudiovizualneDielo>();
    }

    public void pridaj(IAudiovizualneDielo paNoveCD) {
        aZoznamPoloziek.add(paNoveCD);
    }

    public void vypisPolozky() {
        for (IAudiovizualneDielo cd : aZoznamPoloziek) {
            cd.vypis();
            System.out.println("==============================================");
        }
    }
}
