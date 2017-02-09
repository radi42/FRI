package zoo;


/**
 * Interface Prepravitelny.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public interface Prepravitelny // rozhranie, ktore zabezpecuje ze objekt bude prepravitelny, a zadefinuje svoje
                               // poziadavky na prepravu => vahu, objem
{
//     public int koef = 10; // v rozhrani je mozne zadeklarovat konstanty
    
    // hlavicky metod, metody nemaju telo. kazdy objekt, ktory bude implementovat toto rozhranie, tak to telo metody
    // vyplni
    double poziadavkaObjemu();   // vrat poziadavku na objem ako realnu hodnotu
    double poziadavkaVahy();     // vrat poziadavku na vahu ako realnu hodnotu

}
