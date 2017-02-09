
import java.util.Random;

/**
 *
 * @author sisila
 */
public class Vestice {

    public static void main(String[] args) {
        double vesticaPrva = 0;
        double vesticaDruha = 0;
        double vesticaTretia = 0;
        
        Random rngVesticaPrva = new Random();
        Random rngVesticaDruha = new Random();
        Random rngVesticaTretia = new Random();
        
        //aka je pravdepodobnost, ze sa dve vestice (vesticaPrva a vesticaDruha; vesticaTretia je ignorovana) zhodnu na odpovedi a maju pravdu?
        int pocetZhod = 0;
        int kolkokratMaliPravdu = 0;
        
        //vykonajte aspon 1000000 replikacii
        int pocetReplikacii = 100000;
        
        boolean javSaSkutocneStal = false;
        Random rngJav = new Random();
        
        for (int i = 0; i < pocetReplikacii; i++) {
            vesticaPrva = rngVesticaPrva.nextDouble();
            vesticaDruha = rngVesticaDruha.nextDouble();
            javSaSkutocneStal = rngJav.nextBoolean();
            
            
            if(vesticaPrva < 0.8 && vesticaDruha < 0.8){
                pocetZhod++;
                if (javSaSkutocneStal) {
                    kolkokratMaliPravdu++;
                }
            }
        }
        
        System.out.println("Dve vestice mali pravdu s pravdepodobnostou " + ((double)kolkokratMaliPravdu/pocetZhod)*100 + " %");    //NEZABUDNUT PRETYPOVAT NA DOUBLE!

//        for (int i = 0; i < pocetReplikacii; i++) {
//            vesticaPrva = rngVesticaPrva.nextDouble();
//            vesticaDruha = rngVesticaDruha.nextDouble();
//            vesticaTretia = rngVesticaTretia.nextDouble();
//            
//            if(vesticaPrva < 0.8 && vesticaDruha < 0.8 && vesticaTretia < 0.8){
//                pocetTrafeni++;
//            }
//        }
//        
//        System.out.println("Tri vestice mali pravdu s pravdepodobnostou " + ((double)pocetTrafeni/pocetReplikacii)*100 + " %");    //NEZABUDNUT PRETYPOVAT NA DOUBLE!
    }
    
}
