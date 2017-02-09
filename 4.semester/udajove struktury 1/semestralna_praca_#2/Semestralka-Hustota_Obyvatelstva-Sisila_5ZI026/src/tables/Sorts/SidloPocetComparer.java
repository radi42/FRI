package tables.Sorts;

import exception.ETabulka;
import java.util.logging.Level;
import java.util.logging.Logger;
import semestralka.Sidlo;

/**
 *
 * @author Andrej Šišila
 */
public class SidloPocetComparer extends KeyComparer<Sidlo> {
    
    private int aRok;
    
    public SidloPocetComparer(int paRok){
        aRok = paRok;
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
            return paFirst.getPocetObyvatelovSidlaVDanomRoku(aRok) == paSecond.getPocetObyvatelovSidlaVDanomRoku(aRok);
        } catch (ETabulka ex) {
            return false;
        }
    }
    
    @Override
    public boolean firstIsLess(Sidlo paFirst, Sidlo paSecond) {
        try {
            return paFirst.getPocetObyvatelovSidlaVDanomRoku(aRok) < paSecond.getPocetObyvatelovSidlaVDanomRoku(aRok);
        } catch (ETabulka ex) {
            return false;
        }
    }
    
    @Override
    public boolean firstIsGreater(Sidlo paFirst, Sidlo paSecond) {
        try {
            return paFirst.getPocetObyvatelovSidlaVDanomRoku(aRok) > paSecond.getPocetObyvatelovSidlaVDanomRoku(aRok);
        } catch (ETabulka ex) {
            return false;
        }
    }

}
