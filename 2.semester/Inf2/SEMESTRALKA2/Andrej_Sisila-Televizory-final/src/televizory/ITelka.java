package televizory;

import java.io.IOException;

/**
 * Interface ITelka
 * deklaruje vsetky metody ktore musi mat trieda, ak implementuje toto rozhranie
 * 
 * @author Andrej Šišila
 */
public abstract interface ITelka {
    
    /**
     * @return nazov programu, na ktory sa televizor prepne
     */
    String prepniProgramNahodne();
    
    /**
     * @return textovy vypis televizora
     */
    String vypis();
    
    String zapisData() throws IOException;
    
    @Override
    String toString();
    
    //gettery pre atributy
    int getCena();
    int getUhlopriecka();
    boolean isZapnuty();
    
    //settery pre atributy
    /**
     * nastavuje cenu televizora
     * @param cena int - cena telky
     */
    void setCena(int cena);
    
    /**
     * nastavuje stav telky
     * @param zapnuty zapnuty alebo nie?
     */
    void setZapnuty(boolean zapnuty);
}
