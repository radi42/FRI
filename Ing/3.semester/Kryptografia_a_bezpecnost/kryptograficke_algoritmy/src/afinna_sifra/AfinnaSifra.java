package afinna_sifra;

import java.util.ArrayList;

// (17, 5)
// VYRIESIL SOM LAHKU ULOHU
// Monoalfabeticka sifra
// http://mayor.fri.uniza.sk/krypto/cvic01.php
public class AfinnaSifra {
    
    public static void main(String[] args) {
        //Affine Cipher Encryption: https://youtu.be/_E8rSP0uAIY
        //Affine Cipher Decryption - Known Key: https://youtu.be/XFxFPBKFVe8
        //Affine Cipher - Decryption (Known Plaintext Attack):
        //    https://youtu.be/ry3g0xN8QKU
        String plaintext = "HELLO";
        String cipher = zasifruj(plaintext, 7, 2, 26);
        System.out.println(cipher);
        System.out.println(odsifruj(cipher, 7, 2, 26));
        
        cipher = "LIYGTOGDPOAUPDFQNVPVDAQV";
        System.out.println(cipher);
        
        // teraz je pocet pismen abecedy je 27: A = 0, ..., Z = 25, medzera = 26
//        ArrayList platneKluce = najdiPlatneKluce(27);

        // BRUTEFORCE metoda
        for (int a = 1; a < 27; a++) {
            for (int b = 0; b < 27; b++) {
//                if(a == 17 && b == 5) {
                    System.out.println("(" + a + ", " + b + ")");
                    System.out.println(odsifruj(cipher, a, b, 27));
//                }
            }
        }
        
        // TODO - z bruteforce vysledkov vybrat tie, ktore su podla
        // frekvencnej analyzy jazyka v slovencine

        // TODO - namiesto BRUTEFORCE mozem pouzit Known Plaintext Attack,
        // pokial poznam mapovanie aspon 2 pismen zo sifry do plaintextu
    }
    
    private static int charToInt(
            char paChar, int paPocetPismenAbecedy) {
        
        if (paChar >= 'A' && paChar <= 'Z')
            return paChar - 'A';
        return paPocetPismenAbecedy - 1;
    }
    
    private static char intToChar(
            int paIntChar, int paPocetPismenAbecedy) {
        
        if (paIntChar >= 0 && paIntChar < paPocetPismenAbecedy - 1)
            return (char) (paIntChar + 'A');
        return ' ';
    }
    
    private static int inverse(
            int paInt, int paPocetPismenAbecedy) {
        
        int invNum = 0;
        for (int i = 1; i < paPocetPismenAbecedy; i++) {
            if ((paInt * i) % paPocetPismenAbecedy == 1) {
                invNum = i;
                break;
            }
        }
        return invNum;
    }
    
    private static int negativeToPositiveMod(
            int paInt, int paPocetPismenAbecedy) {
        
        return ((paInt % paPocetPismenAbecedy) 
                + paPocetPismenAbecedy) 
                % paPocetPismenAbecedy;
    }
    
    // TODO - najst take kluce, pri ktorych je a nesudelitelne s modulom poctu
    // pismen abecedy
    private static ArrayList<Kluc> najdiPlatneKluce(
            int paPocetPismenAbecedy) {
        
        ArrayList<Kluc> platneKluce = new ArrayList();
        
        //
        for (int a = 0; a < 10; a++) {
            for (int b = 0; b < 10; b++) {
                // ak je a nesudelitelne s poctom pismen abecedy
                    // vytvor novy kluc a pridaj ho do zoznamu platnych klucov
            }
        }
        
        return platneKluce;
    }
    
    private static String zasifruj(
            String paText, int paA, int paB, int paPocetPismenAbecedy) {
        
        String sifra = "";
        int pismeno = 0;
        
        for (int i = 0; i < paText.length(); i++) {
            pismeno = charToInt(paText.charAt(i), paPocetPismenAbecedy);
            sifra += intToChar(
                    (paA * pismeno + paB) % paPocetPismenAbecedy,
                    paPocetPismenAbecedy);
        }
        
        return sifra;
    }
    
    private static String odsifruj(
            String paText, int paA, int paB, int paPocetPismenAbecedy) {
        String povodnyText = "";
        int pismeno = 0;
        int inverseA = inverse(paA, paPocetPismenAbecedy);
        
        for (int i = 0; i < paText.length(); i++) {
            pismeno = charToInt(paText.charAt(i), paPocetPismenAbecedy);
            povodnyText += intToChar(
                    inverseA * negativeToPositiveMod((pismeno - paB), 
                    paPocetPismenAbecedy) % paPocetPismenAbecedy,
                    paPocetPismenAbecedy);
            
//            System.out.println(
//                    inverseA + " * " + 
//                    "(" + pismeno + " - " + paB + ")" + 
//                    " % " + paPocetPismenAbecedy + " = " +
//                    inverseA * negativeToPositiveMod((pismeno - paB), 
//                    paPocetPismenAbecedy) % paPocetPismenAbecedy);
        }
        
        return povodnyText;
    }
    
    private static String odsifruj(
            String cipher,
            ArrayList<Kluc> platneKluce,
            int paPocetPismenAbecedy) {
        
        return null;
    }
}
