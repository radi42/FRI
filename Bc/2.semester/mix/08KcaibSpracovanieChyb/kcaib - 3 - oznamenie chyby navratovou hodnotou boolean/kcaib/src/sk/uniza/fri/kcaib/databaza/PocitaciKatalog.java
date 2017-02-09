/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sk.uniza.fri.kcaib.databaza;

import java.util.Collection;
import sk.uniza.fri.kcaib.polozky.AudiovizualneDielo;

/**
 *
 * @author janik
 */
public class PocitaciKatalog implements IKatalog {

    private int aPocet;
    private final IKatalog aZabaleny;

    public PocitaciKatalog(IKatalog paZabaleny) {
        aPocet = 0;
        aZabaleny = paZabaleny;
    }

    public void pridaj(AudiovizualneDielo paDielo) {
        aPocet++;
        aZabaleny.pridaj(paDielo);
    }

    public void pridajZoznam(Collection<AudiovizualneDielo> paZoznam) {
        aPocet += paZoznam.size();
        aZabaleny.pridajZoznam(paZoznam);
    }

    public int dajPocet() {
        return aPocet;
    }

    @Override
    public void vypisPolozky() {
        aZabaleny.vypisPolozky();
    }

    @Override
    public boolean vymaz(String paTitul) {
        if (aZabaleny.vymaz(paTitul)) {
            aPocet --;
            return true;
        }
        
        return false;
    }
}
