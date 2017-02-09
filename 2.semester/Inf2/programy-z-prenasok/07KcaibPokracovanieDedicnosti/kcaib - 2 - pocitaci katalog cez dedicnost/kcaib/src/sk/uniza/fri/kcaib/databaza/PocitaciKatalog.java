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
public class PocitaciKatalog extends Katalog {

    private int aPocet;

    public PocitaciKatalog() {
        aPocet = 0;
    }

    public void pridaj(AudiovizualneDielo paDielo) {
        aPocet++;
        super.pridaj(paDielo);
    }

    public void pridajZoznam(Collection<AudiovizualneDielo> paZoznam) {
        aPocet += paZoznam.size();
        super.pridajZoznam(paZoznam);
    }

    public int dajPocet() {
        return aPocet;
    }
}
