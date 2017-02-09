
/**
 * Trieda Zbierka
 * @date Datum zaciatku: 29.11.2013
 * 
 * @author Andrej Sisila
 * @version v0.9b
 */
public class Zbierka
{
    private Playlist [] zbierka;
    private int pocetPlaylistov;
    private String nazovZbierky;
    
    /**
     * Parametricky konstruktor
     */
    public Zbierka(int kapacita) {
        zbierka = new Playlist[kapacita];
        pocetPlaylistov = 0;
    }
    
    /**
     * Bezparametricky konstruktor
     */
    public Zbierka() {
        this(10);
    }
    
    
    /**
     * Gettery
     */
    public Playlist get(int index) { // daj skladbu
        return zbierka[index];
    }
    
    public int getPocetPlaylistov() {
        return pocetPlaylistov;
    }
    
    public String getNazovZbierky() {
        return nazovZbierky;
    }
    
    
    //pridaj playlist do zbierky
    public void add(Playlist pllst) { //pridaj playlist
            zbierka[pocetPlaylistov] = pllst;
            pocetPlaylistov++;
            //pllst.setCisloPlaylistu(pocetPlaylistov);
    }
    
    public void delete(int index) { //odober playlist
        zbierka[index] = null; //vynuloval som stvrtu pesnicku          
        pocetPlaylistov--;
        
        int pozicia = index; //vytvorim si pocitadlo pesniciek
        
        // playlist[1=index] = playlist[2]	
        // playlist[2] = playlist[3]
            for (int i = index; i < zbierka.length -1; i++) {
               zbierka[i] = zbierka[i+1];
            }
    }
    
    
    /**
     * toString metoda
     */   
    public String toString() {
        StringBuilder strBuilder = new StringBuilder();
            for (int i = 0; i < pocetPlaylistov; i++) {
                strBuilder.append(nazovZbierky );
            }
        return strBuilder.toString();
    }
}