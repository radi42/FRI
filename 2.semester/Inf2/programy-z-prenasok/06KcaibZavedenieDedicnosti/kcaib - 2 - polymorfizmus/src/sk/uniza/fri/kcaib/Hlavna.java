/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sk.uniza.fri.kcaib;

import sk.uniza.fri.kcaib.databaza.Katalog;
import sk.uniza.fri.kcaib.polozky.CD;
import sk.uniza.fri.kcaib.polozky.DVD;

/**
 *
 * @author janik
 */
public class Hlavna {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        Katalog katalog = new Katalog();

        katalog.pridaj(new CD("The Best of", "The Beatles", 12, 30));
        katalog.pridaj(new CD("Brave New World", "Styx", 14, 45));

        katalog.pridaj(new DVD("Tenkrat na zapade", "Neznamy", 90));
        katalog.pridaj(new DVD("The Avengers", "The Avengers", 142));

        katalog.vypisPolozky();
    }
}
