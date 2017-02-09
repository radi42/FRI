import java.util.Scanner;

/**
 * Write a description of class Main here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public abstract class Main
{
    static Zaznam zaz;
    static Diar db;
    static Scanner scan = new Scanner(System.in);
    
        public static void main(String[] args) {
            String volba = "-1";
            
            /**
            * vypis hlavnu obrazovku
            */
            while(!(volba.equals("x") ) ){
                //vypis moznosti hlavneho menu
                System.out.println("1 - vytvor diar");
                System.out.println("2 - vytvor poznamku a pridaj ju do diara");
                System.out.println("3 - vypis vsetky poznamky");
                System.out.println("x - ukonci program\n");
                
                //reaguj na volbu
                volba = scan.next();
                System.out.println();
                
                switch (volba) {
                    case "x": //ukonci program
                        System.out.println("Hadam program dobre posluzil");
                        break;
                        
                    case "1": //vytvor diar
                        System.out.println("Zadajte nazov diara: ");
                        String nazov = scan.next();

                        db = new Diar(nazov);
                        db.zmenNazovDiara(nazov);
                        System.out.println("Diar " + nazov + " bol vytvoreny\n");
                        break;
                        
                    case "2": //vytvor poznamku a pridaj ju do diara
                        System.out.println("Zadajte datum: ");
                        String datum = scan.next();
                        System.out.println("Zadajte poznamku: ");
                        String pozn = scan.next();
                        zaz = new Zaznam(datum, pozn);
                        db.add(zaz);
                        break;
                        
                    case "3": //vypis vsetky poznamky
                        //System.out.printf("%-15s, %s", "Datum", "Poznamka\n");
                        System.out.println(db.akoSaVolaDiar() );
                        System.out.println(db.toString() );
                        break;
                        
                    default: //osetrenie neplatneho vstupu
                        System.out.println("Zadajte akekolvek cislo uvedene v hlavnom menu");
                        break;
            }
        }
    }
}
