import java.util.*;
/**
 * Geometricky program - Hlavna aplikacia (MainApp)
 * 
 * @author Andrej Sisila
 * @version v0.1 beta
 */
public class MainApp
{
    public static void main (String[] args)
    {
        System.out.println("Praca s obdlznikmi");
        
        
        //------------Lokalne premenne
        //------------obdlznik
        double sirka;
        double vyska;
        //------------stvorec
        double strana;
        //------------kruh
        double r;
        //------------trojuholnik
        double stranaA;
        double stranaB;
        double stranaC;
        
        //------------snimac znakov z klavesnice
        Scanner klav = new Scanner(System.in); // do premennej klav davam hodnoty typu Scanner; zavola konstruktor triedy scanner a napiji sa na System.in
        
        //------------Zadavanie velkosti / priradzovanie hodnot k lokalnym premennym
        //------------obdlznik
        System.out.println("\fObdlznik"); //vymaze terminal
        System.out.println("Zadaj sirku: ");
        sirka = klav.nextInt();
        System.out.println("Zadaj vysku: ");
        vyska = klav.nextInt();
        
        //-------------stvorec
        System.out.println("\nStvorec"); //kazdy dalsi utvar bude oddeleny jednym volnym riadkom
        System.out.println("Zadaj stranu: ");
        strana = klav.nextInt();
        
        //-------------kruh
        System.out.println("\nKruh");
        System.out.println("Zadaj polomer: ");
        r = klav.nextInt();
        
        //-------------trojuholnik
        System.out.println("\nTrojuholnik");
        System.out.println("Zadaj dlzku strany a: ");
        stranaA = klav.nextInt();
        System.out.println("Zadaj dlzku strany b: ");
        stranaB = klav.nextInt();
        System.out.println("Zadaj dlzku strany c: ");
        stranaC = klav.nextInt();
        
        //------------Vyhodnotenie
        //------------Vytvorenie instancii
        Obdlznik obdlznik = new Obdlznik(sirka, vyska); // hodnota premennej obdlznik je instancia Obdlznik
        Stvorec stvorec = new Stvorec(strana);
        Kruh kruh = new Kruh(r);
        Trojuholnik trojuh = new Trojuholnik(stranaA, stranaB, stranaC);
        
        //------------Prikazy pre vypis vlastnosti
        //------------obdlznik
        System.out.println("\nVytvorili sme obdlznik " + obdlznik); //odblznik je v tomto pripade instancia - vypisom bude HASH hodnota(literal)
        System.out.println("obsah = " + obdlznik.obsahObdlznika());
        System.out.println("obvod = " + obdlznik.obvodObdlznika());
        System.out.println("uhlopriecka = " + obdlznik.dlzkaUhlopriecky());
        
        //------------stvorec
        System.out.println("\nVytvorili sme stvorec " + stvorec);
        System.out.println("obsah = " + stvorec.obsahStvorca());
        System.out.println("obvod = " + stvorec.obvodStvorca());
        System.out.println("uhlopriecka = " + stvorec.dlzkaUhlopriecky());
        
        //------------kruh
        System.out.println("\nVytvorili sme kruh " + kruh);
        System.out.println("obsah = " + kruh.obsahKruhu());
        System.out.println("obvod = " + kruh.obvodKruhu());
        
        //------------trojuholnik
        System.out.println("\nVytvorili sme trojuholnik " + trojuh);
        System.out.println("obsah = " + trojuh.obsahTrojuh());
        System.out.println("obvod = " + trojuh.obvodTrojuh());
        System.out.println("Da sa trojuholnik zostrojit? " + trojuh.Test());
    }
    //inicializuj pocet = nastav count na nulu;
    
}