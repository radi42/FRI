package afinna_sifra;

public class AfinnaSifra {
    
    public static void main(String[] args) {
        String plaintext = "HELLO";
        
        String cipher = zasifruj(plaintext, 7, 2, 26);
        System.out.println(cipher);
        System.out.println(odsifruj(cipher, 7, 2, 26));
    }
    
    private static int charToInt(
            char paChar, int paPocetPismenAbecedy) {
        
        if (paChar >= 'A' && paChar <= 'Z')
            return paChar - 'A';
        return paPocetPismenAbecedy - 1;
    }
    
    private static char intToChar(
            int paIntChar, int paPocetPismenAbecedy) {
        
        if (paIntChar >= 0 && paIntChar < paPocetPismenAbecedy)
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
    
    private static int negativeToPositive(
            int paInt, int paPocetPismenAbecedy) {
        
        return ((paInt % paPocetPismenAbecedy) 
                + paPocetPismenAbecedy) 
                % paPocetPismenAbecedy;
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
                    inverseA * negativeToPositive((pismeno - paB), 
                    paPocetPismenAbecedy) % paPocetPismenAbecedy,
                    paPocetPismenAbecedy);
            
            System.out.println(
                    inverseA + " * " + 
                    "(" + pismeno + " - " + paB + ")" + 
                    " % " + paPocetPismenAbecedy + " = " +
                    inverseA * negativeToPositive((pismeno - paB), 
                    paPocetPismenAbecedy) % paPocetPismenAbecedy);
        }
        
        return povodnyText;
    }
}
