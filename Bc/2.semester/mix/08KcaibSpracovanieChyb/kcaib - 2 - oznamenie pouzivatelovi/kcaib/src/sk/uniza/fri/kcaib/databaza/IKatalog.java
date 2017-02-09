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
public interface IKatalog {

    void pridaj(AudiovizualneDielo paNoveCD);

    void pridajZoznam(Collection<AudiovizualneDielo> paZoznam);

    void vypisPolozky();
    
    void vymaz(String paTitul);
}
