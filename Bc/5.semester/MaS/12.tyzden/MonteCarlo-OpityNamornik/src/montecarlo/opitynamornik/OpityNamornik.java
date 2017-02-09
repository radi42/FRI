package montecarlo.opitynamornik;

import java.util.Random;

/**
 * Typ Monte Carla - pravdepodobnost
 * @author sisila
 */
public class OpityNamornik {

    public static void main(String[] args) {
        int x = 0;
        int y = 0;
        int pocetReplikacii = 100000;
        int pocetKrokov = 1000;
        int pocetVsetkychKrokovY = 0;   //kroky vpred vzad
        int pocetVsetkychKrokovX = 0;   //kroky vlavo vpravo
        double smer = 0;
        
        
        Random rngSmer = new Random(); //hore dole dolava doprava dopredu dozadu => JEDEN GENERATOR
        
//        //uloha 1
//        for (int j = 0; j < pocetReplikacii; j++) {
//            for (int i = 0; i < pocetKrokov; i++) {
//                if(rngSmer.nextDouble() < 0.5)     y++;
//                else    y--;
//            }
//            pocetVsetkychKrokovY += y;
//        }
//        
//        System.out.println("Namornik urobil v priemere " + pocetVsetkychKrokov/(pocetReplikacii*pocetKrokov) + " krokov");
        
        //uloha 1
        for (int j = 0; j < pocetReplikacii; j++) {
            for (int i = 0; i < pocetKrokov; i++) {
                smer = rngSmer.nextDouble();
                if(smer < 0.25)                     //dopredu
                    y++;
                else if(smer >= 0.25 && smer < 0.5) //dozadu
                    y--;
                else if(smer >= 0.5 && smer < 0.75) //doprava
                    x++;
                else                                //dolava
                    x--;
            }
            pocetVsetkychKrokovY += y;
            pocetVsetkychKrokovX += x;
        }
        
        double pocetKrokovX = (double)pocetVsetkychKrokovX/(pocetReplikacii*pocetKrokov);
        double pocetKrokovY = (double)pocetVsetkychKrokovY/(pocetReplikacii*pocetKrokov);
        System.out.println("Namornik na v priemere nachadza na suradniciach \n" 
                + pocetKrokovX + ", " + pocetKrokovY);
        
        double euklidVzdialenost = 0;   //neviem ako sa pocita
        System.out.println("Euklidovska vzdialenost namornika od stredu je "
                + euklidVzdialenost);
    }
    
}
