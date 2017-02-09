
/**
 * Write a description of class Dvojica here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Dvojica
{
    private int ziak1; //cislo ziaka jedna
    private int ziak2; //cislo ziaka dva
    
    public Dvojica(int ziak1, int ziak2){
        this.ziak1 = ziak1;
        this.ziak2 = ziak2;        
    }
    //Gettery
    public int getZiak1(){
        return ziak1;
    }
    
    public int getZiak2(){
        return ziak1;
    }
    
    public String toString(){
        String s = "";
        s = s.format("%-5d, %d", ziak1, ziak2);
        return s.replace(",", "");
    }
}
