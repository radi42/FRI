package tables.Sorts;

import exception.ETabulka;
import semestralka.Sidlo;

/**
 *
 * @author Andrej Šišila
 */
public class SidloAbsPrirastokComparer extends KeyComparer<Sidlo> {
    
    private int aRokOd;
    private int aRokDo;
    
    public SidloAbsPrirastokComparer(int paRokOd, int paRokDo){
        aRokOd = paRokOd;
        aRokDo = paRokDo;
    }
    
    @Override
    public int compare(Sidlo paFirst, Sidlo paSecond){
        if(areEqual(paFirst, paSecond))
            return 0;
        else if(firstIsLess(paFirst, paSecond))
            return -1;
        else    //firstIsGreater
            return 1;
    }
    
    @Override
    public boolean areEqual(Sidlo paFirst, Sidlo paSecond) {
        try {
            return paFirst.vypocitajAbsolutnyPrirastok(aRokOd, aRokDo) == paSecond.vypocitajAbsolutnyPrirastok(aRokOd, aRokDo);
        } catch (ETabulka ex) {
            return false;
        }
    }
    
    @Override
    public boolean firstIsLess(Sidlo paFirst, Sidlo paSecond) {
        try {
            return paFirst.vypocitajAbsolutnyPrirastok(aRokOd, aRokDo) < paSecond.vypocitajAbsolutnyPrirastok(aRokOd, aRokDo);
        } catch (ETabulka ex) {
            return false;
        }
    }
    
    @Override
    public boolean firstIsGreater(Sidlo paFirst, Sidlo paSecond) {
        try {
            return paFirst.vypocitajAbsolutnyPrirastok(aRokOd, aRokDo) > paSecond.vypocitajAbsolutnyPrirastok(aRokOd, aRokDo);
        } catch (ETabulka ex) {
            return false;
        }
    }

}