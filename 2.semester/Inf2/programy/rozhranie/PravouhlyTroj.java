package rozhranie;


/**
 * Write a description of class Obdlznik here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class PravouhlyTroj implements Zobrazitelny
{
    private int stranaA;
    private int stranaB;
    
    /**
     * konstruktor
     */
    public PravouhlyTroj(int stranaA, int stranaB){
        this.stranaA = stranaA;
        this.stranaB = stranaB;
    }
    
    //strana A
    /**
     * getter na stranuA
     */
    public int getStranaA(){
        return stranaA;
    }

    /**
     * setter na stranuA
     */
    public void setStranaA(int stranaA){
        this.stranaA = stranaA;
    }
    
    //Strana B
    /**
     * getter na stranuB
     */
    public int getStranaB(){
        return stranaA;
    }

    /**
     * setter na stranuB
     */
    public void setStranaB(int stranaA){
        this.stranaA = stranaA;
    }
    
    public void nakresliSa(){
        
    }
    
    public double dajObvod(){
        return getStranaA()*getStranaB();
    }
}
