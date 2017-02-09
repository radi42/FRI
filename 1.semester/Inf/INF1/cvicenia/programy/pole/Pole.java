import java.util.*;
/**
 * Trieda Pole
 * 
 * @author Andrej Sisila
 * @version v1.0
 */
public class Pole
{
   private int pocet; // pocet aktivnych (vlozenych) prvkov pola
   private int[] pole; //pole urcene na triredenie
   
    public Pole(int kapacita) {
       pole = new int[kapacita];
       pocet =0;
    }
   
    public Pole() {
        this(100);
    }
    
    //zoznam prvkov v tvare retazca
    public String toString() {
       if (pocet == 0) return "Pole je prazdne";
       
       String ret = "[ " + pole[0]; // vytvorime si premennu ret (retazec) typu retazec ktoru budeme vypisovat
       for (int i = 1; i < pocet; i++) {
           ret = pole[i] + " " + ret ; // ku retazcu pridaj hodnotu i-teho prvku. medzi prvkami bude medzera
       }
        return ret + " ]"; //vypise vsetky prvky pola
    }
    
    public boolean naplnNahodne(int pocetPrvkov, int rozsahOd, int rozsahDo) {
        Random rnd = new Random(); //vytvorenie instancie generovania nahodnych cisel
        pocet = pocetPrvkov;
        if (pocetPrvkov > pole.length) return false;

        for (int i = 0; i < pocetPrvkov; i++) {
            pole[i] = rozsahOd + rnd.nextInt(rozsahDo - rozsahOd +1); //metoda nextInt generuje cislo tak ze ide od 0 po vypocitanu hranicu -1, napr ak bude interval od 0 do 50, jeho rozsah je 50-0-1=49 cisel
        }
        return true;
    }
    
    public int get(int index) { // get a ako parameter typ indexu
        return pole[index];
    }
    
    public boolean set(int index, int hodnota) { // parametre - index: kam to mam ulozit, hodnota: co mam ulozit
          //if ( ! (index >= 0 && index < pocet) ) {       // negujeme celu podmienku = zapiseme vykricnik a dame celu podmienku do zatvorky
          if (index < 0 || index >= pocet) {
            return false;
          }   
          else {
              pole[index] = hodnota;
              return true;
          }
    }

    public int size() { // napmiesto getPocet piseme size
        return pocet;
    }
    
    public boolean add(int hodnota) {
        if (pocet > pole.length) {
            return false;
        }
        else {
            pole[pocet] = hodnota;
            pocet++; // pocet zvysime o jedna
            return true;
        }
    }
    
    public void vypis() {
        String ret = "[ " + pole[0]; // vytvorime si premennu ret (retazec) typu retazec ktoru budeme vypisovat
        
        for (int i = 1; i < pocet; i++) {
           ret = ret + " " + pole[i]; // ku retazcu pridaj hodnotu i-teho prvku. medzi prvkami bude medzera
        }    
       
       System.out.println(ret);
    }
}