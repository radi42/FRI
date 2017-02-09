package tables.Sorts;

import exception.ETabulka;
import semestralka.Okres;

/**
 *
 * @author Andrej Šišila
 */
public class OkresPercPrirastokComparer extends KeyComparer<Okres>{

    private int aRokOd;
    private int aRokDo;
    
    public OkresPercPrirastokComparer(int paRokOd, int paRokDo){
        aRokOd = paRokOd;
        aRokDo = paRokDo;
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
            return paFirst.vypocitajPercentualnyPrirastok(aRokOd, aRokDo) == paSecond.vypocitajPercentualnyPrirastok(aRokOd, aRokDo);
        } catch (ETabulka ex) {
            return false;
        }
    }
    
    @Override
    public boolean firstIsLess(Okres paFirst, Okres paSecond) {
        try {
            return paFirst.vypocitajPercentualnyPrirastok(aRokOd, aRokDo) < paSecond.vypocitajPercentualnyPrirastok(aRokOd, aRokDo);
        } catch (ETabulka ex) {
            return false;
        }
    }
    
    @Override
    public boolean firstIsGreater(Okres paFirst, Okres paSecond) {
        try {
            return paFirst.vypocitajPercentualnyPrirastok(aRokOd, aRokDo) > paSecond.vypocitajPercentualnyPrirastok(aRokOd, aRokDo);
        } catch (ETabulka ex) {
            return false;
        }
    }
}
