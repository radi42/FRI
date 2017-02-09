import java.util.ArrayList;
/**
 * Trieda Spoj
 * 
 * @author Andrej Sisila
 * @version v1.0
 */
public class Spoj
{
    private String menoVlak;
    private ArrayList <Stanica> stanice;
    
    public Spoj(String menoVlak){
        this.menoVlak = menoVlak;
        stanice = new ArrayList <Stanica>();
    }
    
    //gettery
    public String getMenoVlak(){
        return menoVlak;
    }
    
    public String getStanice(){
        String s = "";
        for(Stanica stan : stanice){
            s += stan + "\n";
        }
        return s;
    }
    
    //settery
    public void setNazovVlak(String menoVlak){
        this.menoVlak = menoVlak;
    }
    
    public void setStanica(int index, Stanica stan){
        stanice.set(index, stan);
    }
    
    //metody
    //pridaj stanicu
    public void addSpoj(){
        stanice.add(new Stanica("Zilina", new Cas(5, 10, 15)) );
        stanice.add(new Stanica("Blava", new Cas(8, 16, 24)) );
    }
    
    //jazda vlaku
    public void jazdaVlaku(){
        //vsetky stanice po sebe - pocty dat zo stanice, volame nastup, vystup, nazov stanicu
    }
    
    //prekryty toString
    public String toString(){
        return "foo";
    }
}
