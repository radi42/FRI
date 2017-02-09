/**
 * Trieda hrana si pamäta vrcholy, ci je prveho pristupu a ci bola pouzita.
 * @author Dobroslav Grygar
 */
class Hrana {
    
    private int aVrchol1;
    private int aVrchol2;
    private boolean aPrvyPristup;
    private boolean aPouzitie;
    
    public Hrana(int paVrchol1, int paVrchol2){
        aVrchol1 = paVrchol1;
        aVrchol2 = paVrchol2;
        aPrvyPristup = false;
        aPouzitie = false;
    }

    public int dajVrchol1() {
        return aVrchol1;
    }

    public int dajVrchol2() {
        return aVrchol2;
    }

    public boolean dajPrvyPristup() {
        return aPrvyPristup;
    }

    public boolean dajPouzitie() {
        return aPouzitie;
    }

    public void setPrvyPristup(boolean paPrvyPristup) {
        this.aPrvyPristup = paPrvyPristup;
    }

    public void setPouzitie(boolean paPouzitie) {
        this.aPouzitie = paPouzitie;
    }
    
    @Override
    public String toString(){
        String vypis = aVrchol1 + " " + aVrchol2 + ". Je preveho pristupu? " + aPrvyPristup;
        return vypis;
    }
}
