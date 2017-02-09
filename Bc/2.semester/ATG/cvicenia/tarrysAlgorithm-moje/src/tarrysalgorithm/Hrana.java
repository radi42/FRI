package tarrysalgorithm;

/**
 * Trieda Hrana
 * Hrana si pamata:
 * a) zaciatocny a koncovy vrchol
 * b) ci bola hranou prveho pristupu tj ci objavila novy vrchol
 * c) ci bola pouzita
 * @author Andy
 */
public class Hrana {
    private int zaciatokVrchol;
    private int koniecVrchol;
    private boolean bolaPouzita; //udava ci bola hrana prejdena aj v opacnom smere
    private boolean jePrvehoPristupu;
    
    /**
     * Konstruktor
     * vytvori novu hranu
     * @param zaciatokVrchol zaciatocny vrchol hrany
     * @param koniecVrchol koncovy vrchol hrany
     */
    public Hrana(int zaciatokVrchol, int koniecVrchol){
        this.zaciatokVrchol = zaciatokVrchol;
        this.koniecVrchol = koniecVrchol;
        bolaPouzita = false;
        jePrvehoPristupu = false;
    }

    /**
     * 
     * @return zaciatocny vrchol hrany
     */
    public int getZaciatokVrchol() {
        return zaciatokVrchol;
    }

    /**
     * 
     * @return koncovy vrchol hrany
     */
    public int getKoniecVrchol() {
        return koniecVrchol;
    }

    /**
     * zistuje, ci bola hrana v jednom smere pouzita
     * @return pouzitie
     */
    public boolean isBolaPouzita() {
        return bolaPouzita;
    }

    /**
     * zistuje, ci bol hranou prveho pristupuobjaveny novy vrchol
     * @return pristup
     */
    public boolean isJePrvehoPristupu() {
        return jePrvehoPristupu;
    }

    
    /**
     * bolaPouzita nastavuje hranu, ze bola v jednom smere pouzita
     * @param pouzitie hrany
     */
    public void setBolaPouzita(boolean bolaPouzita) {
        this.bolaPouzita = bolaPouzita;
    }

    /**
     * nastavuje hranu na hranu prveho pristupu
     * @param jePrvehoPristupu hrana objavila/neobjavila novy vrchol
     */
    public void setJePrvehoPristupu(boolean jePrvehoPristupu) {
        this.jePrvehoPristupu = jePrvehoPristupu;
    }
    
    
    @Override
    public String toString(){
        String hlasenie = "";
        hlasenie = zaciatokVrchol + " " + koniecVrchol + ". " + 
                "Prvy pristup: " + isJePrvehoPristupu() + 
                "; Bola pouzita: " + isBolaPouzita();
        return hlasenie;
//        String vypis = zaciatokVrchol + " " + koniecVrchol + 
//                ". Je prveho pristupu? " + isJePrvehoPristupu();
//        return vypis;
    }
    
    
}
