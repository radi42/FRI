import java.util.*;
/**
 * Trieda Playlist - zoznam pesniciek
 * Uklada a pracuje s pesnickami
 * 
 * @author Andrej Sisila
 * @version v5.0
 */
public class Playlist
{
    /** 
     * Atributy
     * 
     * private ArrayList <Pesnicka> playlist
     * deklaracia pola s nazvom playlist
     * prvkami pola su pesnicky (trieda Pesnicka)
     * 
     * private String nazovPlaylistu
     * deklaracia stringoveho atributu
     * uklada si nazov playlistu
     */
    private ArrayList <Pesnicka> playlist;
    private String nazovPlaylistu;
    
    /**
     * Konstruktory
     */
    
    /**
     * Parametricky konstruktor
     * @param rozsahPiesni
     * urcuje kolko piesni sa vojde do pola (Playlistu)
     */
    public Playlist(int rozsahPiesni) {
        playlist = new ArrayList <Pesnicka> (rozsahPiesni);
        //pocetPiesni = 0;
    }
    
    /**
     * Bezparametricky konstruktor
     * Rozsah pola je predvolene nastaveny na 100
     */
    public Playlist() {
        this(100);
    }

    
    /**
     * Metody
     */
    
    /**
     * Metoda Get
     * Zistuje hodnotu prvku (Pesnicky) v poli (Playliste)
     * Kontroluje sa podmienka, z index nesmie prekrocit kapacitu pola
     * @param index
     * Datovy typ int
     * Ake parametre ma pesnicka na urcitej pozicii
     */
    public void get(int index) { // daj vlastnosti skladbu
        if (index < 0 && index > getPocetPiesni() ) {
            playlist.get(index);
        }
    }

    /**
     * Metoda Set
     * Nastavuje parametre pesnicky
     * Kontroluje sa podmienka, ze index patri do rozsahu pola
     * @return false 
     * ak podmienka neplati nevykona sa nic
     * @return true 
     * ak podmienka plati, vykonaju sa tieto prikazy
     * - nahradi sa objekt (instancia) na pozicii index-1 (aby bolo zabezpecene jednoduchsie narabanie
     * s cislovanim)
     * - cislo skladby sa nastavi na aktualny pocet piesni
     */
    public boolean set(int index, Pesnicka song) { //uprav parametre skladby
        if (index < 0 && index >= getPocetPiesni() ) {
            return false;
        }
        else {
            playlist.set(index -1, song);
            //song.setCisloSkladby(index);
            return true;
        }
    }
    
    /**
     * Metoda Add
     * Pridava pesnicku
     * @param song
     * datovy typ Pesnicka
     */
    public void add(Pesnicka song) { //pridaj skladbu
            playlist.add(song);
            //song.setCisloSkladby(getPocetPiesni() );
    }
    
    /**
     * Metoda Delete
     * Odobera pesnicku
     * @param idnex
     * Datovy typ int
     * Metoda odobera pesnicku na index-1 pozicii
     */
    public void delete(int index) { //odober skladbu, normalne cislovanie od jednotky
        playlist.remove(index -1);
        
        //for (int i = index; i < getPocetPiesni(); i++) {
        //    playlist.get(i).setCisloSkladby(i-1);
        //}
    }
        
    /**
     * Metoda DeleteAll
     * Odoberie vsetky pesnicky z pola (Playlistu)
     */
    public void deleteAll() { //odober vsetky skladby
        playlist.removeAll(playlist);
    }
    
    /**
     * Metoda GetPocetPiesni
     * Zistuje pocet piesni
     * @return playlist.size()
     * Vracia pocet piesni z pola pomocou metody size, ktora kontroluje naplnenost pola
     */
    public int getPocetPiesni() {
        return playlist.size();
    }
    
    /**
     * Metoda GetNazovPlaylistu
     * Zistuje nazov playlistu
     * @return nazovPlaylistu
     * Vrati nazov playlistu
     */
    public String getNazovPlaylistu() {
        return nazovPlaylistu;
    }
    
    /**
     * Metoda SetNazovPlaylistu
     * Nastavuje nazov playlistu
     * hodnota atributu sa priradi ku parametru
     */
    public void setNazovPlaylistu(String nazovPlaylistu) {
        this.nazovPlaylistu = nazovPlaylistu;
    }
    
    /**
     * Metoda toString
     * Vypisuje vsetky pesnicky v poli (playliste), kazdu na novy riadok podla zadanych parametrov
     * Pouziva triedu StringBuilder, ktory umoznuje dynamicky menit obsah retazca
     */
    public String toString() {
        StringBuilder strBuilder = new StringBuilder();
            for (int i = 0; i < getPocetPiesni(); i++) {
                System.out.print((i + 1) + "   " );
                strBuilder.append("" + playlist.get(i) );
            }
        return "";
    }
}
