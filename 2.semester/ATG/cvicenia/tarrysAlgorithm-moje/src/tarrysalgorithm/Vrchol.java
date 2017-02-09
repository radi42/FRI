package tarrysalgorithm;

/**
 * Trieda Vrchol
 * vrchol si zapamata, ci bol objaveny
 * nazov vrchola je urceny poradovym cislom v arrayliste
 * @author Andy
 */
public class Vrchol {
    private boolean objaveny;
    
    public Vrchol(){
        this.objaveny = false;
    }
    
    public boolean somObjaveny(){
        return objaveny;
    }
    
    public void setObjaveny(boolean objaveny){
        this.objaveny = objaveny;
    }
}