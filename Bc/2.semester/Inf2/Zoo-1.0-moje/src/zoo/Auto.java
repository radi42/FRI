/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package zoo;

import lib.Osoba;

/**
 * Prepravuje vsetko mozne
 * @author Andy
 */
public class Auto extends PrepravnyProstriedok{
    private int pocetDveri;

    public Auto(Osoba vodic, double maxPrepravnaVaha) {
        super(vodic, maxPrepravnaVaha);
        this.pocetDveri = pocetDveri;
    }

    
    @Override
    public String infoOVozidle() {
        String info = "Auto %n"
                + "pocet dveri: " + pocetDveri + "%n"
                + "maximalna prepravna vaha: " + maxPrepravnaVaha + "%n"
                + "aktualna vaha: " + aktualnaVaha;
        return info;
    }
    
}
