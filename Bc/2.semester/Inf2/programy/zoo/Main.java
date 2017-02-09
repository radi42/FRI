package zoo;

import lib.Datum;
/**
 * Trieda Main
 * 
 * vypisuje zoo
 * @author Andrej Sisila 
 * @version v3.11.2014
 */
public abstract class Main
{
   public static void main(String[] args){
       //bez importu triedy datum
       //Zivocich kon = new Zivocich("Kon", "Pavilon 1", new lib.Datum(5, 4, 2005) );
       
       //s importom triedy Datum
       Zivocich kon = new Zivocich("Kon", "Pavilon 1", new Datum(5,4,2005) );
       
       //simpanz
       Zivocich simpanz = new Simpanz(44, false);
       simpanz.setUmiestnenie("Pavilon Exotica");
       simpanz.setDatum(new Datum(8, 2, 2013) );
       
       //slon
       Zivocich slon = new Slon(200, 3500, true);
       slon.setUmiestnenie("Pavilon Indo-Africky");
       slon.setNazovDruhu("Slon John");
       
       //papuch
       Zivocich papagaj = new Papagaj("ruzova", 3, true);
       papagaj.setNazovDruhu("Papagaj Iki");
       papagaj.setDatum(new Datum(8, 6, 2013) );
       papagaj.setUmiestnenie("Pavilon Pauchov");
       
       //had
       Zivocich had = new Had(547.4, 90, true);
       had.setNazovDruhu("Had Slicky");
       had.setUmiestnenie("Hadi Pavilon");
       
       System.out.print("\n\f");
       System.out.println(kon.toString() );
       System.out.println(simpanz.toString() );
       System.out.println(slon.toString() );
       System.out.println(papagaj.toString() );
       System.out.println(had.toString() );
   }
}
