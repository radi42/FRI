package tables.Sorts;

import exception.ETabulka;
import semestralka.Okres;

/**
 *
 * @author Andrej Šišila
 */
public class OkresPocetComparer extends KeyComparer<Okres>{

    private int aRok;
    
    public OkresPocetComparer(int paRok){
        aRok = paRok;
    }

    @Override
    public int compare(Okres paFirst, Okres paSecond){
        if(areEqual(paFirst, paSecond))
            return 0;
        else if(firstIsLess(paFirst, paSecond))
            return -1;
        else    //firstIsGreater
            return 1;
    }
    
    @Override
    public boolean areEqual(Okres paFirst, Okres paSecond) {
        try {
            return paFirst.getPocetObyvatelovOkresuVDanomRoku(aRok) == paSecond.getPocetObyvatelovOkresuVDanomRoku(aRok);
        } catch (ETabulka ex) {
            return false;
        }
    }
    
    @Override
    public boolean firstIsLess(Okres paFirst, Okres paSecond) {
        try {
            return paFirst.getPocetObyvatelovOkresuVDanomRoku(aRok) < paSecond.getPocetObyvatelovOkresuVDanomRoku(aRok);
        } catch (ETabulka ex) {
            return false;
        }
    }
    
    @Override
    public boolean firstIsGreater(Okres paFirst, Okres paSecond) {
        try {
            return paFirst.getPocetObyvatelovOkresuVDanomRoku(aRok) > paSecond.getPocetObyvatelovOkresuVDanomRoku(aRok);
        } catch (ETabulka ex) {
            return false;
        }
    }

}
