/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package zoo;

import lib.Osoba;

/**
 *
 * @author Andy
 */
public class Kamion extends PrepravnyProstriedok implements Prepravitelny{

    private double kapacitaObjemu;
    
    /**
     * 
     * @param vodic osoba vodic
     * @param maxPrepravnaVaha vahovy limit kamionu
     */
    public Kamion(Osoba vodic, double maxPrepravnaVaha) {
        super(vodic, maxPrepravnaVaha);
        this.kapacitaObjemu = 150;
    }
    
    public Kamion(Osoba vodic, double maxPrepravnaVaha, double kapacitaObjemu) {
        super(vodic, maxPrepravnaVaha);
        this.kapacitaObjemu = kapacitaObjemu;
    }

    public double getKapacitaObjemu() {
        return kapacitaObjemu;
    }
    
    
    @Override
    public double poziadavkaObjemu() {
       return 0.0;
    }

    @Override
    public double poziadavkaVahy() {
        return 0.0;
    }

    @Override
    public String infoOVozidle() {
        String str = "Kamion - " + super.toString() + "%n";
        for(Prepravitelny zasielka : pasazieri){
            Zivocich zviera = (Zivocich) zasielka;
            str += zviera.toString() + "%n";
        }
        return str;
    }
    
}
