
/**
 * Trieda Datum
 * 
 * @author Andrej Sisila
 * @version v1.0b
 */
public class Datum
{
    private int den;
    private int mesiac;
    private int rok;
    
    /**
     * Parametricky konstruktor
     * @param den zobrazi den
     * @param mesiac zobrazi mesiac
     * @param rok zobrazi rok
     */
    public Datum(int den, int mesiac, int rok)
    {
        this.den = den;
        this.mesiac = mesiac;
        this.rok = rok;
    }
    
    /**
     * Bezparametricky konstruktor
     */
    public Datum()
    {
        den = 1;
        mesiac = 1;
        rok = 1970;
    }
    
    //----------------Metody
    
    //---------------Settery a Gettery
    /**
     * zisti den
     * @return den
     */
    public int getDen()
    {
        return den;
    }
    
    /**
     * zisti mesiac
     * @return mesiac
     */
    public int getMesiac()
    {
        return mesiac;
    }
    
    /**
     * zisti rok
     * @return rok
     */
    public int getRok()
    {
        return rok;
    }
    
    /**
     * nastavi den
     */
    public void setDen(int den)
    {
        this.den = den;
    }
    
    /**
     * nastavi mesiac
     */
    public void setMesiac(int mesiac)
    {
        this.mesiac = mesiac;
    }
    
    /**
     * nastavi rok
     */
    public void setRok(int rok)
    {
        this.rok = rok;
    }
    
    /**
     * je rok priestupny?
     * metoda triedy
     */
    public static boolean priestupnyRok(int rok) {
        if (rok % 4 == 0 && rok % 100 != 0 || rok % 400 == 0) {
            return true;
        }
        else {
            return false;
        }
        
    }
    
     /**
     * je rok priestupny?
     * pretazenie metody zo statickej
     */
    public boolean priestupnyRok() {
        return priestupnyRok(rok);
    }
    
    public int pocetDniVmesiaci()
    {
        return pocetDniVmesiaci(mesiac, rok);
    }
    
    public static int pocetDniVmesiaci(int mesiac, int rok)
    {
        switch (mesiac)
        {
            //pre mnozinu tychto case prikazov urob
            case 1:
            case 3:
            case 5:
            case 9:
            case 11: 
                return 30;
            case 2:
                if ( priestupnyRok(rok) ) return 29;
                else return 28;
            case 4:
            case 6:
            case 7: //cisar Julius
            case 8: //cisar Augustus
            case 10:
            case 12:
                return 31;
                
            default: //v pripade ze nie je naplneny ani jeden prikaz vola sa defaultna hodnopta, vhodna pre neuplny podmieneny prikaz
                return 0;
        }
    }
    
    public Datum getZajtra() {
        //upravit metodu tak abys om z 31. decembra nedostal 32. december musim zmenit mesiac aj rok
        //je pocet dni vacsi ako v danom mesiaci, ak je tak pridaj +1 k mesiacu a zmen posledny den na 1.
        //rok to iste ako den
        int den2 = den++;
        int mesiac2 = mesiac;
        int rok2 = rok;
        
        if ( den2 > pocetDniVmesiaci() ) {
            den2 = 1;
            mesiac2  = mesiac2++;
        }
        
        if ( mesiac2 > 12) {
            mesiac2 = 1;
            rok2 = rok2++;
        }
        //vytvorenie konstruktora s novymi hodnotami
        return new Datum(den2, mesiac2, rok2);
    }
    
    //pocet dni od zaciatku roku
    public static int pocetDniOdZaciatkuRoku(int den, int mesiac, int rok) {
        int pocet = den;
        //for (inicializacia, podmienka ,modifikacia)
        for (int m = 1; m < mesiac; m++) {
            pocet += pocetDniVmesiaci(m, rok);
        }
        return pocet;
    }
    
    public int pocetDniOdZaciatkuRoku() {
        return pocetDniOdZaciatkuRoku(den, mesiac, rok);
    }
    
    public int pocetDniDoKoncaRoku() {
        int pocet = priestupnyRok() ? 366 : 355;
        pocet -= pocetDniOdZaciatkuRoku();
        return pocet;
    }
    
    //pocet dni od datumu po datum
    public int pocetDniPoDatum(int d, int m, int r){
//         //definujeme si premennu, ktora bude ukladat celkovy rozdiel dni medzi datumami
//         int pocet2 = 0;
//         
//         //vytvorime si novy datum s odlisnymi parametrami
//         Datum druhyden = new Datum(den, mesiac, rok);
//             //tento cyklus sa opakuje tolko krat, kolko je mesiacov
//             for (int pocitadloMesiacov = 1; pocitadloMesiacov <= 12; pocitadloMesiacov++) {
//                 //vnoreny cyklus - opakuje sa tolko krat kolko je absolutna hodnota rozdielu rokov (v pripade, ze by bol rozdiel rokov zaporny)
//                 for (int pocitadloRokov = 1; pocitadloRokov <= Math.abs(rok - r); pocitadloRokov++) {
//                     //do premennej pocet2 uklada postupne vsetky dni rokov a mesiacov
//                     pocet2 = pocetDniVmesiaci(mesiac, rok);
//                 }
//             }
//         
//         return (druhyden.pocetDniOdZaciatkuRoku(d, m, r) - pocetDniOdZaciatkuRoku(den, mesiac, rok));

        int pocet = pocetDniDoKoncaRoku();
        Datum den2 = new Datum(den, mesiac, rok);
        if(rok == getRok() ) { //sme v tom istom roku
            int zvysok = den2.pocetDniDoKoncaRoku(); //vytvorim dalsi den
            return pocet - zvysok;
            }
        else{
            
            for (r = rok+1; r < den2.getRok(); r++){
                pocet += priestupnyRok() ? 366 : 355;
            }
            return pocet + den2.pocetDniOdZaciatkuRoku();
            }
//             return 0;
    }
    
    //--------------Vypis datumu
    public String toString() //je volana automaticky, ak chcem vytvorit retazec
    {
        return den + ". " + mesiac + ". " + rok;
    }
    
    
}
