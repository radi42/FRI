/**
 * Obsahuje podrobnosti o udalosti v diari.
 * 
 * @author David J. Barnes and Michael Kolling
 * @version 2006.03.30
 * 
 * lokalizacia
 * @author Lubomir Sadon a Jan Janech
 * @version 2010.02.12
 */
public class Udalost
{
    // Informacie o udalosti
    private String aPopis;
    // Trvanie udalosti v hodinach
    private int aTrvanie;

    /**
     * Vytvori udalost s zadanym trvanim.
     * 
     * @param paPopis potrebne informacie o udalosti
     * @param paTrvanie cas trvania udalosti v hodinach
     */
    public Udalost(String paPopis, int paTrvanie)
    {
        this.aPopis = paPopis;
        this.aTrvanie = paTrvanie;
    }

    /**
     * @return informacie o udalosti
     */
    public String dajPopis()
    {
        return aPopis;
    }
    
    /**
     * @return cas trvania udalosti v hodinach.
     */
    public int dajTrvanie()
    {
        return aTrvanie;
    }
}
