/**
 * Trieda vrchol si pamäta ci bol vrchol objaveny.
 * Nazvom vrcholu je jeho poradie v Arrayliste.
 * @author Dobroslav Grygar
 */
class Vrchol {
    
    private boolean aObjavenie;
    
    public Vrchol(){
        aObjavenie = false;
    }

    public boolean dajObjavenie() {
        return aObjavenie;
    }

    public void setaObjavenie(boolean paObjavenie) {
        this.aObjavenie = paObjavenie;
    }

}
