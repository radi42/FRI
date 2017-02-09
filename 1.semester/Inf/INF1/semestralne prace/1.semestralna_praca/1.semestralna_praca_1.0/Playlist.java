
/**
 * Playlist - zoznam pesniciek
 * 
 * @author Andrej Sisila
 * @version v3.0
 */
public class Playlist
{
    private Pesnicka [] playlist;
    private int pocetPiesni;
    private String nazovPlaylistu;
    
    /**
     * Parametricky konstruktor
     */
    public Playlist(int rozsahPiesni) {
        playlist = new Pesnicka[rozsahPiesni];
        pocetPiesni = 0;
    }
    
    /**
     * Bezparametricky konstruktor
     */
    public Playlist() {
        this(10);
    }

    
    /**
     * Gettery
     */
    public Pesnicka get(int index) { // daj skladbu
        return playlist[index];
    }
    
    public int getPocetPiesni() {
        return pocetPiesni;
    }
    
    public String getNazovPlaylistu() {
        return nazovPlaylistu;
    }   
    
    /**
     * Settery
     */
    public boolean set(int index, Pesnicka song) { //uprav parametre skladby
        if (index < 0 && index >= pocetPiesni) {
            return false;
        }
        else {
            playlist[index] = song;
            return true;
        }
    }
    
    public void setNazovPlaylistu(String nazovPlaylistu) {
        this.nazovPlaylistu = nazovPlaylistu;
    }
    
    
    /**
     * Metody
     * 
     * Pridaj pesnicku
     */
    public void addSkladba(Pesnicka song) { //pridaj skladbu
            playlist[pocetPiesni] = song;
            pocetPiesni++;
            song.setCisloSkladby(pocetPiesni);
    }
    
    public void delete(int index) { //odober skladbu
        playlist[index] = null; //vynuloval som stvrtu pesnicku          
        pocetPiesni--;
        
        int pozicia = index; //vytvorim si pocitadlo pesniciek
        
        // playlist[1=index] = playlist[2]  
        // playlist[2] = playlist[3]
        for (int i = index; i < playlist.length -1; i++) {
            playlist[i] = playlist[i+1];
        }
    }
    
    
    /**
     * toString metoda
     */   
    public String toString() {
        StringBuilder strBuilder = new StringBuilder();
            for (int i = 0; i < pocetPiesni; i++) {
                strBuilder.append(playlist[i] );
            }
        return strBuilder.toString();
    }
}