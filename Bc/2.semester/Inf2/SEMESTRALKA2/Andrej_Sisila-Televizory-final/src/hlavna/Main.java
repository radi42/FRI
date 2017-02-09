package hlavna;

import zoznam.Obchod;
import televizory.TelkaLcd;
import televizory.TelkaPlazma;
import televizory.TelkaCrt;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Random;
import javax.swing.JOptionPane;

/**
 * Trieda Main
 * 
 * Zobrazuje graficke rozhranie
 * @author Andrej Šišila
 */
public class Main {

    private static Obchod obchodik = new Obchod();
    private static int aZostatokNaKonte = 1200;
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws FileNotFoundException, IOException {
        //zobraz hlavne menu
        String volba = "-1";
        
        while(!volba.equals("0") ){
            volba = String.valueOf(numInputBox(hlavneMenu() ) );
            vykonajAkciu(volba);
        }
        
    }
    
    /**
     * oznamovacie okienko
     * @param obj sprava, ktora sa ma zobrazzit
     */
    private static void msgBox(Object obj){
        JOptionPane.showMessageDialog(null, obj);
    }
    
    /**
     * 
     * @param obj lubovolny objektm ktory pouzivatel vidi v inputboxe
     * @return cislo zadane do inputboxu
     */
    private static int numInputBox(Object obj){
        String volba = JOptionPane.showInputDialog(null, obj);
        int volba2 = -1;
        try{
            volba2 = Integer.parseInt(volba);
        }
        catch(NumberFormatException ex){
            msgBox("Nespravny format cisla");
        }
        return volba2;
    }

    /**
     * @return Vracia hlavne menu v textovom tvare
     */
    private static String hlavneMenu() {
        String hlMenu = "Dobry den! \n"
                + "Srdecne Vas vitame v nasej specializovanej predajni televizorov \n"
                + "Racte si vybrat z nasej bohatej ponuky\n\n"
                + "Zostatok na Vasom konte je " + aZostatokNaKonte + "Eur\n"
                + "=================================================================\n";
        hlMenu += "1. Vypis vsetky televizory v predajni \n"
                + "2. Generuj par televizorov \n"
                + "3. Kupit televizor \n"
                + "4. Zapnut televizor \n"
                + "5. Vypnut televizor \n"
                + "6. Prepnut program na televizore \n"
                + "7. Uloz zoznam do suboru \n"
                + "8. Otvor zoznam zo suboru \n"
                + "0. Koniec";
        return hlMenu;
    }
    
    /**
     * vykonava akciu na zaklade hodnoty vlozenej do parametra
     * indexy volieb zodpovedaju indexom v "case" castiach
     * @param index retazec (String), ktory rozhoduje, ktora cast kodu sa vykona
     */
    private static void vykonajAkciu(String index) throws FileNotFoundException, IOException{
        switch(index){
            case "1":
                System.out.println(obchodik.vypisVsetkyTV() );
                break;
            case "2":
                generujTelevizory();
                break;
            case "3":
                kupitTV();
                break;
            case "4":
                zapniTV();
                break;
            case "5":
                vypniTV();
                break;
            case "6":
                prepniProgramTV();
                break;
            case "7":
                obchodik.zapisDataZoznam();
                System.out.println("zapisal som telky do suboru");
                break;
            case "8":
                obchodik.citajDataZoznam();
                System.out.println("otvoril som telky zo suboru");
                break;
            case "0":
                msgBox("               Dovidenia");
                break;
            default:
                System.out.println("Prosim, zadajte platne cislo volby");
        }
    }

    /**
     * 
     * @param i index prvku v poli
     * @return zostatok na ucte (kladny/zaporny)
     */
    private static int getZostatokNaKontePoKupe(int i){
        if(aZostatokNaKonte < obchodik.getObchod().get(i).getCena() ){
            return aZostatokNaKonte - obchodik.getObchod().get(i).getCena(); //vrati zaporne cislo
        } else {
            aZostatokNaKonte = aZostatokNaKonte - obchodik.getObchod().get(i).getCena();
            return aZostatokNaKonte;
        }
    }
    
    /**
     * metoda kupitTV vybera jeden TV a odpocita zo zostatku jeho cenu
     */
    private static void kupitTV() {
        int index = numInputBox("Zadajte cislo televizora, ktori si chcete kupit");
        
        try{
            if( (getZostatokNaKontePoKupe(index -1) ) < 0 ){
            msgBox("Nemas dost penazi. Zarob si nejake");
            } else {
            msgBox("Kupili ste si takyto televizor\n"
                    + obchodik.getObchod().get(index -1).vypis()
                    + "\n"
                    + "S radostou ho dokonca okamzite a ZADARMO dovezieme ku Vam domov \n"
                    + "Na vasom konte zostalo " + aZostatokNaKonte + "Eur"
                    + "\n");
            }
            obchodik.getObchod().remove(index -1);
        }
        catch(IndexOutOfBoundsException ex){
            msgBox("Taky televizor neexistuje - index nerozpoznany");
        }
         catch(NumberFormatException ex){
            msgBox("Nespravny format cisla");
        }
    }

    /**
     * zapina televizor
     */
    private static void zapniTV() {
        int index = numInputBox("Zadajte cislo televizora, ktory chcete zapnut");
        
        try{
            //test ci je tv uz zapnuty
            if(obchodik.getObchod().get(index -1).isZapnuty() ){ //ak uz je zapnuty
                msgBox("Televizor je uz zapnuty");
            } else {
                obchodik.getObchod().get(index -1).setZapnuty(true);
                obchodik.getObchod().get(index -1).prepniProgramNahodne(); //akonahle zapneme televizor, mala by sa zobrazit nejaka stanica
                msgBox("Zapli ste televizor cislo " + index);
            }
        }
        catch(IndexOutOfBoundsException ex){
            msgBox("Televizor s danym indexom neexistuje");
        }
        catch(NumberFormatException ex){
            msgBox("Nespravny format cisla");
        }
    }
    
    /**
     * vypina televizor
     */
    private static void vypniTV() {
        int index = numInputBox("Zadajte cislo televizora, ktory chcete zapnut");
        
        try{
            //test ci je tv uz vypnuty
            if(!obchodik.getObchod().get(index -1).isZapnuty() ){ //ak uz je vypnuty
                 msgBox("Televizor je uz vypnuty");
            } else {
                obchodik.getObchod().get(index -1).setZapnuty(false);
                 msgBox("Vypli ste televizor cislo " + (index) );
            }
        }
        catch(IndexOutOfBoundsException ex){
            msgBox("Televizor s danym indexom neexistuje");
        }
        catch(NumberFormatException ex){
            msgBox("Nespravny format cisla");
        }
    }

    /**
     * prepne program na zvolenej telke
     * @param index cislo telky
     * @return vypis, ktory televizor a na aky program sa prepol
     */
    private static void prepniProgramTV() {
        int index = numInputBox("Zadajte cislo televizora, ktoreho program chcete prepnut");
        String stanica = "";
        try{
            if(!obchodik.getObchod().get(index -1).isZapnuty() ) {
                msgBox("Nepodarilo sa prepnut stanicu - televizor vypnuty");
            } else{
                stanica = obchodik.getObchod().get(index -1).prepniProgramNahodne();
                msgBox("Na televizore cislo " + index + " teraz bezi " + stanica);
            }
        }
        catch(IndexOutOfBoundsException ex){
            msgBox("Televizor s danym indexom neexistuje");
        }
        catch(NumberFormatException ex){
            msgBox("Nespravny format cisla");
        }
    }
    
    /**
     * vygeneruje zopar teliek a hodi ich do zoznamu v triede Obchod
     */
    private static void generujTelevizory() {
        Random rng = new Random();
        int rCena = 0;
        int rUhl = 0;
        boolean rZap = false;
        boolean rSpecial = false;
        
        for(int i = 0; i < 5; i++){
            rCena = rng.nextInt(100 - 30) + 30;
            rUhl = rng.nextInt(100 - 15) + 15;
            rZap = rng.nextBoolean();
            rSpecial = rng.nextBoolean();
            obchodik.getObchod().add(new TelkaCrt(rCena, rUhl, rZap, rSpecial) );
        }
        
        for(int i = 0; i < 5; i++){
            rCena = rng.nextInt(500 - 80) + 80;
            rUhl = rng.nextInt(130 - 20) + 20;
            rZap = rng.nextBoolean();
            rSpecial = rng.nextBoolean();
            obchodik.getObchod().add(new TelkaLcd(rCena, rUhl, rZap, rSpecial) );
        }
        
        for(int i = 0; i < 5; i++){
            rCena = rng.nextInt(1500 - 400) + 400;
            rUhl = rng.nextInt(180 - 110) + 110;
            rZap = rng.nextBoolean();
            rSpecial = rng.nextBoolean();
            obchodik.getObchod().add(new TelkaPlazma(rCena, rUhl, rZap, rSpecial) );
        }
        
        obchodik.getObchod().add(new TelkaPlazma(1000, 120, true) );
        obchodik.getObchod().add(new TelkaCrt(100, 30, false) );
        obchodik.getObchod().add(new TelkaLcd(400, 95, true) );
        msgBox("vygeneroval som zopar teliek");
    }
    
}
