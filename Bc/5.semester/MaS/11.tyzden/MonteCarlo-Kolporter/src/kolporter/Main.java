package kolporter;

import java.util.Random;

/**
 *
 * @author Andrej
 */
public class Main {
    //naklady za 1 vytlacok = 15 centov = 0.15 eura
    //za jeden nepredany kus dostane 65% nakupnej ceny = 0.15 * 0.65
    //predajna cena je kazdy den ina = trojuholnikove rozdelenie(0.25, 0.6, 0.95)
    //dlzka pracovnej doby je modelovana pomocou uniformneho rozdelenia <250,420) minut
    //doba, ktora uplynie medzi predajmi vytlackov = priemerne 2.7 minuty tj rovnomerne rozdelenie
    
    //urcite preda aspon jedny noviny kazdy den
    //kolporter moze nakupovat noviny iba v balikoch po 10
    
    //Kolko balikov novin musi kolporter zakupit, aby dosiahol co najvyssi zisk?
    //Aky zisk dosiahne kolporter pri Vami odporucenom pocte nakupenych balikov?
    //Pouzite metodu Monte Carlo
    
    public static void main(String[] args) {
        double nakupnaCena  = 0.15;
        double vykupnaCena = nakupnaCena * 0.65;
        double predajnaCena;    //trojuholnikove rozdelenie (0.25, 0.6, 0.95)
        double pracovnaDoba;    //uniformne rozdelenie <250, 420)
        double casMedziKupamiNovin = 2.7; //uniformne rozdelenie so strednou hodnotou 2.7
        
        int objednaneMnozstvo = 0;   //nasobky 10 - skusat od 1 do 100
        int predaneMnozstvo = 0;
        
        Random rngPredajna1 = new Random();
        Random rngPredajna2 = new Random();
        Random rngPracovnaDoba = new Random();
        Random rngCasMedziKupamiNovin = new Random();
        
        double skutocnaPracDoba = 0;
        
        //urobte minimalne 1 000 000 replikacii
        int pocetReplikacii = 1000000;
        
        //Priemery
        double vsetkaPracovnaDoba = 0;
        double vsetokPocetPredanychNovin = 0;
        double vsetokZisk = 0;
        int vsetkoZostatkoveMnozstvo = 0;
        double vsetokPredoslyZisk = 0;
        double najlepsiZisk = 0;
        int optimalnyPocetBalikov = 0;
        
        //j je pocet objednanych balikov
        for (int j = 1; j < 20; j++) {
        
            vsetkaPracovnaDoba = 0;
            vsetokPocetPredanychNovin = 0;
            vsetokZisk = 0;
            predajnaCena = 0;
            skutocnaPracDoba = 0;
            

            
            for (int i = 0; i < pocetReplikacii; i++) {
                //kazdy den predava noviny za inu cenu
                predajnaCena = 0.25 + ((0.95 - 0.25)/2) * (rngPredajna1.nextDouble() + rngPredajna2.nextDouble());
                
                objednaneMnozstvo = j * 10;
                predaneMnozstvo = 0;
                pracovnaDoba = (420 - 250) * rngPracovnaDoba.nextDouble() + 250;
                skutocnaPracDoba = 0;

                //kazdy den preda aspon jedny noviny
                predaneMnozstvo++;
                objednaneMnozstvo--;

                //ak mi neskoncila pracovna doba A mam este co predavat
                while(skutocnaPracDoba < pracovnaDoba && objednaneMnozstvo != 0) {
                    //skutocnaPracDoba += rngCasMedziKupamiNovin.nextDouble() * casMedziKupamiNovin; //<0,1) * 2.7
                    skutocnaPracDoba += casMedziKupamiNovin; //2.7
                    predaneMnozstvo++;
                    objednaneMnozstvo--;
                }

                vsetkaPracovnaDoba += pracovnaDoba;
                vsetokPocetPredanychNovin += predaneMnozstvo;
                double peniazePredaj = predaneMnozstvo * predajnaCena;
                vsetkoZostatkoveMnozstvo += (j * 10) - predaneMnozstvo;
                int zostatkoveMnozstvo = (j * 10) - predaneMnozstvo;
                double peniazeVykup = zostatkoveMnozstvo * vykupnaCena;
                double peniazeNakup = j*10 * nakupnaCena;
                
                vsetokZisk += peniazePredaj + peniazeVykup - peniazeNakup;
            }
        
            if(vsetokZisk > vsetokPredoslyZisk){
                optimalnyPocetBalikov = j;
                najlepsiZisk = vsetokPredoslyZisk;
            }
            
            vsetokPredoslyZisk = vsetokZisk;
            
            System.out.println("Vysledky pre " + j + " balikov");
            System.out.println("Zostatkove mnozstvo novin je " + vsetkoZostatkoveMnozstvo/pocetReplikacii);
            System.out.println("Kolporter pracoval v priemere " + vsetkaPracovnaDoba/pocetReplikacii + " minut");
            System.out.println("Kolporter predal v priemere " + vsetokPocetPredanychNovin/pocetReplikacii + " novin");
            System.out.println("Kolporter ziskal v priemere " + vsetokZisk/pocetReplikacii + " €\n");
        }
        
        System.out.println("Optimalny pocet balikov je " + optimalnyPocetBalikov);
        System.out.println("Pri nakupe " + optimalnyPocetBalikov + " balikov ziskame v priemere " + najlepsiZisk/pocetReplikacii + " €");
    }
}
