/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package zoo;

import lib.Osoba;

/**
 *
 * @author sisi
 */
public class Zoo {
    private Osoba manager;
    private Zverinec zvierataZoo;

    public Zoo(Osoba manager, Zverinec zvierataZoo) {
        this.manager = manager;
        this.zvierataZoo = zvierataZoo;
    }

    public Osoba getManager() {
        return manager;
    }

    public void setManager(Osoba manager) {
        this.manager = manager;
    }

    public Zverinec getZvierataZoo() {
        return zvierataZoo;
    }

    public void setZvierataZoo(Zverinec zvierataZoo) {
        this.zvierataZoo = zvierataZoo;
    }

    @Override
    public String toString() {
        return "Zoologicka zahrada bola vytvorena";
    }
}
