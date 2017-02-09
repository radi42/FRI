import javax.swing.JOptionPane;
/**
 * Cas
 * meria cas
 * 
 * @author Andrej Sisila
 * @version v1.0
 */
public class Cas
{
    private int hod;
    private int min;
    private int sek;
    
    //plny parametricky konstruktor
    public Cas(int hod, int min, int sek){
        if(hod >=0 && hod < 24){
            this.hod = hod;
        }else{
            JOptionPane.showMessageDialog(null,
                "Tolko hodin neni. Zadaj platnu celociselnu hodnotu",
                "Inane dialog",
                JOptionPane.ERROR_MESSAGE);
        }
        
        if(min >=0 && min < 60){
            this.min = min;
        }else{
            JOptionPane.showMessageDialog(null,
            "Tolko minut neni. Zadaj platnu celociselnu hodnotu",
            "Inane dialog",
            JOptionPane.ERROR_MESSAGE);
        }
        
        if(min >=0 && sek < 60){
            this.sek = sek;
        }else{
            JOptionPane.showMessageDialog(null,
            "Tolko sekund neni. Zadaj platnu celociselnu hodnotu",
            "Inane dialog",
            JOptionPane.ERROR_MESSAGE);
        }
    }
    
    //Gettery
    public int getHod(){
        return hod;
    }
    
    public int getMin(){
        return min;
    }
    
    public int getSek(){
        return sek;
    }
    
    //Settery
    public void setHod(int hod){
        if(hod >=0 && hod < 24){
            this.hod = hod;
        }else{
            JOptionPane.showMessageDialog(null,
                "Tolko hodin neni. Zadaj platnu celociselnu hodnotu",
                "Inane dialog",
                JOptionPane.ERROR_MESSAGE);
        }
    }
    
    public void setMin(int min){
        if(min >=0 && min < 60){
            this.min = min;
        }else{
            JOptionPane.showMessageDialog(null,
            "Tolko minut neni. Zadaj platnu celociselnu hodnotu",
            "Inane dialog",
            JOptionPane.ERROR_MESSAGE);
        }
    }
    
    public void setSek(int sek){
        if(min >=0 && sek < 60){
            this.sek = sek;
        }else{
            JOptionPane.showMessageDialog(null,
            "Tolko sekund neni. Zadaj platnu celociselnu hodnotu",
            "Inane dialog",
            JOptionPane.ERROR_MESSAGE);
        }
    }
    
    //DU - metoda na rozdiel dvoch casov napr v sekundach
    //DU - dalsia metoda na prevod sekund na hodiny minuty a sekundy
    
    
    //prekryta metoda toString
    public String toString(){
        String s = "";
        //s = s.format("%d. %s, %d, %s, %d",hod, ":", min, ":", sek);
        s = hod + ":" + min + ":" + sek;
        return s.replace(",","");
    }
}
