package viegenerovska_sifra;

public class ViegnerovskaSifra {

    public static void main(String[] args) {
        //Vigenere Cipher - Encryption: https://youtu.be/izFivfLjD5E
        String plaintext = "HOWTOENCRYPT";
        String password = "KEY";
        int pocPismenAbecedy = 26;

        String cipher = zasifruj(plaintext, password, pocPismenAbecedy);
        System.out.println(cipher);
//        String recoveredText = odsifruj(cipher, password, 26);
//        System.out.println(recoveredText);

        // TODO - odsifrovat ()
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
    
    private static String zasifruj(
            String paText, String paHeslo, int paPocetPismenAbecedy) {
        
        String sifra = "";
        int pismenoText = 0;
        int pismenoHeslo = 0;
        
        for (int i = 0; i < paText.length(); i++) {
            pismenoText = charToInt(paText.charAt(i), paPocetPismenAbecedy);
            pismenoHeslo = charToInt(
                    paHeslo.charAt(i % paHeslo.length()),
                    paHeslo.length());
            sifra += intToChar(
                    (pismenoText + pismenoHeslo) % paPocetPismenAbecedy,
                    paPocetPismenAbecedy);
        }
        
        return sifra;
    }
    
    private static String odsifruj(
            String paText, String paHeslo, int paPocetPismenAbecedy) {
        String povodnyText = "";
        int pismeno = 0;
//        int inverseA = inverse(paA, paPocetPismenAbecedy);
//        
//        for (int i = 0; i < paText.length(); i++) {
//            pismeno = charToInt(paText.charAt(i), paPocetPismenAbecedy);
//            povodnyText += intToChar(
//                    inverseA * negativeToPositiveMod((pismeno - paB), 
//                    paPocetPismenAbecedy) % paPocetPismenAbecedy,
//                    paPocetPismenAbecedy);
//            
//            System.out.println(
//                    inverseA + " * " + 
//                    "(" + pismeno + " - " + paB + ")" + 
//                    " % " + paPocetPismenAbecedy + " = " +
//                    inverseA * negativeToPositiveMod((pismeno - paB), 
//                    paPocetPismenAbecedy) % paPocetPismenAbecedy);
//        }
        
        return povodnyText;
    }
}
